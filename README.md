> This repo is WIP and it is not stable, so expect breaking changes.
>
> Anyway, it might give you a headstart if you want to start using
> Ansible on some remote host the standalone way.
>
> Note that I am also learning how to adapt Ansible to my infrastructure,
> so bear with me that I probably only use very low level Ansible features,
> and often will apply some external script magic instead of using the proper
> Ansible feature.  (Playbooks have a too complex basic design for my taste.)
>
> So all this here offers is, to use basic Ansible as the management driver.
> Perhaps later it will fit into some Semaphore infrastructure.  Or not.
> Currently the branch management is incompatible with Semaphore, and it is
> unlikely to change.  Perhaps some converter will be available in future.


# Ansible

Setup and manage remote VMs with Ansible.

> Perhaps in future this can be fully automated.
>
> For now, the initial (one-time) setup of the remote is a manual step.
>
> Everything else should then be scriptable.


## Requirements

In contrast what you find elsewhere, the requirements to use this here are pretty low:

- Required basic knowledge (this is not explained):
  - Shell: You need to know how the commandline works
  - Ansible: understand, adapt and add Playbooks
  - `git`: know how to pull/push/init `git` repositories and/or run a basic `git` service
  - `git`: know how to use this `git` feature: `git config --global url.XXXX.insteadOf YYYY`
  - `ssh`: How to configure `~/.ssh/config` to tunnel to some VM using `ProxyCommand`
- Some local Linux
  - Can be WSL under Windows, of course
  - Needs this repository here installed
  - Needs a local ansible installed, but this need not be a current one
- Some remote VM which is up an running
  - With some minimum default install
  - No additional setup needed, except `ssh`
  - No need to access the VM host, just the VM is enough
- `ssh` access to the VM
  - Name of the `ssh` connection should match `hostname -f` on the VM
  - Pubkey auth recommended, but SSH login with password is ok
  - `ssh` connection may be proxied, so `ProxyCommand` in `~/.ssh/config` is OK
- The VM does not need to have full Internet connectivity
  - Only `apt` must work to install additional packages
  - So access to some Debian proxy or local Debian mirror is enough
  - This is designed for offline labs or VMs with private IPs without NAT
- Optional:
  - Some `git` server to keep changes to this repo

No other or external infrastructure is needed.


## One-time workstation setup

This is only needed once:

	sudo apt install ansible make git
	git clone https://github.com/hilbix/ansible.git
	cd ansible

From here, all `Local:` shell commands run from this directory.
All `Remote:` things run out of the home of the unprivileged user.
(If you change paths, you need to adopt accordingly.)

Local: Then you probably want to do this, to be able to push your work back to your local `git` server:

	git remote rename origin upstream
	git remote add origin git@gitserver.local:ansible/ansible.git
	git push --mirror origin

> I recommend to have remotes upstream and origin,
> as host configuration usually do not need to be pushed to upstream.


## Prepare VM init

The remote (VM) is called `vm1.example.net` in the examples.  Adapt accordingly.

> - You need to know how to setup `ssh` properly.  This is not explained here.
> - You need to know how to use the VM's commandline.  This is not explained here.

Local: Make sure following works:

	ssh vm1.example.net

This must lead to unprivileged `ssh` login on the remote.

- If the login needs a Password, this is ok.
- This login later is used for management purpose (`sudo` without password)
  hence be sure you use a suitable login.

Remote: Make sure `root` access works:

	su -

alternatively:

	sudo su -

- This should prompt you for a password
  - No need that `sudo` exists


## One-time VM init

Local:

	./init.sh vm1.example.net

Follow instructions.

- This must be run manually
- The command probably asks you for passwords
  - First the `ssh` password
  - Second the `su` password
- This command is idempotent.
  - So you can it run as often as you like until it no more fails.
  - It should not break anything
- This command should never conflict with your Playbooks
  - If you have contradicting Playbooks later, you need to fix the Playbooks in the `init/` directory accordingly.
  - Be sure that the `init/*.yml` Playbooks do not do things, your other Playbooks might revert
  - It is solely your part to make sure this is the case
  - If you cannot read or adapt Playbooks accordingly, this is not for you.  First learn Ansible instead.


## Manage the Playbooks for the VM

The individual Playbooks for the VM are kept in a `git` branch,
prefixed with `ansible/` and named after the VM,
here `host/vm1.example.net`.

`init.sh` initializes this branch if it is missing.

These branches are also checked out into the `host/` directory as `git` submodules.
Be sure to properly manage things from within `git`.

Everything in the branches is mixed with the ansible setup found in the worktree.
For this each host on the remote gets an automatically managed Ansible work directory
under `tmp/` (here: `tmp/vm1.exmample.net`) from which Ansible then runs.

If you want to place `tmp/` somewhere else, use softlinks.
Either `tmp/` or `tmp/vm1.example.net`
Do not edit anything else below `tmp/` as it will be populated and overwritten
unconditionally with force.


## Update VM 

It is your responsibility to keep the worktree in sync with the `git` repository.

You can update the VM either from local or remotely on the VM itself.

Local:  Use this if the remote has no access to `git`

	./push.sh vm1.example.net

This does following:

- Pushes the local changes to the remote worktree.
- Fast forwards the remote to the current `git` TIP.
- Then executes `./run.sh` on the remote
- If anything fails, it stops and prints the error.
  - This happens if you need to rebase or merge on the remote.
  - You must do this manually, as automatic conflct resolution is extremely dangerous in system management.
- There is no locking.
  - Be sure nobody else runs Ansible commands on the remote from the directory while it is updated.


Remote: (Recommended)

	git/ansible/run.sh

Be sure to have all your branches updated properly and checked out the latest current version of your Playbooks,
not only on `master` but on your `host/` submodule, too.  For this you need to know how to use `git`.

There is a helper command which could update things on the remote:

	git/ansible/update.sh

However this may fail if things start to become too complex.

This not only pulls changes from the `git` server, it also pushes your changes.
For safety, only fast-forward pull/push is supported.
If it fails you need to escape by applying manual commands.


## Authenticated Automation

Ansible and Semaphore already offer automation.  It looks a bit like I re-invent the wheel here.

But this is wrong.  Ansible and Semaphore do not offer authenticated automation
and needs some option, which simply do not exist:

Considere a triple offline situation:

- My Workstation is offline
- My Infrastructure is offline
- My Cloud VM is offline

Where `offline` means "only hosts on the local physical LAN can be reached".
Between the 3 different isolated LANs there is no link to communicate directly.

> This is not by accident.  This is by purpose, because all 3 live in
> different security zones and there should be as few permeability
> between the zones as possible.

However I still want to be able to automate things.

`git` to the rescue.

All 3 locations have in common, that there is some local data exchange service,
which can be synchronized with some external data source.

Usually this provides:

- A HTTP based Debian/Ubuntu mirror
  - Most easily with `apt-cacher-ng` (supports to access HTTPS as HTTP with a special syntax)
- `sftp` mount for file transfer
  - This offers various bare `git` repositories
- And some automated `git` mirror scripts
  - These synchronizes the `git` repositories in all 3 locations using standard `git` methods.

> That's pretty basic, but sadly, `git` is unable to utilize `sftp` directly.
>
> Before `git-lfs`, it was enough to offer `git-shell` via `ssh`.
> But now this needs a full featured filesystem.

How can automation look like in this scenario?

- I edit the Playbooks locally on my workstation
- I push the Playbooks
- The `git` sync picks that up and pushes it to the external data source.
- The `git` sync picks the changes on the external data source and updates the fileserver.
- The remote machine picks up the changes from the fileserver.
- It then does `./update.sh && ./run.sh`

> FYI this external data source can be something like
>
> - The official Debian Mirrors
> - GitHub
>
> So nothing which is part of any of my infrastructure.

Usually there is also some signalling.  Hence the local `push` automatically chains the
rest and finally triggers the update.  The log then travels back automatically, too.

> This can be implemented using some external services, like Pipedream or IFTTT.

As you can see, there is no good place where to add what Ansible and Semaphore offer.

For this the Ansible host (which lives in the Infrastructure) must connect to the VM,
but this is not always possible.  Likewise the reverse thing, the VM cannot connect
to the infrastructure.

In contrast, the way I do it, also gives full authentication:

- Debian repositories are already signed and the signature is checked.  So these are authentic.
- `git` commits can also be signed, which allows to check their authenticity.
  - This uses asymmetric PKI, so it is hard to fake

So all management in the zones can only happen with authenticated data.
Even if somebody manages to compromize any component in the path between
my workstation and the VM, no real harm can be done (usually and except DoS).

That is, how management must look like from my perspective.
Semaphore and Ansible do not offer this out-of-the-box, hence the need arises to do it yourself.

> And I do not contradict myself here.
>
> - You only need `ssh` access for `./init.sh`.
> - After that, you can stop using `ssh` and automate things on the remote
>
> Hence you only need a communication link between 2 zones
> while you bootstrap one of them.  Afterwards it is no more needed.
>
> You can also argue, that there is a communication link through the external file service.
> That is basically right, but the communication here is highly limited to unidirectional
> authenticated file exchange.  This is something completely different to what usually
> is understood as being a real communication link which commonly is bi-directional.


## FAQ

License?

- Free as free beer, free speech and free baby.
- This only applies to what you find in this repository,
  not for Ansible, `git` or other tools used.
- Read:  No warranty.  If you break something with it, it is solely your fault.


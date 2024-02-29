# `sftp-only`

Restrict users to `sftp-internal` of `sshd`.

```
  - roles:
    - ftp-user
    - role: sftp-only
      users: ftp
    - role: authorized-keys
      users:
        - ftp
        - root
      keys:
        - alice
        - bob
```

`users`
- list of strings
  - or just a single string
- All users must already exist
- Their home is cleaned from files which are not needed for noninteractive users!
- The given users are caged into their home directory via `chroot` and `sftp-internal` of `sshd`
- This includes the `ssh-end` role to add a rule to your `/etc/ssh/sshd_config`

# Description

The given `users` can be accessed by multiple `ssh` identities which possibly belong to different persons.

- To allow `chroot`, `sshd` requires `root:root` for `$HOME` and `$HOME/.ssh`
  - This is an `sshd` limitation
  - Hence the need to clean the home directory
- All owners of one of the ssh identities have absolutely the same access as all others.
  - This is a limitation of the design of `sftp-internal`
  - See `sftp-internal-group` for a different approach
- You cannot detect nor restrict which `ssh` identity uploads, changes or deletes a file.
  - This is a design limitation of this approach here
  - See `sftp-internal-group` for a different approach
- You can manage the `.ssh/authorized_keys` entries to `restrict` what they are capable to do (like disable port forwarding).
  - `command=""` does not work in `chroot`
- You cannot change the initial directory the `sftp` starts in.
  - It always is the root directory which is the `$HOME` of the `chroot`.
  - So the client needs to change into the correct directory

# Missing

- role `sftp-internal-group` to cage multiple different local users into a single common directory instead.


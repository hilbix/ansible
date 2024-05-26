# `authorized-keys`

Install `~/.ssh/authorized_keys` from files in `files/authorized_keys/` via `ansible.posix.authorized_key`

`users`
- string
- list of strings
- defaults to current user if `users` is missing
- `~{{user}}/.ssh/autorized_keys` destination to manipulate

`keys`
- string
- list of strings
- `files/authorized_keys/{{key}}` source files with lines of ssh-entries
- not implemented: defaults to current user if `keys` is missing

Examples:

```
  roles:
    - role: authorized-keys
      users: alice
      keys: alice
    - role: authorized-keys
      users: bob
      keys: bob
```

Following adds keys of `alice` and `bob` to the current user:

```
  roles:
    - role: authorized-keys
      keys: alice
      keys: bob
```

```
  roles:
    - role: authorized-keys
      users:
        - root
        - ftp
      keys:
        - alice
        - bob
    - role: authorized-keys
      users: alice
      keys: alice
    - role: authorized-keys
      users: bob
      keys: bob
```

`files/authorized_keys/alice`:
```
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINrMHeqkmqjAaDhqRsP+cK4vcojKd5jQygnUjDPPm47d alice@wonderland
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCuy4uFe+slB8rI6pZuXoDuBQJWSTNEHbgl3GPY0VzJbJBoVtMi1FRIL2h4ETxFLPQcr1WPpftuP2Z6oWXlX/wedKfcOyS8e4Hs4A9k9jmGGIuy05Xs338FWbz7zkZfuTZtuKo6+mCBVkN4QIYp1PssIOOf68oxaqI02UGb/58PyN3Zyt+tRUXGNCSlQpQv7wfAj6073AbkLeBQ6zjQe3WJN9RFcJD+/8oYjS5JQKX3FeVrcST6wsL2CejvjiY8NITTOHevyb9tidcrjfjN26DaXGXJ2+R90v03/IgSu3X8lGuJzBeuibaJ+4I5+E7/FKGfvHhYUatLOoqrVSEVdRHJqYecBX/S9fNaio0U2F6QtOE878SuF5xAzkBiKh66wgGWwVOn3oDN+eFEdBYER9tlQgAzT4DcrKuSnNigMRL8VWrdMa5W1yaFTBMkZdNUFZhZEogb4t2RtRdSJrRAfRytkLEfKL8hrL5KESEljDxU2qBmkbBMz/QxFh6D4qX7R71zfT+WgOFugsM4jROLvWNBycigNs4mlCAbT/O3nHcW8S5bAMTkwMH0YyZupJ8q9MP8+n1MQMwA4WIpWN5fZtxQ5dki7diBEoIuDpgv7zQfFaYqOS5NbRJMD+ZH+4lSSjFdkGOxC7uiVBeXwvxr18TB1SqFouT5Zlqw9lP4exmE+w== alice@wonderland
```

`files/authorized_keys/bob`:
```
ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF7qSEe6uYSrmw4jCZH506aWS96/HFlxsaZEpOsQ7zG7 bob@marley
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDF+2WGPcoQs/erdoUw0UmyRkK0LoATFzC7D6ZwJyv7V5U2FlPqtg3KMkcM1KGM8ITqyBucG0jgJowLTz4xRI0A4/n1RyF1ebArLyH5MaeOqI54nYUg3ka6koavTfIcyc0EcWdQLqvJfb+EMxS2ic0EyFK8vFZfDtFCut/5paiEMZpefCqypbtzdppllVpB5ezIFqBbGXZPZUwp/ZglGQdgyh2TpJxIJUs/xStjeinqmmuu65bW+pJBZzEc9VRvlx06zoBHqiMcTp+1AkplxlkWPIWnloj0fwNLmFNaOkLFAVViH2O0/4ssSbsYr6J75duH3G5klPIPBhJebojWrFTH bob@marley
```

## TODO

- `keys` default is not yet implemented
- `state: absent` is not yet implemented
- `exclusive: true` is not yet implemented
- `follow: true` is not yet implemented
- `key_options` is not yet implemented
  - This is the prefix of the ssh key
  - Note that this can be implemented with the template files, too

And additionally:

- `template`
  - Generate the files from a template instead
- `metoo` boolean
  - If set, the current running user's IDs are also added
- `minetoo` boolean
  - If set, the current running user's `autorized_keys` are added, too
- `forward` for lists of ports allowed to forward to
- `listen` for lists of ports allowed to listen to
- `x11` if x11 forwarding allowed
- `restrict` to enable `restrict`
- and so on
  - This also should work directly with some [`oath-auth`](https://github.com/hilbix/oath-auth) setup.

I am undecided how to properly add following:

- `comment`
  - Perhaps interesting to add some comment when it was added or removed etc.
- `path`
  - Probably a directory prefix where then the files are put as `authorized_keys.user` or similar
  - For SFTP the authorized-keys file can be put somewhere quite different
  - Keeping the files somewhere else is mandatory to securely implement a shared SFTP space for multiple users


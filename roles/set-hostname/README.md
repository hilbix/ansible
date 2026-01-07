# `update-hostname`

Update the hostname from one name to another.  Fails if neither name is set!

Install `~/.ssh/authorized_keys` from files in `files/authorized_keys/` via `ansible.posix.authorized_key`

`to`
- string
- hostname to set

`from`
- string
- list of strings
- defaults to `to`

Examples:

```
  roles:
    - role: update-hostname
      to: www.example.com
      from:
        - dummy
        - dummy.example.com
        - dummy.example.org
```


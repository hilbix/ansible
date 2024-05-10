# `ssh-id`

Install `~/.ssh/id_xxxx` from files `files/ssh-id/xxxx.key` and `files/ssh-id/xxxx.pub`

`keys`
- string
- list of strings

`users`
- string
- list of strings
- defaults to the current user of the play

- `files/ssh-id/{{key}}.key` source file for `.ssh/id_{{key}}`
- `files/ssh-id/{{key}}.pub` source file for `.ssh/id_{{key}}.pub`

Examples:

```
  roles:
    - role: ssh-id
      keys: machine1
```

```
  roles:
    - role: ssh-id
      users:
        - root
	- alice
	- bob
      keys:
        - service1
        - service2
```

## TODO

- generate the `.pub` out of `.key` if missing


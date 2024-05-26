# `ssh-id`

Install files `files/ssh-id/xxxx/*.key` and `files/ssh-id/xxxx/*.pub` to `~/.ssh/`

`keys`
- string
- list of strings

`users`
- string
- list of strings
- defaults to the current user of the play

`dir`
- string
- defaults to .

- `files/ssh-id/{{key}/name.key` source file for `.ssh/{{dir}}/name`
- `files/ssh-id/{{key}/name.pub` source file for `.ssh/{{dir}}/name.pub`

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


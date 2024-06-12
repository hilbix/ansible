# `ssh-id`

Install files `files/ssh-id/xxxx/*.key` and `files/ssh-id/xxxx/*.pub` to `~/.ssh/`

- `files/ssh-id/{{key}}/*.key` is searched, where `*` becomes `{{name}}`
- `files/ssh-id/{{key}/{{name}}.key` source file for `.ssh/{{dir}}/id_{{name}}`
- `files/ssh-id/{{key}/{{name}}.pub` source file for `.ssh/{{dir}}/id_{{name}}.pub`

`keys`
- string
- list of strings
- there is no default yet

`users`
- string
- list of strings
- defaults to the current user of the play

`dir`
- string
- defaults to `keys` which means `.ssh/keys/`
- use `dir: .` to put the key directly into `.ssh/`

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

- there should be some suitable default for `keys` (like the current host name)
  - undecided yet, I need to gather common usage patterns first
- generate the `.pub` out of `.key` if the `.pub` is missing


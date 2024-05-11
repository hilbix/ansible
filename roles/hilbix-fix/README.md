# `hilbix-fix`

Install and setup <https://github.com/hilbix/fix> into `/root/git/`

This also installs some templates into `/etc/apt/apt.conf.d/`:

- `99tino` see `/root/.apt`
- `99proxy` for using a standard `apt-cacher-ng` proxy
  - see <https://github.com/hilbix/apt-cacher-ng-proxy>

See also:

- role ssh-id

key:

- string
- defines, which `.ssh/id_XXX` key to use
  - Leave away prefix `id_` here

```
  roles:
    - role: hilbix-fix
      key: service1
```


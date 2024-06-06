# `hilbix-fix`

```
  roles:
    - hilbix-fix
  become: true
```

```
  roles:
    - hilbix-fix
```

```
  tasks:
    - name: "install hilbix-fix"
      ansible.builtin.import_role:
        name: hilbig-fix
```


## Description

Install and setup <https://github.com/hilbix/fix> into `$HOME/git/fix/`

As `root` this also installs some templates into `/etc/apt/apt.conf.d/`:

- `99tino` see `/root/.apt`
- `99proxy` for using a standard `apt-cacher-ng` proxy
  - see <https://github.com/hilbix/apt-cacher-ng-proxy>

See also:

- role `ssh-id`

key:

- string
- defines, which `.ssh/id_XXX` key to use
  - Leave away prefix `id_` here


Do a checkout with a deployment key:

```
  roles:
    - role: ssh-id
      keys: service1

  tasks:
    - name: roles
      ansible.builtin.include_role:
        name: hilbix-fix
      vars:
        key: service1
```


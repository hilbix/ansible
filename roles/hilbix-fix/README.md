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
  - `apt_proxy: IP:PORT` variable to set the apt proxy
  - see <https://github.com/hilbix/apt-cacher-ng-proxy>

See also:

- role `ssh-id`

key:

- string
- defines, which `.ssh/id_XXX` key to use
  - Leave away prefix `id_` here

`apt_proxy`

- string of the form `hostname`, `hostname:PORT`, `IP`, `IP:PORT`
- defines, which `http://{{apt_proxy}}` to use
- sorry, `http` only for now
- Note that `apt-cacher-ng` allows `https` with `http:///HTTPS/` prefix (but then fails for me without next fix)
- <https://github.com/hilbix/apt-cacher-ng-proxy> is a proxy to use http URLs with apt-cacher-ng for https-only repos
  - So the path is `apt =99proxy=> apt-cacher-ng =/etc/apt-cacher-ng/proxy.conf=> apt-cacher-ng-proxy =socat=> Internet`
- Note: HTTPS cannot secure repositories.  Only signatures can.  Hence HTTPS for Debian repositories usually is unnecessary
  - But in some environments it may be more easy to serve repos via HTTPS, so it should be supported

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


# role `hilbix-fix`

Install and setup <https://github.com/hilbix/fix> into `/root/git/`

This also installs some templates into `/etc/apt/apt.conf.d/`:

- `99tino` see `/root/.apt`
- `99proxy` for using a standard `apt-cacher-ng` proxy
  - see <https://github.com/hilbix/apt-cacher-ng-proxy>
  - see Variables

Variables:

T.B.D.

Example:

```
  roles:
    - hilbix-fix
```


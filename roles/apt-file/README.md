# `apt-file`

```
  become: true
  roles:
    - apt-file
```

```
  tasks:
    - name: install apt-file
      ansible.builtin.import_role:
        name: hilbig-fix
      become: true
```


## Description

This installs `apt-file` and initially fills the `apt-file` cache.

It does not update the `apt-file` cache, though.  For this you need a task like:

```
- name: Update apt-file
  ansible.builtin.shell:
    cmd: apt-file update
```

or

```
  notify: Update apt-file
```


## TODO

There should be some `apt` role which supports common things and update `apt-file`, too, if it is installed.


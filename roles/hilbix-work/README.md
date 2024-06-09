# `hilbix-work`

```
  roles:
    - hilbix-work
```

```
  tasks:
    - name: install hilbix-work
      ansible.builtin.import_role:
        name: hilbig-work
```

See also:

- role `hilbix-fix`

## Description

Install and setup common utilities used by me for my work.

This is somewhat hackish.

You need a `files/gitignore` template else this fails.
There isn't one by default, as it includes privacy information (such like the mail address).


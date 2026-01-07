# `nginx`

Install `nginx` and optionally deploy `template/{sites}.nginx`

`sites`
- string
- list of strings
- no default

Examples:

```
  roles:
    - role: nginx
      sites: letsencrypt
```

```
  roles:
    - role: nginx
      sites:
        - letsencrypt
        - dummy-ssl
        - mysite
```

Example for `templates/mysite.nginx` see `templates/dummmy-ssl.nginx`


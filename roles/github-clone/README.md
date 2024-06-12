# `github-clone`

```
  roles:
    - role: github-clone
      from: organization-name
      repo: repo-name
      depth: 5

    - role: ssh-id
      keys: keyfiles
    - role: github-clone
      from: organization-name
      key: repo-name

    - role: ssh-id
      keys: keyfiles
    - role: github-clone
      from: organization-name
      repo: repo-name
      key: key-name
```

```
  tasks:
    - ansible.builtin.import_role:
       name: ssh-id
       keys: keyfiles
    - ansible.builtin.import_role:
        name: github-clone
        from: organization-name
        key: repo-name
        depth: 5
```

See also:

- `ssh-id` to setup your deployment keys


## Description

Clone something from GitHub, possibly with a deployment key

- compare: `https://github.com/from/repo.git`

from:

- string
- GitHub account or origanization

repo:

- string
- GitHub repo name
- defauts to: key

key:

- string
- takes key from `.ssh/keys/id_{{ key }}`
- this creates `.ssh/config` with `Include ~/.ssh/config.d/*.conf`
- this creates `.ssh/config.d/github.com+{{from}}+{{repo}}.conf` files

You can also give variables for `ansible.builtin.git`:

- `depth` for shallow clones


## TODO

- Allow `dir` parameter to select another directory than `.ssh/keys/` for the deployment keys
- Use `git config url.github.com+{{from}}+{{repo}}:{{from}}/{{repo}}.git.insteadOf https://github.com/{{from}}/{{repo}}.git`
  - currently it uses the direct URL
  - As Ansible is for deployments, it is likely that I never need this or it even would be counterproductive
  - we will see


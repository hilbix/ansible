# `docker-ce`

```
  roles:
    - docker-ce
```

# Description

Adds the docker-ce repositories and installs Docker CE.

- Implemented according to `https://docs.docker.com/engine/install/debian/`
- Also verifies the downloaded docker key having the known ID
  - If the docker key ever changes, this will fail.


## Bugs

- This only works for Debian
  - Ubuntu is missing etc.
- There should be variables
  - for the Docker key ID
  - for the packages to install
- Does not pull a changed Docker key from the web


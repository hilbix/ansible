# `i2p`

```
  become: true
  roles:
    - i2p
```

```
  tasks:
    - name: install i2p
      ansible.builtin.import_role:
        name: i2p
      become: true
```


## Description

This installs `i2p` on Debian.

It does not configure it yet.


## Ports

> This are the default ports of i2pd at the time of writing

- `127.0.0.1:4444` HTTP
- `127.0.0.1:4447` Socks
- `127.0.0.1:6668` IRC
- `127.0.0.1:7070` i2pd console
- `127.0.0.1:7656` SAM bridge
- `127.0.0.1:7658` Your EEPSITE (probably)
- `127.0.0.1:7659` smtp (closed)
- `127.0.0.1:7660` pop3 (closed)
- `127.0.0.1:7670` git over ssh (closed)


## TODO

There should be more configuration


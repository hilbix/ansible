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

- `127.0.0.1:4444` HTTP
- `127.0.0.1:4447` Socks
- `127.0.0.1:6668` IRC
- `127.0.0.1:7070` i2pd Console
- `127.0.0.1:7656` SAM bridge
- `127.0.0.1:7657` Router Console (i2p Java)
- `127.0.0.1:7658` EEPSITE
- `127.0.0.1:7659` smtp
- `127.0.0.1:7660` pop3
- `127.0.0.1:7670` git over ssh


## TODO

There should be more configuration


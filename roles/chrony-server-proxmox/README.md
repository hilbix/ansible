> This is intermediary until I come up with something better

# role `chrony-server-proxmox`

This role creates a chrony-server using kernel module `kvm_ptp` to get the time from the underlying host (like ProxMox) as the (only) time source.

This means you do not need Internet connectivity for this.

See also:

- `chrony-server` for NTP service which synchonizes to pool.ntp.org.
- `chrony-client` for NTP clients using either `chrony-server` or `chrony-server-proxmox`

Example:

```
  roles:
    - chrony-server-proxmox
```


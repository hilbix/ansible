# role `chrony`

This installs `chrony` as it comes with the distro.

This is a supporting role for following roles:

- `chrony-server-proxmox` for VM based NTP service which synchonizes to the hosts RTC which is synchronized to the network
- `chrony-server` for NTP service which synchonizes to pool.ntp.org.
- `chrony-client` for NTP clients using either `chrony-server` or `chrony-server-proxmox`


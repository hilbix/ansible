# `rrdcached`

Setup `rrdcached`.

```
  roles:
    - role: rrdcached
```

Missing parts:

- Create LV to keep `rrdcached` data
- Setting up `rrdcached` as NetData receiver
- `rrdtool` frontend

And a way to restore previous data from backup, such that a `rrdcached` instance can be re-generated from scratch.


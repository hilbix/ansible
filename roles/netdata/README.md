# `netdata`

```
  roles:
    - role: netdata
      type: client
      server: IP
```

`type`: (not yet implemented)

- `client` transmits data to relay, cache or server, keeps nothing on disk or in memory
- `relay`  receives data and transmits to `cache` or `server`, keeps data only in memory
- `cache`  receives data and transmits to `server`, caches data on disk between restarts, may run its own `rrdcached`
- `server` receives data, stores data on disk between restarts, runs `rrdcached`

`client`: (not yet implemented)
- default type if `server` variable is set

`server`: (not yet implemented)

- default type if local IP matches `netdata-server`
- fact: `netdata-server`
- The IP of the server
  - `IPv4:port`
  - `[IPv6]:port`

`cache`: (not yet implemented)

- default type if local IP matches `netdata-cache`
- fact: `netdata-cache`
- The IP of the `cache`, see `server` above
- Same as `server`
- Used on `client` and `relay` types instead of `server`

`relay`: (not yet implemented)

- default type if local IP matches `netdata-relay`
- fact: `netdata-relay`
- The IP of the `relay`, see `server` above
- Used on `client` types instead of `cache` or `server`


# Description

Gathers data using NetData and streams that data from `client` to `server` via NetData transport.

This does not support NetData cloud, because this is meant for offline cluster setups.

> I am not sure how to do this, because I cannot understand why anybody wants to use the NetData cloud.
>
> AFAICS (IANAL) NetData Cloud violates German law, because German law prohibits employee data (their login and their IP) to leave the German border.
> In my understanding of the DSGVO, at least an explicite "Auftragsverarbeitungsvertrag" (physically written and signed) must be present for this, but there isn't anything like that.
> However, even if there is, this might still not be enough to fulfill the labour rights, as NetData is able to track working hours of employees (per login), which is unlawful.
> Hence there must be some contract which prohibits this possibility.  The problem here:  You must be able to actively supervise and enforce this contract to stay within the law.
> Sorry, but I do not support unlawful things.
>
> Note that it is easy to make it lawful:  NetData Cloud just needs to offer a Germany only variant, where data never leaves the German border.
> This, however, includes, that this data never is subject to NSLs issued by the United States, too.
> Hence the German NetData Cloud must be run fully independent of the USA.
> (I am not sure if it is valid that this cloud is within the EU union and not directly in Germany.  But I think so, because the EU is privileged by Germany,
> so the EU territory can be seen as being a part of the German border, so we are outside of Germany but still within the German border.  But I might err here, IANAL!)


# Missing

- `type` not yet implemented.
  - For now please use role `netdata-server` for server instead
- `apikey`
  - it is `00000000-0000-0000-0000-000000000000` for now
- `port`
  - it is the default `19999`
- `relay`, `cache`, `server`
  - T.B.D.


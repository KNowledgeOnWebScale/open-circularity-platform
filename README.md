<!-- omit in toc -->
# Architecture

- [Docker](#docker)
  - [Docker Compose](#docker-compose)
    - [Profiles](#profiles)
- [STATUS](#status)

## Docker

### Docker Compose

#### Profiles

Doc: <https://docs.docker.com/compose/profiles/>

Example: pods + frontend (no proxy!)

```bash
docker compose --profile pod --profile frontend --profile dev up
```

## STATUS

[http://pod1](http://pod1/) reachable. Shows landing page. Shows file tree. `user1/data/...`. But none of the data can be viewed publicly.

[http://pod2](http://pod2/) reachable. Shows landing page. Shows file tree. `/manufacturer1/data/...`. But none of the data can be viewed publicly.

[http://webclient](http://webclient/) reachable, but

- unauthenticated queries to either `pod1/user1` or `pod2/manufacturer1` don’t work.
- logging through `pod1` IDP and querying doesn’t work —> `headersAuthenticator not yet initialized`.

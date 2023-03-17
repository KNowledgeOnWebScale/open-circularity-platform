<!-- omit in toc -->
# Architecture

- [Docker](#docker)
  - [Docker Compose](#docker-compose)
    - [Profiles](#profiles)
- [STATUS](#status)

## Development

🧹 Clean start

```bash
./scripts/docker-reset.sh
./setup_browser.sh
```

🚀 Fire up the services !

```bash
docker compose --profile pod --profile frontend up
```

Browse the network through the Firefox container at <http:localhost5800>.

- [ ] doc: add ca certifcate to Firefox browser
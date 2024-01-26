```shell
# without worker mode
$ docker compose up -d workspace && docker compose logs -f workspace

# in a different panel (for me it throws error)
$ docker compose up k6
```

```shell
# with worker
docker compose -f docker-compose-worker.yaml up -d workspace && docker compose logs -f workspace

# in a different panel
$ docker compose up k6
```

```shell
# without worker mode
$ docker compose up -d workspace_bookworm && docker compose logs -f workspace_bookworm

# in a different panel (for me it throws error)
$ docker compose up k6_bookworm
```

```shell
# bookworm with worker
docker compose -f docker-compose-worker.yaml up -d workspace_bookworm && docker compose logs -f workspace_bookworm

# in a different panel
$ docker compose up k6_bookworm
```



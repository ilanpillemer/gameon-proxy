# Game-On.org Proxy


## Build
```
docker build -t game-on-proxy .
```

## Stop
```
docker stop -t 0 game-on-proxy ; docker rm game-on-proxy
```

## Daemon
```
docker run -d -p 443:443 -p 1936:1936 -e ADMIN_PASSWORD=admin --name=game-on-proxy game-on-proxy
```

## Restart
```
docker stop -t 0 game-on-proxy ; docker rm game-on-proxy ; docker run -d -p 443:443 -p 1936:1936 -e ADMIN_PASSWORD=admin --name=game-on-proxy game-on-proxy
```

## Interactive
```
docker run -it -p 443:443 -p 1936:1936 -e ADMIN_PASSWORD=admin --name=game-on-proxy game-on-proxy bash
```
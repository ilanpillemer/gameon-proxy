# Game-On.org Proxy


## Build
```
docker build -t gameon-proxy .
```

## Stop
```
docker stop -t 0 gameon-proxy ; docker rm gameon-proxy
```

## Daemon
```
docker run -d -p 80:80 -p 443:443 -p 1936:1936 -e ADMIN_PASSWORD=admin -e PROXY_DOCKER_HOST=localhost --name=gameon-proxy gameon-proxy
```

## Restart
```
docker stop -t 0 gameon-proxy ; docker rm gameon-proxy ; docker run -d -p 80:80 -p 443:443 -p 1936:1936 -e ADMIN_PASSWORD=admin -e PROXY_DOCKER_HOST=localhost --name=gameon-proxy gameon-proxy
```

## Interactive
```
docker run -it -p 443:443 -p 1936:1936 -e ADMIN_PASSWORD=admin -e PROXY_DOCKER_HOST=localhost --name=gameon-proxy gameon-proxy bash
```

## Build the Key
```
cat  ~/certificate/game-on_org.crt ~/certificate/game-on_org.ca-bundle ~/certificate/server.key > proxy.pem
```
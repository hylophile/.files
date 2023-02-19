#!/usr/bin/env fish

function docker_reset
    docker system prune
    docker container stop (docker container ls -aq)
    docker container rm (docker container ls -aq)
    docker rmi (docker images -aq)
    docker volume prune
    docker kill (docker ps -q)
    docker rm (docker ps -a -q)
    docker rmi (docker images -q)
    docker system prune -a --volumes
end

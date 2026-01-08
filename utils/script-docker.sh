#!/bin/bash
docker kill ubuntu
docker container rm ubuntu
docker run -dit --name ubuntu --mount type=bind,src="/home/user/personal/dotfiles/",dst="/dotfiles" ubuntu
docker exec -it ubuntu bash

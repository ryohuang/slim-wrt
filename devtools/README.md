# Build tools

## Build with docker

```shell
# build the image
cd devtools
docker build --build-arg UID=$(id -u) \
                --build-arg GID=$(id -g) \
                -t slim_builder .
cd /path/of/source/code
docker run -v $(pwd):/home/user slim_builder /bin/bash -c "id && ls -l /home/user && make encore"
```
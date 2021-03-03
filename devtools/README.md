# Build tools

## Build with docker

```shell
# build the image
cd devtools
docker build --build-arg UID=$(id -u) \
                --build-arg GID=$(id -g) \
                -t slim_builder .
cd /path/of/source/code
# build with oneline
docker run -v $(pwd):/home/user/work slim_builder /bin/bash -c "id && ls -l /home/user && make encore"
# build with interactive mode
docker run -it -v $(pwd):/home/user/work slim_builder /bin/bash
```
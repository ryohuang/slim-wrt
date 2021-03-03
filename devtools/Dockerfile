FROM ubuntu:20.04

ARG USER=user
ARG UID=1000
ARG GID=1000
# default password for user
ARG PW=docker
# only on local machine
RUN sed -i "s/archive.ubuntu.com/mirrors.aliyun.com/g" /etc/apt/sources.list

RUN export DEBIAN_FRONTEND=noninteractive; \
    export DEBCONF_NONINTERACTIVE_SEEN=true; \
    echo 'tzdata tzdata/Areas select Etc' | debconf-set-selections; \
    echo 'tzdata tzdata/Zones/Etc select UTC' | debconf-set-selections; \
    apt-get update &&\
    apt-get install -qqy --no-install-recommends libpkgconf-dev libpkgconf3 rsync build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo npm python-is-python3 ssh-client wget curl file screen && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN useradd -m ${USER} --uid=${UID} && echo "${USER}:${PW}" | \
      chpasswd

USER ${UID}:${GID}
RUN mkdir -p /home/${USER}/work
WORKDIR /home/${USER}/work

# set dummy git config
RUN git config --global user.name "user" && git config --global user.email "user@example.com"
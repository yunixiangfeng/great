FROM ubuntu:18.04

EXPOSE 3306 10080

RUN sed -i 's/archive.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list && \
    sed -i 's/security.ubuntu.com/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list

RUN apt-get -y update && \
    apt-get -yq --no-install-suggests --no-install-recommends install \
    dnsutils \
    iputils-ping \
    libaio-dev \
    libkeyutils1 \
    libkeyutils-dev \
    libncurses5-dev \
    libnuma1 \
    libnuma-dev


RUN mkdir -p /user/local/greatdb-cluster-5.0.4-3d46f2558e2-Linux-glibc2.12-x86_64/
COPY greatdb-cluster-5.0.4-3d46f2558e2-Linux-glibc2.12-x86_64 /user/local/greatdb-cluster-5.0.4-3d46f2558e2-Linux-glibc2.12-x86_64/

RUN groupadd greatdb && \
    useradd -r -g greatdb -s /bin/false greatdb && \
    mkdir /etc/greatdb-cluster && \
    mkdir /var/lib/greatdb-cluster && \
    ln -s /user/local/greatdb-cluster-5.0.4-3d46f2558e2-Linux-glibc2.12-x86_64 /user/local/greatdb-cluster && \
    chown greatdb:greatdb -R /user/local/greatdb-cluster

#CMD ["/bin/sh","-c","tail -f /dev/null"]
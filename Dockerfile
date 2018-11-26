FROM centos:7

RUN yum install -y git && \
    rm -rf /var/cache/yum && \
    git clone https://github.com/sstephenson/bats.git && \
    cd bats && \
    ./install.sh /usr && \
    useradd -m bats

USER bats

ENTRYPOINT ["/usr/bin/bats"]

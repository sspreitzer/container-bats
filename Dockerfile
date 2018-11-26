FROM centos:7

RUN yum install -y centos-release-openshift-origin && \
    yum install -y origin-clients \
                   git \
    && \
    rm -rf /var/cache/yum && \
    curl -L -o /tmp/webhook.tar.gz https://github.com/adnanh/webhook/releases/download/2.6.9/webhook-linux-amd64.tar.gz && \
    tar xzf /tmp/webhook.tar.gz -C /tmp && \
    install -o root -g root -m 0755 -D /tmp/webhook-linux-amd64/webhook /usr/bin/webhook && \
    rm -rf /tmp/webhook* && \
    git clone https://github.com/sstephenson/bats.git && \
    cd bats && \
    ./install.sh /usr && \
    useradd -m bats

EXPOSE 8080
VOLUME "/etc/webhook"
USER bats

ENTRYPOINT [ "/usr/bin/webhook" ]
CMD [ "-port", "8080", "-nopanic", "-verbose", "-hooks", "/etc/webhook/hooks.json" ]

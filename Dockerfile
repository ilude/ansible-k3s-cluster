ARG ALPINE_VERSION=latest
FROM alpine:${ALPINE_VERSION}

ARG USER
ENV USER=${USER}
WORKDIR /app/ansible

RUN apk --no-cache add \
    ansible \
    apache2-utils \
    bash \
    bind-tools \
    ca-certificates \
    curl \
    git \
    make \
    nano \
    py-pip \
    openssl \
    openssh-client \
    shadow \
    sudo \
    tzdata \
    zsh \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    && rm -rf /var/cache/apk/* 

RUN useradd -U -u 919 -m -d /home/$USER -s /bin/zsh $USER && \
    echo "$USER ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/$USER

# install oh-my-zsh
RUN curl -sLO "https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh" | bash -s 

# install kubectl
RUN curl -sLO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl" && \
    chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl 

# install k3sup
RUN curl -L "https://get.k3sup.dev" | bash -s

# install helm
RUN curl -L https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash -s

ADD https://gist.githubusercontent.com/ilude/e2342829a97c3c3d3da5f9c73976c4ec/raw/gitconfig /home/$USER/.gitconfig

ENV ANSIBLE_LOCALHOST_WARNING=false
COPY ansible/Makefile /app/ansible/
COPY ansible/docker-requirements.yml /app/ansible/
#RUN make requirements

COPY config/*.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/*.sh

COPY config/zshrc /home/$USER/.zshrc

ENTRYPOINT [ "docker-entrypoint.sh" ]
CMD ["/bin/zsh"]

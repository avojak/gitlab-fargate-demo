FROM redhat/ubi8

# Install tini
ARG TINI_VERSION=v0.19.0

RUN curl -Lo /usr/local/bin/tini https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-amd64 && \
    chmod +x /usr/local/bin/tini

# Install sshd and generate host keys
RUN yum install -y openssh-server && \
    mkdir -p /var/run/sshd && \
    ssh-keygen -A

EXPOSE 22

# Install GitLab CI required dependencies
RUN curl -s "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.rpm.sh" | bash && \
    yum install -y gitlab-runner bash ca-certificates git git-lfs && \
    git lfs install --skip-repo

# Cleanup
RUN yum clean all && \
    rm -rf /var/cache/yum

# TODO: Setup non-root user

# Setup entrypoint
COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT [ "tini", "--", "/usr/local/bin/docker-entrypoint.sh" ]
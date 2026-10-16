FROM docker.io/rockylinux/rockylinux:9
RUN \
  dnf install -y sudo rpm-sign && \
  dnf install -y 'dnf-command(config-manager)' && \
  dnf install -y \
    https://yum.theforeman.org/releases/3.18/el9/x86_64/foreman-release.rpm \
    https://yum.theforeman.org/katello/4.20/katello/el9/x86_64/katello-repos-latest.rpm && \
  dnf config-manager --set-enabled crb && \
  dnf install -y rubygem-hammer_cli_katello && \
  dnf clean all && \
  groupadd -g 1001 build && \
  useradd -c "Build User" -u 1001 -g 1001 -G wheel -s /bin/bash -m build && \
  sed -i -E 's/^%wheel/# %wheel/; s/# %wheel(.*NOPASSWD:)/%wheel\1/' \
    /etc/sudoers
USER build
ENTRYPOINT ["/usr/bin/hammer"]

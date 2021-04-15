# THIS FILE WAS AUTO-GENERATED
#
#  $ lcitool dockerfile fedora-rawhide libvirt+dist,libvirt-ocaml
#
# https://gitlab.com/libvirt/libvirt-ci/-/commit/6552fd8885423cfc383a58255eca542937f7d4ea

FROM registry.fedoraproject.org/fedora:rawhide

RUN dnf update -y --nogpgcheck fedora-gpg-keys && \
    dnf install -y nosync && \
    echo -e '#!/bin/sh\n\
if test -d /usr/lib64\n\
then\n\
    export LD_PRELOAD=/usr/lib64/nosync/nosync.so\n\
else\n\
    export LD_PRELOAD=/usr/lib/nosync/nosync.so\n\
fi\n\
exec "$@"' > /usr/bin/nosync && \
    chmod +x /usr/bin/nosync && \
    nosync dnf update -y && \
    nosync dnf install -y \
        autoconf \
        automake \
        ca-certificates \
        ccache \
        diffutils \
        gcc \
        gettext-devel \
        git \
        glibc-langpack-en \
        libtool \
        libvirt-devel \
        make \
        ocaml \
        ocaml-findlib \
        perl \
        pkgconfig && \
    nosync dnf autoremove -y && \
    nosync dnf clean all -y && \
    rpm -qa | sort > /packages.txt && \
    mkdir -p /usr/libexec/ccache-wrappers && \
    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/cc && \
    ln -s /usr/bin/ccache /usr/libexec/ccache-wrappers/gcc

ENV LANG "en_US.UTF-8"
ENV MAKE "/usr/bin/make"
ENV CCACHE_WRAPPERSDIR "/usr/libexec/ccache-wrappers"

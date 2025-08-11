FROM redhat/ubi8-minimal:latest
LABEL maintainer=ehrig.t@googlemail.com

RUN microdnf -y install wget
# Add CentOS repo
COPY ./centos.repo /etc/yum.repos.d/

RUN wget http://mirror.centos.org/centos/RPM-GPG-KEY-CentOS-Official -O /etc/pki/rpm-gpg/RPM-GPG-KEY-centosofficial && \
     microdnf install -y \
        shadow-utils            \     
        which sudo tar gzip \     
        libaio                    \     
        # libaio1 - not avail  \     
        # libncurses5 - not avail \
        ncurses-devel    \     
        hostname && \      
    groupadd informix -g 200 && \
    useradd -m -g informix -u 200 informix  -s /bin/bash && \
    useradd -m  guest -s /bin/bash && \
    rm -rf /var/cache/yum/* && \
    echo "informix ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    echo "informix:in4mix" | chpasswd

RUN microdnf install -y java
RUN microdnf install -y net-tools

# ** Informix Server needs a lower version of these libraries. 
#         Workaround:
#         Run the following commands as root user from /usr/lib64
#     ln -s libncurses.so.6 libncurses.so.5
#     ln -s libtinfo.so.6 libtinfo.so.5

RUN sudo ln -s /usr/lib64/libncurses.so.6 /usr/lib64/libncurses.so.5
RUN sudo ln -s /usr/lib64/libtinfo.so.6 /usr/lib64/libtinfo.so.5




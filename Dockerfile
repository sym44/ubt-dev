FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt -y update \
    && apt install -y openssh-server sudo \
    && apt install -y vim build-essential gdb cmake rsync \
    && apt install -y net-tools \
    && apt install -y wget \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -rm -d /home/sym44 -s /bin/bash -g root -G sudo -u 1000 sym44

RUN echo 'sym44:123abc' | chpasswd

# install conda
RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-x86_64.sh -O ~/anaconda.sh \
    && /bin/bash ~/anaconda.sh -b -p /opt/anaconda3 

# activate conda
RUN echo "PATH=/opt/anaconda3/bin:$PATH" >> /home/sym44/.bashrc


RUN service ssh start

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]

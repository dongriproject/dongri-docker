FROM centos:7

RUN yum  -y install \
    git \
    autoconf \
    automake \
    libtool \
    zlib-devel \
    openssl-devel \
    libevent-devel \
    gcc-c++ \
    libdb-devel \
    libdb-cxx-devel \
    boost-devel \
    epel-release \
    libdb4-devel \
    libdb4-cxx-devel \
    which \
    make
RUN mkdir -p /root/local/dongri && \
    echo "server=1" >> /root/local/dongri/dongri.conf && \
    echo "rpcuser=admin" >> /root/local/dongri/dongri.conf && \
    echo "rpcpassword=adminpass" >> /root/local/dongri/dongri.conf && \
    echo "rpcallowip=0.0.0.0/0" >> /root/local/dongri/dongri.conf && \
    echo "rpcport=8332" >> /root/local/dongri/dongri.conf && \
    echo "port=9402" >> /root/local/dongri/dongri.conf && \
    echo "gen=0" >> /root/local/dongri/dongri.conf && \
    mkdir work && cd work && \
    git clone https://github.com/dongriproject/dongri.git && \
    cd dongri && \
    ./autogen.sh && \
    ./configure --enable-cxx --disable-shared --with-pic --prefix=/root/local --with-incompatible-bdb && \
    make && make install

EXPOSE 9402

CMD [ "/root/local/bin/dongrid", "-datadir=/root/local/dongri", "--debug" ]


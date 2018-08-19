# This is a comment
FROM fedora:25
MAINTAINER evias 
RUN dnf -y install java-1.8.0-openjdk-headless.x86_64 tar tmux supervisor procps jq unzip gnupg.x86_64
RUN dnf -y upgrade nss

# NEM software
RUN curl -L http://bob.nem.ninja/beta-testnet/nis-0.6.96.tgz > nis-0.6.96.tgz

RUN tar zxf nis-0.6.96.tgz
RUN mkdir -p /home/nem/nem/ncc/
RUN mkdir -p /home/nem/nem/nis/data

RUN adduser nem
RUN chown -R nem /home/nem/nem

RUN curl -L http://bob.nem.ninja/beta-testnet/nis5_testnet-835k.h2.db.zip > nis5_testnet.h2.db.zip
RUN unzip nis5_testnet.h2.db.zip
RUN mv nis5_testnet.h2.db /home/nem/nem/nis/data

# servant
RUN curl -L https://github.com/rb2nem/nem-servant/raw/master/servant.zip > servant.zip
RUN unzip servant.zip

# the sample is used as default config in the container
COPY ./custom-configs/supervisord.conf.sample /etc/supervisord.conf
# wallet
EXPOSE 7777
# NIS
EXPOSE 7890
# servant
EXPOSE 7880
# NCC
EXPOSE 8989
CMD ["/usr/bin/supervisord"]

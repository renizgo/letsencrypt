FROM centos:7
LABEL maintainer "Renato Diniz renatocabelo@gmail.com"	

ENV container docker
RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == \
systemd-tmpfiles-setup.service ] || rm -f $i; done); \
rm -f /lib/systemd/system/multi-user.target.wants/*;\
rm -f /etc/systemd/system/*.wants/*;\
rm -f /lib/systemd/system/local-fs.target.wants/*; \
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
rm -f /lib/systemd/system/basic.target.wants/*;\
rm -f /lib/systemd/system/anaconda.target.wants/*;
VOLUME [ "/sys/fs/cgroup" ]

RUN yum -y update &&\
    yum -y install epel-release &&\
    yum -y install git python-pip augeas nginx &&\
    pip install virtualenv &&\
    systemctl enable nginx.service &&\
    mkdir -p /var/www/certmanager_scielo_org    

RUN cd /opt/ &&\
    git clone https://github.com/letsencrypt/letsencrypt &&\
    yum -y install certbot &&\    
    yum -y clean all


COPY index.html /usr/share/nginx/html/index.html

CMD ["/usr/sbin/init"]

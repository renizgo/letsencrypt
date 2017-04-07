FROM centos:7
LABEL maintainer "Renato Diniz renatocabelo@gmail.com"	
RUN yum -y update &&\
    yum -y install epel-release &&\
    yum -y install git python-pip augeas nginx &&\
    pip install virtualenv &&\
    systemctl enable nginx && systemctl start nginx &&\
    mkdir /var/www/certmanager_scielo_org    

RUN cd /opt/ &&\
    git clone https://github.com/letsencrypt/letsencrypt &&\
    yum install certbot &&\    
    yum clean all &&\

COPY index.html /usr/share/nginx/html/index.html

CMD ["/usr/sbin/init"]

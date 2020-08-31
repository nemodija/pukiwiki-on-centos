FROM centos:centos5.11

COPY config/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo

RUN yum update -y && \
    yum install -y --enablerepo=centosplus openssl-devel && \
    yum install -y httpd httpd-devel php-devel php-mysql php-mbstring php-gd

WORKDIR /root

COPY pukiwiki-1.4.7_notb.tar.gz /root/pukiwiki-1.4.7_notb.tar.gz
RUN tar -zxvf pukiwiki-1.4.7_notb.tar.gz -C /var/www/html && \
    ln -s pukiwiki-1.4.7_notb /var/www/html/wiki && \
    chown -R $(id -u apache):$(id -g apache) /var/www/html/wiki/

EXPOSE 80

CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

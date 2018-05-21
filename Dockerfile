FROM ubuntu:1404-163
MAINTAINER qiang <194724379@qq.com>

# Install base packages
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get -yq install \
	make autoconf \
        gcc &&\
	rm -rf /var/lib/apt/lists/*
ADD      redis-3.2.8.tar.gz /tmp/
WORKDIR  /tmp/redis-3.2.8 
#编译
RUN  make && make install
# 修改配置文件
RUN mkdir /etc/redis
RUN cp redis.conf /etc/redis/6379.conf
RUN  sed -i "s/daemonize no/daemonize yes/g" /etc/redis/6379.conf
RUN  sed -i "s/# requirepass foobared/requirepass qiangge/g" /etc/redis/6379.conf
RUN  sed -i "s/bind 127.0.0.1/#bind 127.0.0.1/g" /etc/redis/6379.conf
# 配置启动服务
RUN cp utils/redis_init_script /etc/init.d/redis
RUN chmod +x /etc/init.d/redis

#scripts
ADD run.sh /run.sh
RUN chmod 755 /*.sh

VOLUME  ["/etc/redis"]

EXPOSE 6379
CMD ["/run.sh"]

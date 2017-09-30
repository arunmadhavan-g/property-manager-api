FROM ubuntu

RUN \
	apt-get update &&\
	apt-get -y install locales &&\
	locale-gen en_US en_US.UTF-8 &&\
    dpkg-reconfigure locales &&\
	apt-get -y install wget &&\
	apt-get -y install gcc &&\
	apt-get -y install make &&\
	wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb &&\
	dpkg -i erlang-solutions_1.0_all.deb &&\
	apt-get update &&\
	apt-get -y install esl-erlang &&\
	apt-get -y install elixir &&\
	apt-get -y install git &&\
	cd ~ &&\
	wget http://download.redis.io/releases/redis-4.0.1.tar.gz &&\
	tar xzf redis-4.0.1.tar.gz &&\
	cd redis-4.0.1 &&\
	make &&\
	make install &&\
	cp -f src/redis-sentinel /usr/local/bin && \
  	mkdir -p /etc/redis && \
  	cp -f *.conf /etc/redis && \
  	rm -rf /tmp/redis-stable* && \
  	sed -i 's/^\(bind .*\)$/# \1/' /etc/redis/redis.conf && \
  	sed -i 's/^\(daemonize .*\)$/# \1/' /etc/redis/redis.conf && \
  	sed -i 's/^\(dir .*\)$/# \1\ndir \/data/' /etc/redis/redis.conf && \
  	sed -i 's/^\(logfile .*\)$/# \1/' /etc/redis/redis.conf


VOLUME ["/data"]

WORKDIR /data

RUN redis-server /etc/redis/redis.conf &

RUN apt-get -y install inotify-tools

RUN \
  	cd ~ &&\
  	mkdir property-manager-api &&\
  	cd property-manager-api &&\
  	wget --no-check-certificate https://github.com/arunmadhavan-g/property-manager-api/archive/master.tar.gz &&\
  	tar -xvf master.tar.gz &&\
  	rm -rf master.tar.gz &&\
  	cd property-manager-api-master &&\
  	mix local.hex --force &&\
  	mix local.rebar --force &&\
  	mix deps.get &&\
  	mix compile

WORKDIR /root/property-manager-api/property-manager-api-master

CMD ./runner.sh


EXPOSE 4000

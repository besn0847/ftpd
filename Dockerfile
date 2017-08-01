FROM alpine

RUN echo "http://nl.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories &&\
	apk update && \
	apk add proftpd &&\
	mkdir /data &&\
	adduser -h /data -H -D -s /bin/ash default &&\
	echo "default:passw0rd" | chpasswd &&\
	chown -R default.default /data &&\
	mkdir -p /run/proftpd/ &&\
	touch /run/proftpd/proftpd.pid

ADD config/proftpd.conf /etc/ 

EXPOSE 20 21

CMD proftpd -n --config /etc/proftpd.conf

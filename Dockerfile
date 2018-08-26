FROM ruby:2.4-alpine3.6

LABEL 	maintainer="Andrzej Golawski <andipansa@gmail.com>" \
	io.k8s.description="MailCatcher For OpenShift" \
 	io.openshift.non-scalable=true 

RUN set -xe \
    && apk add --no-cache \
        libstdc++ \
        sqlite-libs \
    && apk add --no-cache --virtual .build-deps \
        build-base \
        sqlite-dev \
    && gem install mailcatcher -v 0.6.5 --no-ri --no-rdoc \
    && apk del .build-deps

EXPOSE 1025
EXPOSE 1080

USER 1001

CMD ["mailcatcher", "--no-quit", "--foreground", "--ip=0.0.0.0"]

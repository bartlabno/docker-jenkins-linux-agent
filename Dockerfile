FROM jenkins/jnlp-slave:alpine

MAINTAINER "Bart Labno<labno.b@gmail.com>"
LABEL Description="Base linux image with all required tools to work against infrastructure."

USER root
WORKDIR /

RUN apk update

# Install aws-cli
RUN apk -Uuv add groff less python py-pip
RUN pip install awscli
RUN apk --purge -v del py-pip
RUN rm /var/cache/apk/*

# Install ansible
RUN apk add ansible

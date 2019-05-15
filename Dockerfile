FROM jenkins/jnlp-slave:alpine

MAINTAINER "Bart Labno<labno.b@gmail.com>"
LABEL Description="Base linux image with all required tools to work against infrastructure."

USER root
WORKDIR /

RUN apk update

# Install aws-cli and terraform
RUN apk -Uuv add groff less python py-pip curl terraform
RUN pip install awscli
RUN apk --purge -v del py-pip
RUN rm /var/cache/apk/*

# Install k8s tools
RUN curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /bin
RUN curl -o /bin/kubectl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl
RUN chmod 755 /bin/kubectl
RUN curl -o /bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.12.7/2019-03-27/bin/linux/amd64/aws-iam-authenticator
RUN chmod 755 /bin/aws-iam-authenticator

USER jenkins
WORKDIR /home/jenkins

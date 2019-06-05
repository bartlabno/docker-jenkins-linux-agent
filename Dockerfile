FROM jenkins/jnlp-slave:alpine

USER root
WORKDIR /

RUN apk update && apk -Uuv add groff less python py-pip curl
RUN pip install awscli && apk --purge -v del py-pip

RUN curl --silent --location "https://github.com/weaveworks/eksctl/releases/download/latest_release/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /bin
RUN curl -o /bin/kubectl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl && chmod 755 /bin/kubectl
RUN curl -o /bin/aws-iam-authenticator https://amazon-eks.s3-us-west-2.amazonaws.com/1.12.7/2019-03-27/bin/linux/amd64/aws-iam-authenticator && chmod 755 /bin/aws-iam-authenticator
RUN curl -o helm.tar.gz https://storage.googleapis.com/kubernetes-helm/helm-v2.14.0-linux-amd64.tar.gz && tar zxvf helm.tar.gz && mv ./linux-amd64/helm /usr/bin/helm && chmod 755 /usr/bin/helm

USER jenkins
WORKDIR /home/jenkins

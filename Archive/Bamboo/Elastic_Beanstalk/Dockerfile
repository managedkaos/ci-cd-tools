FROM atlassian/bamboo-server
USER root
RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y \
                        bash \
                        curl \
                        git \
                        make \
                        openjdk-8-jdk \
                        openssl \
                        procps \
                        python \
                        python-pip \
                        python3 \
                        python3-pip && \
    pip install virtualenv && \
    pip3 install virtualenv

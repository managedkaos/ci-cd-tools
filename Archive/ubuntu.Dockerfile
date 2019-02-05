FROM gocd/gocd-agent-ubuntu-18.04:v19.1.0
RUN apt-get update && \
    apt-get -qq install make python-pip python3 python3-pip && \
    pip install virtualenv && \
    pip3 install virtualenv

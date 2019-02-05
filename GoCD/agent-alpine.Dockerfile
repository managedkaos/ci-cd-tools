FROM gocd/gocd-agent-alpine-3.8:v19.1.0
RUN apk update && \
    apk add \
        build-base \
        make \
        py-pip \
        py3-setuptools \
        python \
        python3 && \
    pip install --upgrade pip virtualenv && \
    pip3 install --upgrade pip virtualenv

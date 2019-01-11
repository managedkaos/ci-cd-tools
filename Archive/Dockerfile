FROM alpine:3.7
RUN apk update && \
    apk upgrade && \
    apk add --no-cache curl
ADD ./wait_for_jenkins_login.sh /bin/wait_for_jenkins_login.sh
ENTRYPOINT ["/bin/wait_for_jenkins_login.sh"]

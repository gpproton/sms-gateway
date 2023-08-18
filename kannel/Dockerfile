FROM debian:bullseye-slim

RUN apt-get update && \
    apt-get upgrade && \
    apt-get install -y curl kannel=1.4.5-9 kannel-extras=1.4.5-9

COPY kannel.sample.conf /etc/kannel/kannel.conf
RUN mkdir -p /usr/local/sbin
RUN ln /usr/sbin/smsbox /usr/local/sbin/smsbox
RUN ln /usr/sbin/bearerbox /usr/local/sbin/bearerbox

ENTRYPOINT ["/usr/sbin/bearerbox"]
CMD [ "/etc/kannel/kannel.conf" ]

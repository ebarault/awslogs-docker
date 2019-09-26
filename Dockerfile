FROM amazonlinux:2018.03.0.20180424
MAINTAINER "@ebarault"

RUN yum update -y && \
    yum install -y \
      awslogs \
      logrotate \
      cronie && \
    yum clean all

# use our own logrotate cron.daily script to collect logrotate logs
RUN rm -f /etc/cron.daily/logrotate
COPY logrotate.cron.daily /etc/cron.daily/logrotate
RUN chmod +x /etc/cron.daily/logrotate

# make sure logrotate logs are rotated
COPY logrotate.logrotate.d /etc/logrotate.d/logrotate

COPY start.sh /start.sh
RUN chmod +x /start.sh

# HEALTHCHECK --interval=30s --start-period=10s --timeout=5s --retries=3 \
# 	CMD service awslogs status | grep -v running && exit 1 || exit 0

CMD ["/start.sh"]

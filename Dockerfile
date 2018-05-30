FROM amazonlinux:2018.03.0.20180424

RUN yum update -y && \
    yum install -y awslogs && \
    yum clean all

COPY start.sh /start.sh
RUN chmod +x /start.sh

# HEALTHCHECK --interval=30s --start-period=10s --timeout=5s --retries=3 \
# 	CMD service awslogs status | grep -v running && exit 1 || exit 0

CMD ["/start.sh"]

/var/log/logrotate.log
{
    rotate 4
    size 10M
    daily
    missingok
    notifempty
    delaycompress
    compress
    copytruncate
}

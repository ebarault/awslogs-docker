/var/log/logrotate.log
{
    rotate 4
    size 100M
    daily
    missingok
    notifempty
    delaycompress
    compress
    copytruncate
}

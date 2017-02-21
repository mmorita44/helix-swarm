#!/bin/bash

set -e

cron

if [ ! -e /var/run/configure-swarm ]; then
    
    # Set up a recurring task to spawn workers
    echo "* * * * * nobody wget -q -O /dev/null --no-check-certificate -T5 https://$HOSTNAME/queue/worker" >> /etc/cron.d/helix-swarm

    # configure swarm
    /opt/perforce/swarm/sbin/configure-swarm.sh -p "$P4PORT" -u "$P4USER" -w "$P4PASSWD" -H "$HOSTNAME" -e "$MXHOST"
fi

for i in `seq 20`; do
    test -e /var/run/apache2/apache2.pid && break
    sleep 2
done
exec ls -1v --color=never /var/log/apache2/* | xargs tail -f
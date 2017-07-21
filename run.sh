#!/bin/bash

set -e

# Start the cron service
cron

# Check the swarm was configured
if [ ! -e /var/run/configure-swarm ]; then
    
    # Set up a recurring task to spawn workers
    echo "* * * * * nobody wget -q -O /dev/null --no-check-certificate -T5 https://$HOSTNAME/queue/worker" >> /etc/cron.d/helix-swarm

    # Configure the swarm
    /opt/perforce/swarm/sbin/configure-swarm.sh -n \
       -p "$P4PORT" \
       -u "$P4USER" \
       -w "$P4PASSWD" \
       -H "$HOSTNAME" \
       -e "$MXHOST"
fi

# Check the apache service is run.
for i in `seq 20`; do
    test -e /var/run/apache2/apache2.pid && break
    sleep 2
done

# Monitor log files
exec ls -1v --color=never /var/log/apache2/* | xargs tail -f

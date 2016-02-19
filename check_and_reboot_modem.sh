#! /bin/sh

#configuration
MODEM_IP=192.168.100.254

STAMP=/tmp/wait_for_modem.stamp
TMPSTAMP=/tmp/tmp.stamp
WAITTIME=10
PACKETCOUNT=4

if ping -q -c $PACKETCOUNT $MODEM_IP > /dev/null && ! ping -q -c $PACKETCOUNT www.google.com > /dev/null; then
	if [ -f $STAMP ]; then
		touch $TMPSTAMP -d "-$WAITTIME minutes"

		if [ $TMPSTAMP -ot $STAMP ]; then
			echo "Assuming modem is still booting. Waiting..."
		else
			echo "Modem is still borked."
			rm $STAMP;
		fi
	else
		echo "Cannot connect remotely, but modem is up. => rebooting."
		echo

		$(dirname $0)/reboot_modem.expect $MODEM_IP

		touch $STAMP
	fi
else
	rm -f $STAMP
fi

rm -f $TMPSTAMP

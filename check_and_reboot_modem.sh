#! /bin/sh

STAMP=/tmp/wait_for_modem.stamp
TMPSTAMP=/tmp/tmp.stamp

if ping -q -c 1 10.1.1.1 > /dev/null && ! ping -q -c 1 8.8.8.8 > /dev/null; then
	if [ -f $STAMP ]; then
		touch $TMPSTAMP -d "-10 minutes"

		if [ $TMPSTAMP -ot $STAMP ]; then
			echo "Assuming modem is still booting. Waiting..."
		else
			echo "Modem is still borked."
			rm $STAMP;
		fi
	else
		echo "Cannot connect remotely, but modem is up. => rebooting."
		echo

		$(dirname $0)/reboot_modem.expect

		touch $STAMP
	fi
else
	rm -f $STAMP
fi

rm -f $TMPSTAMP

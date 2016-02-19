# Netgear Modem Rebooter

A cron script to reboot old netgear ADSL modems

This works by pinging the modem to see if it's accessible (it's assumed that some some other script or cron job is keeping the modem connection up), and if it is, and we can't ping `www.google.com`, we soft reboot the modem with an expect script.

It expects to be run every 5 minutes and will wait at least 10 minutes after rebooting the modem for it to reconnect. I strongly recommend you do not run it more frequently than this as it can take some time for ping to fail when there is no connectivity.

This successfully deals with almost all connection issues and generally "fixes" modem connectivity loss within 10 minutes, and I generally only notice that I've had connectivity issues when I see the emails from cron in my inbox.

## Dependencies
* standard TCP ping
* expect
* telnet

Running
`apt-get install iputils-ping expect telnet`
on debian should ensure that everything required is installed.

## Modem / Router Requirements

The router _MUST_ have the telnet port open and provide a command prompt on it and the server this runs on _MUST_ be able to connect to this. (I.e. "inside" your home network)

## How it works

The shell script is just a lot of plumbing around pinging the modem's IP address and `www.google.com`.

The expect script spawns telnet, connects to the modem, logs in with the default username and password, then issues a reboot command.

## Configuration

The IP address for the modem is set at the top of the shell script and the server we ping, `www.google.com` is hard coded.

The shell script also has a few configuration variables at the top (wait time after rebooting, number of attempts ping should try, temporary files, etc.)

## Known Bugs

* The expect script does not deal gracefully with the modem not responding to commands
* There is no option to do anything beyond just soft rebooting the modem. This is occasionally not enough to fix connectivity issues, particularly when the modem is hot.

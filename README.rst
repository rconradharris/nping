=====================
nping - Ping notifier
=====================

Send a notification when a machine becomes pingable.

Let's say you're working on a server that takes a while to boot up and you
eventually need to reboot it. Rather stare at the output of the ``ping``
command directly, you can run ``nping`` with the same arguments you would pass
to ``ping`` and it will generate a terminal notification when the machine
comes back up.

You can also generate a notification to your phone via the wonderful Pushover
(https://pushover.net/) app. So feel free to leave your desk and grab a
coffee!

Requirements
============

terminal-notifier
curl (if using Pushover)

Installation
============

First make sure terminal-notifier is installed::

    brew install terminal-notifier


Then, either copy the 'nping` function into your ``.bash_profile`` directly,
or have your profile source ``nping.sh`` like so::

    source /Documents/code/nping/nping.sh


Configuring Pushover
====================

To use Pushover, set the following environment variables::

    export NPING_PUSHOVER_TOKEN=<your-token-here>
    export NPING_PUSHOVER_USER=<your-username-here>

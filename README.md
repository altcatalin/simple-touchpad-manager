simple-touchpad-manager
=======================

Enable/Disable Touchpad when an USB mouse is plugged/unplugged. This is a workaround when your touchpad is not recognized and [touchpad-indicator](https://launchpad.net/touchpad-indicator) is not working.

Requirements
------------

 * [Net::DBus](http://search.cpan.org/~danberr/Net-DBus-1.0.0/lib/Net/DBus.pm)
 * [HAL - Hardware Abstraction Layer](http://www.freedesktop.org/wiki/Software/hal/)

Installation
------------

 * Clone repository.
 * Run `xinput` for touchpad identification and change the value of `$touchpad` variable.
 * Add script to startup.

#!/usr/bin/perl -w
use strict;
use Net::DBus;
use Net::DBus::Reactor;

my $bus = Net::DBus->system;
my $service = $bus->get_service ( 'org.freedesktop.Hal' );
my $object = $service->get_object ( '/org/freedesktop/Hal/Manager' , 'org.freedesktop.Hal.Manager' );

# touchpad
my $touchpad = '';
$touchpad =~ s/\s/\\ /gis;

# touchpad id
my @ids = ( `xinput | grep $touchpad` =~ /id=(\d+)/g );

if (scalar(@ids) > 1) {
    print "Error! Multiple devices with same name!\n";
    print `xinput | grep $touchpad`;
    exit 1;
}

# init
touchpadState();
$object->connect_to_signal ( "DeviceAdded" , sub { touchpadState(); });
$object->connect_to_signal ( "DeviceRemoved" , sub { touchpadState(); });

my $reactor = Net::DBus::Reactor->main();
$reactor->run();

# change touchpad state
sub touchpadState {

    # how many mice we have?
    my @devices = split(/\n/, `ls /dev/input | grep mouse`);

    # more than one mouse in the house! - disable touchpad
    if (scalar(keys @devices) > 1) {
        `xinput set-prop $ids[0] "Device Enabled" 0`;
        print "Touchpad ($touchpad) disabled!\n";
    }
    else {
        `xinput set-prop $ids[0] "Device Enabled" 1`;
        print "Touchpad ($touchpad) enabled!\n";
    }
}
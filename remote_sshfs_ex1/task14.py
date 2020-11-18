#!/usr/bin/python

# Dependencies
from mininet.net import Mininet
from mininet.topo import Topo
from mininet.cli import CLI
from mininet.node import OVSSwitch, RemoteController
from mininet.log import setLogLevel, info

# Enable logging to the terminal
setLogLevel( 'info' )

# Initialize Mininet
net = Mininet( switch=OVSSwitch, controller=RemoteController, build=False )
# Add remote controller
net.addController( 'c0', port=6653 ) # use Floodlight's default OF port

#! TODO: add hosts
#! TODO: add switches
#! TODO: add links

# Start Mininet
info( '=== Starting Mininet ===\n' )
net.build()
net.start()

#! TODO: fill ARP caches of all hosts

# Start CLI
CLI( net )
# When user exits CLI, stop Mininet
info( '=== Stopping Mininet ===\n' )
net.stop()


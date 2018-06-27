#!/usr/bin/env ruby

# This script prepares a dataplane environment on vlan 2 by building a subnet
#  172.16.0.1/24, assigning 172.16.0.2 and .3 to policies that provide
#  unfettered access, and by installing a forward of tcp and udp ports 23232
#  and 23233 to 172.16.0.3 (the data interface).
#
# This all assumes:
#  - that what the script builds below doesn't already exist.
#  - that the dataplane is using 172.16.0.2 to communicate out to the
#    controller, and 172.16.0.3 (on port 23232/23233) to tunnel traffic back to
#    the internal network.

# get rails env
require '/space/rxg/console/config/boot_script_environment'

# disable paging (for pasting into pry)
_pry_.config.pager = false

# dict
name_prefix = 'vSZ-D'
local_interface_id = 2
local_ip = '172.16.0.1'
mask = '255.255.255.0'
local_vlan = 2
mgmt_ip = '172.16.0.2'
data_ip = '172.16.0.3'
data_port_name = 'tunnel'
data_ports = [23232, 23233]

# build vlan 2
v = Vlan.new(
  :name => name_prefix,
  :interface_id => local_interface_id,
  :mtu => 1500,
  :tag => local_vlan
)
v.save()

# build the network address
net = Address.new(
  :name => 'LAN-' + name_prefix,
  :vlan => v,
  :primary => true,
  :ip => local_ip,
  :subnet => mask,
  :span => 1,
  :autoincrement => 1
)
net.save()

# build vSZ-D-mgmt policy/group
pm = Policy.new(:name => name_prefix + '-mgmt')
pm.save()
ipm = Ip.new(:ip => mgmt_ip)
ipm.save()
ipgm = IpGroup.new(
  :name => name_prefix + '-mgmt',
  :policy => pm,
  :priority => 9,
  :ips => [ipm]
)
ipgm.save()

# build vSZ-D-data policy/group
pd = Policy.new(:name => name_prefix + '-data')
pd.save()
ipd = Ip.new(:ip => data_ip)
ipd.save()
ipgd = IpGroup.new(
  :name => name_prefix + '-data',
  :policy => pd,
  :priority => 9,
  :ips => [ipd]
)
ipgd.save()

# build port forward
p = NetApp.new(:name => data_port_name)
p.protocol = 'tcp udp'
p.destination_ports = data_ports.join(',')
p.save()
fwd = NetAppForward.new(
  :name => name_prefix + '-data',
  :policy => pd,
  :policy_mode => 'first',
  :net_apps => [p],
  :direction => 'inbound'
)
fwd.save()




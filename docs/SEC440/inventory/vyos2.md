# vyos1

## Networking

- eth0 is 10.0.17.83/24

- eth1 is 10.0.5.3/24

- eth2 is 10.0.6.2/24

![image](https://user-images.githubusercontent.com/54637271/131581945-e928e311-3476-4025-821d-f5c057b030cd.png)

## Initial Configuration

- Set interface addresses and descriptions

```
set interfaces ethernet eth0 address '10.0.17.83/24'

set interfaces ethernet eth0 description 'WAN'

set interfaces ethernet eth1 address '10.0.5.3/24'

set interfaces ethernet eth1 description 'LAN'

set interfaces ethernet eth2 address '10.0.6.2/24'

set interfaces ethernet eth2 description 'OPT'
```

- Set hostname and name server

```
set system host-name 'vyos2-lucas'

set system name-server '10.0.17.2'
```

- Create nat source rules for masquerading

```
set nat source rule 10 description 'NAT FROM LAN to WAN'

set nat source rule 10 outbound-interface 'eth0'

set nat source rule 10 source address '10.0.5.0/24'

set nat source rule 10 translation address 'masquerade'
```

- Set static route to gateway

```
set protocols static route 0.0.0.0/0 next-hop 10.0.17.2
```

- Set dns forwarding from WAN and LAN subnets

```
set service dns forwarding allow-from '10.0.5.0/24'

set service dns forwarding allow-from '10.0.17.0/24'

set service dns forwarding listen-address '10.0.5.1'

set service dns forwarding listen-address '10.0.17.113'
```

## Create VRRP groups for redundancy

- LAN

```
set high-availability vrrp group SEC440-LAN interface 'eth1'

set high-availability vrrp group SEC440-LAN preempt-delay '10'

set high-availability vrrp group SEC440-LAN priority '100'

set high-availability vrrp group SEC440-LAN virtual-address '10.0.5.1/24'

set high-availability vrrp group SEC440-LAN vrid '10'
```

- WAN

```
set high-availability vrrp group SEC440-WAN interface 'eth0'

set high-availability vrrp group SEC440-WAN preempt-delay '10'

set high-availability vrrp group SEC440-WAN priority '100'

set high-availability vrrp group SEC440-WAN virtual-address '10.0.17.113/24'

set high-availability vrrp group SEC440-WAN vrid '20'
```

## Port Forwarding

- Create nat destination rules for HTTP

```
set nat destination rule 10 description 'Port Forwarding HTTP from WAN to Web01'

set nat destination rule 10 destination port '80'

set nat destination rule 10 inbound-interface 'eth0'

set nat destination rule 10 protocol 'tcp'

set nat destination rule 10 translation address '10.0.5.100'
```

- Create nat destination rules for SSH
```
set nat destination rule 20 description 'Port Forwarding SSH from WAN to Web01'

set nat destination rule 20 destination port '22'

set nat destination rule 20 inbound-interface 'eth0'

set nat destination rule 20 protocol 'tcp'

set nat destination rule 20 translation address '10.0.5.100'
```

- Set SSH listener to WAN virtual IP
```
set service ssh listen-address '10.0.5.1'
```

## Configuration File
[vyos2.week1.txt](https://github.com/lkaine24/Tech-Journal/blob/master/docs/SEC440/vyos/vyos2.week1.txt)

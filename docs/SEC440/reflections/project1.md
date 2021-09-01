# Project 1 Reflection

## Chronological Discussion

8/30/21

- Networked xubuntu wan

- Networked xubuntu lan

- Networked vyos1

- Networked web01, installed httpd, disabled root SSH, enabled MFA

8/31/21

- Networked vyos2

- Created high-availability VRRP groups on vyos1 and vyos2 for both LAN and WAN

- Set priority higher on vyos1 than on vyos2

- Port forwarded SSH and HTTP on both vyos1 and vyos2

## Trials, Tribulations, and Lessons Learned

A problem that I ran into with this lab was setting up redundancy for both WAN and LAN interfaces on both vyos machines. This wasn't something that I've done before so I had to read vyOS documentation to set it up properly.

Another problem that I ran into was that after I had set up the virtual IP's for each VRRP group and changed the gateway of each endpoint to reflect that, DNS forwarding stopped working. I realized that this was because I had not set up DNS forwarding listeners on the virtual IP's that I had created. After setting these up on vyOS, it started to work again. 

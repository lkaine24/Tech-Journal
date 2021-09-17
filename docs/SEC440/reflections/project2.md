# Project 2 Reflection

## Chronological Discussion

9/13/21
- Added OPT interface to vyos1 and vyos2
- Added VRRP group for OPT on vyos1 and vyos2
- Networked ha1, ha2, and web02
- Added custom landing page for both web01 and web02
- Installed nginx and configured round robin load balancing on both ha1 and ha2
- Installed and configured keepalived on both ha1 and ha2
- Changed nat destination rule to port forward http traffic to ha's virtual IP instead of web01

9/17/21
- Completed tech journal for project 2

## Trials, Tribulations, and Lessons Learned

The main problem that I ran into originally was creating high availability load balancers with nginx. To do it soley with nginx, you have to obtain nginx+ which costs some money. I was able to work around this problem by utilizing keepalived, which allowed me to create a vrrp for both HA's similarly to how it was done for vyos1 and vyos2 for LAN, WAN, and OPT.

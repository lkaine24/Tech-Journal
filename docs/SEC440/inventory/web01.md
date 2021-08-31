# web01

## Networking

- ens192 is 10.0.5.100

## Install Google PAM

```
sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

sudo yum install google-authenticator
```

## Run google-authenticator

```
google-authenticator
```

## Answer prompts

```
Do you want authentication tokens to be time-based (y/n) y

Do you want me to update your "/home/<user>/.google_authenticator" file (y/n) y

Do you want to disallow multiple uses of the same authentication token? This restricts you to one login about every 30s, but it increases your chances to notice or even prevent man-in-the-middle attacks (y/n) y

By default, tokens are good for 30 seconds. In order to compensate for possible time-skew between the client and the server, we allow an extra token before and after the current time. If you experience problems with poor time synchronization, you can increase the window from its default size of +-1min (window size of 3) to about +-4min (window size of 17 acceptable tokens). Do you want to do so? (y/n) n

If the computer that you are logging into isn't hardened against brute-force login attempts, you can enable rate-limiting for the authentication module. By default, this limits attackers to no more than 3 login attempts every 30s. Do you want to enable rate-limiting (y/n) y
```

## Configure SSH

- Open the following file with a text editor

`sudo vim /etc/pam.d/sshd`

- Add the following to the bottom of this file

![image](https://user-images.githubusercontent.com/54637271/131584018-0e504f88-ed0c-4b25-b307-9d72926afa61.png)

- Open the following file with a text editor for SSH to support MFA. Make sure the yes line is uncommented and the no line is commented

`sudo vim /etc/ssh/sshd_config`

![image](https://user-images.githubusercontent.com/54637271/131584209-577c0adc-6aea-41e8-9f70-96e7c0b669a4.png)

## Restart SSH

`sudo systemctl restart sshd.service`

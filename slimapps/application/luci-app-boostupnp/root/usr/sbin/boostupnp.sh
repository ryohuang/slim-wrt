#!/bin/sh


upnplog(){
    echo "$1"
    logger boostupnp  "$1"
}

# get public ip address
ip=$(curl -s https://api.ipify.org)
upnplog "My public IP address is: $ip"

# check public ip
if [ -z "$ip" ];then
    upnplog "No validate public IP, exit !"
exit
fi


if expr "$ip" : '[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*\.[0-9][0-9]*$' >/dev/null; then
  upnplog "Validate public IP"
else
  upnplog "Wrong IP address"
  exit
fi

# get upnp configed external ip
upnp_ext_ip=$(uci get upnpd.config.external_ip)
upnplog "My upnp external IP address is: $upnp_ext_ip"


if [ "$ip" = "$upnp_ext_ip" ];then
    upnplog "Upnp external IP up to date. Exit."
    exit
fi

# ok, set new external ip to upnp
uci set upnpd.config.external_ip=$ip
uci commit upnpd

# restart upnpd
/etc/init.d/miniupnpd restart &

upnplog "Configed new external for upnp: $ip"

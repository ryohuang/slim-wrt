-- Copyright 2008 Steven Barth <steven@midlink.org>
-- Copyright 2008-2011 Jo-Philipp Wich <jow@openwrt.org>
-- Licensed to the public under the Apache License 2.0.

m = Map("upnpd", luci.util.pcdata(translate("Universal Plug & Play")),
	translate("UPnP allows clients in the local network to automatically configure the router."))


s = m:section(NamedSection, "config", "upnpd", translate("MiniUPnP extra settings"))
s.addremove = false
s:tab("general",  translate("Settings for router behined DMZ"))


s:taboption("general", Value, "external_iface", translate("External Network Interface"),
	translate("usually is wan")).rmempty = true

s:taboption("general", Value, "internal_iface", translate("Internal Network Interface"),
	translate("usually is lan")).rmempty = true

return m

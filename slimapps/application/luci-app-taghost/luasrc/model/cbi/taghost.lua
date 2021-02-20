local sys = require "luci.sys"
local ifaces = sys.net:devices()
local log = luci.util.perror
local uci = require("luci.model.uci").cursor()


m = Map("dhcp", translate("Tag your device"),
        translatef("Tag a device and set another gateway for it."))



-- device list 
devices = m:section(TypedSection, "host", translate("Bind to tag"))
devices.template = "cbi/tblsection"
devices.anonymous = true
devices.addremove = true

a = devices:option(Value, "name", translate("Device Name"))
a.datatype = "string"
a.optional = false

a = devices:option(Value, "mac", translate("MAC Address"))
a.datatype = "macaddr"
a.optional = false
luci.ip.neighbors({family = 4}, function(neighbor)
        if neighbor.reachable then
                a:value(neighbor.mac, "%s (%s)" %{neighbor.mac, neighbor.dest:string()})
        end
end)

a = devices:option(Value, "tag", translate("Device Tag"))
a.datatype = "string"
a.optional = false

uci:foreach("dhcp","tag",
        function(i)
                -- log(i['.name'])
                a:value(i['.name'])
        end)

-- dhcp section
t = m:section(TypedSection, "tag", translate("DHCP tags"))
t.addremove = true
t.anonymous = false

a = t:option(DynamicList, "dhcp_option", translate("dhcp_option"),translate("3 means gateway and 6 means dns") )
a.optional = false
a.datatype = "string"

return  m


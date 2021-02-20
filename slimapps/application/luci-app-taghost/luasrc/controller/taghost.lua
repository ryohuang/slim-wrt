--[[
给设备加tag以指定不同网关
]]--

module("luci.controller.taghost", package.seeall)

function index()
        if not nixio.fs.access("/etc/config/dhcp") then
                return
        end
        entry({"admin", "network", "taghost"}, cbi("taghost"), _("TAG HOST"), 45).dependent = true
end

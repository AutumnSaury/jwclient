--[[
LuCI - Lua Configuration Interface
Copyright 2010 Jo-Philipp Wich <xm@subsignal.org>
Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at
	http://www.apache.org/licenses/LICENSE-2.0
]]--

require("luci.sys")

m = Map("jwclient", translate("Joywise Client"), translate("A Joywise campus network client for OpenWRT."))
s = m:section(TypedSection, "userinfo", "User Information", "Information needed to get access to your campus network")
s.addremove = false
s.anonymous = true

enable = s:option(Flag, "enable", translate("Enable"))
username = s:option(Value, "username", translate("Username"))
pwd = s:option(Value, "pwd", translate("Password"))
pwd.password = true
ifname = s:option(ListValue, "ifname", translate("Interfaces"))


for _, v in pairs(luci.sys.net.devices()) do
    if v ~= "lo" then ifname:value(v) end
end

local apply = luci.http.formvalue("cbi.apply")
if apply then
	io.popen("/etc/init.d/jwclient restart")
end

return m

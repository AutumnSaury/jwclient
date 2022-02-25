module("luci.controller.jwclient", package.seeall)

function index()
        entry({"admin", "network", "jwclient"}, cbi("jwclient"), _("Joywise Client"), 100)
        end
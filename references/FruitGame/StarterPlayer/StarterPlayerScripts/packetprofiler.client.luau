 

local v1 = game:GetService("Players").LocalPlayer
if v1.Name == "Phoeating" then
    local v2 = script.Components
    local v3 = script.Modules
    local v4 = require(v3.Packages)
    v4.IsPlugin = false
    local v5 = require(v4.Directory.Roact)
    local v6 = require(v2.MainPlugin)
    local v7 = v5.createElement(v6)
    v5.mount(v7, v1.PlayerGui, "PacketProfiler")
end
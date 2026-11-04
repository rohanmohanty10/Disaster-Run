 

local _ = workspace.CurrentCamera
game:GetService("RunService")
local v1 = require(script.WindShake)
v1:SetDefaultSettings({
    ["WindSpeed"] = 20,
    ["WindDirection"] = Vector3.new(1, 0, 0.3),
    ["WindPower"] = 0.5
})
v1:Init()
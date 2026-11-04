 

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v3 = v1.Modules
local _ = v2.LocalPlayer
require(v3.ContextActionService)
local v4 = require(script.Parent.Shared)
local u5 = setmetatable({}, v4)
u5.__index = u5
function u5.new(p6) --[[ Line: 16 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    local v7 = u5
    local v8 = setmetatable({}, v7)
    v8.Mobile = p6
    v8.Button = v8:_createButton({
        ["ButtonData"] = p6.SavedButtons[script.Name],
        ["Texture"] = "rbxassetid://17653706771",
        ["Name"] = script.Name
    })
    return v8
end
function u5.Activated(_) --[[ Line: 29 ]]
    _G.swimmingDecension = true
end
function u5.Deactivated(_) --[[ Line: 33 ]]
    _G.swimmingDecension = false
end
function u5.Update(p9) --[[ Line: 37 ]]
    p9.Button.Visible = _G.swimming or p9.Mobile.EditMode.Editting
end
return u5
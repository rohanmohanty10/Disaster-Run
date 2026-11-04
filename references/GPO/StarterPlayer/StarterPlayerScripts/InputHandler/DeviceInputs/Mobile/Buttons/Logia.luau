 

local v1 = game:GetService("ReplicatedStorage")
local v2 = game:GetService("Players")
local v3 = v1.Modules
local u4 = v2.LocalPlayer
local u5 = u4.PlayerGui
require(v3.ContextActionService)
local v6 = require(script.Parent.Shared)
local u7 = setmetatable({}, v6)
u7.__index = u7
function u7.new(p8) --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u7
    --]]
    local v9 = u7
    local v10 = setmetatable({}, v9)
    v10.Button = v10:_createButton({
        ["ButtonData"] = p8.SavedButtons[script.Name],
        ["Button"] = v10:_getButton(),
        ["Name"] = script.Name
    })
    return v10
end
function u7._getButton(_) --[[ Line: 29 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
    --]]
    if not u4.Character then
        u4.CharacterAdded:Wait()
    end
    return u5:WaitForChild("Modes"):WaitForChild("Frame"):WaitForChild("GeneralBars"):WaitForChild("Logia")
end
return u7
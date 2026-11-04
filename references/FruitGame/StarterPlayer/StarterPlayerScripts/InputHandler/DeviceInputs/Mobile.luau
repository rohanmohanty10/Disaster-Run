 

local v1 = game:GetService("ReplicatedStorage")
game:GetService("Players")
local v2 = v1.Modules
local u3 = v1.Events.GetButtons
local u4 = workspace.CurrentCamera
local u5 = require(v2.ContextActionService)
local u8 = {
    ["EditMode"] = require(script.EditMode),
    ["Buttons"] = require(script.Buttons),
    ["_getViewportSize"] = function(_) --[[ Name: _getViewportSize, Line 20 ]]
        --[[
        Upvalues:
            [1] = u4
        --]]
        while u4.ViewportSize == Vector2.one do
            u4:GetPropertyChangedSignal("ViewportSize"):Wait()
        end
        return u4.ViewportSize
    end,
    ["Initialize"] = function(p6) --[[ Name: Initialize, Line 29 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u8
            [3] = u3
        --]]
        local _, _, v7 = u5:GetMobileUI()
        u8.SavedButtons = u3:InvokeServer({
            ["Increments"] = u8.EditMode.Increment,
            ["ViewportSize"] = p6:_getViewportSize(),
            ["JumpButtonSize"] = v7.AbsoluteSize
        })
        u8.EditMode:Initialize(p6)
        u8.Buttons:Initialize(p6)
        warn("Mobile")
    end
}
return u8
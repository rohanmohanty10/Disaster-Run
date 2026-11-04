 

game:GetService("ReplicatedStorage")
local v1 = game:GetService("Players")
local u2 = game:GetService("UserInputService")
local v3 = game:GetService("ReplicatedStorage")
local v4 = require(v3.Modules.Shared.GameUtils)
local v5 = v3.Modules
local u6 = v1.LocalPlayer
local u7 = require(v5.ContextActionService)
local v8 = require(script.Parent.Shared)
local u9 = setmetatable({}, v8)
u9.__index = u9
local u10 = v4.GetStatsFolder(u6)
function u9.new(_) --[[ Line: 22 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u7
        [3] = u2
    --]]
    local v11 = u9
    local u12 = setmetatable({}, v11)
    local _, v13 = u7:GetMobileUI()
    local v14 = v13:WaitForChild("DynamicThumbstickFrame", 2) or v13:WaitForChild("ThumbstickFrame")
    u12.Thread = nil
    u12.RunRadius = 25
    v14.InputBegan:Connect(function(p15, p16) --[[ Name: InputBegan, Line 28 ]]
        --[[
        Upvalues:
            [1] = u12
        --]]
        if p16 then
            return
        elseif p15.UserInputType == Enum.UserInputType.Touch then
            u12:Activated()
        end
    end)
    u2.InputEnded:Connect(function(p17) --[[ Name: InputEnded, Line 34 ]]
        --[[
        Upvalues:
            [1] = u12
        --]]
        if p17.UserInputType == Enum.UserInputType.Touch then
            u12:Deactivated()
        end
    end)
    return u12
end
function u9.Activated(u18) --[[ Line: 48 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u2
        [3] = u10
    --]]
    u18:Deactivated()
    local u19 = require(u6.Backpack:WaitForChild("InputCallbacks"))
    local u20 = u2:GetMouseLocation()
    local function v23() --[[ Line: 54 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u20
            [3] = u10
            [4] = u18
            [5] = u19
        --]]
        while task.wait() do
            local v21 = (u2:GetMouseLocation() - u20).Magnitude
            local v22 = u10.Settings.AutoRun.Value == true
            if (u18.RunRadius < v21 or v22 == true) and _G.running == false then
                _G.running = true
                u19.Callbacks.Run.HoldingRun = true
                task.spawn(u19.Callbacks.Run.PC_Activate, u19.Callbacks.Run)
            elseif v21 < u18.RunRadius and v22 == false then
                _G.running = false
                u19.Callbacks.Run.HoldingRun = false
            end
        end
    end
    u18.Thread = task.spawn(v23)
end
function u9.Deactivated(p24) --[[ Line: 75 ]]
    if p24.Thread and coroutine.status(p24.Thread) ~= "dead" then
        task.cancel(p24.Thread)
        p24.Thread = nil
    end
end
return u9
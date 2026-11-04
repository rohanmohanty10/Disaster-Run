 

local v1 = script.Parent
local u2 = nil
local u3 = nil
local u4 = nil
local u5 = nil
local u6 = false
local u7 = {}
local v8 = game:FindService("Players")
local v9 = v8.LocalPlayer or v8.PlayerAdded:Wait()
local v10 = game:GetService("ReplicatedStorage")
local u11 = nil
u11 = v1:BindToMessage("Setup", function(p12, p13, p14) --[[ Line: 32 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u4
        [4] = u5
        [5] = u6
        [6] = u11
    --]]
    u2 = p12
    u3 = p13
    u4 = p14
    u5 = require(p14)
    u6 = true
    u11:Disconnect()
end)
repeat
    task.wait()
until u6
local v15 = game:GetService("CollectionService")
local v16 = game:GetService("RunService")
local u17 = u5.new()
local v18 = u4.Dependencies
require(v18.Debug.DebugUi)
require(v18.Config)
local u19 = require(v18.Utilities)
u4:WaitForChild("OverlayEvent")
local v20 = v10:WaitForChild("Stats" .. game.Players.LocalPlayer.Name, 600)
if v20 then
    local u21 = v20:WaitForChild("Settings"):WaitForChild("AnimatedHats")
    local u22 = false
    shared.FrameCounter = 0
    local u23 = os.clock
    local u24 = u23()
    local u25 = {}
    local u26 = 60
    local function u35() --[[ Line: 90 ]]
        --[[
        Upvalues:
            [1] = u23
            [2] = u25
            [3] = u24
            [4] = u26
        --]]
        local v27 = u23()
        for v28 = #u25, 1, -1 do
            local v29 = u25
            local v30 = v28 + 1
            local v31
            if u25[v28] >= v27 - 1 then
                v31 = u25[v28] or nil
            else
                v31 = nil
            end
            v29[v30] = v31
        end
        u25[1] = v27
        local v32 = v27 - u24
        local v33 = v32 >= 1 and #u25 or #u25 / v32
        u26 = math.floor(v33)
        local v34 = (u26 * (1 / u26) ^ 2 + 0.001) * 1000 + 0.5
        return math.floor(v34) / 1000
    end
    v1.Name = ("%* - %*"):format(u2.Name, u17.ID)
    local u36 = u2:IsDescendantOf(v9.Character)
    u17:LoadObject(u2)
    for _, v37 in u3 do
        u17:LoadRawCollider(v37[1], v37[2])
    end
    local v41 = v15:GetInstanceAddedSignal("SmartCollider"):Connect(function(p38) --[[ Line: 150 ]]
        --[[
        Upvalues:
            [1] = u2
            [2] = u19
            [3] = u17
        --]]
        if p38:IsA("BasePart") then
            local v39 = p38:GetAttribute("ColliderKey")
            local v40 = u2:GetAttribute("ColliderKey")
            if tostring(v39) == tostring(v40) then
                u17:LoadRawCollider(u19.GetCollider(p38), p38)
            end
        else
            return
        end
    end)
    u7[#u7 + 1] = v41
    local v42 = v1:BindToMessage("Destroy", function() --[[ Line: 167 ]]
        --[[
        Upvalues:
            [1] = u22
        --]]
        u22 = true
    end)
    u7[#u7 + 1] = v42
    local u43 = false
    local v46 = v16.Heartbeat:ConnectParallel(function(_) --[[ Line: 173 ]]
        --[[
        Upvalues:
            [1] = u21
            [2] = u36
            [3] = u43
            [4] = u17
            [5] = u35
            [6] = u22
            [7] = u7
            [8] = u2
            [9] = u3
            [10] = u4
            [11] = u5
        --]]
        local v44 = shared
        v44.FrameCounter = v44.FrameCounter + 1
        if shared.FrameCounter > 131072 then
            shared.FrameCounter = 0
        end
        if u21.Value == false or u36 == false then
            if u43 == false then
                u43 = true
                u17:SkipUpdate()
            end
            return
        else
            u43 = false
            u17:StepBoneTrees((u35()))
            if u17.ShouldDestroy or u22 then
                u17:Destroy()
                task.synchronize()
                for _, v45 in u7 do
                    v45:Disconnect()
                end
                table.clear(u7)
                u2 = nil
                u3 = nil
                u4 = nil
                u5 = nil
            end
        end
    end)
    u7[#u7 + 1] = v46
    local v47 = u2.Destroying:Once(function() --[[ Line: 204 ]]
        --[[
        Upvalues:
            [1] = u22
        --]]
        u22 = true
    end)
    u7[#u7 + 1] = v47
end
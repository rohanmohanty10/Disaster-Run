 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = require(game.ReplicatedStorage.Modules.Skills)
local u4 = require(script.Parent.Parent.MobileBase)
local v5 = require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
v5:GetControls()
local u6 = setmetatable({}, u4)
u6.__index = u6
function u6.new(_) --[[ Line: 20 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u6
    --]]
    local v7 = u4.new(script.Name)
    local v8 = u6
    local v9 = setmetatable(v7, v8)
    v9.Cooldowns = {
        ["upper"] = false,
        ["dash"] = false
    }
    return v9
end
function u6.CrimsonSlice(p10, p11) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v12 = p10.Cooldowns
    local u13 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v12.upper == false and _G.check:inspect(u13) == true then
        local v14 = u3.GetM("Crimson Slice")
        local v15 = v14.cd
        if _G.StamCheck("Crimson Slice") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        local u16 = u13.Humanoid.Animator:LoadAnimation(script.upper)
        u16:Play()
        u16:AdjustWeight(2)
        v12.upper = true
        _G.canuse = false
        u13.Humanoid.WalkSpeed = 4
        local v17 = game.ReplicatedStorage.Events.Skill:InvokeServer("Crimson Slice")
        _G.PauseAnim(u16, 0.35, 1.5)
        local u18 = tick()
        p10:ChargeSkill(p11, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 54 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u16
                --]]
                if _G.check:inspect(u13) == false then
                    u16:Stop()
                    return true
                end
                u13.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 63 ]]
                --[[
                Upvalues:
                    [1] = u13
                    [2] = u18
                --]]
                if u13:FindFirstChild(script.Name) == nil or tick() - u18 >= 10 then
                    return true
                end
            end
        })
        u16:AdjustSpeed(1)
        u13.HumanoidRootPart.Anchored = true
        if v17 then
            task.wait(0.2)
            v17:FireServer(u13.HumanoidRootPart.CFrame)
        end
        task.wait(0.4)
        u13.HumanoidRootPart.Anchored = false
        u13.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Crimson Slice", v15)
        _G.fw(v15)
        v12.upper = false
    end
end
function u6.ReapingSlash(p19, p20) --[[ Line: 92 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v21 = p19.Cooldowns
    local u22 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v21.dash == false and _G.check:inspect(u22) == true then
        local v23 = u3.GetM("Reaping Slash")
        local v24 = v23.cd
        if _G.StamCheck("Reaping Slash") == false then
            return
        end
        if v23.statreq and _G.MeetReq(v23.statreq) == false then
            return
        end
        local u25 = u22.Humanoid.Animator:LoadAnimation(script.dash)
        u25:Play()
        u25:AdjustWeight(2)
        v21.dash = true
        _G.canuse = false
        u22.Humanoid.WalkSpeed = 4
        local v26 = game.ReplicatedStorage.Events.Skill:InvokeServer("Reaping Slash")
        _G.PauseAnim(u25, 0.5, 1)
        p19:ChargeSkill(p20, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 114 ]]
                --[[
                Upvalues:
                    [1] = u22
                    [2] = u25
                --]]
                if _G.check:inspect(u22) == false then
                    u25:Stop()
                    return true
                end
                u22.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 121 ]]
                --[[
                Upvalues:
                    [1] = u22
                --]]
                if u22:FindFirstChild(script.Name) == nil then
                    return true
                end
            end
        })
        u25:AdjustSpeed(2)
        task.wait(0.15)
        u22.Humanoid.AutoRotate = false
        local v27 = u22.HumanoidRootPart.CFrame
        local v28 = Ray.new(u22.HumanoidRootPart.CFrame.Position, u22.HumanoidRootPart.CFrame.LookVector * 30)
        local _, v29 = _G.raycastWhitelist(v28, { workspace.Islands, workspace.Ships, workspace.Env })
        local v30 = (v27.Position - v29).Magnitude - 1
        local _ = v27 * CFrame.new(0, 0, -v30)
        u22.HumanoidRootPart.Anchored = true
        if v26 then
            v26:FireServer(u22.HumanoidRootPart.CFrame, v30)
        end
        task.wait(0.25)
        u25:Stop()
        local v31 = u22.Humanoid.Animator:LoadAnimation(script.slash)
        v31:Play(0)
        v31:AdjustWeight(2)
        task.wait(1)
        u22.Humanoid.AutoRotate = true
        u22.HumanoidRootPart.Anchored = false
        u22.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Reaping Slash", v24)
        _G.fw(v24)
        v21.dash = false
    end
end
return u6
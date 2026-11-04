 

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
        ["pull"] = false,
        ["impale"] = false
    }
    return v9
end
function u6.MochiTridentDrill(u10, p11) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v12 = u10.Cooldowns
    local u13 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v12.impale == false and _G.check:inspect(u13) == true then
        local v14 = u3.GetM("Mochi Trident Drill")
        local v15 = v14.cd
        if _G.StamCheck("Mochi Trident Drill") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        v12.impale = true
        _G.canuse = false
        local u16 = game.ReplicatedStorage.Events.Skill:InvokeServer("Mochi Trident Drill")
        local v17 = u13.Humanoid:LoadAnimation(script.drillWindup)
        v17:Play()
        v17:AdjustWeight(2)
        v17.Priority = Enum.AnimationPriority.Action3
        u13.Humanoid.WalkSpeed = 4
        _G.PauseAnim(v17, 0.12, 1)
        v17:AdjustSpeed(0)
        local u18 = tick()
        u10:ChargeSkill(p11, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 61 ]]
                --[[
                Upvalues:
                    [1] = u13
                --]]
                if _G.check:inspect(u13) == false then
                    return true
                end
                u13.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 68 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u13
                    [3] = u18
                    [4] = u16
                --]]
                if u10.Tool.Parent ~= u13 or (tick() - u18 >= 3 or (_G.check:inspect(u13) == false or u16 == nil)) then
                    return true
                end
            end
        })
        v17:AdjustSpeed(1)
        task.wait(0.1)
        if u16 then
            u16:FireServer(u13.HumanoidRootPart.CFrame)
        end
        task.wait(0.45)
        u13.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Mochi Trident Drill", v15)
        _G.fw(v15)
        v12.impale = false
    end
end
function u6.MochiTridentThrow(p19, p20) --[[ Line: 96 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v21 = p19.Cooldowns
    local u22 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v21.pull == false and _G.check:inspect(u22) == true then
        local v23 = u3.GetM("Mochi Trident Throw")
        local v24 = v23.cd
        if _G.StamCheck("Mochi Trident Throw") == false then
            return
        end
        if v23.statreq and _G.MeetReq(v23.statreq) == false then
            return
        end
        _G.canuse = false
        v21.pull = true
        _G.FaceMouse = true
        local v25 = game.ReplicatedStorage.Events.Skill:InvokeServer("Mochi Trident Throw")
        local v26 = u22.Humanoid.Animator:LoadAnimation(script.throw)
        v26:Play()
        v26:AdjustWeight(2)
        v26.Priority = Enum.AnimationPriority.Action3
        _G.PauseAnim(v26, 0.57, 1)
        local u27 = tick()
        p19:ChargeSkill(p20, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 129 ]]
                --[[
                Upvalues:
                    [1] = u22
                --]]
                if _G.check:inspect(u22) == false then
                    return true
                end
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 135 ]]
                --[[
                Upvalues:
                    [1] = u27
                --]]
                if tick() - u27 >= 3 then
                    return true
                end
            end
        })
        u22.Humanoid.AutoRotate = false
        v26:AdjustSpeed(1)
        task.wait(0.43000000000000005)
        u22.Humanoid.AutoRotate = false
        _G.FaceMouse = false
        u22.HumanoidRootPart.Anchored = true
        local v28 = _G.MouseCF.Position
        local v29 = u22:FindFirstChild(script.Name .. "Sword")
        if v25 then
            local v30
            if v29 then
                v30 = v29:FindFirstChild("Blade")
            else
                v30 = nil
            end
            if v30 then
                v30.Transparency = 1
            end
            v25:InvokeServer({
                ["swordCFrame"] = v29 and v29.Blade.CFrame or u22.PrimaryPart.CFrame,
                ["aimPosition"] = v28
            })
            if v30 then
                v30.Transparency = 0
            end
        end
        task.wait(0.2)
        u22.HumanoidRootPart.Anchored = false
        u22.Humanoid.AutoRotate = true
        _G.canuse = true
        _G.keysetup:cooldown("Mochi Trident Throw", v24)
        _G.fw(v24)
        v21.pull = false
    end
end
return u6
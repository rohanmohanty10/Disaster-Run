 

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
function u6.FireworkParade(p10, p11) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v12 = p10.Cooldowns
    local u13 = u1.Character
    local u14 = u2["Stats" .. u1.Name]
    if v12.upper == false and _G.check:inspect(u13) == true then
        local v15 = u3.GetM("Firework Parade")
        local v16 = v15.cd
        if _G.StamCheck("Firework Parade") == false then
            return
        end
        if v15.statreq and _G.MeetReq(v15.statreq) == false then
            return
        end
        v12.upper = true
        _G.canuse = false
        u13.Humanoid.Animator:LoadAnimation(script.startup):Play()
        local v17 = game.ReplicatedStorage.Events.Skill:InvokeServer("Firework Parade")
        local u18 = tick()
        task.wait(0.3)
        local v19 = u13.Humanoid.Animator:LoadAnimation(script.paradeLoop)
        v19:Play()
        p10:ChargeSkill(p11, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 50 ]]
                --[[
                Upvalues:
                    [1] = u13
                --]]
                u13.Humanoid.Jump = false
                u13.Humanoid.WalkSpeed = 35
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 55 ]]
                --[[
                Upvalues:
                    [1] = u18
                    [2] = u14
                --]]
                if tick() - u18 >= 3 or u14.Stamina.Value <= 0 then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        if v17 then
            v17:FireServer()
        end
        v19:Stop()
        task.wait(0.25)
        u13.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Firework Parade", v16)
        _G.fw(v16)
        v12.upper = false
    end
end
function u6.DashingPyrotechnics(p20, p21) --[[ Line: 85 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v22 = p20.Cooldowns
    local u23 = u1.Character
    local u24 = u2["Stats" .. u1.Name]
    if v22.dash == false and _G.check:inspect(u23) == true then
        local v25 = u3.GetM("Dashing Pyrotechnics")
        local v26 = v25.cd
        if _G.StamCheck("Dashing Pyrotechnics") == false then
            return
        end
        if v25.statreq and _G.MeetReq(v25.statreq) == false then
            return
        end
        local v27, _, _ = _G.getRayFloor(u23.PrimaryPart.CFrame, 5)
        if v27 == nil then
            return nil
        end
        local v28 = u23.Humanoid.Animator:LoadAnimation(script.dash)
        v28:Play()
        v28:AdjustWeight(2)
        v22.dash = true
        _G.canuse = false
        _G.FaceMouse = true
        _G.mouseLevel = true
        local u29 = 0
        local v30 = game.ReplicatedStorage.Events.Skill:InvokeServer("Dashing Pyrotechnics", u23.PrimaryPart.CFrame)
        _G.PauseAnim(v28, 0.5, 1.2)
        local u31 = tick()
        local u32 = 0
        local function v33() --[[ Line: 117 ]]
            --[[
            Upvalues:
                [1] = u23
                [2] = u32
                [3] = u29
            --]]
            u23.Humanoid.Jump = false
            u23.Humanoid.WalkSpeed = 0
            if tick() - u32 >= 0.1 then
                u32 = tick()
                u29 = u29 + 2
            end
        end
        p20:ChargeSkill(p21, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = v33,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 126 ]]
                --[[
                Upvalues:
                    [1] = u31
                    [2] = u24
                --]]
                if tick() - u31 >= 3 or u24.Stamina.Value <= 0 then
                    return true
                end
            end
        })
        u23.PrimaryPart.Anchored = true
        if v30 then
            v30:FireServer(u23.PrimaryPart.CFrame, u29)
        end
        v28:AdjustSpeed(1)
        _G.FaceMouse = false
        _G.mouseLevel = false
        task.wait(1)
        u23.PrimaryPart.Anchored = false
        u23.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Dashing Pyrotechnics", v26)
        _G.fw(v26)
        v22.dash = false
    end
end
return u6
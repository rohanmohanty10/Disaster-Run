 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = require(game.ReplicatedStorage.Modules.Skills)
local u3 = require(script.Parent.Parent.MobileBase)
require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
local u4 = setmetatable({}, u3)
u4.__index = u4
function u4.new(_) --[[ Line: 17 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
    --]]
    local v5 = u3.new(script.Name)
    local v6 = u4
    local v7 = setmetatable(v5, v6)
    v7.Cooldowns = {
        ["BrickFist"] = false,
        ["SeaSplit"] = false,
        ["Dive"] = false,
        ["Surge"] = false,
        ["Feeding"] = false,
        ["trans"] = false,
        ["ult"] = false
    }
    return v7
end
function u4.DemonBrickFist(u8, p9) --[[ Line: 47 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v10 = u8.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local u11 = u1.Character
    if v10.BrickFist == false and (_G.StamCheck("Demon Brick Fist") == true and (_G.canuse == true and _G.check:inspect(u11) == true)) then
        local v12 = u2.GetM("Demon Brick Fist")
        local v13 = v12.cd
        if v12.statreq and _G.MeetReq(v12.statreq) == false then
            return
        end
        v10.BrickFist = true
        _G.canuse = false
        local v14 = u11.Humanoid:LoadAnimation(script.brickCharge)
        v14:Play()
        v14:AdjustWeight(3)
        local u15 = tick()
        _G.FaceMouse = true
        local u16 = game.ReplicatedStorage.Events.Skill:InvokeServer("Demon Brick Fist")
        u8:ChargeSkill(p9, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 69 ]] end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 73 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u11
                    [3] = u15
                    [4] = u16
                --]]
                if u8.Tool.Parent ~= u11 or (tick() - u15 >= 3 or u16 == nil) then
                    return true
                end
            end,
            ["HoldDuration"] = 0.425
        })
        v14:Stop()
        local v17 = u11.Humanoid:LoadAnimation(script.brickRelease)
        v17:Play()
        v17:AdjustWeight(3)
        v17:AdjustSpeed(1.25)
        _G.FaceMouse = false
        u11.PrimaryPart.Anchored = true
        if u16 then
            u16:FireServer(u11.PrimaryPart.CFrame, u8:GetMouseCFrame().Position)
        end
        task.wait(0.75)
        u11.PrimaryPart.Anchored = false
        v17:Stop(0)
        u11.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Demon Brick Fist", v13)
        _G.canuse = true
        _G.fw(v13)
        v10.BrickFist = false
    end
end
function u4.SplittingSeaFist(u18, p19) --[[ Line: 110 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v20 = u18.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local u21 = u1.Character
    if v20.SeaSplit == false and (_G.StamCheck("Splitting Sea Fist") == true and (_G.canuse == true and _G.check:inspect(u21) == true)) then
        local v22 = u2.GetM("Splitting Sea Fist")
        local v23 = v22.cd
        if v22.statreq and _G.MeetReq(v22.statreq) == false then
            return
        end
        local v24, _, _ = _G.getRayFloor(u21.PrimaryPart.CFrame, 5)
        if v24 == nil then
            _G.displayMessage("<Color=Red>I have to touch the ground")
            return nil
        end
        v20.SeaSplit = true
        _G.canuse = false
        local v25 = u21.Humanoid:LoadAnimation(script.splitCharge)
        v25:Play()
        v25:AdjustWeight(3)
        local u26 = tick()
        _G.mouseLevel = true
        _G.FaceMouse = true
        local u27 = game.ReplicatedStorage.Events.Skill:InvokeServer("Splitting Sea Fist")
        u18:ChargeSkill(p19, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 140 ]] end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 144 ]]
                --[[
                Upvalues:
                    [1] = u18
                    [2] = u21
                    [3] = u26
                    [4] = u27
                --]]
                if u18.Tool.Parent ~= u21 or (tick() - u26 >= 3 or u27 == nil) then
                    return true
                end
            end,
            ["HoldDuration"] = 0.7
        })
        v25:Stop(0)
        _G.mouseLevel = nil
        _G.FaceMouse = false
        u21.PrimaryPart.Anchored = true
        local v28 = u21.Humanoid:LoadAnimation(script.splitRelease)
        v28:Play()
        if u27 then
            u27:FireServer(u21.PrimaryPart.CFrame)
        end
        task.wait(0.65)
        v28:Stop(0)
        u21.PrimaryPart.Anchored = false
        u21.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Splitting Sea Fist", v23)
        _G.canuse = true
        _G.fw(v23)
        v20.SeaSplit = false
    end
end
function u4.DivingTides(p29, _) --[[ Line: 181 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v30 = p29.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local v31 = u1.Character
    if v30.Dive == false and (_G.StamCheck("Diving Tides") == true and (_G.canuse == true and _G.check:inspect(v31) == true)) then
        local v32 = u2.GetM("Diving Tides")
        local v33 = v32.cd
        if v32.statreq and _G.MeetReq(v32.statreq) == false then
            return
        end
        v30.Dive = true
        _G.canuse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Diving Tides")
        _G.keysetup:cooldown("Diving Tides", v33)
        _G.canuse = true
        _G.fw(v33)
        v30.Dive = false
    end
end
function u4.SurgingBermuda(p34, _) --[[ Line: 205 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v35 = p34.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local v36 = u1.Character
    if v35.Surge == false and (_G.StamCheck("Surging Bermuda") == true and (_G.canuse == true and _G.check:inspect(v36) == true)) then
        local v37 = u2.GetM("Surging Bermuda")
        local v38 = v37.cd
        if v37.statreq and _G.MeetReq(v37.statreq) == false then
            return
        end
        v35.Surge = true
        _G.canuse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Surging Bermuda", v36.PrimaryPart.CFrame)
        _G.keysetup:cooldown("Surging Bermuda", v38)
        _G.canuse = true
        _G.fw(v38)
        v35.Surge = false
    end
end
function u4.FeedingFrenzy(u39, p40) --[[ Line: 230 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v41 = u39.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local u42 = u1.Character
    if v41.Feeding == false and (_G.StamCheck("Feeding Frenzy") == true and (_G.canuse == true and _G.check:inspect(u42) == true)) then
        local v43 = u2.GetM("Feeding Frenzy")
        local v44 = v43.cd
        if v43.statreq and _G.MeetReq(v43.statreq) == false then
            return
        end
        v41.Feeding = true
        _G.canuse = false
        local v45 = u42.Humanoid:LoadAnimation(script.barrageCharge)
        v45:Play()
        v45:AdjustWeight(3)
        local u46 = tick()
        _G.FaceMouse = true
        _G.mouseLevel = true
        local u47 = game.ReplicatedStorage.Events.Skill:InvokeServer("Feeding Frenzy")
        u39:ChargeSkill(p40, {
            ["Key"] = Enum.KeyCode.X,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 253 ]] end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 257 ]]
                --[[
                Upvalues:
                    [1] = u39
                    [2] = u42
                    [3] = u46
                    [4] = u47
                --]]
                if u39.Tool.Parent ~= u42 or (tick() - u46 >= 3.5 or (u47 == nil or _G.check:inspect(u42) == false)) then
                    return true
                end
            end,
            ["HoldDuration"] = 0.25,
            ["IgnoreInstantCastSetting"] = true
        })
        v45:Stop()
        local v48 = u42.Humanoid:LoadAnimation(script.barrageFire)
        v48:Play()
        v48:AdjustWeight(3)
        _G.FaceMouse = false
        u42.PrimaryPart.Anchored = true
        _G.mouseLevel = nil
        if u47 then
            u47:InvokeServer(u42.PrimaryPart.CFrame)
        end
        task.wait(0.45)
        u42.PrimaryPart.Anchored = false
        u42.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Feeding Frenzy", v44)
        _G.canuse = true
        _G.fw(v44)
        v41.Feeding = false
    end
end
function u4.AbyssalAwakening(p49, _) --[[ Line: 296 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v50 = p49.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local v51 = u1.Character
    if v50.trans == false and (_G.StamCheck("Abyssal Awakening") == true and (_G.canuse == true and _G.check:inspect(v51) == true)) then
        local v52 = u2.GetM("Abyssal Awakening")
        local v53 = v52.cd
        if v52.statreq and _G.MeetReq(v52.statreq) == false then
            return
        end
        local v54 = v51:GetAttribute("FishmanTransform") or false
        local v55 = v51:GetAttribute(p49.Tool:GetAttribute("damageName")) or 0
        if v54 == false and v55 < require(game.ReplicatedStorage.Modules.Skills.Modes["Abyssal Karate"])(u1) * p49.Tool:GetAttribute("modePercent") then
            _G.displayMessage("<Color=Red>My transformation bar (80%) isnt full enough!")
            return
        end
        v50.trans = true
        _G.canuse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Abyssal Awakening", v51.PrimaryPart.CFrame)
        _G.keysetup:cooldown("Abyssal Awakening", v53)
        _G.canuse = true
        _G.fw(v53)
        v50.trans = false
    end
end
function u4.LeviathanPlunge(p56, _) --[[ Line: 327 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v57 = p56.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local v58 = u1.Character
    if v57.ult == false and (_G.StamCheck("Leviathan Plunge") == true and (_G.canuse == true and _G.check:inspect(v58) == true)) then
        local v59 = u2.GetM("Leviathan Plunge")
        local v60 = v59.cd
        if v59.statreq and _G.MeetReq(v59.statreq) == false then
            return
        end
        v57.ult = true
        _G.canuse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Leviathan Plunge", {
            ["charCF"] = v58.PrimaryPart.CFrame,
            ["mouseCF"] = p56:GetMouseCFrame()
        })
        _G.keysetup:cooldown("Leviathan Plunge", v60)
        _G.canuse = true
        _G.fw(v60)
        v57.ult = false
    end
end
return u4
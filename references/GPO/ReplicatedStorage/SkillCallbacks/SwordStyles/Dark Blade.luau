 

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
        ["slash"] = false,
        ["slices"] = false,
        ["tackle"] = false,
        ["Counter"] = false
    }
    return v9
end
u6["World\'sStrongestSlash"] = function(u10, p11) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v12 = u10.Cooldowns
    local u13 = u1.Character
    local u14 = u2["Stats" .. u1.Name]
    if v12.slash == false and _G.check:inspect(u13) == true then
        local v15 = u3.GetM("World\'s Strongest Slash")
        local v16 = v15.cd
        if _G.StamCheck("World\'s Strongest Slash") == false then
            return
        end
        if v15.statreq and _G.MeetReq(v15.statreq) == false then
            return
        end
        v12.slash = true
        _G.canuse = false
        _G.FaceMouse = true
        _G.mouseLevel = true
        local u17 = u13.Humanoid.Animator:LoadAnimation(script.holdSlash)
        u17:Play()
        u17:AdjustWeight(2)
        u17.Priority = Enum.AnimationPriority.Action4
        local u18 = game.ReplicatedStorage.Events.Skill:InvokeServer("World\'s Strongest Slash")
        local u19 = tick()
        _G.PauseAnim(u17, 0.4, 0.33)
        local u20 = false
        local function v21() --[[ Line: 60 ]]
            --[[
            Upvalues:
                [1] = u19
                [2] = u20
                [3] = u14
                [4] = u18
                [5] = u17
                [6] = u13
            --]]
            if tick() - u19 >= 2 and (u20 == false and u14.Skills.DarkBladeTripleSlash.Value == true) then
                u20 = true
                if u18 then
                    u18:FireServer("Triple")
                    u17:Stop()
                    u17:Destroy()
                    u17 = u13.Humanoid:LoadAnimation(script.tripleHold)
                    u17:Play()
                end
            end
        end
        u10:ChargeSkill(p11, {
            ["Key"] = Enum.KeyCode.X,
            ["CheckFunction"] = v21,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 73 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u13
                    [3] = u19
                --]]
                if u10.Tool.Parent ~= u13 or tick() - u19 >= 10 then
                    return true
                end
            end
        })
        u17:Stop()
        _G.FaceMouse = false
        _G.mouseLevel = false
        u13.HumanoidRootPart.Anchored = true
        if u18 then
            u18:FireServer("slashSfx")
        end
        if u20 == false then
            local v22 = u13.Humanoid.Animator:LoadAnimation(script.slashRelease)
            v22:Play()
            v22:AdjustSpeed(1.25)
            v22:AdjustWeight(2)
            task.wait(0.64)
        else
            local v23 = u13.Humanoid:LoadAnimation(script.triple)
            v23:Play()
            v23:AdjustWeight(2)
            v23:AdjustSpeed(1.25)
            task.wait(0.48)
        end
        if u18 then
            u18:FireServer(u13.PrimaryPart.CFrame)
        end
        u17:AdjustSpeed(1)
        task.wait(0.4)
        u13.HumanoidRootPart.Anchored = false
        u13.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("World\'s Strongest Slash", v16)
        _G.fw(v16)
        v12.slash = false
    end
end
function u6.ThousandSlices(p24, _) --[[ Line: 129 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v25 = p24.Cooldowns
    local v26 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v25.slices == false and _G.check:inspect(v26) == true then
        local v27 = u3.GetM("Thousand Slices")
        local v28 = v27.cd
        if _G.StamCheck("Thousand Slices") == false then
            return
        end
        if v27.statreq and _G.MeetReq(v27.statreq) == false then
            return
        end
        v25.slices = true
        _G.canuse = false
        v26.Humanoid.AutoRotate = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Thousand Slices", v26.PrimaryPart.CFrame)
        v26.Humanoid.AutoRotate = true
        task.wait(0.1)
        v26.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Thousand Slices", v28)
        _G.fw(v28)
        v25.slices = false
    end
end
function u6.NightfallRush(p29, _) --[[ Line: 164 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v30 = p29.Cooldowns
    local v31 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v30.tackle == false and _G.check:inspect(v31) == true then
        local v32 = u3.GetM("Nightfall Rush")
        local v33 = v32.cd
        if _G.StamCheck("Nightfall Rush") == false then
            return
        end
        if v32.statreq and _G.MeetReq(v32.statreq) == false then
            return
        end
        v30.tackle = true
        _G.canuse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Nightfall Rush", v31.PrimaryPart.CFrame)
        task.wait(0.5)
        v31.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Nightfall Rush", v33)
        _G.fw(v33)
        v30.tackle = false
    end
end
function u6.NightfallCounter(p34, _) --[[ Line: 194 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v35 = p34.Cooldowns
    local v36 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v35.Counter == false and _G.check:inspect(v36) == true then
        local v37 = u3.GetM("Nightfall Counter")
        local v38 = v37.cd
        if _G.StamCheck("Nightfall Counter") == false then
            return
        end
        if v37.statreq and _G.MeetReq(v37.statreq) == false then
            return
        end
        v35.Counter = true
        _G.canuse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Nightfall Counter", v36.PrimaryPart.CFrame)
        task.wait(0.3)
        v36.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Nightfall Counter", v38)
        _G.fw(v38)
        v35.Counter = false
    end
end
return u6
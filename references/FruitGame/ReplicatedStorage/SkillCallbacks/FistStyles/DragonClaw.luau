 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = require(game.ReplicatedStorage.Modules.Skills)
local u3 = require(script.Parent.Parent.MobileBase)
require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
local u4 = setmetatable({}, u3)
u4.__index = u4
game:GetService("UserInputService")
function u4.new(_) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
    --]]
    local v5 = u3.new(script.Name)
    local v6 = u4
    local v7 = setmetatable(v5, v6)
    v7.Cooldowns = {
        ["fist"] = false,
        ["breath"] = false,
        ["ult"] = false,
        ["rush"] = false,
        ["reverse"] = false,
        ["mode"] = false,
        ["triple"] = false
    }
    return v7
end
function u4.DragonFist(p8, _) --[[ Line: 27 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v9 = p8.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local v10 = u1.Character
    if v9.fist == false and (_G.check:inspect(v10) == true and _G.StamCheck("Dragon Fist") == true) then
        local v11 = u2.GetM("Dragon Fist")
        local v12 = v11.cd
        if _G.StamCheck("Dragon Fist") == false then
            return
        end
        if v11.statreq and _G.MeetReq(v11.statreq) == false then
            return
        end
        v9.fist = true
        _G.canuse = false
        local v13 = v10.Humanoid:LoadAnimation(script.fist)
        v13:Play()
        v13:AdjustWeight(2)
        v13:AdjustSpeed(1)
        v10.Humanoid.WalkSpeed = 4
        game.ReplicatedStorage.Events.Skill:InvokeServer("Dragon Fist", v10.PrimaryPart.CFrame)
        local v14 = tick()
        repeat
            game["Run Service"].RenderStepped:Wait()
            v10.Humanoid.WalkSpeed = 4
        until tick() - v14 >= 1
        v10.Humanoid.WalkSpeed = 16
        _G.mouseLevel = false
        _G.keysetup:cooldown("Dragon Fist", v12)
        _G.canuse = true
        _G.fw(v12)
        v9.fist = false
    end
end
function u4.DragonBreath(p15, _) --[[ Line: 69 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v16 = p15.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local v17 = u1.Character
    if v16.breath == false and (_G.check:inspect(v17) == true and _G.StamCheck("Dragon Breath") == true) then
        local v18 = u2.GetM("Dragon Breath")
        local v19 = v18.cd
        if _G.StamCheck("Dragon Breath") == false then
            return
        end
        if v18.statreq and _G.MeetReq(v18.statreq) == false then
            return
        end
        local v20, _, _ = _G.getRayFloor(v17.PrimaryPart.CFrame, 5)
        if v20 == nil then
            return nil
        end
        v16.breath = true
        _G.canuse = false
        local v21 = v17.Humanoid:LoadAnimation(script.breath)
        v21:Play()
        v21:AdjustWeight(2)
        v21:AdjustSpeed(1)
        v17.Humanoid.WalkSpeed = 0
        v17.PrimaryPart.Anchored = true
        game.ReplicatedStorage.Events.Skill:InvokeServer("Dragon Breath", v17.PrimaryPart.CFrame)
        local v22 = tick()
        repeat
            game["Run Service"].RenderStepped:Wait()
            v17.Humanoid.Jump = false
            v17.Humanoid.WalkSpeed = 0
        until tick() - v22 >= 3
        v17.PrimaryPart.Anchored = false
        v17.Humanoid.WalkSpeed = 16
        _G.mouseLevel = false
        _G.keysetup:cooldown("Dragon Breath", v19)
        _G.canuse = true
        _G.fw(v19)
        v16.breath = false
    end
end
function u4.DragonSkullCrusher(p23, p24) --[[ Line: 119 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v25 = p23.Cooldowns
    local u26 = game.ReplicatedStorage["Stats" .. u1.Name]
    local u27 = u1.Character
    if v25.ult == false and (_G.check:inspect(u27) == true and _G.StamCheck("Dragon Skull Crusher") == true) then
        local v28 = u2.GetM("Dragon Skull Crusher")
        local v29 = v28.cd
        if _G.StamCheck("Dragon Skull Crusher") == false then
            return
        end
        if v28.statreq and _G.MeetReq(v28.statreq) == false then
            return
        end
        _G.canuse = false
        v25.ult = true
        local v30 = u27.Humanoid:LoadAnimation(script.ultgrab)
        v30:Play()
        v30:AdjustWeight(2)
        _G.canuse = false
        local v31 = game.ReplicatedStorage.Events.Skill:InvokeServer("Dragon Skull Crusher", {
            ["cf"] = u27.HumanoidRootPart.CFrame
        })
        u27.Humanoid.WalkSpeed = 4
        _G.PauseAnim(v30, 0.4, 1)
        local u32 = tick()
        p23:ChargeSkill(p24, {
            ["Key"] = Enum.KeyCode.C,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 150 ]]
                --[[
                Upvalues:
                    [1] = u27
                --]]
                u27.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 154 ]]
                --[[
                Upvalues:
                    [1] = u32
                    [2] = u27
                    [3] = u26
                --]]
                if tick() - u32 >= 10 or (u27:FindFirstChild(script.Name) == nil or (u27.Parent == nil or (u27.Parent ~= workspace.PlayerCharacters or u26.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        v30:AdjustSpeed(1)
        if v31 then
            v31:FireServer(u27.PrimaryPart.CFrame)
        end
        u27.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Dragon Skull Crusher", v29)
        _G.fw(v29)
        v25.ult = false
    end
end
function u4.DragonRush(p33, p34) --[[ Line: 178 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v35 = p33.Cooldowns
    local u36 = game.ReplicatedStorage["Stats" .. u1.Name]
    local u37 = u1.Character
    if v35.rush == false and (_G.check:inspect(u37) == true and _G.StamCheck("Dragon Rush") == true) then
        local v38 = u2.GetM("Dragon Rush")
        local v39 = v38.cd
        if _G.StamCheck("Dragon Rush") == false then
            return
        end
        if v38.statreq and _G.MeetReq(v38.statreq) == false then
            return
        end
        _G.canuse = false
        v35.rush = true
        local u40 = u37.Humanoid:LoadAnimation(script.rushgrab)
        u40:Play()
        u40:AdjustWeight(2)
        _G.canuse = false
        u37.Humanoid.WalkSpeed = 4
        local u41 = game.ReplicatedStorage.Events.Skill:InvokeServer("Dragon Rush", {
            ["cf"] = u37.HumanoidRootPart.CFrame
        })
        _G.PauseAnim(u40, 0.3, 1)
        local u42 = tick()
        p33:ChargeSkill(p34, {
            ["Key"] = Enum.KeyCode.Z,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 209 ]]
                --[[
                Upvalues:
                    [1] = u37
                --]]
                u37.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 213 ]]
                --[[
                Upvalues:
                    [1] = u42
                    [2] = u37
                    [3] = u36
                --]]
                if tick() - u42 >= 10 or (u37:FindFirstChild(script.Name) == nil or (u37.Parent == nil or (u37.Parent ~= workspace.PlayerCharacters or u36.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        u40:AdjustSpeed(1)
        local u43 = Instance.new("BodyVelocity", u37.HumanoidRootPart)
        u43.MaxForce = Vector3.new(100000, 0, 100000)
        u43.Velocity = u37.HumanoidRootPart.CFrame.LookVector * 100
        _G.destroy(u43, 0.15)
        if u41 then
            u41:FireServer("sfx")
        end
        local u44 = false
        local function v45() --[[ Line: 243 ]]
            --[[
            Upvalues:
                [1] = u43
                [2] = u44
                [3] = u40
            --]]
            u43:Destroy()
            u44 = true
            u40:Stop()
        end
        _G.hitbox:start(u37, Vector3.new(8, 5, 12), 0.3, CFrame.new(0, 0, -3), function(p46) --[[ Name: hitfound, Line 235 ]]
            --[[
            Upvalues:
                [1] = u43
                [2] = u37
                [3] = u41
            --]]
            u43:Destroy()
            u37.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
            if u41 then
                u41:FireServer({
                    ["cf"] = u37.PrimaryPart.CFrame,
                    ["Target"] = p46.Parent
                })
            end
        end, v45)
        task.wait(0.3)
        u37.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Dragon Rush", v39)
        _G.fw(v39)
        v35.rush = false
    end
end
function u4.ReverseDragon(p47, _) --[[ Line: 258 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v48 = p47.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local v49 = u1.Character
    if v48.reverse == false and (_G.check:inspect(v49) == true and _G.StamCheck("Reverse Dragon") == true) then
        local v50 = u2.GetM("Reverse Dragon")
        local v51 = v50.cd
        if _G.StamCheck("Reverse Dragon") == false then
            return
        end
        if v50.statreq and _G.MeetReq(v50.statreq) == false then
            return
        end
        _G.canuse = false
        v48.reverse = true
        local v52 = v49.Humanoid:LoadAnimation(script.counter)
        v52:Play()
        v52:AdjustWeight(2)
        _G.canuse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Reverse Dragon", {
            ["cf"] = v49.HumanoidRootPart.CFrame
        })
        task.wait(1)
        v52:Stop()
        _G.canuse = true
        _G.keysetup:cooldown("Reverse Dragon", v51)
        _G.fw(v51)
        v48.reverse = false
    end
end
function u4.DragonClawSlashStance(_, p53, p54, p55) --[[ Line: 290 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local v56 = p53.Cooldowns
    local _ = game.ReplicatedStorage["Stats" .. u1.Name]
    local u57 = u1.Character
    if _G.check:inspect(u57) == true then
        local v58 = "Dragon Claw Slash"
        if _G.StamCheck(v58) == false then
            return
        end
        local u59 = tick()
        local u60 = tick()
        if p55 == nil or _G.mobile == nil then
            p53:ChargeSkill(p54, {
                ["Key"] = Enum.KeyCode.T,
                ["EndFunction"] = function() --[[ Name: EndFunction, Line 310 ]]
                    --[[
                    Upvalues:
                        [1] = u60
                        [2] = u59
                    --]]
                    u60 = tick() - u59
                    return u60 > 0.25
                end,
                ["canUse"] = false
            })
        end
        local v61 = p55 or (tick() - u59 >= 0.25 and "Dragon Claw Stance" or v58)
        if _G.StamCheck(v61) == false or _G.isCustomHUB == true then
            return
        end
        local v62 = u2.GetM(v61)
        local v63 = v62.cd
        if v62.statreq and _G.MeetReq(v62.statreq) == false then
            return
        end
        if v61 == "Dragon Claw Stance" and (v56.mode == true or u57:findFirstChild("DragonClawStance") ~= nil) then
            return
        end
        if v61 == "Dragon Claw Slash" and v56.triple == true then
            return
        end
        _G.canuse = false
        if v61 == "Dragon Claw Stance" then
            v56.mode = true
            local v64 = u57.Humanoid:LoadAnimation(script.mode)
            v64:Play()
            v64:AdjustWeight(2)
            u57.PrimaryPart.Anchored = true
            game.ReplicatedStorage.Events.Skill:InvokeServer(v61, {
                ["cf"] = u57.HumanoidRootPart.CFrame
            })
            task.wait(0.75)
            u57.PrimaryPart.Anchored = false
        else
            v56.triple = true
            local v65 = u57.Humanoid:LoadAnimation(script.tripleslash)
            v65:Play()
            v65:AdjustWeight(2)
            local u66 = game.ReplicatedStorage.Events.Skill:InvokeServer(v61, {
                ["cf"] = u57.HumanoidRootPart.CFrame
            })
            if u66 then
                u66:FireServer("start")
                task.delay(0.3, function() --[[ Line: 362 ]]
                    --[[
                    Upvalues:
                        [1] = u57
                        [2] = u66
                    --]]
                    local v67 = Instance.new("BodyVelocity")
                    v67.MaxForce = Vector3.new(100000000000, 100000000000, 100000000000)
                    v67.Parent = u57.HumanoidRootPart
                    _G.destroy(v67, 1)
                    u66:FireServer(nil, u57.PrimaryPart.CFrame)
                    repeat
                        v67.Velocity = u57.PrimaryPart.CFrame.LookVector * 20
                        task.wait()
                    until v67.Parent == nil
                end)
                task.delay(0.7, function() --[[ Line: 373 ]]
                    --[[
                    Upvalues:
                        [1] = u66
                        [2] = u57
                    --]]
                    u66:FireServer(nil, u57.PrimaryPart.CFrame)
                end)
                task.delay(1.0666666666666667, function() --[[ Line: 376 ]]
                    --[[
                    Upvalues:
                        [1] = u66
                        [2] = u57
                    --]]
                    u66:FireServer(nil, u57.PrimaryPart.CFrame)
                end)
                task.wait(1.75)
            end
        end
        _G.canuse = true
        _G.keysetup:cooldown(v61, v63)
        _G.fw(v63)
        if v61 == "Dragon Claw Slash" then
            v56.triple = false
        else
            v56.mode = false
        end
    end
end
function u4.DragonClawStance(p68, p69) --[[ Line: 395 ]]
    warn(p68)
    p68:DragonClawSlashStance(p68, p69, "Dragon Claw Stance")
end
function u4.DragonClawSlash(p70, p71) --[[ Line: 401 ]]
    warn(p70)
    p70:DragonClawSlashStance(p70, p71, "Dragon Claw Slash")
end
return u4
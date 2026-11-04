 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = require(game.ReplicatedStorage.Modules.Skills)
local u4 = require(script.Parent.Parent.MobileBase)
require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
local u5 = setmetatable({}, u4)
u5.__index = u5
function u5.new(_) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
    --]]
    local v6 = u4.new(script.Name)
    local v7 = u5
    local v8 = setmetatable(v6, v7)
    v8.Cooldowns = {
        ["shiningkick"] = false,
        ["Diamond Dash"] = false,
        ["Diamond Defense"] = false,
        ["Rock Toss"] = false,
        ["Prismatic Lift"] = false
    }
    return v8
end
function u5.DiamondKick(u9, p10) --[[ Line: 33 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v11 = u9.Cooldowns
    local u12 = u1.Character
    local u13 = u2["Stats" .. u1.Name]
    if _G.canuse and (not v11.shiningkick and _G.check:inspect(u12)) then
        local v14 = u3.GetM("Diamond Kick")
        local v15 = v14.cd
        if _G.StamCheck("Diamond Kick") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        v11.shiningkick = true
        _G.canuse = false
        local v16 = game.ReplicatedStorage.Events.Skill:InvokeServer("Diamond Kick", u12.PrimaryPart.CFrame, "start")
        local v17 = u12.Humanoid:LoadAnimation(script.kickStart)
        v17.Priority = Enum.AnimationPriority.Action4
        v17:Play()
        _G.PauseAnim(v17, 0.233, 1)
        local u18 = tick()
        u9:ChargeSkill(p10, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 63 ]]
                --[[
                Upvalues:
                    [1] = u12
                --]]
                u12.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 67 ]]
                --[[
                Upvalues:
                    [1] = u18
                    [2] = u9
                    [3] = u12
                    [4] = u13
                --]]
                if tick() - u18 >= 10 or (u9.Tool.Parent ~= u12 or (u12.Parent == nil or (u12.Parent ~= workspace.PlayerCharacters or u13.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        v17:AdjustSpeed(1.2)
        if v16 then
            v16:FireServer(u12.PrimaryPart.CFrame)
        end
        task.wait(0.6)
        _G.keysetup:cooldown("Diamond Kick", v15)
        _G.canuse = true
        u12.Humanoid.WalkSpeed = 16
        u12.Humanoid.AutoRotate = true
        _G.fw(v15)
        v11.shiningkick = false
    end
end
function u5.RockToss(u19, p20) --[[ Line: 97 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
    --]]
    local v21 = u19.Cooldowns
    local u22 = game.ReplicatedStorage["Stats" .. u1.Name]
    local u23 = u1.Character
    if v21["Rock Toss"] == false and (_G.check:inspect(u23) == true and _G.StamCheck("Rock Toss") == true) then
        local v24 = u3.GetM("Rock Toss")
        local v25 = v24.cd
        if v24.stamreq and u22.Stamina.Value < v24.stamreq then
            return
        end
        if v24.statreq and _G.MeetReq(v24.statreq) == false then
            return
        end
        v21["Rock Toss"] = true
        _G.canuse = false
        _G.FaceMouse = true
        _G.mouseLevel = true
        local v26 = game.ReplicatedStorage.Events.Skill:InvokeServer("Rock Toss", u23.PrimaryPart.CFrame, "start")
        local v27 = u23.Humanoid:LoadAnimation(script.rockToss)
        v27.Priority = Enum.AnimationPriority.Action4
        v27:Play()
        _G.PauseAnim(v27, 1.25, 1.3)
        local u28 = tick()
        u19:ChargeSkill(p20, {
            ["Key"] = Enum.KeyCode.Z,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 128 ]]
                --[[
                Upvalues:
                    [1] = u23
                --]]
                u23.Humanoid.WalkSpeed = 0
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 132 ]]
                --[[
                Upvalues:
                    [1] = u28
                    [2] = u19
                    [3] = u23
                    [4] = u22
                --]]
                if tick() - u28 >= 10 or (u19.Tool.Parent ~= u23 or (u23.Parent == nil or (u23.Parent ~= workspace.PlayerCharacters or u22.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        v27:AdjustSpeed(1)
        _G.FaceMouse = false
        _G.mouseLevel = nil
        u23.PrimaryPart.Anchored = true
        if v26 then
            v26:FireServer(u23.PrimaryPart.CFrame, u19:GetMouseCFrame())
        end
        task.wait(0.8)
        u23.PrimaryPart.Anchored = false
        _G.keysetup:cooldown("Rock Toss", v25)
        _G.canuse = true
        u23.Humanoid.WalkSpeed = 16
        _G.fw(v25)
        v21["Rock Toss"] = false
    end
end
function u5.PrismaticLift(u29, p30) --[[ Line: 162 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
    --]]
    local v31 = u29.Cooldowns
    local u32 = game.ReplicatedStorage["Stats" .. u1.Name]
    local u33 = u1.Character
    if v31["Prismatic Lift"] == false and (_G.check:inspect(u33) == true and _G.StamCheck("Prismatic Lift") == true) then
        local v34 = u3.GetM("Prismatic Lift")
        local v35 = v34.cd
        if v34.stamreq and u32.Stamina.Value < v34.stamreq then
            return
        end
        if v34.statreq and _G.MeetReq(v34.statreq) == false then
            return
        end
        u33.Humanoid.WalkSpeed = 0
        _G.FaceMouse = true
        _G.mouseLevel = true
        v31["Prismatic Lift"] = true
        local v36 = game.ReplicatedStorage.Events.Skill:InvokeServer("Prismatic Lift", u33.PrimaryPart.CFrame, "start")
        local v37 = u33.Humanoid:LoadAnimation(script.prismatic)
        v37.Priority = Enum.AnimationPriority.Action4
        v37:Play()
        u33.Humanoid.AutoRotate = false
        _G.PauseAnim(v37, 1.35, 1)
        u33.Humanoid.AutoRotate = true
        _G.canuse = false
        local u38 = tick()
        u29:ChargeSkill(p30, {
            ["Key"] = Enum.KeyCode.C,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 201 ]]
                --[[
                Upvalues:
                    [1] = u33
                --]]
                u33.Humanoid.WalkSpeed = 0
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 205 ]]
                --[[
                Upvalues:
                    [1] = u38
                    [2] = u29
                    [3] = u33
                    [4] = u32
                --]]
                if tick() - u38 >= 10 or (u29.Tool.Parent ~= u33 or (u33.Parent == nil or (u33.Parent ~= workspace.PlayerCharacters or u32.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        v37:AdjustSpeed(1)
        if v36 then
            v36:FireServer(u33.PrimaryPart.CFrame, u29:GetMouseCFrame(), u33.LeftHand.CFrame * CFrame.new(0.1, -13, 7))
        end
        task.wait(0.7)
        _G.FaceMouse = false
        _G.mouseLevel = nil
        _G.canuse = true
        u33.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Prismatic Lift", v35)
        _G.fw(v35)
        v31["Prismatic Lift"] = false
    end
end
function u5.DiamondDash(u39, p40) --[[ Line: 236 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
    --]]
    local v41 = u39.Cooldowns
    local u42 = game.ReplicatedStorage["Stats" .. u1.Name]
    local u43 = u1.Character
    if v41["Diamond Dash"] == false and (_G.check:inspect(u43) == true and _G.StamCheck("Diamond Dash") == true) then
        local v44 = u3.GetM("Diamond Dash")
        local v45 = v44.cd
        if v44.stamreq and u42.Stamina.Value < v44.stamreq then
            return
        end
        if v44.statreq and _G.MeetReq(v44.statreq) == false then
            return
        end
        v41["Diamond Dash"] = true
        _G.canuse = false
        _G.FaceMouse = true
        local v46 = game.ReplicatedStorage.Events.Skill:InvokeServer("Diamond Dash", u43.PrimaryPart.CFrame, "start")
        local v47 = u43.Humanoid:LoadAnimation(script.windupcharge)
        v47.Priority = Enum.AnimationPriority.Action4
        v47:Play()
        _G.PauseAnim(v47, 0.23, 1)
        local u48 = tick()
        u39:ChargeSkill(p40, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 267 ]] end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 270 ]]
                --[[
                Upvalues:
                    [1] = u48
                    [2] = u39
                    [3] = u43
                    [4] = u42
                --]]
                if tick() - u48 >= 3 or (u39.Tool.Parent ~= u43 or (u43.Parent == nil or (u43.Parent ~= workspace.PlayerCharacters or u42.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        v47:Stop()
        local v49 = u43.Humanoid:LoadAnimation(script.dashLoop)
        v49.Priority = Enum.AnimationPriority.Action4
        v49:Play()
        _G.FaceMouse = false
        if v46 then
            v46:InvokeServer(u39:GetMouseCFrame())
        end
        task.wait(0.1)
        v49:Stop()
        _G.keysetup:cooldown("Diamond Dash", v45)
        _G.canuse = true
        u43.HumanoidRootPart.Anchored = false
        _G.fw(v45)
        v41["Diamond Dash"] = false
    end
end
function u5.DiamondDefense(p50, p51) --[[ Line: 304 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u3
    --]]
    local v52 = p50.Cooldowns
    local v53 = game.ReplicatedStorage["Stats" .. u1.Name]
    local u54 = u1.Character
    if v52["Diamond Defense"] == false and (_G.check:inspect(u54) == true and _G.StamCheck("Diamond Defense") == true) then
        local v55 = u3.GetM("Diamond Defense")
        local v56 = v55.cd
        if v55.stamreq and v53.Stamina.Value < v55.stamreq then
            return
        end
        if v55.statreq and _G.MeetReq(v55.statreq) == false then
            return
        end
        local u57 = p50.Tool
        if u57 == nil then
            return
        end
        if (u54:GetAttribute(u57:GetAttribute("damageName")) or 0) < u57:GetAttribute("modePercent") * require(game.ReplicatedStorage.Modules.Skills.Modes.Kira)(u1) then
            _G.displayMessage((("<Color=Red>I need <Color=/>%*%% bar<Color=Red> to use this skill!"):format(u57:GetAttribute("modePercent") * 100)))
            return
        end
        _G.canuse = false
        v52["Diamond Defense"] = true
        local v58 = u54.Humanoid:LoadAnimation(script.defenseStartup)
        v58:Play()
        v58.Priority = Enum.AnimationPriority.Action2
        task.wait(0.35)
        local u59 = false
        local v60 = game.ReplicatedStorage.Events.Skill:InvokeServer("Diamond Defense", u54.PrimaryPart.CFrame)
        p50:DoubleCastSkill(p51, {
            ["Key"] = Enum.KeyCode.X,
            ["SkipTap"] = true,
            ["CompleteFunction"] = function() --[[ Name: CompleteFunction, Line 347 ]]
                --[[
                Upvalues:
                    [1] = u59
                --]]
                u59 = true
            end,
            ["PassFunction"] = function() --[[ Name: PassFunction, Line 350 ]]
                --[[
                Upvalues:
                    [1] = u57
                    [2] = u54
                --]]
                return u57.Parent == u54
            end
        })
        _G.canuse = true
        repeat
            task.wait()
        until u59 == true or u54:GetAttribute("DiamondDefense") == nil
        if v60 then
            v60:FireServer()
        end
        _G.keysetup:cooldown("Diamond Defense", v56)
        _G.fw(v56)
        v52["Diamond Defense"] = false
    end
end
return u5
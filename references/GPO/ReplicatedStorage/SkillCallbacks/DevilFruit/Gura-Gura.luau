 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = require(game.ReplicatedStorage.Modules.Skills)
local u4 = require(script.Parent.Parent.MobileBase)
require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
local u5 = setmetatable({}, u4)
u5.__index = u5
function u5.new(_) --[[ Line: 18 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u5
    --]]
    local v6 = u4.new(script.Name)
    local v7 = u5
    local v8 = setmetatable(v6, v7)
    v8.Cooldowns = {
        ["punch"] = false,
        ["taunt"] = false,
        ["head"] = false,
        ["air"] = false,
        ["sea"] = false
    }
    return v8
end
function u5.ShockPunch(p9, p10) --[[ Line: 32 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v11 = p9.Cooldowns
    local u12 = u1.Character
    local u13 = u2["Stats" .. u1.Name]
    if v11.punch == false and (_G.check:inspect(u12) == true and _G.StamCheck("Shock Punch") == true) then
        local v14 = u3.GetM("Shock Punch")
        local v15 = v14.cd
        if _G.StamCheck("Shock Punch") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        _G.canuse = false
        local v16 = game.ReplicatedStorage.Events.Skill:InvokeServer("Shock Punch", {
            ["cf"] = p9:GetMouseCFrame()
        })
        if v16 == nil then
            _G.canuse = true
            return
        end
        v11.punch = true
        local v17 = u12.Humanoid:LoadAnimation(script.punch)
        v17:Play()
        v17:AdjustWeight(2)
        _G.canuse = false
        _G.FaceMouse = true
        _G.PauseAnim(v17, 0.42, 1)
        local u18 = tick()
        p9:ChargeSkill(p10, {
            ["Key"] = Enum.KeyCode.E,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 69 ]]
                --[[
                Upvalues:
                    [1] = u18
                    [2] = u12
                    [3] = u13
                --]]
                return tick() - u18 >= 10 or not u12:FindFirstChild("Gura-Gura") or ((u12.Parent == nil or u12.Parent ~= workspace.PlayerCharacters) and true or u13.Stamina.Value <= 0)
            end
        })
        u12.HumanoidRootPart.Anchored = true
        _G.FaceMouse = false
        v17:AdjustSpeed(1)
        u12.HumanoidRootPart.Anchored = true
        task.wait(0.1)
        if v16 then
            v16:FireServer(u12.HumanoidRootPart.CFrame)
        end
        task.wait(0.7)
        u12.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Shock Punch", v15)
        _G.fw(v15)
        v11.punch = false
    end
end
function u5.ComeATme(p19, _) --[[ Line: 91 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v20 = p19.Cooldowns
    local v21 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v20.taunt == false and (_G.check:inspect(v21) == true and _G.StamCheck("Come AT me") == true) then
        local v22 = u3.GetM("Come AT me")
        local v23 = v22.cd
        if _G.StamCheck("Come AT me") == false then
            return
        end
        if v22.statreq and _G.MeetReq(v22.statreq) == false then
            return
        end
        _G.canuse = false
        v20.taunt = true
        local v24 = v21.Humanoid:LoadAnimation(script.taunt)
        v24:Play()
        _G.canuse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Come AT me")
        task.wait(0.45)
        v24:Stop()
        task.wait(0.6)
        _G.canuse = true
        _G.keysetup:cooldown("Come AT me", v23)
        _G.fw(v23)
        v20.taunt = false
    end
end
function u5.HeadCrusher(p25, p26) --[[ Line: 124 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v27 = p25.Cooldowns
    local u28 = u1.Character
    local u29 = u2["Stats" .. u1.Name]
    if v27.head == false and (_G.check:inspect(u28) == true and _G.StamCheck("Head Crusher") == true) then
        local v30 = u3.GetM("Head Crusher")
        local v31 = v30.cd
        if _G.StamCheck("Head Crusher") == false then
            return
        end
        if v30.statreq and _G.MeetReq(v30.statreq) == false then
            return
        end
        _G.canuse = false
        v27.head = true
        local v32 = u28.Humanoid:LoadAnimation(script.grab)
        v32:Play()
        v32:AdjustWeight(2)
        _G.canuse = false
        u28.Humanoid.WalkSpeed = 4
        _G.PauseAnim(v32, 0.35, 1)
        local u33 = tick()
        p25:ChargeSkill(p26, {
            ["Key"] = Enum.KeyCode.Z,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 155 ]]
                --[[
                Upvalues:
                    [1] = u33
                    [2] = u28
                    [3] = u29
                --]]
                return tick() - u33 >= 10 or not u28:FindFirstChild("Gura-Gura") or ((u28.Parent == nil or u28.Parent ~= workspace.PlayerCharacters) and true or u29.Stamina.Value <= 0)
            end
        })
        v32:AdjustSpeed(1)
        u28.Humanoid.WalkSpeed = 16
        game.ReplicatedStorage.Events.Skill:InvokeServer("Head Crusher", {
            ["cf"] = u28.HumanoidRootPart.CFrame
        })
        _G.canuse = true
        _G.keysetup:cooldown("Head Crusher", v31)
        _G.fw(v31)
        v27.head = false
    end
end
function u5.BlastClutcher(p34, p35) --[[ Line: 170 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v36 = p34.Cooldowns
    local u37 = u1.Character
    local u38 = u2["Stats" .. u1.Name]
    if v36.air == false and (_G.check:inspect(u37) == true and _G.StamCheck("Blast Clutcher") == true) then
        local v39 = u3.GetM("Blast Clutcher")
        local v40 = v39.cd
        if _G.StamCheck("Blast Clutcher") == false then
            return
        end
        if v39.statreq and _G.MeetReq(v39.statreq) == false then
            return
        end
        _G.canuse = false
        v36.air = true
        local v41 = u37.Humanoid:LoadAnimation(script.airgrab)
        v41:Play()
        _G.canuse = false
        _G.FaceMouse = true
        _G.mouseLevel = true
        _G.PauseAnim(v41, 0.4, 1)
        local u42 = game.ReplicatedStorage.Events.Skill:InvokeServer("Blast Clutcher")
        local u43 = tick()
        local u44 = false
        p34:ChargeSkill(p35, {
            ["Key"] = Enum.KeyCode.X,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 203 ]]
                --[[
                Upvalues:
                    [1] = u43
                    [2] = u44
                    [3] = u42
                    [4] = u37
                    [5] = u38
                --]]
                if tick() - u43 >= 4.2 and u44 == false then
                    u44 = true
                    if u42 then
                        u42:FireServer("maxed")
                    end
                end
                return tick() - u43 >= 7 or not u37:FindFirstChild("Gura-Gura") or ((u37.Parent == nil or u37.Parent ~= workspace.PlayerCharacters) and true or u38.Stamina.Value <= 0)
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        v41:AdjustSpeed(1)
        _G.mouseLevel = nil
        _G.FaceMouse = false
        u37.HumanoidRootPart.Anchored = true
        if u42 then
            u42:FireServer()
        end
        task.wait(0.35)
        task.wait(1)
        u37.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Blast Clutcher", v40)
        _G.fw(v40)
        v36.air = false
    end
end
function u5.SeaQuake(p45, p46) --[[ Line: 234 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v47 = p45.Cooldowns
    local u48 = u1.Character
    local u49 = u2["Stats" .. u1.Name]
    if v47.sea == false and (_G.check:inspect(u48) == true and _G.StamCheck("Sea Quake") == true) then
        local v50 = u3.GetM("Sea Quake")
        local v51 = v50.cd
        if _G.StamCheck("Sea Quake") == false then
            return
        end
        if v50.statreq and _G.MeetReq(v50.statreq) == false then
            return
        end
        _G.canuse = false
        local v52 = game.ReplicatedStorage.Events.Skill:InvokeServer("Sea Quake", {
            ["cf"] = p45:GetMouseCFrame()
        })
        if v52 == nil then
            _G.canuse = true
            return
        end
        v47.sea = true
        local v53 = u48.Humanoid:LoadAnimation(script.seaQuake)
        v53:Play()
        v53:AdjustWeight(2)
        _G.canuse = false
        _G.mouseLevel = true
        _G.FaceMouse = true
        _G.PauseAnim(v53, 0, 1)
        local u54 = tick()
        p45:ChargeSkill(p46, {
            ["Key"] = Enum.KeyCode.C,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 272 ]]
                --[[
                Upvalues:
                    [1] = u54
                    [2] = u48
                    [3] = u49
                --]]
                return tick() - u54 >= 10 or not u48:FindFirstChild("Gura-Gura") or ((u48.Parent == nil or u48.Parent ~= workspace.PlayerCharacters) and true or u49.Stamina.Value <= 0)
            end
        })
        u48.HumanoidRootPart.Anchored = true
        _G.FaceMouse = false
        _G.mouseLevel = nil
        v53:AdjustSpeed(0.67)
        u48.HumanoidRootPart.Anchored = true
        task.wait(0.75)
        if v52 then
            v52:FireServer(u48.HumanoidRootPart.CFrame)
        end
        task.wait(0.7)
        u48.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Sea Quake", v51)
        _G.fw(v51)
        v47.sea = false
    end
end
return u5
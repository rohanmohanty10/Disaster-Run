 

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
        ["leap"] = false,
        ["swipe"] = false,
        ["trap"] = false,
        ["selfex"] = false,
        ["swing"] = false
    }
    v8.CurrentSwipe = 1
    return v8
end
function u5.ExplosiveLeap(p9, p10) --[[ Line: 34 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v11 = p9.Cooldowns
    local u12 = u1.Character
    local u13 = u2["Stats" .. u1.Name]
    if _G.grounded == false and (v11.leap == false and (_G.check:inspect(u12) == true and _G.StamCheck("Explosive Leap") == true)) then
        local v14 = u3.GetM("Explosive Leap")
        local v15 = v14.cd
        if _G.StamCheck("Explosive Leap") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        v11.leap = true
        _G.canuse = false
        local v16 = u12.Humanoid:LoadAnimation(script.leap)
        v16:Play()
        v16:AdjustWeight(2)
        u12.Humanoid.WalkSpeed = 4
        local v17 = game.ReplicatedStorage.Events.Skill:InvokeServer("Explosive Leap")
        tick()
        _G.PauseAnim(v16, 0.25, 1)
        local u18 = tick()
        local u19 = 0
        local function v20() --[[ Line: 62 ]]
            --[[
            Upvalues:
                [1] = u12
                [2] = u19
            --]]
            u12.Humanoid.WalkSpeed = 4
            u19 = u19 + 0.25
        end
        p9:ChargeSkill(p10, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = v20,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 67 ]]
                --[[
                Upvalues:
                    [1] = u18
                    [2] = u12
                    [3] = u13
                --]]
                if tick() - u18 >= 3 or (not u12:FindFirstChild("Bomb-Bomb") or (u12.Parent == nil or (u12.Parent ~= workspace.PlayerCharacters or u13.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        v16:AdjustSpeed(1.5)
        task.wait(0.1)
        local v21 = Instance.new("BodyVelocity", u12.HumanoidRootPart)
        v21.Name = "geppo"
        v21.MaxForce = Vector3.new(100000000000, 1000000000, 100000000000)
        local v22 = u19 + 70
        v21.Velocity = Vector3.new(0, v22, 0)
        _G.destroy(v21, 0.25)
        u12.Humanoid.WalkSpeed = 16
        if v17 then
            v17:FireServer({
                ["cf"] = u12.HumanoidRootPart.CFrame,
                ["extra"] = u19
            })
        end
        _G.canuse = true
        _G.keysetup:cooldown("Explosive Leap", v15)
        _G.fw(v15)
        v11.leap = false
    end
end
function u5.ExplosiveSwipe(u23, p24) --[[ Line: 99 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v25 = u23.Cooldowns
    local u26 = u1.Character
    local u27 = u2["Stats" .. u1.Name]
    if v25.swipe == false and (_G.check:inspect(u26) == true and _G.StamCheck("Explosive Swipe") == true) then
        local v28 = u3.GetM("Explosive Swipe")
        local v29 = v28.cd
        if _G.StamCheck("Explosive Swipe") == false then
            return
        end
        if v28.statreq and _G.MeetReq(v28.statreq) == false then
            return
        end
        v25.swipe = true
        _G.canuse = false
        local v30 = u26.Humanoid:LoadAnimation(script["swipe" .. u23.CurrentSwipe])
        v30:Play()
        v30:AdjustWeight(2)
        u23.CurrentSwipe = u23.CurrentSwipe + 1
        if u23.CurrentSwipe > 2 then
            u23.CurrentSwipe = 1
        end
        _G.FaceMouse = true
        _G.PauseAnim(v30, 0.42, 1)
        local u31 = nil
        local u32 = nil
        pcall(function() --[[ Line: 126 ]]
            --[[
            Upvalues:
                [1] = u31
                [2] = u32
                [3] = u23
            --]]
            local v33 = game.ReplicatedStorage.Events.Skill
            local v34 = {
                ["cf"] = u23:GetMouseCFrame()
            }
            local v35, v36 = unpack(v33:InvokeServer("Explosive Swipe", v34))
            u31 = v35
            u32 = v36
            if u32 then
                u32 = _G.awaitObject(u32)
            end
        end)
        local u37 = tick()
        local u38 = 0
        local u39
        if u32 then
            u39 = u32.CFrame
        else
            u39 = nil
        end
        local function v43() --[[ Line: 141 ]]
            --[[
            Upvalues:
                [1] = u39
                [2] = u23
                [3] = u38
                [4] = u31
                [5] = u32
                [6] = u26
            --]]
            if u39 then
                local v40 = u39:Lerp(u23:GetMouseCFrame(), 0.1)
                if tick() - u38 >= 0.05 and u31 then
                    u31:FireServer("update", v40)
                    u38 = tick()
                end
                if u32 then
                    if (u26.HumanoidRootPart.Position - v40.Position).Magnitude >= 150 then
                        local v41 = Ray.new(u26.HumanoidRootPart.Position, (u26.HumanoidRootPart.Position - v40.Position).unit * -150)
                        local _, v42 = _G.raycastIgnoreList(v41, { workspace })
                        v40 = CFrame.new(v42)
                    end
                    u32.CFrame = v40
                    u39 = v40
                end
            end
        end
        u23:ChargeSkill(p24, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = v43,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 163 ]]
                --[[
                Upvalues:
                    [1] = u37
                    [2] = u26
                    [3] = u27
                --]]
                if tick() - u37 >= 3 or (not u26:FindFirstChild("Bomb-Bomb") or (u26.Parent == nil or (u26.Parent ~= workspace.PlayerCharacters or u27.Stamina.Value <= 0))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        v30:AdjustSpeed(0.85)
        u26.HumanoidRootPart.Anchored = true
        if u31 then
            u31:FireServer(u39)
        end
        _G.FaceMouse = false
        task.wait(0.45)
        u26.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Explosive Swipe", v29)
        _G.fw(v29)
        v25.swipe = false
    end
end
function u5.ExplosiveMines(p44, p45) --[[ Line: 194 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v46 = p44.Cooldowns
    local u47 = u1.Character
    local u48 = u2["Stats" .. u1.Name]
    if v46.trap == false and (_G.check:inspect(u47) == true and _G.StamCheck("Explosive Mines") == true) then
        local v49 = u3.GetM("Explosive Mines")
        local v50 = v49.cd
        if _G.StamCheck("Explosive Mines") == false then
            return
        end
        if v49.statreq and _G.MeetReq(v49.statreq) == false then
            return
        end
        v46.trap = true
        _G.canuse = false
        local v51 = u47.Humanoid:LoadAnimation(script.trap)
        v51:Play()
        v51:AdjustWeight(2)
        u47.Humanoid.WalkSpeed = 0
        _G.PauseAnim(v51, 0.5, 1)
        local v52 = game.ReplicatedStorage.Events.Skill:InvokeServer("Explosive Mines")
        local u53 = tick()
        local v54 = u47.HumanoidRootPart.CFrame
        local v55 = Ray.new(v54.Position + Vector3.new(0, 5, 0), CFrame.new(v54.Position).upVector * -25)
        local v56, v57, v58 = _G.raycastWhitelist(v55, { workspace.Islands, workspace.Ships, workspace.Env })
        local u59
        if v56 then
            u59 = game.ReplicatedStorage.MiscModels.BombTrap:Clone()
            u59.Parent = workspace.Effects
            u59.CFrame = CFrame.new(v57, v57 + v58) * CFrame.Angles(1.5707963267948966, 0, 0)
            u59.Mesh.Scale = Vector3.new(20, 0.25, 20)
        else
            u59 = nil
        end
        local u60 = 0
        local function v61() --[[ Line: 233 ]]
            --[[
            Upvalues:
                [1] = u47
                [2] = u59
                [3] = u60
            --]]
            u47.Humanoid.WalkSpeed = 0
            if u59 and tick() - u60 >= 0.1 then
                u59.Mesh.Scale = u59.Mesh.Scale + Vector3.new(2, 0, 2)
                u60 = tick()
            end
        end
        p44:ChargeSkill(p45, {
            ["Key"] = Enum.KeyCode.Z,
            ["CheckFunction"] = v61,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 241 ]]
                --[[
                Upvalues:
                    [1] = u53
                    [2] = u47
                    [3] = u48
                --]]
                if tick() - u53 >= 5 or (u47:FindFirstChild("Stun") or (not u47:FindFirstChild("Bomb-Bomb") or (u47.Parent == nil or (u47.Parent ~= workspace.PlayerCharacters or u48.Stamina.Value <= 0)))) then
                    return true
                end
            end
        })
        v51:AdjustSpeed(1)
        if u59 then
            local _ = u59.Mesh.Scale.X
            _G.tween(u59, {
                0.25,
                "EntranceExpressive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1
            })
            _G.destroy(u59, 0.25)
        end
        local u62
        if v52 then
            u62 = v52:InvokeServer({
                ["cf"] = u47.HumanoidRootPart.CFrame
            })
        else
            u62 = nil
        end
        if u62 then
            task.delay(1.1, function() --[[ Line: 268 ]]
                --[[
                Upvalues:
                    [1] = u62
                --]]
                for u63 = 1, #u62 do
                    task.spawn(function() --[[ Line: 270 ]]
                        --[[
                        Upvalues:
                            [1] = u62
                            [2] = u63
                        --]]
                        local v64 = _G.awaitObject(u62[u63])
                        if v64 and typeof(v64) == "Instance" then
                            v64.Transparency = 0.5
                        end
                    end)
                end
            end)
        end
        u47.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Explosive Mines", v50)
        _G.fw(v50)
        v46.trap = false
    end
end
function u5.SelfDestruction(p65, p66) --[[ Line: 287 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v67 = p65.Cooldowns
    local u68 = u1.Character
    local u69 = u2["Stats" .. u1.Name]
    if v67.selfex == false and (_G.check:inspect(u68) == true and _G.StamCheck("Self Destruction") == true) then
        local v70 = u3.GetM("Self Destruction")
        local v71 = v70.cd
        if _G.StamCheck("Self Destruction") == false then
            return
        end
        if v70.statreq and _G.MeetReq(v70.statreq) == false then
            return
        end
        v67.selfex = true
        _G.canuse = false
        local v72 = u68.Humanoid:LoadAnimation(script.self)
        v72:Play()
        v72:AdjustWeight(2)
        u68.HumanoidRootPart.Anchored = true
        local v73 = game.ReplicatedStorage.Events.Skill:InvokeServer("Self Destruction", {
            ["cf"] = u68.HumanoidRootPart.CFrame,
            ["cf2"] = true
        })
        local u74 = tick()
        _G.PauseAnim(v72, 0.4, 1)
        p65:ChargeSkill(p66, {
            ["Key"] = Enum.KeyCode.C,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 312 ]] end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 316 ]]
                --[[
                Upvalues:
                    [1] = u74
                    [2] = u68
                    [3] = u69
                --]]
                if tick() - u74 >= 4 or (not u68:FindFirstChild("Bomb-Bomb") or (u68.Parent == nil or (u68.Parent ~= workspace.PlayerCharacters or u69.Stamina.Value <= 0))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        v72:AdjustSpeed(1)
        if v73 then
            v73:FireServer()
        end
        task.wait(0.5)
        u68.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Self Destruction", v71)
        _G.fw(v71)
        v67.selfex = false
    end
end
function u5.ExplosiveGrab(p75, p76) --[[ Line: 344 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v77 = p75.Cooldowns
    local u78 = u1.Character
    local u79 = u2["Stats" .. u1.Name]
    if v77.swing == false and (_G.check:inspect(u78) == true and _G.StamCheck("Explosive Grab") == true) then
        local v80 = u3.GetM("Explosive Grab")
        local v81 = v80.cd
        if _G.StamCheck("Explosive Grab") == false then
            return
        end
        if v80.statreq and _G.MeetReq(v80.statreq) == false then
            return
        end
        v77.swing = true
        _G.canuse = false
        local v82 = u78.Humanoid:LoadAnimation(script.swing)
        v82:Play()
        v82:AdjustWeight(2)
        local u83 = tick()
        u78.Humanoid.WalkSpeed = 4
        _G.PauseAnim(v82, 0.25, 1.5)
        p75:ChargeSkill(p76, {
            ["Key"] = Enum.KeyCode.X,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 369 ]]
                --[[
                Upvalues:
                    [1] = u78
                --]]
                u78.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 374 ]]
                --[[
                Upvalues:
                    [1] = u83
                    [2] = u78
                    [3] = u79
                --]]
                if tick() - u83 >= 4 or (u78:FindFirstChild("Stun") or (not u78:FindFirstChild("Bomb-Bomb") or (u78.Parent == nil or (u78.Parent ~= workspace.PlayerCharacters or u79.Stamina.Value <= 0)))) then
                    return true
                end
            end
        })
        v82:AdjustSpeed(1)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Explosive Grab", {
            ["cf"] = u78.HumanoidRootPart.CFrame
        })
        u78.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Explosive Grab", v81)
        _G.fw(v81)
        v77.swing = false
    end
end
return u5
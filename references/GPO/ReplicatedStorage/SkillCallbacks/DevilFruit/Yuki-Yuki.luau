 

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
        ["reform"] = false,
        ["swipe"] = false,
        ["storm"] = false,
        ["frostbite"] = false,
        ["turret"] = false,
        ["blizzard"] = false
    }
    v8.CurrentSwipe = 1
    return v8
end
function u5.SnowReformation(p9, _) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v10 = p9.Cooldowns
    local v11 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v10.reform == false and (_G.check:inspect(v11) == true and _G.StamCheck("Snow Reformation") == true) then
        local v12 = u3.GetM("Snow Reformation")
        local v13 = v12.cd
        if _G.StamCheck("Snow Reformation") == false then
            return
        end
        if v12.statreq and _G.MeetReq(v12.statreq) == false then
            return
        end
        v10.reform = true
        _G.canuse = false
        v11.PrimaryPart.Velocity = Vector3.new()
        local v14 = CFrame.new(v11.HumanoidRootPart.Position, p9:GetMouseCFrame().Position)
        local v15 = Ray.new(v14.Position, v14.LookVector * 150)
        local _, v16, _ = _G.raycastWhitelist(v15, { workspace.Islands, workspace.Ships, workspace.Env })
        local v17 = (v11.HumanoidRootPart.CFrame.Position - v16).Magnitude
        local v18 = CFrame.new(v11.HumanoidRootPart.CFrame.Position, v16) * CFrame.new(0, v11.Humanoid.HipHeight * 1.75, -v17)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Snow Reformation", v18)
        local v19 = v17 / 75 / 1.5
        task.wait(v19 + 0.75)
        v11.Humanoid.PlatformStand = false
        _G.canuse = true
        _G.keysetup:cooldown("Snow Reformation", v13)
        _G.fw(v13)
        v10.reform = false
    end
end
function u5.SnowGust(p20, p21) --[[ Line: 65 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v22 = p20.Cooldowns
    local u23 = u1.Character
    local u24 = u2["Stats" .. u1.Name]
    if v22.swipe == false and (_G.check:inspect(u23) == true and _G.StamCheck("Snow Gust") == true) then
        local v25 = u3.GetM("Snow Gust")
        local v26 = v25.cd
        if _G.StamCheck("Snow Gust") == false then
            return
        end
        if v25.statreq and _G.MeetReq(v25.statreq) == false then
            return
        end
        v22.swipe = true
        local v27 = u23.Humanoid:LoadAnimation(script.swipe)
        v27:Play()
        v27:AdjustWeight(2)
        v27:AdjustSpeed(1)
        _G.FaceMouse = true
        _G.canuse = false
        local u28 = game.ReplicatedStorage.Events.Skill:InvokeServer("Snow Gust")
        _G.PauseAnim(v27, 0.3, 1.25)
        local u29 = tick()
        p20:ChargeSkill(p21, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 93 ]]
                --[[
                Upvalues:
                    [1] = u28
                --]]
                if u28 == nil then
                    return false
                end
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 99 ]]
                --[[
                Upvalues:
                    [1] = u23
                    [2] = u29
                    [3] = u24
                --]]
                if not u23:FindFirstChild(script.Name) or (tick() - u29 >= 10 or (u23.Parent == nil or (u23.Parent ~= workspace.PlayerCharacters or u24.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        u23.PrimaryPart.Anchored = true
        _G.FaceMouse = false
        v27:AdjustSpeed(2)
        task.wait(0.15)
        if u28 then
            u28:FireServer(u23.PrimaryPart.CFrame)
        end
        task.wait(0.75)
        u23.PrimaryPart.Anchored = false
        _G.keysetup:cooldown("Snow Gust", v26)
        _G.canuse = true
        _G.fw(v26)
        v22.swipe = false
    end
end
function u5.SnowStorm(p30, p31) --[[ Line: 131 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v32 = p30.Cooldowns
    local u33 = u1.Character
    local u34 = u2["Stats" .. u1.Name]
    if v32.storm == false and (_G.check:inspect(u33) == true and _G.StamCheck("Snow Storm") == true) then
        local v35 = u3.GetM("Snow Storm")
        local v36 = v35.cd
        if _G.StamCheck("Snow Storm") == false then
            return
        end
        if v35.statreq and _G.MeetReq(v35.statreq) == false then
            return
        end
        v32.storm = true
        _G.canuse = false
        local v37 = u33.Humanoid:LoadAnimation(script.spin)
        v37:Play()
        v37:AdjustWeight(2)
        v37:AdjustSpeed(1)
        local u38 = Instance.new("BodyVelocity")
        u38.MaxForce = Vector3.new(1000000, 1000000, 1000000)
        u38.Velocity = u33.HumanoidRootPart.CFrame.LookVector * 25
        u38.Parent = u33.LowerTorso
        local u39 = game.ReplicatedStorage.Events.Skill:InvokeServer("Snow Storm")
        task.wait(0.3)
        local u40 = tick()
        p30:ChargeSkill(p31, {
            ["Key"] = Enum.KeyCode.X,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 166 ]]
                --[[
                Upvalues:
                    [1] = u38
                    [2] = u33
                    [3] = u39
                --]]
                u38.Velocity = u33.HumanoidRootPart.CFrame.LookVector * 10
                u33.Humanoid.WalkSpeed = 8
                if u39 == nil then
                    return false
                end
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 175 ]]
                --[[
                Upvalues:
                    [1] = u33
                    [2] = u40
                    [3] = u34
                --]]
                if u33:FindFirstChild("PB") then
                    return true
                end
                if not u33:FindFirstChild(script.Name) or (tick() - u40 >= 4 or (u33.Parent == nil or (u33.Parent ~= workspace.PlayerCharacters or u34.Stamina.Value <= 0))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        if u39 then
            u39:FireServer(u33.PrimaryPart.CFrame)
        end
        u38.Velocity = Vector3.new()
        _G.destroy(u38, 0.2)
        local v41 = u33.Humanoid:LoadAnimation(script.stormEnd)
        v41:Play()
        v41:AdjustWeight(2)
        v41:AdjustSpeed(1)
        u33.Humanoid.WalkSpeed = 16
        task.wait(0.75)
        _G.keysetup:cooldown("Snow Storm", v36)
        _G.canuse = true
        _G.fw(v36)
        v32.storm = false
    end
end
function u5.FrostBite(p42, _) --[[ Line: 212 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v43 = p42.Cooldowns
    local u44 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v43.frostbite == false and (_G.check:inspect(u44) == true and _G.StamCheck("Frost Bite") == true) then
        local v45 = u3.GetM("Frost Bite")
        local v46 = v45.cd
        if _G.StamCheck("Frost Bite") == false then
            return
        end
        if v45.statreq and _G.MeetReq(v45.statreq) == false then
            return
        end
        v43.frostbite = true
        _G.canuse = false
        local v47 = u44.Humanoid:LoadAnimation(script.dashGrab)
        v47:Play(0)
        v47:AdjustWeight(2)
        u44.Humanoid.WalkSpeed = 4
        task.wait(0.15)
        local u48 = game.ReplicatedStorage.Events.Skill:InvokeServer("Frost Bite", {
            ["cf"] = u44.HumanoidRootPart.CFrame
        })
        tick()
        v47:AdjustSpeed(1)
        task.wait(0.2)
        local u49 = Instance.new("BodyVelocity", u44.HumanoidRootPart)
        u49.MaxForce = Vector3.new(1000000, 1000000, 1000000)
        u49.Velocity = u44.HumanoidRootPart.CFrame.LookVector * 75
        _G.destroy(u49, 0.1)
        if u48 then
            u48:FireServer()
        end
        _G.hitbox:start(u44, Vector3.new(8, 12, 12), 0.5, CFrame.new(0, 0, -2), function(p50) --[[ Name: hitfound, Line 248 ]]
            --[[
            Upvalues:
                [1] = u49
                [2] = u48
                [3] = u44
            --]]
            u49:Destroy()
            u49 = nil
            u48:FireServer(p50.Parent, u44.HumanoidRootPart.CFrame)
        end, nil)
        u44.Humanoid.WalkSpeed = 16
        task.wait(0.4)
        _G.canuse = true
        _G.keysetup:cooldown("Frost Bite", v46)
        _G.fw(v46)
        v43.frostbite = false
    end
end
function u5.SnowBunnyTurret(p51, _) --[[ Line: 263 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v52 = p51.Cooldowns
    local v53 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v52.turret == false and (_G.check:inspect(v53) == true and _G.StamCheck("Snow Bunny Turret") == true) then
        local v54 = u3.GetM("Snow Bunny Turret")
        local v55 = v54.cd
        if _G.StamCheck("Snow Bunny Turret") == false then
            return
        end
        if v54.statreq and _G.MeetReq(v54.statreq) == false then
            return
        end
        local v56, _, _ = _G.getRayFloor(v53.PrimaryPart.CFrame, 5)
        if v56 == nil then
            return nil
        end
        v52.turret = true
        _G.canuse = false
        local v57 = v53.Humanoid:LoadAnimation(script.summonBunny)
        v57:Play(0)
        v57:AdjustWeight(2)
        v53.Humanoid.WalkSpeed = 4
        local v58, v59 = _G.raycast:cast(v53.HumanoidRootPart.CFrame.Position, v53.HumanoidRootPart.CFrame.LookVector * 4.5, { workspace.Islands, workspace.Ships, workspace.Env })
        local v60 = (v53.HumanoidRootPart.Position - v59).Magnitude
        if v58 then
            v60 = v60 - 3
        end
        game.ReplicatedStorage.Events.Skill:InvokeServer("Snow Bunny Turret", v53.PrimaryPart.CFrame * CFrame.new(0, -1, -v60))
        task.wait(0.65)
        v53.Humanoid.WalkSpeed = 16
        _G.keysetup:cooldown("Snow Bunny Turret", v55)
        _G.canuse = true
        _G.fw(v55)
        v52.turret = false
    end
end
function u5.SnowBlizzard(p61, _) --[[ Line: 309 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v62 = p61.Cooldowns
    local v63 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v62.blizzard == false and (_G.check:inspect(v63) == true and _G.StamCheck("Snow Blizzard") == true) then
        local v64 = u3.GetM("Snow Blizzard")
        local v65 = v64.cd
        if _G.StamCheck("Snow Blizzard") == false then
            return
        end
        if v64.statreq and _G.MeetReq(v64.statreq) == false then
            return
        end
        local v66, v67, _ = _G.getRayFloor(v63.PrimaryPart.CFrame * CFrame.new(0, 0, -1.5), 5)
        if v66 == nil then
            return nil
        end
        v62.blizzard = true
        _G.canuse = false
        local v68 = v63.Humanoid:LoadAnimation(script.stomp)
        v68:Play()
        v68:AdjustWeight(2)
        v68:AdjustSpeed(1)
        v63.Humanoid.WalkSpeed = 0
        local v69 = game.ReplicatedStorage.Events.Skill:InvokeServer("Snow Blizzard", v67)
        _G.PauseAnim(v68, 0.4, 0.6)
        v68:Stop()
        v63.Humanoid.AutoRotate = false
        v63.PrimaryPart.Anchored = true
        local v70 = v63.Humanoid:LoadAnimation(script.stompLoop)
        v70:Play()
        v70:AdjustWeight(2)
        if v69 then
            v69:InvokeServer()
        end
        v70:Stop()
        v63.PrimaryPart.Anchored = false
        v63.Humanoid.AutoRotate = true
        v63.Humanoid.WalkSpeed = 16
        task.wait(0.25)
        _G.keysetup:cooldown("Snow Blizzard", v65)
        _G.canuse = true
        _G.fw(v65)
        v62.blizzard = false
    end
end
return u5
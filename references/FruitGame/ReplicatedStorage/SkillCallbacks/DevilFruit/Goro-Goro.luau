 

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
        ["piller"] = false,
        ["sango"] = false,
        ["dragon"] = false,
        ["flash"] = false,
        ["raigo"] = false,
        ["fly"] = false
    }
    return v8
end
function u5.LightningWrath(p9, p10) --[[ Line: 35 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v11 = p9.Cooldowns
    local u12 = u1.Character
    local u13 = u2["Stats" .. u1.Name]
    if v11.piller == false and (_G.check:inspect(u12) == true and _G.StamCheck("Lightning Wrath") == true) then
        local v14 = u3.GetM("Lightning Wrath")
        local v15 = v14.cd
        if _G.StamCheck("Lightning Wrath") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        v11.piller = true
        _G.canuse = false
        local v16 = u12.Humanoid:LoadAnimation(script.piller)
        v16:Play()
        v16:AdjustWeight(2)
        _G.FaceMouse = true
        _G.PauseAnim(v16, 0.42, 1.68)
        local u17 = tick()
        local u18 = false
        p9:ChargeSkill(p10, {
            ["Key"] = Enum.KeyCode.Z,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 65 ]]
                --[[
                Upvalues:
                    [1] = u17
                    [2] = u12
                    [3] = u13
                    [4] = u18
                --]]
                if tick() - u17 >= 10 or (not u12:FindFirstChild("Goro-Goro") or (u12.Parent == nil or (u12.Parent ~= workspace.PlayerCharacters or u13.Stamina.Value <= 0))) then
                    return true
                end
                if _G.check:inspect(u12) == false then
                    u18 = true
                    return true
                end
            end
        })
        if u18 == false then
            v16:AdjustSpeed(1.5)
            game.ReplicatedStorage.Events.Skill:InvokeServer("Lightning Wrath", {
                ["cf"] = p9:GetMouseCFrame()
            })
            u12.HumanoidRootPart.Anchored = true
        else
            v16:Stop()
        end
        _G.FaceMouse = false
        task.wait(0.5)
        u12.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Lightning Wrath", v15)
        _G.fw(v15)
        v11.piller = false
    end
end
function u5.LightningParalyzation(p19, p20) --[[ Line: 96 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v21 = p19.Cooldowns
    local u22 = u1.Character
    local u23 = u2["Stats" .. u1.Name]
    if v21.sango == false and (_G.check:inspect(u22) == true and _G.StamCheck("Lightning Paralyzation") == true) then
        local v24 = u3.GetM("Lightning Paralyzation")
        local v25 = v24.cd
        if _G.StamCheck("Lightning Paralyzation") == false then
            return
        end
        if v24.statreq and _G.MeetReq(v24.statreq) == false then
            return
        end
        v21.sango = true
        _G.canuse = false
        local v26 = u22.Humanoid:LoadAnimation(script.sango)
        v26:Play()
        v26:AdjustWeight(2)
        u22.Humanoid.WalkSpeed = 4
        local u27 = game.ReplicatedStorage.MiscModels.GoroSphere:Clone()
        u27.Parent = workspace.Effects
        local v28 = Instance.new("Weld", u27)
        v28.Part0 = u22.HumanoidRootPart
        v28.Part1 = u27
        _G.tween(u27.Mesh, {
            0.42,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Scale"] = Vector3.new(35, 35, 35)
        })
        _G.PauseAnim(v26, 0.42, 1)
        tick()
        p19:ChargeSkill(p20, {
            ["Key"] = Enum.KeyCode.E,
            ["IgnoreInstantCastSetting"] = true,
            ["CheckFunction"] = function() --[[ Name: CheckFunction, Line 135 ]]
                --[[
                Upvalues:
                    [1] = u22
                    [2] = u27
                --]]
                u22.Humanoid.WalkSpeed = 4
                local _ = u22.RightHand.CFrame
                if u27.Mesh.Scale.X < 100 then
                    local v29 = u27.Mesh
                    v29.Scale = v29.Scale + Vector3.new(0.75, 0.75, 0.75) * (60 / _G.FPS)
                end
                _G.canuse = false
            end,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 143 ]]
                --[[
                Upvalues:
                    [1] = u22
                    [2] = u23
                --]]
                return not u22:FindFirstChild("Goro-Goro") or ((u22.Parent == nil or u22.Parent ~= workspace.PlayerCharacters) and true or u23.Stamina.Value <= 0)
            end
        })
        v26:AdjustSpeed(1.5)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Lightning Paralyzation", {
            ["cf"] = u22.PrimaryPart.CFrame,
            ["size"] = u27.Mesh.Scale.X
        })
        _G.tween(u27, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1
        })
        _G.destroy(u27, 0.25)
        task.wait(0.7)
        u22.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Lightning Paralyzation", v25)
        _G.fw(v25)
        v21.sango = false
    end
end
function u5.FlashSmash(p30, p31) --[[ Line: 161 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v32 = p30.Cooldowns
    local u33 = u1.Character
    local u34 = u2["Stats" .. u1.Name]
    if v32.flash == false and (_G.check:inspect(u33) == true and _G.StamCheck("Flash Smash") == true) then
        local v35 = u3.GetM("Flash Smash")
        local v36 = v35.cd
        if _G.StamCheck("Flash Smash") == false then
            return
        end
        if v35.statreq and _G.MeetReq(v35.statreq) == false then
            return
        end
        _G.canuse = false
        local u37 = tick()
        local v38 = u33.Humanoid:LoadAnimation(script.dashCharge)
        v38:Play()
        _G.FaceMouse = true
        _G.PauseAnim(v38, 0.6, 1.3)
        v32.flash = true
        p30:ChargeSkill(p31, {
            ["Key"] = Enum.KeyCode.R,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 186 ]]
                --[[
                Upvalues:
                    [1] = u33
                    [2] = u37
                    [3] = u34
                --]]
                u33.Humanoid.WalkSpeed = 4
                return tick() - u37 >= 10 and true or (not u33:FindFirstChild("Goro-Goro") or (u33.Parent == nil and true or (u33.Parent ~= workspace.PlayerCharacters and true or (u34.Stamina.Value <= 0 and true or u33:FindFirstChild("Stun")))))
            end
        })
        v38:AdjustSpeed(1)
        _G.FaceMouse = false
        u33.Humanoid.WalkSpeed = 16
        u33.HumanoidRootPart.Anchored = true
        game.ReplicatedStorage.Events.Skill:InvokeServer("Flash Smash", {
            ["endPos"] = p30:GetMouseCFrame()
        })
        u33.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Flash Smash", v36)
        _G.fw(v36)
        v32.flash = false
    end
end
function u5.LightningDragon(p39, p40) --[[ Line: 207 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v41 = p39.Cooldowns
    local u42 = u1.Character
    local u43 = u2["Stats" .. u1.Name]
    if v41.dragon == false and (_G.check:inspect(u42) == true and _G.StamCheck("Lightning Dragon") == true) then
        local v44 = u3.GetM("Lightning Dragon")
        local v45 = v44.cd
        if _G.StamCheck("Lightning Dragon") == false then
            return
        end
        if v44.statreq and _G.MeetReq(v44.statreq) == false then
            return
        end
        v41.dragon = true
        _G.canuse = false
        local u46 = tick()
        local v47 = u42.Humanoid:LoadAnimation(script.dragon)
        v47:Play()
        v47:AdjustWeight(2)
        _G.FaceMouse = true
        _G.PauseAnim(v47, 0.42, 1)
        local u48 = false
        p39:ChargeSkill(p40, {
            ["Key"] = Enum.KeyCode.X,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 250 ]]
                --[[
                Upvalues:
                    [1] = u46
                    [2] = u42
                    [3] = u43
                    [4] = u48
                --]]
                if tick() - u46 >= 10 or (not u42:FindFirstChild("Goro-Goro") or (u42.Parent == nil or (u42.Parent ~= workspace.PlayerCharacters or u43.Stamina.Value <= 0))) then
                    return true
                end
                if _G.check:inspect(u42) == false then
                    u48 = true
                    return true
                end
            end
        })
        u42.HumanoidRootPart.Anchored = true
        _G.FaceMouse = false
        if u48 == false then
            v47:AdjustSpeed(1)
            task.wait(0.3)
            game.ReplicatedStorage.Events.Skill:InvokeServer("Lightning Dragon", {
                ["endPos"] = p39:GetMouseCFrame(),
                ["start"] = u42.RightHand.CFrame
            })
            task.wait(0.4)
        else
            v47:Stop()
        end
        u42.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Lightning Dragon", v45)
        _G.fw(v45)
        v41.dragon = false
    end
end
function u5.ThunderGreeting(p49, p50) --[[ Line: 280 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v51 = p49.Cooldowns
    local u52 = u1.Character
    local u53 = u2["Stats" .. u1.Name]
    if v51.raigo == false and (_G.check:inspect(u52) == true and _G.StamCheck("Thunder Greeting") == true) then
        local v54 = u3.GetM("Thunder Greeting")
        local v55 = v54.cd
        if _G.StamCheck("Thunder Greeting") == false then
            return
        end
        if v54.statreq and _G.MeetReq(v54.statreq) == false then
            return
        end
        v51.raigo = true
        _G.canuse = false
        local v56 = u52.Humanoid:LoadAnimation(script.raigo)
        v56:Play()
        v56:AdjustWeight(2)
        _G.FaceMouse = true
        _G.PauseAnim(v56, 0.5, 1)
        local v57 = game.ReplicatedStorage.Events.Skill:InvokeServer("Thunder Greeting", {
            ["cf"] = p49:GetMouseCFrame()
        })
        local u58 = tick()
        p49:ChargeSkill(p50, {
            ["Key"] = Enum.KeyCode.C,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 323 ]]
                --[[
                Upvalues:
                    [1] = u52
                    [2] = u53
                    [3] = u58
                --]]
                return not u52:FindFirstChild("Goro-Goro") or ((u52.Parent == nil or (u52.Parent ~= workspace.PlayerCharacters or (u53.Stamina.Value <= 0 or tick() - u58 >= 15))) and true or u52:GetAttribute("goroUltMax") ~= nil)
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        v56:AdjustSpeed(1.5)
        if v57 then
            v57:FireServer(p49:GetMouseCFrame())
        end
        u52.HumanoidRootPart.Anchored = true
        _G.FaceMouse = false
        task.wait(0.5)
        u52.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Thunder Greeting", v55)
        _G.fw(v55)
        v51.raigo = false
    end
end
function u5.LightningForm(u59, p60) --[[ Line: 349 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v61 = u59.Cooldowns
    local u62 = u1.Character
    local u63 = u2["Stats" .. u1.Name]
    if _G.grounded == false and (v61.fly == false and (_G.check:inspect(u62) == true and _G.StamCheck("Lightning Form") == true)) then
        local v64 = u3.GetM("Lightning Form")
        local v65 = v64.cd
        if _G.StamCheck("Lightning Form") == false then
            return
        end
        if v64.statreq and _G.MeetReq(v64.statreq) == false then
            return
        end
        v61.fly = true
        _G.canuse = false
        tick()
        local u66 = game.ReplicatedStorage.Events.Skill:InvokeServer("Lightning Form")
        local u67
        if u66 then
            u67 = Instance.new("BodyVelocity", u62.LowerTorso)
            u67.MaxForce = Vector3.new(inf, inf, inf)
            u67.Name = "geppo"
            u67.Velocity = Vector3.new()
        else
            u67 = nil
        end
        local _ = u62.PrimaryPart.CFrame
        local function v69() --[[ Line: 383 ]]
            --[[
            Upvalues:
                [1] = u62
                [2] = u67
                [3] = u59
            --]]
            _G.canuse = false
            local v68 = u62.Humanoid.Health / u62.Humanoid.MaxHealth
            if u67 then
                u67.Velocity = (u62.HumanoidRootPart.Position - u59:GetMouseCFrame().Position).unit * -(125 * v68)
            end
            u62.PrimaryPart.Velocity = Vector3.new()
        end
        u59:ChargeSkill(p60, {
            ["Button"] = p60,
            ["Key"] = Enum.KeyCode.T,
            ["PCInputType"] = "Default",
            ["MobileInputType"] = "Toggle",
            ["IgnoreInstantCastSetting"] = true,
            ["CheckFunction"] = v69,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 392 ]]
                --[[
                Upvalues:
                    [1] = u62
                    [2] = u63
                    [3] = u66
                --]]
                if u62:FindFirstChild("Goro-Goro") == nil or (_G.check:inspect(u62) == false or (u62.Parent == nil or (u62.Parent ~= workspace.PlayerCharacters or (u63.Stamina.Value <= 0 or u66 == nil)))) then
                    return true
                end
            end
        })
        if u66 then
            u66:FireServer()
        end
        if u67 then
            u67:Destroy()
        end
        u62:SetPrimaryPartCFrame(CFrame.new(u62.PrimaryPart.Position, u59:GetMouseCFrame().Position))
        _G.canuse = true
        _G.keysetup:cooldown("Lightning Form", v65)
        _G.fw(v65)
        v61.fly = false
    end
end
return u5
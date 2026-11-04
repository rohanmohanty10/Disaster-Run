 

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
        ["Bird"] = false,
        ["Spear"] = false,
        ["Bike"] = false,
        ["Sword"] = false,
        ["Stomp"] = false,
        ["age"] = false
    }
    v8.SpearHand = false
    return v8
end
function u5.IcePartisan(p9, p10) --[[ Line: 36 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
        [3] = u3
    --]]
    local u11 = p9.Cooldowns
    local u12 = u2:FindFirstChild("Stats" .. u1.Name)
    local u13 = u1.Character
    if u11.Spear == false and (_G.check:inspect(u13) == true and _G.StamCheck("Ice Partisan") == true) then
        local v14 = u3.GetM("Ice Partisan")
        local u15 = v14.cd
        if _G.StamCheck("Ice Partisan") == false then
            return
        end
        if v14.statreq and _G.MeetReq(v14.statreq) == false then
            return
        end
        u11.Spear = true
        _G.canuse = false
        _G.FaceMouse = true
        local u16 = tick()
        local v17 = u13.Humanoid:LoadAnimation(script.Spear)
        p9.SpearHand = not p9.SpearHand
        if p9.SpearHand then
            v17:Destroy()
            v17 = u13.Humanoid:LoadAnimation(script.Spear2)
        end
        v17:Play()
        _G.PauseAnim(v17, 0.25, 1)
        p9:ChargeSkill(p10, {
            ["Key"] = Enum.KeyCode.E,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 66 ]]
                --[[
                Upvalues:
                    [1] = u16
                    [2] = u13
                    [3] = u12
                --]]
                return (tick() - u16 >= 10 or (u13:FindFirstChild("Hie-Hie") == false or (u13.Parent == nil or u13.Parent ~= workspace.PlayerCharacters))) and true or u12.Stamina.Value <= 0
            end
        })
        _G.FaceMouse = false
        v17:AdjustSpeed(1)
        u13.HumanoidRootPart.Anchored = true
        task.wait(0.15000000000000002)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Ice Partisan", {
            ["cf"] = u13.HumanoidRootPart.CFrame,
            ["ExploitCheck"] = true
        })
        task.spawn(function() --[[ Line: 76 ]]
            --[[
            Upvalues:
                [1] = u15
                [2] = u11
            --]]
            _G.keysetup:cooldown("Ice Partisan", u15)
            _G.fw(u15)
            u11.Spear = false
        end)
        task.wait(0.35)
        u13.HumanoidRootPart.Anchored = false
        _G.canuse = true
    end
end
function u5.IceBike(p18, p19) --[[ Line: 89 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v20 = p18.Cooldowns
    local u21 = u1.Character
    local u22 = u2:FindFirstChild("Stats" .. u1.Name)
    if _G.grounded == false and (v20.Bike == false and (_G.check:inspect(u21) == true and _G.StamCheck("Ice Bike") == true)) then
        local v23 = u3.GetM("Ice Bike")
        local v24 = v23.cd
        if _G.StamCheck("Ice Bike") == false then
            return
        end
        if v23.statreq and _G.MeetReq(v23.statreq) == false then
            return
        end
        v20.Bike = true
        _G.allowJumpWhileStunned = true
        _G.canuse = false
        local u25 = nil
        pcall(function() --[[ Line: 109 ]]
            --[[
            Upvalues:
                [1] = u25
                [2] = u21
            --]]
            u25 = game.ReplicatedStorage.Events.Skill:InvokeServer("Ice Bike", {
                ["cf"] = u21.HumanoidRootPart.CFrame
            })
        end)
        tick()
        local u26 = Instance.new("BodyVelocity", u21.HumanoidRootPart)
        u26.MaxForce = Vector3.new(100000, 0, 100000)
        local u27 = 5
        local v28 = workspace.Effects:WaitForChild(u1.Name .. "IceBike", 3)
        local u29, u30
        if v28 then
            u29 = v28.AnimationController:LoadAnimation(script.BikeWheel)
            u29:Play()
            u30 = u21.Humanoid:LoadAnimation(script.Pedal)
            u30:Play()
        else
            u29 = nil
            u30 = nil
        end
        _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.IceBike]:start(u21)
        tick()
        local function v41(_) --[[ Line: 135 ]]
            --[[
            Upvalues:
                [1] = u27
                [2] = u21
                [3] = u26
                [4] = u29
                [5] = u30
                [6] = u22
            --]]
            if tick() - 0 >= 0.016666666666666666 then
                u27 = u27 + 0.25 * (u21.Humanoid.Health / u21.Humanoid.MaxHealth)
            end
            local v31 = u27
            local v32 = 125 * (u21.Humanoid.Health / u21.Humanoid.MaxHealth)
            u27 = math.clamp(v31, 0, v32)
            local v33 = CFrame.new(u21.HumanoidRootPart.Position)
            local v34 = Ray.new(v33.Position, v33.upVector * -(u21.Humanoid.HipHeight * 2 + 5))
            local v35, _, _ = _G.raycastWhitelist(v34, { workspace.Islands, workspace.Ships, workspace.Env })
            local v36 = u21.HumanoidRootPart.CFrame
            local v37 = Ray.new(v36.Position, v36.LookVector * 2)
            local v38, _, _ = _G.raycastWhitelist(v37, { workspace.Islands, workspace.Ships, workspace.Env })
            if v35 == nil then
                u27 = u27 - 0.25
            end
            if v38 and v38.CanCollide == true then
                u27 = 0
            end
            u27 = u27
            u26.Velocity = u21.HumanoidRootPart.CFrame.LookVector * u27
            local v39 = u27 / 125 * 3
            local v40 = v35 == nil and 0.25 or v39
            if u29 then
                u29:AdjustSpeed(v40)
                u30:AdjustSpeed(v40)
            end
            _G.allowJumpWhileStunned = true
            _G.canuse = false
            if u21:FindFirstChild("Stun") then
                return true
            end
            if u22.Stamina.Value <= 0 or u21.Parent == workspace.Ragdolls then
                return true
            end
        end
        p18:ChargeSkill(p19, {
            ["Button"] = p19,
            ["Key"] = Enum.KeyCode.T,
            ["PCInputType"] = "Toggle",
            ["MobileInputType"] = "Toggle",
            ["EndFunction"] = v41
        })
        u26:Destroy()
        _G.allowJumpWhileStunned = nil
        pcall(function() --[[ Line: 187 ]]
            --[[
            Upvalues:
                [1] = u29
                [2] = u30
            --]]
            u29:Stop()
            u30:Stop()
        end)
        _G.canuse = true
        if u25 then
            u25:FireServer()
        end
        _G.keysetup:cooldown("Ice Bike", v24)
        _G.fw(v24)
        v20.Bike = false
    end
end
function u5.PheasantBeak(p42, p43) --[[ Line: 201 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
        [3] = u3
    --]]
    local v44 = p42.Cooldowns
    local u45 = u2:FindFirstChild("Stats" .. u1.Name)
    local u46 = u1.Character
    if v44.Bird == false and (_G.check:inspect(u46) == true and _G.StamCheck("Pheasant Beak") == true) then
        local v47 = u3.GetM("Pheasant Beak")
        local v48 = v47.cd
        if _G.StamCheck("Pheasant Beak") == false then
            return
        end
        if v47.statreq and _G.MeetReq(v47.statreq) == false then
            return
        end
        v44.Bird = true
        _G.canuse = false
        _G.FaceMouse = true
        local u49 = tick()
        local v50 = u46.Humanoid:LoadAnimation(script.beak)
        v50:Play()
        _G.PauseAnim(v50, 0.45, 2)
        p42:ChargeSkill(p43, {
            ["Key"] = Enum.KeyCode.R,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 226 ]]
                --[[
                Upvalues:
                    [1] = u46
                    [2] = u49
                    [3] = u45
                --]]
                return not u46:FindFirstChild("Hie-Hie") or ((tick() - u49 >= 10 or (u46.Parent == nil or u46.Parent ~= workspace.PlayerCharacters)) and true or u45.Stamina.Value <= 0)
            end
        })
        _G.FaceMouse = false
        u46.HumanoidRootPart.Anchored = true
        v50:AdjustSpeed(1)
        task.wait(0.15)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Pheasant Beak", {
            ["cf"] = u46.HumanoidRootPart.CFrame
        })
        task.wait(0.35)
        u46.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Pheasant Beak", v48)
        _G.fw(v48)
        v44.Bird = false
    end
end
function u5.IceStomp(p51, p52) --[[ Line: 246 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
        [3] = u3
    --]]
    local v53 = p51.Cooldowns
    local u54 = u2:FindFirstChild("Stats" .. u1.Name)
    local u55 = u1.Character
    if v53.Stomp == false and (_G.check:inspect(u55) == true and _G.StamCheck("Ice Stomp") == true) then
        local v56 = u3.GetM("Ice Stomp")
        local v57 = v56.cd
        if _G.StamCheck("Ice Stomp") == false then
            return
        end
        if v56.statreq and _G.MeetReq(v56.statreq) == false then
            return
        end
        v53.Stomp = true
        _G.canuse = false
        local v58 = u55.Humanoid:LoadAnimation(script.stomp)
        v58:Play()
        u55.Humanoid.WalkSpeed = 4
        _G.PauseAnim(v58, 0.3, 1.25)
        p51:ChargeSkill(p52, {
            ["Key"] = Enum.KeyCode.Z,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 270 ]]
                --[[
                Upvalues:
                    [1] = u55
                --]]
                u55.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 275 ]]
                --[[
                Upvalues:
                    [1] = u55
                    [2] = u54
                --]]
                if not u55:FindFirstChild("Hie-Hie") or (u55.Parent == nil or (u55.Parent ~= workspace.PlayerCharacters or u54.Stamina.Value <= 0)) then
                    return true
                end
            end
        })
        v58:AdjustSpeed(1)
        task.wait(0.3)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Ice Stomp", {
            ["cf"] = u55.HumanoidRootPart.CFrame
        })
        task.wait(0.25)
        u55.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Ice Stomp", v57)
        _G.fw(v57)
        v53.Stomp = false
    end
end
function u5.FrostBlade(p59, p60) --[[ Line: 300 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
        [3] = u3
    --]]
    local v61 = p59.Cooldowns
    local u62 = u2:FindFirstChild("Stats" .. u1.Name)
    local u63 = u1.Character
    if v61.Sword == false and (_G.check:inspect(u63) == true and _G.StamCheck("Frost Blade") == true) then
        local v64 = u3.GetM("Frost Blade")
        local v65 = v64.cd
        if _G.StamCheck("Frost Blade") == false then
            return
        end
        if v64.statreq and _G.MeetReq(v64.statreq) == false then
            return
        end
        _G.canuse = false
        local u66 = game.ReplicatedStorage.Events.Skill:InvokeServer("Frost Blade", {
            ["cf"] = u63.HumanoidRootPart.CFrame
        })
        if u66 == nil then
            _G.canuse = true
            return
        end
        v61.Sword = true
        local u67 = tick()
        local v68 = u63.Humanoid:LoadAnimation(script.IceSword)
        v68:Play()
        v68:AdjustWeight(5)
        _G.FaceMouse = true
        _G.PauseAnim(v68, 1.25, 1.25)
        p59:ChargeSkill(p60, {
            ["Key"] = Enum.KeyCode.X,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 333 ]]
                --[[
                Upvalues:
                    [1] = u63
                    [2] = u67
                    [3] = u62
                --]]
                return not u63:FindFirstChild("Hie-Hie") or ((tick() - u67 >= 10 or (u63.Parent == nil or u63.Parent ~= workspace.PlayerCharacters)) and true or u62.Stamina.Value <= 0)
            end
        })
        v68:AdjustSpeed(1.35)
        v68.KeyframeReached:Connect(function(p69) --[[ Line: 339 ]]
            --[[
            Upvalues:
                [1] = u66
                [2] = u63
            --]]
            if p69:match("slash") and u66 ~= nil then
                u66:FireServer(p69, u63.HumanoidRootPart.CFrame)
            end
        end)
        u63.HumanoidRootPart.Anchored = true
        u63.Humanoid.WalkSpeed = 16
        _G.FaceMouse = false
        task.wait(2)
        _G.canuse = true
        u66:FireServer("finish")
        u63.HumanoidRootPart.Anchored = false
        _G.keysetup:cooldown("Frost Blade", v65)
        _G.fw(v65)
        v61.Sword = false
    end
end
function u5.IceAge(p70, p71) --[[ Line: 358 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
        [3] = u3
    --]]
    local v72 = p70.Cooldowns
    local u73 = u2:FindFirstChild("Stats" .. u1.Name)
    local u74 = u1.Character
    if v72.age == false and (_G.check:inspect(u74) == true and _G.StamCheck("Ice Age") == true) then
        if u74:FindFirstChild("ragcarry") then
            return
        end
        local v75 = u3.GetM("Ice Age")
        local v76 = v75.cd
        if _G.StamCheck("Ice Age") == false then
            return
        end
        if v75.statreq and _G.MeetReq(v75.statreq) == false then
            return
        end
        v72.age = true
        _G.canuse = false
        local v77 = u74.Humanoid:LoadAnimation(script.iceage)
        v77:Play()
        v77:AdjustWeight(2)
        u74.Humanoid.WalkSpeed = 2
        _G.PauseAnim(v77, 0.67, 1)
        p70:ChargeSkill(p71, {
            ["Key"] = Enum.KeyCode.C,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 386 ]]
                --[[
                Upvalues:
                    [1] = u74
                    [2] = u73
                --]]
                u74.Humanoid.WalkSpeed = 2
                return not u74:FindFirstChild("Hie-Hie") or ((u74.Parent == nil or u74.Parent ~= workspace.PlayerCharacters) and true or u73.Stamina.Value <= 0)
            end
        })
        v77:AdjustSpeed(1.35)
        task.wait(0.2)
        game.ReplicatedStorage.Events.Skill:InvokeServer("Ice Age", {
            ["cf"] = u74.HumanoidRootPart.CFrame
        })
        task.wait(0.3)
        u74.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Ice Age", v76)
        _G.fw(v76)
        v72.age = false
    end
end
return u5
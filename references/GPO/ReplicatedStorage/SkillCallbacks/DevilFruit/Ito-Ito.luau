 

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
        [3] = u1
    --]]
    local v6 = u4.new(script.Name)
    local v7 = u5
    local u8 = setmetatable(v6, v7)
    u8.Cooldowns = {
        ["cage"] = false,
        ["penta"] = false,
        ["bullet"] = false,
        ["overheat"] = false,
        ["parasite"] = false,
        ["stringTravel"] = false
    }
    u8.CurrentSwipe = 1
    local u9 = u1.Character
    u8.rope = nil
    u8.endPoint = nil
    u8.bodyForce = nil
    u8.oldPos = nil
    u8.vel = nil
    u8.swingSide = nil
    u8.alreadySwinging = false
    u8.inSwingStartup = false
    u8.inCombatSwings = 0
    u8.anims = {}
    for _, v10 in script.Swing:GetDescendants() do
        if v10:IsA("Animation") then
            u8.anims[v10.Name] = u9:WaitForChild("Humanoid"):LoadAnimation(v10)
        end
    end
    u8.attach1 = Instance.new("Attachment", u9.HumanoidRootPart)
    function u8.cleanupWebSwing() --[[ Line: 48 ]]
        --[[
        Upvalues:
            [1] = u1
            [2] = u8
            [3] = u9
        --]]
        _G.PlayEffect("Webswing", nil, "clean", u1.Name)
        if u8.rope then
            u8.rope:Destroy()
            u8.rope = nil
        end
        if u8.endPoint then
            u8.endPoint:Destroy()
            u8.endPoint = nil
        end
        if u9.HumanoidRootPart:FindFirstChild("SwingGyro") then
            u9.HumanoidRootPart:FindFirstChild("SwingGyro"):Destroy()
        end
    end
    u8.RenderStepped = game:GetService("RunService").RenderStepped:Connect(function(p11) --[[ Line: 67 ]]
        --[[
        Upvalues:
            [1] = u8
            [2] = u1
            [3] = u9
        --]]
        if u8.rope and u8.endPoint then
            u1:DistanceFromCharacter(u8.endPoint.WorldPosition)
            local v12 = u9.Humanoid.Health / u9.Humanoid.MaxHealth
            if v12 < 0.8 then
                v12 = v12 * 0.5
            end
            local v13 = u8.rope
            local v14 = u8.rope.Length
            local v15 = u1:DistanceFromCharacter(u8.endPoint.WorldPosition) - p11 * 30
            v13.Length = v14 + (math.clamp(v15, 10, 10000) - v14) * v12
            local v16 = u9.HumanoidRootPart.Position
            u8.vel = (v16 - u8.oldPos) / p11
            u8.oldPos = u8.oldPos:Lerp(v16, v12)
        end
        if u9.HumanoidRootPart:FindFirstChild("SwingGyro") and u8.endPoint ~= nil then
            u9.HumanoidRootPart.SwingGyro.CFrame = u9.HumanoidRootPart.SwingGyro.CFrame:Lerp(CFrame.new(u9.HumanoidRootPart.Position, u8.endPoint.WorldPosition), 0.1)
        end
    end)
    return u8
end
function u5.Birdcage(p17, _) --[[ Line: 87 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v18 = p17.Cooldowns
    local v19 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if v18.cage == false and (_G.check:inspect(v19) == true and _G.StamCheck("Birdcage") == true) then
        local v20 = u3.GetM("Birdcage")
        local v21 = v20.cd
        if _G.StamCheck("Birdcage") == false then
            return
        end
        if v20.statreq and _G.MeetReq(v20.statreq) == false then
            return
        end
        v18.cage = true
        local v22 = v19.Humanoid:LoadAnimation(script.cage)
        v22:Play()
        v22:AdjustWeight(2)
        v22:AdjustSpeed(1)
        _G.canuse = false
        task.wait(0.25)
        local v23 = p17:GetMouseCFrame()
        local v24 = Ray.new(v23.Position + Vector3.new(0, 10, 0), v23.upVector * -25)
        local _, v25, _ = _G.raycastWhitelist(v24, { workspace.Islands, workspace.Ships, workspace.Env })
        game.ReplicatedStorage.Events.Skill:InvokeServer("Birdcage", v25)
        _G.canuse = true
        _G.keysetup:cooldown("Birdcage", v21)
        _G.fw(v21)
        v18.cage = false
    end
end
function u5.PentachromaticStrings(u26, p27) --[[ Line: 121 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v28 = u26.Cooldowns
    local u29 = u1.Character
    local u30 = u2["Stats" .. u1.Name]
    if v28.penta == false and (_G.check:inspect(u29) == true and _G.StamCheck("Pentachromatic Strings") == true) then
        local v31 = u3.GetM("Pentachromatic Strings")
        local v32 = v31.cd
        if _G.StamCheck("Pentachromatic Strings") == false then
            return
        end
        if v31.statreq and _G.MeetReq(v31.statreq) == false then
            return
        end
        v28.penta = true
        local v33 = u29.Humanoid:LoadAnimation(script.penta)
        v33:Play()
        v33:AdjustWeight(2)
        v33:AdjustSpeed(1)
        u29.Humanoid.WalkSpeed = 4
        _G.canuse = false
        local v34 = game.ReplicatedStorage.Events.Skill:InvokeServer("Pentachromatic Strings")
        _G.PauseAnim(v33, 0.3, 1)
        local u35 = tick()
        local u36 = false
        local function v37() --[[ Line: 154 ]]
            --[[
            Upvalues:
                [1] = u35
                [2] = u26
                [3] = u29
                [4] = u30
                [5] = u36
            --]]
            if tick() - u35 >= 10 or (u26.Tool.Parent ~= u29 or (u29.Parent == nil or (u29.Parent ~= workspace.PlayerCharacters or u30.Stamina.Value <= 0))) then
                return true
            end
            if _G.check:inspect(u29) == false then
                u36 = true
                return true
            end
        end
        u26:ChargeSkill(p27, {
            ["Key"] = Enum.KeyCode.R,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 148 ]]
                --[[
                Upvalues:
                    [1] = u29
                --]]
                u29.Humanoid.WalkSpeed = 4
            end,
            ["EndFunction"] = v37
        })
        v33:AdjustSpeed(1)
        u29.Humanoid.AutoRotate = false
        if u36 == false then
            local v38 = u29.HumanoidRootPart.CFrame
            local _, v39 = _G.raycast:cast(u29.HumanoidRootPart.CFrame.Position, u29.PrimaryPart.CFrame.LookVector * 15, { workspace.Islands, workspace.Ships, workspace.Env })
            local v40 = (v38.Position - v39).Magnitude
            if v34 then
                v34:FireServer(u29.HumanoidRootPart.CFrame * CFrame.new(0, 0, -v40), u29.PrimaryPart.CFrame)
                _G.tween(u29.HumanoidRootPart, { 0.2, "Quad", Enum.EasingDirection.Out }, {
                    ["CFrame"] = u29.HumanoidRootPart.CFrame * CFrame.new(0, 0, -v40)
                })
            end
        else
            v33:Stop()
            if v34 then
                v34:FireServer("cancel")
            end
        end
        task.wait(0.4)
        u29.Humanoid.WalkSpeed = 16
        u29.Humanoid.AutoRotate = true
        _G.keysetup:cooldown("Pentachromatic Strings", v32)
        _G.canuse = true
        _G.fw(v32)
        v28.penta = false
    end
end
function u5.StringBullet(u41, p42) --[[ Line: 196 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v43 = u41.Cooldowns
    local u44 = u1.Character
    local u45 = u2["Stats" .. u1.Name]
    if v43.bullet == false and (_G.check:inspect(u44) == true and _G.StamCheck("String Bullet") == true) then
        local v46 = u3.GetM("String Bullet")
        local v47 = v46.cd
        if _G.StamCheck("String Bullet") == false then
            return
        end
        if v46.statreq and _G.MeetReq(v46.statreq) == false then
            return
        end
        v43.bullet = true
        local v48 = u44.Humanoid:LoadAnimation(script.bullet)
        v48:Play()
        v48:AdjustWeight(2)
        v48:AdjustSpeed(1)
        _G.FaceMouse = true
        _G.canuse = false
        local v49 = game.ReplicatedStorage.Events.Skill:InvokeServer("String Bullet")
        _G.PauseAnim(v48, 0.2, 1)
        local u50 = tick()
        u41:ChargeSkill(p42, {
            ["Key"] = Enum.KeyCode.E,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 224 ]] end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 228 ]]
                --[[
                Upvalues:
                    [1] = u50
                    [2] = u41
                    [3] = u44
                    [4] = u45
                --]]
                if tick() - u50 >= 10 or (u41.Tool.Parent ~= u44 or (u44.Parent == nil or (u44.Parent ~= workspace.PlayerCharacters or u45.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        v48:AdjustSpeed(1)
        u44.HumanoidRootPart.Anchored = true
        _G.FaceMouse = false
        task.wait(0.2)
        if v49 then
            v49:FireServer(u44.PrimaryPart.CFrame)
        end
        task.wait(0.3)
        u44.HumanoidRootPart.Anchored = false
        u44.Humanoid.AutoRotate = true
        _G.keysetup:cooldown("String Bullet", v47)
        _G.canuse = true
        _G.fw(v47)
        v43.bullet = false
    end
end
function u5.OverheatedWhip(u51, p52) --[[ Line: 258 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v53 = u51.Cooldowns
    local u54 = u1.Character
    local u55 = u2["Stats" .. u1.Name]
    if v53.overheat == false and (_G.check:inspect(u54) == true and _G.StamCheck("Overheated Whip") == true) then
        local v56 = u3.GetM("Overheated Whip")
        local v57 = v56.cd
        if _G.StamCheck("Overheated Whip") == false then
            return
        end
        if v56.statreq and _G.MeetReq(v56.statreq) == false then
            return
        end
        v53.overheat = true
        local v58 = u54.Humanoid:LoadAnimation(script.overheat)
        v58:Play()
        v58:AdjustWeight(2)
        v58:AdjustSpeed(1)
        _G.FaceMouse = true
        _G.canuse = false
        local v59 = game.ReplicatedStorage.Events.Skill:InvokeServer("Overheated Whip")
        _G.PauseAnim(v58, 0.4, 1)
        local u60 = tick()
        u51:ChargeSkill(p52, {
            ["Key"] = Enum.KeyCode.Z,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 285 ]] end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 289 ]]
                --[[
                Upvalues:
                    [1] = u60
                    [2] = u51
                    [3] = u54
                    [4] = u55
                --]]
                if tick() - u60 >= 10 or (u51.Tool.Parent ~= u54 or (u54.Parent == nil or (u54.Parent ~= workspace.PlayerCharacters or u55.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        v58:AdjustSpeed(2)
        u54.HumanoidRootPart.Anchored = true
        _G.FaceMouse = false
        task.wait(0.2)
        if v59 then
            v59:FireServer(u51:GetMouseCFrame())
        end
        task.wait(0.6)
        u54.HumanoidRootPart.Anchored = false
        _G.FaceMouse = false
        u54.Humanoid.AutoRotate = true
        _G.keysetup:cooldown("Overheated Whip", v57)
        _G.canuse = true
        _G.fw(v57)
        v53.overheat = false
    end
end
function u5.ParasiticStrings(u61, p62) --[[ Line: 320 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v63 = u61.Cooldowns
    local u64 = u1.Character
    local u65 = u2["Stats" .. u1.Name]
    if _G.grounded == false and (v63.parasite == false and (_G.check:inspect(u64) == true and _G.StamCheck("Parasitic Strings") == true)) then
        local v66 = u3.GetM("Parasitic Strings")
        local v67 = v66.cd
        if _G.StamCheck("Parasitic Strings") == false then
            return
        end
        if v66.statreq and _G.MeetReq(v66.statreq) == false then
            return
        end
        v63.parasite = true
        local v68 = u64.Humanoid:LoadAnimation(script.parasite)
        v68:Play()
        v68:AdjustWeight(2)
        v68:AdjustSpeed(1)
        _G.FaceMouse = true
        _G.canuse = false
        _G.PauseAnim(v68, 0.3, 1)
        local u69 = tick()
        u61:ChargeSkill(p62, {
            ["Key"] = Enum.KeyCode.X,
            ["CheckFunction"] = function() --[[ Name: checkFunction, Line 347 ]] end,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 351 ]]
                --[[
                Upvalues:
                    [1] = u69
                    [2] = u61
                    [3] = u64
                    [4] = u65
                --]]
                if tick() - u69 >= 10 or (u61.Tool.Parent ~= u64 or (u64.Parent == nil or (u64.Parent ~= workspace.PlayerCharacters or u65.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        v68:AdjustSpeed(2)
        u64.HumanoidRootPart.Anchored = true
        _G.FaceMouse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Parasitic Strings", u61:GetMouseCFrame())
        task.wait(0.6)
        u64.HumanoidRootPart.Anchored = false
        u64.Humanoid.AutoRotate = true
        _G.keysetup:cooldown("Parasitic Strings", v67)
        _G.canuse = true
        _G.fw(v67)
        v63.parasite = false
    end
end
local u70 = RaycastParams.new()
u70.FilterType = Enum.RaycastFilterType.Include
u70.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
function u5.SkyStrings(u71, p72) --[[ Line: 395 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
        [4] = u70
        [5] = u1
    --]]
    local v73 = u71.Cooldowns
    local u74 = u1.Character
    local u75 = u2["Stats" .. u1.Name]
    if v73.stringTravel == false and (_G.check:inspect(u74) == true and (_G.grounded == false and _G.canuse == true)) then
        local v76 = u3.GetM("Sky Strings")
        local v77 = v76.cd
        if u74:findFirstChild("inCombat") then
            if _G.StamCheck("Sky Strings", nil, u75.Stamina.MaxValue * 0.05) == false then
                return
            end
        elseif _G.StamCheck("Sky Strings", nil, 15) == false then
            return
        end
        if v76.statreq and _G.MeetReq(v76.statreq) == false then
            return
        end
        if _G.isCustomHUB == true then
            return
        end
        v73.stringTravel = true
        if u71.inSwingStartup then
            return
        end
        if u71.alreadySwinging then
            return
        end
        u71.cleanupWebSwing()
        u71.alreadySwinging = true
        u71.inSwingStartup = true
        local v78 = u74.Humanoid.Health / u74.Humanoid.MaxHealth
        local _, v86 = (function(p79, p80) --[[ Name: getMouseHit, Line 431 ]]
            --[[
            Upvalues:
                [1] = u71
            --]]
            local v81 = u71:GetMouseCFrame().Position
            local v82 = game.Workspace.CurrentCamera:WorldToViewportPoint(v81)
            local v83 = Vector2.new(v82.X, v82.Y)
            local v84 = workspace.CurrentCamera:ViewportPointToRay(v83.X, v83.Y)
            local v85 = Ray.new(v84.Origin, v84.Direction * (p80 or 500))
            return _G.raycastIgnoreList(v85, p79)
        end)({ workspace.Effects, u74 }, 200)
        local v87 = (u74.HumanoidRootPart.Position - v86).Magnitude
        local v88 = v87 / 300
        if u74.HumanoidRootPart.CFrame:ToObjectSpace(CFrame.new(v86)).X > 0 then
            u71.swingSide = "Right"
        else
            u71.swingSide = "Left"
        end
        u74.Humanoid.AutoRotate = false
        local v89 = Instance.new("BodyGyro")
        v89.Name = "SwingGyro"
        v89.MaxTorque = Vector3.new(10000000000000000, 10000000000000000, 10000000000000000)
        v89.P = 100000
        v89.D = 1000
        v89.Parent = u74.HumanoidRootPart
        u71.endPoint = Instance.new("Attachment")
        u71.endPoint.Parent = workspace.Terrain
        u71.endPoint.WorldPosition = v86
        if workspace:Raycast(u74.HumanoidRootPart.Position, Vector3.new(0, -10, 0), u70) then
            u71.anims[u71.swingSide .. " Ground Activate"]:Play()
        else
            u71.anims[u71.swingSide .. " Swing Activate"]:Play()
        end
        _G.canuse = false
        local v90 = game.ReplicatedStorage.Events.Skill:InvokeServer("Sky Strings", { v87, v86, u71.swingSide })
        if v90 then
            _G.PlayEffect("Webswing", nil, u74, v88, v86, u71.swingSide)
            task.wait(v88)
            u74.Humanoid:ChangeState(Enum.HumanoidStateType.FallingDown)
            u71.anims[u71.swingSide .. " Swing Loop"]:Play()
            u71.inSwingStartup = false
            u71.rope = script.Rope:Clone()
            u71.rope.Length = u1:DistanceFromCharacter(u71.endPoint.WorldPosition)
            u71.rope.Parent = workspace.Effects
            u71.rope.Attachment0 = u71.attach1
            u71.rope.Attachment1 = u71.endPoint
            u71.bodyForce = Instance.new("BodyForce")
            u71.bodyForce.Name = "geppo"
            u71.bodyForce.Parent = u74.HumanoidRootPart
            u71.bodyForce.Force = (CFrame.new(u74.HumanoidRootPart.Position, u71.endPoint.Position).LookVector + u74.Humanoid.MoveDirection * 0.25) * 10000 + Vector3.new(0, 400, 0)
            u71.bodyForce.Force = u71.bodyForce.Force * 0
            _G.tween(u71.bodyForce, { 0.2 * v78, "Quad", Enum.EasingDirection.Out }, {
                ["Force"] = Vector3.new(0, 0, 0)
            })
            u71.oldPos = u74.HumanoidRootPart.Position
        end
        local u91 = tick()
        u71:ChargeSkill(p72, {
            ["Key"] = Enum.KeyCode.T,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 506 ]]
                --[[
                Upvalues:
                    [1] = u74
                    [2] = u91
                    [3] = u71
                    [4] = u75
                --]]
                _G.canuse = false
                u74.Humanoid.PlatformStand = true
                u74.Humanoid.AutoRotate = false
                if tick() - u91 >= 5 or (u71.Tool.Parent ~= u74 or (_G.check:inspect(u74) == false or (u74.Parent == nil or (u74.Parent ~= workspace.PlayerCharacters or u75.Stamina.Value <= 0)))) then
                    return true
                end
            end
        })
        if tick() - u91 < 0.2 then
            repeat
                task.wait()
            until tick() - u91 >= 0.2
        end
        u71.cleanupWebSwing()
        u71.alreadySwinging = false
        if v90 then
            v90:FireServer()
        end
        if u71.bodyForce and u71.vel ~= nil then
            local v92 = u71.vel.X
            local v93 = math.clamp(v92, -100, 100)
            local v94 = u71.vel.Y
            local v95 = math.clamp(v94, -100, 100)
            local v96 = u71.vel.Z
            local v97 = math.clamp(v96, -100, 100)
            u71.vel = Vector3.new(v93, v95, v97) * v78
            u71.bodyForce.Force = u71.vel * 300 + Vector3.new(0, 400, 0)
            local v98 = 0.1 * v78
            _G.tween(u71.bodyForce, { v98, "Quad", Enum.EasingDirection.Out }, {
                ["Force"] = Vector3.new(0, 0, 0)
            })
            _G.destroy(u71.bodyForce, v98)
        end
        if u71.swingSide then
            u71.anims[u71.swingSide .. " Swing Loop"]:Stop()
            if u74.PrimaryPart.Velocity.Magnitude >= 150 then
                u71.anims[u71.swingSide .. " Flip"]:Play()
                _G.PlaySound(u74.PrimaryPart, script["SwingWhoosh" .. math.random(1, 2)]).Parent = u74.PrimaryPart
            elseif workspace:Raycast(u74.HumanoidRootPart.Position, Vector3.new(0, -10, 0), u70) == nil then
                u71.anims[u71.swingSide .. " Swing End"]:Play()
            end
            u71.swingSide = nil
        end
        u74.Humanoid.AutoRotate = true
        u74.Humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
        u74.Humanoid.PlatformStand = false
        if u74:FindFirstChild("inCombat") then
            u71.inCombatSwings = u71.inCombatSwings + 1
            if u71.inCombatSwings >= 2 then
                u71.inCombatSwings = 0
                v77 = 15
            end
        else
            u71.inCombatSwings = 0
        end
        _G.keysetup:cooldown("Sky Strings", v77)
        _G.canuse = true
        _G.fw(v77)
        v73.stringTravel = false
    end
end
return u5
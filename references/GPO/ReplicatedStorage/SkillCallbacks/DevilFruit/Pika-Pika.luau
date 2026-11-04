 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = require(game.ReplicatedStorage.Modules.Skills)
local u4 = require(script.Parent.Parent.MobileBase)
require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
function setTwoEndPoints(p5, p6, p7)
    local _ = (p6 - p7).Magnitude
    p5.CFrame = CFrame.new(p6:Lerp(p7, 0.5), p7)
    return p5
end
local u8 = setmetatable({}, u4)
u8.__index = u8
function u8.new(_) --[[ Line: 39 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u8
    --]]
    local v9 = u4.new(script.Name)
    local v10 = u8
    local v11 = setmetatable(v9, v10)
    v11.Cooldowns = {
        ["Pillar"] = false,
        ["Mirror"] = false,
        ["Kick"] = false,
        ["Sword"] = false,
        ["rapid"] = false,
        ["fly"] = false
    }
    return v11
end
function u8.LightLunge(p12, p13) --[[ Line: 54 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v14 = p12.Cooldowns
    local u15 = u1.Character
    local u16 = u2["Stats" .. u1.Name]
    if _G.canuse == true and (v14.Sword == false and (_G.check:inspect(u15) == true and _G.StamCheck("Light Lunge") == true)) then
        local v17 = u3.GetM("Light Lunge")
        local v18 = v17.cd
        if _G.StamCheck("Light Lunge") == false then
            return
        end
        if v17.statreq and _G.MeetReq(v17.statreq) == false then
            return
        end
        v14.Sword = true
        _G.canuse = false
        local v19 = u15.Humanoid:LoadAnimation(script.summonSword)
        v19:Play()
        _G.FaceMouse = true
        local v20 = game.ReplicatedStorage.Events.Skill:InvokeServer("Light Lunge")
        local u21 = tick()
        _G.PauseAnim(v19, 1.5, 1.5)
        p12:ChargeSkill(p13, {
            ["Key"] = Enum.KeyCode.E,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 78 ]]
                --[[
                Upvalues:
                    [1] = u21
                    [2] = u15
                    [3] = u16
                --]]
                if tick() - u21 >= 10 or (not u15:FindFirstChild("Pika-Pika") or (u15.Parent == nil or (u15.Parent ~= workspace.PlayerCharacters or u16.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        v19:Stop()
        local v22 = u15.Humanoid:LoadAnimation(script.sword)
        v22:Play()
        v22:AdjustSpeed(1)
        v22:AdjustWeight(3)
        u15.HumanoidRootPart.Anchored = true
        task.wait(0.1)
        _G.FaceMouse = false
        Ray.new(u15.HumanoidRootPart.CFrame.Position, (p12:GetMouseCFrame().Position - u15.HumanoidRootPart.CFrame.Position).unit * 100)
        local _, v23 = _G.raycast:cast(u15.HumanoidRootPart.CFrame.Position, (p12:GetMouseCFrame().Position - u15.HumanoidRootPart.CFrame.Position).unit * 100, { workspace.Islands, workspace.Ships, workspace.Env })
        local v24 = u15.HumanoidRootPart.CFrame
        if v20 then
            u15.HumanoidRootPart.CFrame = CFrame.new(v23, v24.Position) * CFrame.Angles(0, 3.141592653589793, 0) * CFrame.new(0, u15.Humanoid.HipHeight * 1.25, 2)
            v20:FireServer(u15.HumanoidRootPart.CFrame)
        end
        task.wait(0.5)
        v22:Stop()
        u15.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Light Lunge", v18)
        _G.fw(v18)
        v14.Sword = false
    end
end
function u8.LightKick(u25, p26) --[[ Line: 120 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v27 = u25.Cooldowns
    local u28 = u1.Character
    local u29 = u2["Stats" .. u1.Name]
    if _G.canuse == true and (v27.Kick == false and (_G.check:inspect(u28) == true and _G.StamCheck("Light Kick") == true)) then
        local v30 = u3.GetM("Light Kick")
        local v31 = v30.cd
        if _G.StamCheck("Light Kick") == false then
            return
        end
        if v30.statreq and _G.MeetReq(v30.statreq) == false then
            return
        end
        v27.Kick = true
        _G.canuse = false
        _G.FaceMouse = true
        local v32 = u28.Humanoid:LoadAnimation(script.kick)
        v32:Play()
        v32:AdjustWeight(2)
        _G.PauseAnim(v32, 0.35, 1.5)
        local u33 = tick()
        local u34 = game.ReplicatedStorage.Events.Skill:InvokeServer("Light Kick")
        u25:ChargeSkill(p26, {
            ["Key"] = Enum.KeyCode.R,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 144 ]]
                --[[
                Upvalues:
                    [1] = u33
                    [2] = u28
                    [3] = u29
                --]]
                if tick() - u33 >= 10 or (not u28:FindFirstChild("Pika-Pika") or (u28.Parent == nil or (u28.Parent ~= workspace.PlayerCharacters or u29.Stamina.Value <= 0))) then
                    return true
                end
            end
        })
        v32:AdjustSpeed(1)
        u28.HumanoidRootPart.Anchored = true
        _G.FaceMouse = false
        task.delay(0.2, function() --[[ Line: 159 ]]
            --[[
            Upvalues:
                [1] = u34
                [2] = u25
                [3] = u28
            --]]
            if u34 then
                u34:FireServer(u25:GetMouseCFrame().Position, u28.LeftFoot.CFrame)
            end
        end)
        task.wait(0.75)
        u28.HumanoidRootPart.Anchored = false
        _G.canuse = true
        _G.keysetup:cooldown("Light Kick", v31)
        _G.fw(v31)
        v27.Kick = false
    end
end
function u8.LightRay(u35, p36) --[[ Line: 174 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v37 = u35.Cooldowns
    local u38 = u1.Character
    local u39 = u2["Stats" .. u1.Name]
    if _G.canuse == true and (v37.Pillar == false and (_G.check:inspect(u38) == true and _G.StamCheck("Light Ray") == true)) then
        local v40 = u3.GetM("Light Ray")
        local v41 = v40.cd
        if _G.StamCheck("Light Ray") == false then
            return
        end
        if v40.statreq and _G.MeetReq(v40.statreq) == false then
            return
        end
        v37.Pillar = true
        _G.canuse = false
        local v42 = u38.Humanoid:LoadAnimation(script.pillar)
        v42:Play()
        v42:AdjustWeight(2)
        _G.PauseAnim(v42, 0.55, 1)
        local u43 = nil
        local u44 = nil
        pcall(function() --[[ Line: 196 ]]
            --[[
            Upvalues:
                [1] = u43
                [2] = u44
                [3] = u35
            --]]
            local v45 = game.ReplicatedStorage.Events.Skill
            local v46 = {
                ["pos"] = u35:GetMousePosition()
            }
            local v47, v48 = unpack(v45:InvokeServer("Light Ray", v46))
            u43 = v47
            u44 = v48
        end)
        local u49 = tick()
        local function v51() --[[ Line: 201 ]]
            --[[
            Upvalues:
                [1] = u44
                [2] = u35
                [3] = u43
                [4] = u38
            --]]
            if u44 == nil then
                return false
            end
            local v50 = u35:GetMouseCFrame().Position
            if not u43 then
                return true
            end
            u43:FireServer(v50)
            u38.Humanoid.WalkSpeed = 4
        end
        local function v52() --[[ Line: 214 ]]
            --[[
            Upvalues:
                [1] = u38
                [2] = u49
                [3] = u39
                [4] = u44
            --]]
            if u38:FindFirstChild("Stun") or (u38.Humanoid.FloorMaterial == Enum.Material.Air or (tick() - u49 >= 10 or (not u38:FindFirstChild("Pika-Pika") or (u38.Parent == nil or (u38.Parent ~= workspace.PlayerCharacters or (u39.Stamina.Value <= 0 or u44 and u44.Parent == nil)))))) then
                return true
            end
        end
        u35:ChargeSkill(p36, {
            ["Key"] = Enum.KeyCode.Z,
            ["CheckFunction"] = v51,
            ["EndFunction"] = v52,
            ["IgnoreInstantCastSetting"] = true
        })
        if u43 then
            u43:FireServer("done")
        end
        v42:Stop(0.25)
        u38.Humanoid.WalkSpeed = 16
        task.wait(0.25)
        _G.canuse = true
        _G.keysetup:cooldown("Light Ray", v41)
        _G.fw(v41)
        v37.Pillar = false
    end
end
function u8.LightFlight(p53, p54) --[[ Line: 242 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v55 = p53.Cooldowns
    local u56 = u1.Character
    local _ = u56.HumanoidRootPart
    local u57 = u2["Stats" .. u1.Name]
    if _G.grounded == false and (_G.canuse == true and (v55.fly == false and (_G.check:inspect(u56) == true and _G.StamCheck("Light Flight") == true))) then
        local v58 = u3.GetM("Light Flight")
        local v59 = v58.cd
        if _G.StamCheck("Light Flight") == false then
            return
        end
        if v58.statreq and _G.MeetReq(v58.statreq) == false then
            return
        end
        v55.fly = true
        _G.canuse = false
        local v60 = Instance.new("BodyVelocity", u56.HumanoidRootPart)
        v60.Name = "geppo"
        v60.MaxForce = Vector3.new(inf, inf, inf)
        v60.Velocity = Vector3.new()
        v60.P = 4324234234
        local u61 = tick()
        local u62 = u56:GetDescendants()
        _G.transparentCharacter(u56, nil, nil, true)
        local u63 = {}
        for u64 = 1, #u62 do
            if u62[u64]:IsA("BasePart") then
                pcall(function() --[[ Line: 278 ]]
                    --[[
                    Upvalues:
                        [1] = u62
                        [2] = u64
                        [3] = u63
                    --]]
                    u62[u64].CollisionGroup = "noclip"
                    local v65 = u63
                    local v66 = u62[u64]
                    table.insert(v65, v66)
                end)
            end
        end
        local v67 = CFrame.new(u56.HumanoidRootPart.Position, p53:GetMouseCFrame().Position)
        u56.HumanoidRootPart.CFrame = v67
        u56.Humanoid.PlatformStand = true
        local u68 = u56.HumanoidRootPart.CFrame
        local u69 = game.ReplicatedStorage.Events.Skill:InvokeServer("Light Flight")
        u56.HumanoidRootPart.CFrame = v67
        local u70 = u56.HumanoidRootPart.CFrame
        local u71 = u68.Position
        local u72 = u68.LookVector
        tick()
        p53:ToggleSkill(p54, {
            ["Key"] = Enum.KeyCode.T,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 301 ]]
                --[[
                Upvalues:
                    [1] = u56
                    [2] = u70
                    [3] = u68
                    [4] = u71
                    [5] = u72
                    [6] = u69
                    [7] = u61
                    [8] = u57
                --]]
                local v73 = 5 * (60 / _G.FPS) * (u56.Humanoid.Health / u56.Humanoid.MaxHealth)
                local v74 = Ray.new(u70.Position, (u70.Position - (u68 * CFrame.new(0, 0, -v73)).Position).unit * -v73)
                local v75, v76, v77 = _G.raycastWhitelist(v74, { workspace.Islands, workspace.Ships, workspace.Env })
                u68 = CFrame.new(u71:Lerp(v76, 0.5), v76)
                if u68 ~= u68 then
                    return true
                end
                u56.HumanoidRootPart.CFrame = u68
                u71 = v76
                if v75 or v76.Y <= workspace.Env.WaterStuff.Falls.Position.Y and (v76.Y > workspace.Env.WaterStuff.Sand.Position.Y and u56:FindFirstChild("coatBubble") == nil) then
                    if v76.Y <= workspace.Env.WaterStuff.Falls.Position.Y and (v76.Y > workspace.Env.WaterStuff.Sand.Position.Y and u56:FindFirstChild("coatBubble") == nil) then
                        local v78 = v76.X
                        local v79 = workspace.Env.WaterStuff.Falls.Position.Y + 0.25
                        local v80 = v76.Z
                        v76 = Vector3.new(v78, v79, v80)
                        v77 = Vector3.new(0, 1, 0)
                    end
                    if u56.HumanoidRootPart.Position.Y > workspace.Env.WaterStuff.Falls.Position.Y - 1 or (v76.Y < workspace.Env.WaterStuff.Sand.Position.Y or u56:FindFirstChild("coatBubble")) then
                        u72 = u72 - 2 * u72:Dot(v77) * v77
                        if u69 then
                            u69:FireServer("reflect", CFrame.new(v76, v76 + v77))
                        end
                    end
                    u68 = CFrame.new(v76, v76 + u72)
                    if u68 ~= u68 then
                        return true
                    end
                    u56.HumanoidRootPart.CFrame = u68
                end
                if u56.Humanoid.SeatPart ~= nil then
                    u56.Humanoid.SeatPart:Sit(nil)
                end
                u56.HumanoidRootPart.Velocity = Vector3.new()
                u56.HumanoidRootPart.RotVelocity = Vector3.new()
                u70 = u68
                return u56:FindFirstChild("inCombat") and tick() - u61 >= 7 and true or (u56:GetAttribute("ACFlag") == true and true or (u69 == nil or not u56:FindFirstChild("Pika-Pika") or ((u56.Parent == nil or (u56.Parent ~= workspace.PlayerCharacters or u57.Stamina.Value <= 0)) and true or _G.check:inspect(u56) == false)))
            end
        })
        u56.Humanoid.PlatformStand = false
        u56.Humanoid.AutoRotate = true
        _G.transparentCharacter(u56, true, nil, true)
        for u81 = 1, #u63 do
            pcall(function() --[[ Line: 360 ]]
                --[[
                Upvalues:
                    [1] = u63
                    [2] = u81
                --]]
                u63[u81].CollisionGroup = "Players"
            end)
        end
        u56.HumanoidRootPart.Velocity = Vector3.new()
        u56.Humanoid.PlatformStand = false
        if u69 then
            u69:FireServer()
        end
        v60:Destroy()
        _G.canuse = true
        _G.keysetup:cooldown("Light Flight", v59)
        _G.fw(v59)
        v55.fly = false
    end
end
function u8.MirrorKick(p82, _) --[[ Line: 380 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v83 = p82.Cooldowns
    local v84 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if _G.canuse == true and (v83.Mirror == false and (_G.check:inspect(v84) == true and _G.StamCheck("Mirror Kick") == true)) then
        local v85 = u3.GetM("Mirror Kick")
        local v86 = v85.cd
        if _G.StamCheck("Mirror Kick") == false then
            return
        end
        if v85.statreq and _G.MeetReq(v85.statreq) == false then
            return
        end
        v83.Mirror = true
        _G.canuse = false
        game.ReplicatedStorage.Events.Skill:InvokeServer("Mirror Kick", {
            ["pos"] = p82:GetMousePosition(),
            ["cf"] = v84.HumanoidRootPart.CFrame
        })
        task.wait(0.25)
        _G.canuse = true
        _G.keysetup:cooldown("Mirror Kick", v86)
        _G.fw(v86)
        v83.Mirror = false
    end
end
function u8.JewelsofLight(p87, p88) --[[ Line: 407 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v89 = p87.Cooldowns
    local u90 = u1.Character
    local u91 = u2["Stats" .. u1.Name]
    if _G.canuse == true and (v89.rapid == false and (_G.check:inspect(u90) == true and _G.StamCheck("Jewels of Light") == true)) then
        local v92 = u3.GetM("Jewels of Light")
        local v93 = v92.cd
        if _G.StamCheck("Jewels of Light") == false then
            return
        end
        if v92.statreq and _G.MeetReq(v92.statreq) == false then
            return
        end
        v89.rapid = true
        _G.canuse = false
        local v94 = u90.Humanoid:LoadAnimation(script.rapid)
        v94:Play()
        local v95 = u90.HumanoidRootPart:FindFirstChild("ComboBP")
        if v95 then
            v95:Destroy()
        end
        local v96 = Instance.new("BodyVelocity", u90.HumanoidRootPart)
        v96.Name = "geppo"
        v96.MaxForce = Vector3.new(1000000000, 10000000000000000, 1000000000)
        v96.Velocity = u90.HumanoidRootPart.CFrame.upVector * 125
        v96.P = 4324234234
        _G.destroy(v96, 0.25)
        local v97 = game.ReplicatedStorage.Events.Skill:InvokeServer("Jewels of Light")
        _G.PauseAnim(v94, 0.525, 1)
        _G.FaceMouse = true
        local u98 = tick()
        p87:ChargeSkill(p88, {
            ["Key"] = Enum.KeyCode.C,
            ["EndFunction"] = function() --[[ Name: endFunction, Line 445 ]]
                --[[
                Upvalues:
                    [1] = u90
                    [2] = u91
                    [3] = u98
                --]]
                if not u90:FindFirstChild("Pika-Pika") or (u90.Parent == nil or (u90.Parent ~= workspace.PlayerCharacters or (u91.Stamina.Value <= 0 or tick() - u98 >= 5))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        _G.FaceMouse = false
        if v97 then
            v97:FireServer()
        end
        v94:Stop()
        _G.canuse = true
        _G.keysetup:cooldown("Jewels of Light", v93)
        _G.fw(v93)
        v89.rapid = false
    end
end
return u8
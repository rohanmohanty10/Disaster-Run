 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = require(game.ReplicatedStorage.Modules.Skills)
local u4 = require(script.Parent.Parent.MobileBase)
local u5 = require(u1.PlayerScripts:WaitForChild("PlayerModule"))
u1:GetMouse()
local u6 = {}
local function u16(p7, p8) --[[ Line: 16 ]]
    --[[
    Upvalues:
        [1] = u6
    --]]
    if p7 == true then
        local v9 = p8:GetDescendants()
        local v10 = _G.getAccessorys(p8)
        for v11 = 1, #v10 do
            local v12 = v10[v11]
            table.insert(v9, v12)
        end
        for v13 = 1, #v9 do
            if (v9[v13]:IsA("BasePart") or v9[v13]:IsA("Decal")) and v9[v13].Transparency ~= 1 then
                u6[v9[v13]] = v9[v13].Transparency
                v9[v13].Transparency = 1
            end
        end
    else
        for v14, v15 in u6 do
            if v14 then
                v14.Transparency = v15
            end
        end
        u6 = {}
    end
end
local u17 = setmetatable({}, u4)
u17.__index = u17
function u17.new(_) --[[ Line: 42 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u17
    --]]
    local v18 = u4.new(script.Name)
    local v19 = u17
    local v20 = setmetatable(v18, v19)
    v20.Cooldowns = {
        ["Fist"] = false,
        ["Rain"] = false,
        ["Swam"] = false,
        ["Hound"] = false,
        ["Smash"] = false,
        ["Swamp"] = false
    }
    return v20
end
function u17.MagmaFist(p21, p22) --[[ Line: 57 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
        [3] = u3
    --]]
    local v23 = p21.Cooldowns
    local u24 = u2["Stats" .. u1.Name]
    local u25 = u1.Character
    if v23.Fist == false and (_G.check:inspect(u25) == true and _G.StamCheck("Magma Fist") == true) then
        local v26 = u3.GetM("Magma Fist")
        local v27 = v26.cd
        if _G.StamCheck("Magma Fist") == false then
            return
        end
        if v26.statreq and _G.MeetReq(v26.statreq) == false then
            return
        end
        v23.Fist = true
        _G.canuse = false
        local u28 = tick()
        local v29 = u25.Humanoid:LoadAnimation(script.fist)
        v29:Play()
        _G.moveFace = true
        _G.FaceMouse = true
        _G.PauseAnim(v29, 0.35, 1)
        local u30 = game.ReplicatedStorage.Events.Skill:InvokeServer("Magma Fist")
        p21:ChargeSkill(p22, {
            ["Key"] = Enum.KeyCode.Z,
            ["IgnoreInstantCastSetting"] = true,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 85 ]]
                --[[
                Upvalues:
                    [1] = u28
                    [2] = u25
                    [3] = u24
                --]]
                return (tick() - u28 >= 10 or (u25:FindFirstChild("Magu-Magu") == false or (u25.Parent == nil or u25.Parent ~= workspace.PlayerCharacters))) and true or u24.Stamina.Value <= 0
            end
        })
        _G.FaceMouse = false
        v29:AdjustSpeed(1)
        u25.HumanoidRootPart.Anchored = true
        task.wait(0.3)
        if u30 then
            task.spawn(function() --[[ Line: 95 ]]
                --[[
                Upvalues:
                    [1] = u30
                    [2] = u25
                --]]
                u30:InvokeServer(u25.HumanoidRootPart.CFrame)
            end)
        end
        task.wait(0.2)
        u25.HumanoidRootPart.Anchored = false
        task.wait(0.25)
        _G.moveFace = false
        _G.canuse = true
        _G.keysetup:cooldown("Magma Fist", v27)
        _G.fw(v27)
        v23.Fist = false
    end
end
function u17.MagmaRain(u31, p32) --[[ Line: 111 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
        [3] = u3
    --]]
    local v33 = u31.Cooldowns
    local u34 = u2["Stats" .. u1.Name]
    local u35 = u1.Character
    if v33.Rain == false and (_G.check:inspect(u35) == true and _G.StamCheck("Magma Rain") == true) then
        local v36 = u3.GetM("Magma Rain")
        local v37 = v36.cd
        if _G.StamCheck("Magma Rain") == false then
            return
        end
        if v36.statreq and _G.MeetReq(v36.statreq) == false then
            return
        end
        v33.Rain = true
        _G.canuse = false
        local u38 = nil
        local u39 = nil
        local u40 = tick()
        pcall(function() --[[ Line: 131 ]]
            --[[
            Upvalues:
                [1] = u38
                [2] = u39
            --]]
            local v41 = game.ReplicatedStorage.Events.Skill
            local v42, v43 = unpack(v41:InvokeServer("Magma Rain"))
            u38 = v42
            u39 = v43
        end)
        local v44 = u35.Humanoid:LoadAnimation(script.raincharge)
        v44:Play()
        _G.FaceMouse = true
        _G.mouseLevel = true
        task.wait(0.7)
        v44:Stop(0.25)
        local v45 = u35.Humanoid:LoadAnimation(script.rainloop)
        v45:Play()
        u31:ChargeSkill(p32, {
            ["Key"] = Enum.KeyCode.C,
            ["CheckFunction"] = function() --[[ Name: CheckFunction, Line 155 ]]
                --[[
                Upvalues:
                    [1] = u39
                    [2] = u31
                --]]
                _G.canuse = false
                if u39 then
                    u39:FireServer(u31:GetMouseCFrame().Position)
                end
            end,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 162 ]]
                --[[
                Upvalues:
                    [1] = u40
                    [2] = u38
                    [3] = u35
                    [4] = u34
                --]]
                return (tick() - u40 >= 10 or (u38 == nil or (u35:FindFirstChild("Magu-Magu") == false or (u35.Parent == nil or u35.Parent ~= workspace.PlayerCharacters)))) and true or u34.Stamina.Value <= 0
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        v45:Stop(0.25)
        u35.HumanoidRootPart.Anchored = false
        _G.FaceMouse = false
        _G.mouseLevel = nil
        _G.canuse = true
        if u38 then
            task.spawn(function() --[[ Line: 176 ]]
                --[[
                Upvalues:
                    [1] = u38
                --]]
                u38:InvokeServer()
            end)
        end
        task.wait(0.25)
        _G.keysetup:cooldown("Magma Rain", v37)
        _G.fw(v37)
        v33.Rain = false
    end
end
function u17.MagmaHound(p46, p47) --[[ Line: 188 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v48 = p46.Cooldowns
    local u49 = u1.Character
    local u50 = u2["Stats" .. u1.Name]
    if v48.Hound == false and (_G.check:inspect(u49) == true and _G.StamCheck("Magma Hound") == true) then
        local v51 = u3.GetM("Magma Hound")
        local v52 = v51.cd
        if _G.StamCheck("Magma Hound") == false then
            return
        end
        if v51.statreq and _G.MeetReq(v51.statreq) == false then
            return
        end
        v48.Hound = true
        _G.canuse = false
        local v53 = u49.Humanoid:LoadAnimation(script.hound)
        v53:Play()
        _G.moveFace = true
        _G.FaceMouse = true
        _G.PauseAnim(v53, 0.4, 1)
        local u54 = tick()
        local u55 = game.ReplicatedStorage.Events.Skill:InvokeServer("Magma Hound")
        p46:ChargeSkill(p47, {
            ["Key"] = Enum.KeyCode.X,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 223 ]]
                --[[
                Upvalues:
                    [1] = u50
                    [2] = u54
                --]]
                return u50.Stamina.Value <= 0 and true or tick() - u54 >= 10
            end
        })
        u49.HumanoidRootPart.Anchored = true
        v53:AdjustSpeed(1)
        _G.FaceMouse = false
        task.wait(0.25)
        if u55 then
            task.spawn(function() --[[ Line: 234 ]]
                --[[
                Upvalues:
                    [1] = u55
                    [2] = u49
                --]]
                u55:InvokeServer(u49.HumanoidRootPart.CFrame)
            end)
        end
        task.wait(0.5)
        _G.canuse = true
        u49.HumanoidRootPart.Anchored = false
        _G.keysetup:cooldown("Magma Hound", v52)
        _G.fw(v52)
        v48.Hound = false
    end
end
function u17.MagmaEruption(p56, p57) --[[ Line: 247 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v58 = p56.Cooldowns
    local u59 = u1.Character
    local u60 = u2["Stats" .. u1.Name]
    if v58.Smash == false and (_G.check:inspect(u59) == true and _G.StamCheck("Magma Eruption") == true) then
        local v61 = u3.GetM("Magma Eruption")
        local v62 = v61.cd
        if _G.StamCheck("Magma Eruption") == false then
            return
        end
        if v61.statreq and _G.MeetReq(v61.statreq) == false then
            return
        end
        v58.Smash = true
        _G.canuse = false
        local v63 = u59.Humanoid:LoadAnimation(script.Smash)
        v63:Play()
        v63:AdjustWeight(2)
        u59.Humanoid.WalkSpeed = 4
        local v64 = game.ReplicatedStorage.Events.Skill:InvokeServer("Magma Eruption", {
            ["cf"] = u59.LeftFoot.CFrame
        })
        _G.PauseAnim(v63, 0.4, 2)
        p56:ChargeSkill(p57, {
            ["Key"] = Enum.KeyCode.R,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 279 ]]
                --[[
                Upvalues:
                    [1] = u59
                    [2] = u60
                --]]
                _G.canuse = false
                u59.Humanoid.WalkSpeed = 4
                return u60.Stamina.Value <= 0
            end
        })
        u59.Humanoid.WalkSpeed = 0
        v63:AdjustSpeed(2)
        task.wait(0.25)
        if v64 then
            v64:FireServer(u59.LeftFoot.CFrame)
        end
        task.wait(0.25)
        u59.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Magma Eruption", v62)
        _G.fw(v62)
        v58.Smash = false
    end
end
function u17.MagmaSwamp(p65, p66) --[[ Line: 302 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
        [3] = u3
        [4] = u16
        [5] = u5
        [6] = u6
    --]]
    local v67 = p65.Cooldowns
    local u68 = u2["Stats" .. u1.Name]
    local u69 = u1.Character
    if v67.Swamp == false and (_G.check:inspect(u69) == true and _G.StamCheck("Magma Swamp") == true) then
        local v70 = u3.GetM("Magma Swamp")
        local v71 = v70.cd
        if _G.StamCheck("Magma Swamp") == false then
            return
        end
        if v70.statreq and _G.MeetReq(v70.statreq) == false then
            return
        end
        local v72 = CFrame.new(u69.HumanoidRootPart.Position)
        local v73 = Ray.new(v72.Position, v72.UpVector * -u69.Humanoid.HipHeight * 2)
        local v74, _, _ = _G.raycastWhitelist(v73, { workspace.Islands, workspace.Ships, workspace.Env })
        if v74 == nil then
            return
        end
        _G.canuse = false
        local u75 = _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.MagmaPool]
        v67.Swamp = true
        local v76 = u69.Humanoid:LoadAnimation(script.swamp)
        v76:Play()
        u69.HumanoidRootPart.Anchored = true
        _G.canuse = false
        task.wait(0.7)
        local v77 = u69.LowerTorso.Root
        local v78 = v77.C0
        _G.tween(v77, {
            0.1,
            "Linear",
            Enum.EasingDirection.In,
            0,
            false,
            0
        }, {
            ["C0"] = v78 * CFrame.new(0, -u69.Humanoid.HipHeight * 4, 0)
        })
        local u79 = nil
        local u80 = nil
        pcall(function() --[[ Line: 335 ]]
            --[[
            Upvalues:
                [1] = u79
                [2] = u80
            --]]
            local v81 = game.ReplicatedStorage.Events.Skill
            local v82, v83 = unpack(v81:InvokeServer("Magma Swamp"))
            u79 = v82
            u80 = v83
        end)
        task.wait(0.1)
        u16(true, u69)
        local u84 = workspace.CurrentCamera
        local u85 = 0
        u75:start(u69.HumanoidRootPart.CFrame)
        v77.C0 = v78
        task.wait(0.1)
        u69.HumanoidRootPart.Anchored = false
        local u86 = 0
        local u87 = tick()
        p65:ChargeSkill(p66, {
            ["Button"] = p66,
            ["Key"] = Enum.KeyCode.E,
            ["IgnoreInstantCastSetting"] = true,
            ["PCInputType"] = "Default",
            ["MobileInputType"] = "Toggle",
            ["RunServiceType"] = game["Run Service"].RenderStepped,
            ["CheckFunction"] = function(p88) --[[ Name: CheckFunction, Line 363 ]]
                --[[
                Upvalues:
                    [1] = u69
                    [2] = u5
                    [3] = u84
                    [4] = u85
                    [5] = u80
                    [6] = u75
                    [7] = u86
                --]]
                u69.Humanoid.Jump = false
                u69.Humanoid.WalkSpeed = 0
                tick()
                local v89 = CFrame.new(0, 0, 0)
                local v90 = u69.Humanoid.Health / u69.Humanoid.MaxHealth
                local v91
                if v90 < 0.6 then
                    local v92 = 0.5 + (v90 - 0.3) / 0.3 * 0.5
                    v91 = math.clamp(v92, 0.5, 1)
                else
                    v91 = 1
                end
                local v93 = v91 * 400
                local v94 = v89 * CFrame.new(-u5:GetControls():GetMoveVector() * (v93 * p88))
                local v95 = CFrame.new
                local v96 = u69.HumanoidRootPart.Position
                local v97 = u84.CFrame.X
                local v98 = u69.HumanoidRootPart.Position.Y
                local v99 = u84.CFrame.Z
                local v100 = v95(v96, (Vector3.new(v97, v98, v99))) * v94 * CFrame.Angles(0, 3.141592653589793, 0)
                local v101 = CFrame.new(v100.Position, u69.HumanoidRootPart.Position + u69.Humanoid.MoveDirection) * CFrame.Angles(0, 3.141592653589793, 0)
                local v102 = u69.HumanoidRootPart.CFrame
                local v103 = Ray.new(v102.Position, (v102.Position - v101.Position).Magnitude * -(v102.Position - v101.Position).unit)
                local v104, _, _ = _G.raycastWhitelist(v103, { workspace.Islands, workspace.Ships, workspace.Env })
                if (v104 == nil or v104 and v104.CanCollide == false) and u69.Humanoid.MoveDirection ~= Vector3.new(0, 0, 0) then
                    u69.HumanoidRootPart.CFrame = u69.HumanoidRootPart.CFrame:Lerp(v101, 0.1)
                end
                if tick() - u85 >= 0.05 and u80 then
                    u75:start(u69.HumanoidRootPart.CFrame)
                    u80:FireServer(u69.HumanoidRootPart.CFrame)
                    u85 = tick()
                end
                u86 = tick()
                _G.canuse = false
            end,
            ["EndFunction"] = function() --[[ Name: EndFunction, Line 397 ]]
                --[[
                Upvalues:
                    [1] = u69
                    [2] = u68
                    [3] = u80
                    [4] = u79
                    [5] = u87
                --]]
                local v105 = CFrame.new(u69.HumanoidRootPart.Position)
                local v106 = Ray.new(v105.Position, v105.UpVector * -(u69.Humanoid.HipHeight * 2 + 2))
                local v107, _, _ = _G.raycastWhitelist(v106, { workspace.Islands, workspace.Ships, workspace.Env })
                return (v107 == nil or u69:FindFirstChild("PB")) and true or ((u68.Stamina.Value <= 0 or (u80 == nil or (u79 == nil or u69.Parent == workspace.Ragdolls))) and true or tick() - u87 >= 15)
            end
        })
        u69.Humanoid.WalkSpeed = 16
        v76:Stop()
        v77.C0 = v78 * CFrame.new(0, -u69.Humanoid.HipHeight * 2, 0)
        u69.HumanoidRootPart.Anchored = true
        u69.Humanoid:LoadAnimation(script.swampup):Play()
        _G.tween(v77, {
            0.25,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["C0"] = v78
        })
        local u108 = u79
        for v109, v110 in u6 do
            if v109 then
                v109.Transparency = v110
            end
        end
        u6 = {}
        task.wait(0.255)
        if u108 then
            task.spawn(function() --[[ Line: 422 ]]
                --[[
                Upvalues:
                    [1] = u108
                --]]
                u108:InvokeServer()
            end)
        end
        task.wait(0.25)
        task.wait(0.5)
        _G.canuse = true
        u69.HumanoidRootPart.Anchored = false
        _G.keysetup:cooldown("Magma Swamp", v71)
        _G.fw(v71)
        v67.Swamp = false
    end
end
return u17
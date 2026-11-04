 

local u1 = game.Players.LocalPlayer
game:GetService("RunService")
local u2 = game:GetService("ReplicatedStorage")
local u3 = require(game.ReplicatedStorage.Modules.Skills)
local u4 = require(script.Parent.Parent.MobileBase)
local v5 = require(u1.PlayerScripts:WaitForChild("PlayerModule"))
local u6 = u1:GetMouse()
local u7 = v5:GetControls()
Random.new()
local u8 = workspace.CurrentCamera
local u9 = setmetatable({}, u4)
u9.__index = u9
function u9.new(_) --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u9
        [3] = u1
    --]]
    local v10 = u4.new(script.Name)
    local v11 = u9
    local v12 = setmetatable(v10, v11)
    v12.Cooldowns = {
        ["SoulSwap"] = false,
        ["HungerRage"] = false,
        ["SunRay"] = false,
        ["BonBon"] = false,
        ["BonBonBomb"] = false,
        ["PrometheusPunch"] = false,
        ["PrometheusCrash"] = false,
        ["LightningDrop"] = false,
        ["BatteryAssault"] = false,
        ["Raitei"] = false,
        ["ThunderFlash"] = false,
        ["Raigeki"] = false,
        ["Indra"] = false,
        ["ZeusFly"] = false
    }
    print("soul soul")
    v12.Info = workspace.Effects:WaitForChild((("%*\'s Homies"):format(u1)))
    v12:_main()
    return v12
end
function u9.SoulSwap(p13) --[[ Line: 51 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local _ = p13.Cooldowns
    local v14 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if _G.check:inspect(v14) == true and _G.StamCheck("Soul Swap") == true then
        game.ReplicatedStorage.Events.Skill:InvokeServer("Soul Swap")
    end
end
function u9.HungerRage(p15) --[[ Line: 62 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
    --]]
    local _ = p15.Cooldowns
    local v16 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if _G.check:inspect(v16) == true and _G.StamCheck("Hunger Rage") == true then
        game.ReplicatedStorage.Events.Skill:InvokeServer("Hunger Rage")
    end
end
function u9.LifeorTreat(u17, p18) --[[ Line: 73 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v19 = u17.Cooldowns
    local u20 = u1.Character
    local u21 = u2["Stats" .. u1.Name]
    local _ = u20.HumanoidRootPart
    local _ = u20.Humanoid
    if _G.check:inspect(u20) == true and (_G.StamCheck("Life or Treat") == true and not v19.LifeorTreat) then
        local v22 = u3.GetM("Life or Treat").cd
        local _ = u17.Info.Homies.Prometheus.RootPart
        os.clock()
        v19.LifeorTreat = true
        _G.canuse = false
        local u23 = game.ReplicatedStorage.Events.Skill:InvokeServer("Life or Treat")
        u17:ChargeSkill(p18, {
            ["Key"] = Enum.KeyCode.T,
            ["EndFunction"] = function(_) --[[ Name: endFunction, Line 96 ]]
                --[[
                Upvalues:
                    [1] = u23
                    [2] = u17
                    [3] = u20
                    [4] = u21
                --]]
                if not u23 then
                    return true
                end
                if u17.Tool.Parent ~= u20 or (u20.Parent == nil or (u20.Parent ~= workspace.PlayerCharacters or (u21.Stamina.Value <= 0 or _G.check:inspect(u20) == false))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        if u23 then
            u23:FireServer()
        end
        _G.canuse = true
        _G.keysetup:cooldown("Life or Treat", v22)
        _G.fw(v22)
        v19.LifeorTreat = false
    end
end
function u9.ZeusFly(u24, p25) --[[ Line: 123 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
        [4] = u8
        [5] = u7
    --]]
    local v26 = u24.Cooldowns
    local u27 = u1.Character
    local u28 = u2["Stats" .. u1.Name]
    local v29 = u27.HumanoidRootPart
    local u30 = u27.Humanoid
    if _G.check:inspect(u27) == true and (_G.StamCheck("Zeus Fly") == true and not v26.ZeusFly) then
        local v31 = u3.GetM("Zeus Fly").cd
        local _ = u24.Info.Homies.Prometheus.RootPart
        os.clock()
        v26.ZeusFly = true
        _G.canuse = false
        local u32 = game.ReplicatedStorage.Events.Skill:InvokeServer("Zeus Fly")
        local u33 = Instance.new("BodyPosition")
        u33.MaxForce = Vector3.new(2000000000, 2000000000, 2000000000)
        u33.Position = v29.Position
        u33.Parent = v29
        local u34 = Instance.new("BodyGyro")
        u34.MaxTorque = Vector3.new(2000000000, 2000000000, 2000000000)
        u34.CFrame = v29.CFrame
        u34.Parent = v29
        u30.AutoRotate = false
        local u35 = Vector3.new(0, 0, 0)
        local function v39(p36) --[[ Line: 162 ]]
            --[[
            Upvalues:
                [1] = u32
                [2] = u35
                [3] = u30
                [4] = u8
                [5] = u7
                [6] = u33
                [7] = u34
                [8] = u24
                [9] = u27
                [10] = u28
            --]]
            if not u32 then
                return true
            end
            u35 = u35:Lerp(u30.MoveDirection, p36)
            local v37 = u8.CFrame:VectorToWorldSpace(u7:GetMoveVector())
            local v38 = u33
            v38.Position = v38.Position + v37 * p36 * 30
            u34.CFrame = CFrame.new(Vector3.new(0, 0, 0), (Vector3.new(0, 1, 0)):Cross(u8.CFrame.RightVector))
            if u24.Tool.Parent ~= u27 or (u27.Parent == nil or (u27.Parent ~= workspace.PlayerCharacters or (u28.Stamina.Value <= 0 or _G.check:inspect(u27) == false))) then
                return true
            end
        end
        u24:ChargeSkill(p25, {
            ["Key"] = Enum.KeyCode.R,
            ["EndFunction"] = v39,
            ["IgnoreInstantCastSetting"] = true
        })
        if u32 then
            u32:FireServer()
        end
        task.wait()
        u33:Destroy()
        u34:Destroy()
        u30.AutoRotate = true
        _G.canuse = true
        _G.keysetup:cooldown("Zeus Fly", v31)
        _G.fw(v31)
        v26.ZeusFly = false
    end
end
function u9.PrometheusCrash(u40, p41) --[[ Line: 202 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
        [4] = u8
        [5] = u6
    --]]
    local v42 = u40.Cooldowns
    local u43 = u1.Character
    local u44 = u2["Stats" .. u1.Name]
    local _ = u43.RightHand
    if _G.check:inspect(u43) == true and (_G.StamCheck("Prometheus Crash") == true and not v42.PrometheusCrash) then
        local v45 = u3.GetM("Prometheus Crash").cd
        local u46 = u40.Info.Homies.Prometheus.RootPart
        local u47 = u43.HumanoidRootPart
        local u48 = os.clock()
        v42.PrometheusCrash = true
        _G.canuse = false
        local v49 = u43.Humanoid.Animator:LoadAnimation(script.LightningDropPlayer)
        v49:Play()
        task.wait(0.1)
        v49:AdjustSpeed(0)
        local u50 = u46.CFrame
        local u51 = game.ReplicatedStorage.Events.Skill:InvokeServer("Prometheus Crash")
        local function v53(p52) --[[ Line: 236 ]]
            --[[
            Upvalues:
                [1] = u51
                [2] = u50
                [3] = u47
                [4] = u8
                [5] = u48
                [6] = u46
                [7] = u6
                [8] = u40
                [9] = u43
                [10] = u44
            --]]
            if not u51 then
                return true
            end
            u50 = u50:Lerp(u47.CFrame + u8.CFrame.RightVector * 10 + Vector3.new(0, 3, 0) + Vector3.new(0, 3.5, 0) * (os.clock() - u48), p52)
            u46.BodyGyro.CFrame = u46.BodyGyro.CFrame:Lerp(CFrame.new(u46.Position, u6.Hit.Position), p52 * 2)
            u46.BodyPosition.Position = u50.Position
            if u40.Tool.Parent ~= u43 or (u43.Parent == nil or (u43.Parent ~= workspace.PlayerCharacters or (u44.Stamina.Value <= 0 or (os.clock() - u48 >= 5 or _G.check:inspect(u43) == false)))) then
                return true
            end
        end
        u40:ChargeSkill(p41, {
            ["Key"] = Enum.KeyCode.C,
            ["EndFunction"] = v53,
            ["IgnoreInstantCastSetting"] = true
        })
        if u51 then
            u51:FireServer(u40:GetMousePosition())
        end
        v49:AdjustSpeed(1)
        task.wait()
        _G.canuse = true
        _G.keysetup:cooldown("Prometheus Crash", v45)
        _G.fw(v45)
        v42.PrometheusCrash = false
    end
end
function u9.PrometheusPunch(u54, p55) --[[ Line: 272 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v56 = u54.Cooldowns
    local u57 = u1.Character
    local u58 = u2["Stats" .. u1.Name]
    local _ = u57.RightHand
    if _G.check:inspect(u57) == true and (_G.StamCheck("Prometheus Punch") == true and not v56.PrometheusPunch) then
        local v59 = u3.GetM("Prometheus Punch").cd
        local _ = u54.Info.Homies.Prometheus.RootPart
        local u60 = os.clock()
        v56.PrometheusPunch = true
        _G.canuse = false
        _G.FaceMouse = true
        local u61 = game.ReplicatedStorage.Events.Skill:InvokeServer("Prometheus Punch")
        u54:ChargeSkill(p55, {
            ["Key"] = Enum.KeyCode.Z,
            ["EndFunction"] = function(_) --[[ Name: endFunction, Line 295 ]]
                --[[
                Upvalues:
                    [1] = u61
                    [2] = u54
                    [3] = u57
                    [4] = u58
                    [5] = u60
                --]]
                if not u61 then
                    return true
                end
                if u54.Tool.Parent ~= u57 or (u57.Parent == nil or (u57.Parent ~= workspace.PlayerCharacters or (u58.Stamina.Value <= 0 or (os.clock() - u60 >= 5 or _G.check:inspect(u57) == false)))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        if u61 then
            u61:FireServer(u54:GetMousePosition())
        end
        task.wait()
        _G.FaceMouse = false
        _G.canuse = true
        _G.keysetup:cooldown("Prometheus Punch", v59)
        _G.fw(v59)
        v56.PrometheusPunch = false
    end
end
function u9.BonBonTorch(u62, p63) --[[ Line: 325 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v64 = u62.Cooldowns
    local u65 = u1.Character
    local u66 = u2["Stats" .. u1.Name]
    if _G.check:inspect(u65) == true and (_G.StamCheck("Bon Bon Torch") == true and not v64.BonBonTorch) then
        local v67 = u3.GetM("Bon Bon Torch").cd
        local u68 = os.clock()
        v64.BonBonTorch = true
        _G.canuse = false
        local u69 = os.clock()
        local u70 = u62.Info.Homies.Prometheus.RootPart
        local u71 = u65.HumanoidRootPart
        local u72 = Vector3.new(0, 0, 0)
        local u73 = Vector3.new(0, 0, 0)
        local u74 = Vector3.new(0, 0, 0)
        local v75 = (Vector3.new(0, 1, 0)):Cross(u71.CFrame.RightVector)
        local v76 = Instance.new("BodyPosition")
        v76.MaxForce = Vector3.new(2000000000, 2000000000, 2000000000)
        v76.Position = u71.Position
        v76.Parent = u71
        local u77 = Instance.new("BodyGyro")
        u77.P = 50000
        u77.D = 250
        u77.MaxTorque = Vector3.new(2000000000, 2000000000, 2000000000)
        u77.CFrame = CFrame.new(Vector3.new(0, 0, 0), v75)
        u77.Parent = u71
        local v78 = u65.Humanoid
        v78.AutoRotate = false
        v78.PlatformStand = true
        local u79 = true
        task.spawn(function() --[[ Line: 372 ]]
            --[[
            Upvalues:
                [1] = u69
                [2] = u74
                [3] = u71
                [4] = u72
                [5] = u73
                [6] = u70
                [7] = u79
                [8] = u77
                [9] = u62
            --]]
            while true do
                local v80 = task.wait()
                local v81 = os.clock() - u69
                local v82 = v81 / 0.5
                local v83 = math.min(v82, 1)
                u74 = u71.Position:Lerp(u71.Position + u71.CFrame.LookVector * 5, v83)
                local v84 = u74 + u72 + u73
                if v81 <= 0.5 then
                    local v85 = u71.CFrame
                    local v86 = CFrame.new
                    local v87 = 3.141592653589793 * v83
                    local v88 = math.sin(v87)
                    local v89 = 3.141592653589793 * v83
                    local v90 = math.cos(v89)
                    local v91 = Vector3.new(v88, 0, v90)
                    local v92 = v83 * 3.141592653589793
                    u72 = v85 * v86(v91 * math.sin(v92) * 25).Position - u71.Position
                    local v93 = v83 * 3.141592653589793
                    u73 = Vector3.new(0, 15, 0) * math.sin(v93)
                    u70.BodyGyro.CFrame = u70.CFrame:Lerp(CFrame.new(u70.Position, v84), v80 * 3)
                else
                    if not u79 then
                        return
                    end
                    u77.CFrame = u77.CFrame:Lerp(CFrame.new(u71.Position, u62:GetMousePosition()), v80)
                end
                u70.BodyPosition.Position = v84
            end
        end)
        local u94 = game.ReplicatedStorage.Events.Skill:InvokeServer("Bon Bon Torch")
        u62:ChargeSkill(p63, {
            ["Key"] = Enum.KeyCode.X,
            ["EndFunction"] = function(_) --[[ Name: endFunction, Line 397 ]]
                --[[
                Upvalues:
                    [1] = u65
                    [2] = u94
                    [3] = u69
                    [4] = u62
                    [5] = u66
                    [6] = u68
                --]]
                u65.Humanoid.WalkSpeed = 4
                if u94 then
                    if os.clock() - u69 > 0.5 then
                        if u62.Tool.Parent ~= u65 or (u65.Parent == nil or (u65.Parent ~= workspace.PlayerCharacters or (u66.Stamina.Value <= 0 or (os.clock() - u68 >= 15 or _G.check:inspect(u65) == false)))) then
                            return true
                        end
                    end
                else
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        v76:Destroy()
        u77:Destroy()
        if u94 then
            u94:FireServer("Finished")
        end
        task.wait()
        u79 = false
        v78.AutoRotate = true
        v78.PlatformStand = false
        u65.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Bon Bon Torch", v67)
        _G.fw(v67)
        v64.BonBonTorch = false
    end
end
function u9.Raigeki(u95, p96) --[[ Line: 439 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v97 = u95.Cooldowns
    local u98 = u1.Character
    local u99 = u2["Stats" .. u1.Name]
    if _G.check:inspect(u98) == true and (_G.StamCheck("Raigeki") == true and not v97.Raigeki) then
        local v100 = u3.GetM("Raigeki").cd
        local u101 = os.clock()
        v97.Raigeki = true
        _G.canuse = false
        local u102 = os.clock()
        local u103 = u95.Info.Homies.Zeus.RootPart
        local u104 = u98.HumanoidRootPart
        local _ = u103.BodyPosition
        local u105 = game.ReplicatedStorage.Events.Skill:InvokeServer("Raigeki")
        local u119 = task.spawn(function() --[[ Line: 468 ]]
            --[[
            Upvalues:
                [1] = u102
                [2] = u104
                [3] = u95
                [4] = u103
            --]]
            local v106 = Vector3.new(0, 0, 0)
            while true do
                local v107 = task.wait()
                local v108 = (os.clock() - u102) / 2
                local v109 = math.min(v108, 1)
                local v110 = 18.84955592153876 * v109
                local v111 = math.sin(v110)
                local v112 = 18.84955592153876 * v109
                local v113 = math.cos(v112)
                local v114 = Vector3.new(v111, 0, v113)
                local v115 = v109 * 3.141592653589793
                local v116 = v114 * math.sin(v115) * 25
                v106 = v106:Lerp((Vector3.new(0, 1, 0)):Cross(CFrame.new(u104.Position, u95:GetMousePosition()).RightVector) * 40 * v109, v107 * 0.5)
                local v117 = Vector3.new(0, 65, 0) * v109
                local v118 = u104.Position + v116 + v106 + v117
                u103.BodyGyro.CFrame = CFrame.new(u103.Position, v118)
                u103.BodyPosition.Position = v118
            end
        end)
        function u105.OnClientInvoke() --[[ Line: 488 ]]
            --[[
            Upvalues:
                [1] = u119
            --]]
            task.cancel(u119)
        end
        u95:ChargeSkill(p96, {
            ["Key"] = Enum.KeyCode.C,
            ["EndFunction"] = function(_) --[[ Name: endFunction, Line 492 ]]
                --[[
                Upvalues:
                    [1] = u98
                    [2] = u105
                    [3] = u95
                    [4] = u99
                    [5] = u101
                --]]
                u98.Humanoid.WalkSpeed = 4
                if not u105 then
                    return true
                end
                if u95.Tool.Parent ~= u98 or (u98.Parent == nil or (u98.Parent ~= workspace.PlayerCharacters or (u99.Stamina.Value <= 0 or (os.clock() - u101 >= 5 or _G.check:inspect(u98) == false)))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        if u105 then
            u105:InvokeServer("Finished")
        end
        task.wait()
        u98.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Raigeki", v100)
        _G.fw(v100)
        v97.Raigeki = false
    end
end
function u9.LightningDrop(u120, p121) --[[ Line: 524 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v122 = u120.Cooldowns
    local u123 = u1.Character
    local u124 = u2["Stats" .. u1.Name]
    if _G.check:inspect(u123) == true and (_G.StamCheck("Lightning Drop") == true and not v122.LightningDrop) then
        local v125 = u3.GetM("Lightning Drop").cd
        local u126 = os.clock()
        v122.LightningDrop = true
        _G.canuse = false
        local u127 = u120.Info.Homies.Zeus.RootPart
        local u128 = u123.HumanoidRootPart
        local u129 = 0
        local u130 = u127.Position
        local v131 = u123.Humanoid.Animator:LoadAnimation(script.LightningDropPlayer)
        v131:Play()
        local u132 = game.ReplicatedStorage.Events.Skill:InvokeServer("Lightning Drop")
        task.wait(0.1)
        v131:AdjustSpeed(0)
        local function v143(p133) --[[ Line: 561 ]]
            --[[
            Upvalues:
                [1] = u123
                [2] = u132
                [3] = u120
                [4] = u128
                [5] = u130
                [6] = u129
                [7] = u127
                [8] = u124
                [9] = u126
            --]]
            u123.Humanoid.WalkSpeed = 4
            if not u132 then
                return true
            end
            local v134 = u120:GetMouseCFrame()
            local v135 = u128.Position
            local v136 = v134.Position - v135
            local v137
            if v136.Magnitude < 50 then
                v137 = v134.Position
            else
                v137 = v136.Unit * 50 + v135
            end
            local _, v138, _ = _G.getRayFloor(CFrame.new(v137) + Vector3.new(0, 2, 0), 200)
            if v138 then
                local v139 = v138 + Vector3.new(0, 45, 0)
                local v140 = (CFrame.new(u130, v139) * CFrame.new(-25, 0, -(v139 - u130) / 2)).Position
                local v141 = u129 + p133 / 1
                u129 = math.min(1, v141)
                local v142 = u130:Lerp(v140, u129):Lerp(v140:Lerp(v139, u129), u129)
                u127.BodyPosition.Position = u127.BodyPosition.Position:Lerp(v142, p133 * 5)
                u127.BodyGyro.CFrame = CFrame.new(u127.Position * Vector3.new(1, 0, 1), u128.Position * Vector3.new(1, 0, 1))
            end
            if u120.Tool.Parent ~= u123 or (u123.Parent == nil or (u123.Parent ~= workspace.PlayerCharacters or (u124.Stamina.Value <= 0 or (os.clock() - u126 >= 5 or _G.check:inspect(u123) == false)))) then
                return true
            end
        end
        u120:ChargeSkill(p121, {
            ["Key"] = Enum.KeyCode.Z,
            ["EndFunction"] = v143,
            ["IgnoreInstantCastSetting"] = true
        })
        if u132 then
            u132:FireServer("Finished", u120:GetMouseCFrame())
        end
        v131:AdjustSpeed(1)
        task.wait()
        u123.Humanoid.WalkSpeed = 16
        _G.canuse = true
        _G.keysetup:cooldown("Lightning Drop", v125)
        _G.fw(v125)
        v122.LightningDrop = false
    end
end
function u9.Indra(p144) --[[ Line: 622 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v145 = p144.Cooldowns
    local v146 = u1.Character
    local _ = u2["Stats" .. u1.Name]
    if _G.check:inspect(v146) == true and (_G.StamCheck("Indra") == true and not v145.Indra) then
        local v147 = u3.GetM("Indra").cd
        v145.Indra = true
        game.ReplicatedStorage.Events.Skill:InvokeServer("Indra", p144:GetMouseCFrame())
        _G.keysetup:cooldown("Indra", v147)
        _G.fw(v147)
        v145.Indra = false
    end
end
function u9.SunRay(u148, p149) --[[ Line: 642 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v150 = u148.Cooldowns
    local u151 = u1.Character
    local u152 = u2["Stats" .. u1.Name]
    if _G.check:inspect(u151) == true and (_G.StamCheck("Sun Ray") == true and not v150.SunRay) then
        local v153 = u3.GetM("Sun Ray").cd
        _G.canuse = false
        v150.SunRay = true
        local u154 = os.clock()
        local u155 = game.ReplicatedStorage.Events.Skill:InvokeServer("Sun Ray")
        local u156 = u148.Info.Homies.Prometheus.RootPart
        local u157 = CFrame.new()
        local u158 = u156.CFrame
        local u159 = os.clock()
        local function v170(p160) --[[ Line: 670 ]]
            --[[
            Upvalues:
                [1] = u155
                [2] = u148
                [3] = u159
                [4] = u158
                [5] = u157
                [6] = u156
                [7] = u151
                [8] = u152
                [9] = u154
            --]]
            if not u155 then
                return true
            end
            local v161 = u148:GetMouseCFrame().Position
            local v162 = os.clock() - u159
            local _ = u158 * u157
            u156.BodyPosition.Position = (u158 * u157).Position
            u158 = u158:Lerp(CFrame.new(v161), 2 * p160)
            if v162 <= 0.5 then
                local v163 = v162 / 0.5
                local v164 = math.min(1, v163)
                local _ = 1 - v164
                local v165 = u157
                local v166 = CFrame.Angles(0, 6.283185307179586 * v164, 0)
                local v167 = CFrame.new
                local v168 = v164 * 3.141592653589793
                u157 = v165:Lerp(v166 * v167(0, 0, math.sin(v168) * 25) + Vector3.new(0, 55, 0) * v164, v164)
            else
                local _, v169, _ = _G.getRayFloor(CFrame.new(u156.Position), 200)
                if v169 then
                    u155:InvokeServer("Position", v169)
                end
            end
            if u148.Tool.Parent ~= u151 or (u151.Parent == nil or (u151.Parent ~= workspace.PlayerCharacters or (u152.Stamina.Value <= 0 or (os.clock() - u154 >= 5 or _G.check:inspect(u151) == false)))) then
                return true
            end
        end
        u148:ChargeSkill(p149, {
            ["Key"] = Enum.KeyCode.X,
            ["EndFunction"] = v170,
            ["IgnoreInstantCastSetting"] = true
        })
        if u155 then
            task.wait(0.1)
            u155:InvokeServer("Finished")
        end
        _G.canuse = true
        _G.keysetup:cooldown("Sun Ray", v153)
        _G.fw(v153)
        v150.SunRay = false
    end
end
function u9.BonBon(u171, p172) --[[ Line: 723 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v173 = u171.Cooldowns
    local u174 = u1.Character
    local u175 = u2["Stats" .. u1.Name]
    if _G.check:inspect(u174) == true and (_G.StamCheck("Bon Bon") == true and not v173.BonBon) then
        local v176 = u3.GetM("Bon Bon").cd
        local _ = u171.Info.Homies.Zeus.RootPart
        _G.FaceMouse = true
        _G.canuse = false
        v173.BonBon = true
        local u177 = os.clock()
        local v178 = game.ReplicatedStorage.Events.Skill:InvokeServer("Bon Bon")
        u171:ChargeSkill(p172, {
            ["Key"] = Enum.KeyCode.Z,
            ["EndFunction"] = function(_) --[[ Name: endFunction, Line 746 ]]
                --[[
                Upvalues:
                    [1] = u171
                    [2] = u174
                    [3] = u175
                    [4] = u177
                --]]
                if u171.Tool.Parent ~= u174 or (u174.Parent == nil or (u174.Parent ~= workspace.PlayerCharacters or (u175.Stamina.Value <= 0 or (os.clock() - u177 >= 5 or _G.check:inspect(u174) == false)))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        if v178 then
            _G.FaceMouse = false
            task.wait(0.1)
            v178:FireServer(u171:GetMouseCFrame().Position)
        end
        _G.canuse = true
        _G.keysetup:cooldown("Bon Bon", v176)
        _G.fw(v176)
        v173.BonBon = false
    end
end
function u9.ThunderFlash(u179, p180) --[[ Line: 772 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v181 = u179.Cooldowns
    local u182 = u1.Character
    local u183 = u2["Stats" .. u1.Name]
    local u184 = u182.HumanoidRootPart
    if _G.check:inspect(u182) == true and (_G.StamCheck("Thunder Flash") == true and not v181.ThunderFlash) then
        local v185 = u3.GetM("Thunder Flash").cd
        local u186 = u179.Info.Homies.Zeus.RootPart
        _G.canuse = false
        local v187 = Instance.new("BodyPosition")
        v187.MaxForce = Vector3.new(100000, 100000, 100000)
        v187.Position = u184.Position + Vector3.new(0, 7.5, 0)
        v187.Parent = u184
        local u188 = Instance.new("BodyGyro")
        u188.MaxTorque = Vector3.new(2000000000, 2000000000, 2000000000)
        u188.P = 2000
        u188.CFrame = CFrame.new(u184.Position, u179:GetMouseCFrame().Position)
        u188.Parent = u184
        v181.ThunderFlash = true
        local u189 = os.clock()
        local u190 = game.ReplicatedStorage.Events.Skill:InvokeServer("Thunder Flash")
        u179:ChargeSkill(p180, {
            ["Key"] = Enum.KeyCode.X,
            ["EndFunction"] = function(_) --[[ Name: endFunction, Line 806 ]]
                --[[
                Upvalues:
                    [1] = u190
                    [2] = u186
                    [3] = u184
                    [4] = u188
                    [5] = u179
                    [6] = u182
                    [7] = u183
                    [8] = u189
                --]]
                if not u190 then
                    return true
                end
                u186.BodyPosition.Position = u184.Position + u184.CFrame.UpVector * -3
                u186.BodyGyro.CFrame = u184.CFrame
                u188.CFrame = CFrame.new(u184.Position, u179:GetMouseCFrame().Position)
                if u179.Tool.Parent ~= u182 or (u182.Parent == nil or (u182.Parent ~= workspace.PlayerCharacters or (u183.Stamina.Value <= 0 or (os.clock() - u189 >= 5 or _G.check:inspect(u182) == false)))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        u188:Destroy()
        v187:Destroy()
        if u190 then
            u190:InvokeServer(u179:GetMouseCFrame().Position)
        end
        _G.canuse = true
        _G.keysetup:cooldown("Thunder Flash", v185)
        _G.fw(v185)
        v181.ThunderFlash = false
    end
end
function u9.Raitei(u191, p192) --[[ Line: 841 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v193 = u191.Cooldowns
    local u194 = u1.Character
    local u195 = u2["Stats" .. u1.Name]
    if _G.check:inspect(u194) == true and (_G.StamCheck("Raitei") == true and not v193.Raitei) then
        local v196 = u3.GetM("Raitei").cd
        local _ = u191.Info.Homies.Zeus.RootPart
        _G.FaceMouse = true
        _G.canuse = false
        v193.Raitei = true
        local u197 = os.clock()
        local u198 = game.ReplicatedStorage.Events.Skill:InvokeServer("Raitei")
        u191:ChargeSkill(p192, {
            ["Key"] = Enum.KeyCode.Z,
            ["EndFunction"] = function(_) --[[ Name: endFunction, Line 864 ]]
                --[[
                Upvalues:
                    [1] = u198
                    [2] = u191
                    [3] = u194
                    [4] = u195
                    [5] = u197
                --]]
                if not u198 then
                    return true
                end
                if u191.Tool.Parent ~= u194 or (u194.Parent == nil or (u194.Parent ~= workspace.PlayerCharacters or (u195.Stamina.Value <= 0 or (os.clock() - u197 >= 5 or _G.check:inspect(u194) == false)))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        _G.FaceMouse = false
        if u198 then
            u198:FireServer(u191:GetMouseCFrame().Position)
        end
        _G.canuse = true
        _G.keysetup:cooldown("Raitei", v196)
        _G.fw(v196)
        v193.Raitei = false
    end
end
function u9.BonBonBomb(u199, p200) --[[ Line: 894 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v201 = u199.Cooldowns
    local u202 = u1.Character
    local u203 = u2["Stats" .. u1.Name]
    local u204 = u202.RightHand
    if _G.check:inspect(u202) == true and (_G.StamCheck("Bon Bon Bomb") == true and not v201.BonBonBomb) then
        local v205 = u3.GetM("Bon Bon Bomb").cd
        local u206 = u199.Info.Homies.Prometheus.RootPart
        local v207 = u202.Humanoid.Animator:LoadAnimation(script.BonBonBombPlayer)
        v207:Play()
        _G.FaceMouse = true
        _G.canuse = false
        v201.BonBonBomb = true
        local u208 = os.clock()
        local u209 = game.ReplicatedStorage.Events.Skill:InvokeServer("Bon Bon Bomb")
        task.wait(0.1)
        v207:AdjustSpeed(0)
        u199:ChargeSkill(p200, {
            ["Key"] = Enum.KeyCode.C,
            ["EndFunction"] = function(_) --[[ Name: endFunction, Line 925 ]]
                --[[
                Upvalues:
                    [1] = u209
                    [2] = u206
                    [3] = u204
                    [4] = u199
                    [5] = u202
                    [6] = u203
                    [7] = u208
                --]]
                if not u209 then
                    return true
                end
                u206.BodyPosition.Position = u204.Position
                u206.BodyGyro.CFrame = u204.CFrame
                if u199.Tool.Parent ~= u202 or (u202.Parent == nil or (u202.Parent ~= workspace.PlayerCharacters or (u203.Stamina.Value <= 0 or (os.clock() - u208 >= 5 or _G.check:inspect(u202) == false)))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        if u209 then
            _G.FaceMouse = false
            task.wait(0.1)
            u209:FireServer(u199:GetMouseCFrame().Position)
        end
        v207:AdjustSpeed(1)
        _G.canuse = true
        _G.keysetup:cooldown("Bon Bon Bomb", v205)
        _G.fw(v205)
        v201.BonBonBomb = false
    end
end
function u9.BatteryAssault(u210, p211) --[[ Line: 959 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u2
        [3] = u3
    --]]
    local v212 = u210.Cooldowns
    local u213 = u1.Character
    local u214 = u2["Stats" .. u1.Name]
    local _ = u213.RightHand
    if _G.check:inspect(u213) == true and (_G.StamCheck("Battery Assault") == true and not v212.BatteryAssault) then
        local v215 = u3.GetM("Battery Assault").cd
        local _ = u210.Info.Homies.Zeus.RootPart
        _G.FaceMouse = true
        _G.canuse = false
        v212.BatteryAssault = true
        local v216 = u213.Humanoid.Animator:LoadAnimation(script.BatteryAssaultPlayer)
        v216:Play()
        task.wait(0.1)
        v216:AdjustSpeed(0)
        local u217 = os.clock()
        local u218 = game.ReplicatedStorage.Events.Skill:InvokeServer("Battery Assault")
        u210:ChargeSkill(p211, {
            ["Key"] = Enum.KeyCode.C,
            ["EndFunction"] = function(_) --[[ Name: endFunction, Line 990 ]]
                --[[
                Upvalues:
                    [1] = u218
                    [2] = u210
                    [3] = u213
                    [4] = u214
                    [5] = u217
                --]]
                if not u218 then
                    return true
                end
                if u210.Tool.Parent ~= u213 or (u213.Parent == nil or (u213.Parent ~= workspace.PlayerCharacters or (u214.Stamina.Value <= 0 or (os.clock() - u217 >= 5 or _G.check:inspect(u213) == false)))) then
                    return true
                end
            end,
            ["IgnoreInstantCastSetting"] = true
        })
        v216:AdjustSpeed(1)
        if u218 then
            _G.FaceMouse = false
            task.wait(0.1)
            u218:InvokeServer()
        end
        _G.canuse = true
        _G.keysetup:cooldown("Battery Assault", v215)
        _G.fw(v215)
        v212.BatteryAssault = false
    end
end
function u9._main(p219) --[[ Line: 1022 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v220 = p219.Info.Homies
    local v221 = p219.Info.RageMode
    local u222 = (u1.Character or u1.CharacterAdded:Wait()).HumanoidRootPart
    v221.Prometheus.AnimationController.Animator:LoadAnimation(script.PrometheusRageIdle):Play()
    for u223, u224 in {
        [v220.Prometheus] = {
            ["Offset"] = CFrame.new(5, 0, 3)
        },
        [v220.Zeus] = {
            ["Offset"] = CFrame.new(-5, 0, 3)
        }
    } do
        (function(p225) --[[ Name: RootPartAdded, Line 1042 ]]
            --[[
            Upvalues:
                [1] = u223
                [2] = u222
                [3] = u224
            --]]
            if p225.Name == "RootPart" then
                local v226 = Instance.new("BodyPosition")
                v226.MaxForce = Vector3.new(2000000000, 2000000000, 2000000000)
                v226.P = 20000
                v226.D = 500
                v226.Parent = p225
                local v227 = Instance.new("BodyGyro")
                v227.MaxTorque = Vector3.new(2000000000, 2000000000, 2000000000)
                v227.P = 10000
                v227.D = 500
                v227.Parent = v226.Parent
                local u228 = p225.BodyPosition
                local u229 = p225.BodyGyro
                local u230 = os.clock()
                local u231 = math.random() * 0.5
                u228.MaxForce = u223.EnableMover.Value and Vector3.new(2000000000, 2000000000, 2000000000) or Vector3.new(0, 0, 0)
                u229.MaxTorque = u228.MaxForce
                u223.EnableMover.Changed:Connect(function(p232) --[[ Name: MoverChanged, Line 1063 ]]
                    --[[
                    Upvalues:
                        [1] = u228
                        [2] = u229
                    --]]
                    u228.MaxForce = p232 and Vector3.new(2000000000, 2000000000, 2000000000) or Vector3.new(0, 0, 0)
                    u229.MaxTorque = u228.MaxForce
                end)
                task.spawn(function() --[[ Line: 1071 ]]
                    --[[
                    Upvalues:
                        [1] = u223
                        [2] = u228
                        [3] = u230
                        [4] = u222
                        [5] = u224
                        [6] = u231
                        [7] = u229
                    --]]
                    while u223.Parent and u228.Parent do
                        task.wait()
                        if not u223.CustomMovement.Value then
                            local v233 = os.clock() - u230
                            local v234 = u228
                            local v235 = (u222.CFrame * u224.Offset).Position
                            local v236 = v233 + u231
                            v234.Position = v235 + Vector3.new(0, 1, 0) * math.sin(v236)
                            u229.CFrame = u222.CFrame
                        end
                    end
                end)
            end
        end)(u223:WaitForChild("RootPart"))
    end
end
return u9
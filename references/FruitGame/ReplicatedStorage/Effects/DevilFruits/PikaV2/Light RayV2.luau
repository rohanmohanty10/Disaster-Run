 

local v1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("RunService")
local v3 = game:GetService("Players")
local u4 = game:GetService("TweenService")
require(game:GetService("ReplicatedStorage").Modules.CameraShaker)
require(v1.Modules.CraterHandler)
require(v1.Modules.ParticleTween)
local u5 = require(v1.Modules.Client.WeaponVFXRecolor)
local _ = v3.LocalPlayer
local u6 = workspace.Effects
local u7 = {}
function Flipbook(p8, u9, u10, u11)
    local u12 = p8:FindFirstChildOfClass("SpecialMesh")
    if u12 and u9 then
        task.spawn(function() --[[ Line: 23 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u12
                [3] = u10
                [4] = u11
            --]]
            for v13 = 1, #u9 do
                u12.TextureId = u9[v13]
                task.wait(1 / u10)
            end
            if u11 == true then
                u12.Parent:Destroy()
            end
        end)
    end
end
local function u24(p14, p15, p16) --[[ Line: 37 ]]
    local function v22(u17, p18, p19) --[[ Line: 38 ]]
        for _, v20 in ipairs(u17:GetDescendants()) do
            if v20:IsA("ParticleEmitter") or v20:IsA("Trail") then
                v20.Enabled = p18
            end
        end
        if p19 then
            task.delay(p19, function() --[[ Line: 46 ]]
                --[[
                Upvalues:
                    [1] = u17
                --]]
                for _, v21 in ipairs(u17:GetDescendants()) do
                    if v21:IsA("ParticleEmitter") or v21:IsA("Trail") then
                        v21.Enabled = false
                    end
                end
            end)
        end
    end
    if typeof(p14) == "table" then
        for _, v23 in p14 do
            v22(v23, p15, p16)
        end
    else
        v22(p14, p15, p16)
    end
end
local function u31(p25, p26, p27) --[[ Line: 75 ]]
    local v28 = p25.CFrame
    local v29 = Random.new():NextNumber(p26, p27)
    local v30 = Instance.new("Model")
    v30.Parent = p25.Parent
    p25.Parent = v30
    v30:ScaleTo(v29)
    p25.Parent = v30.Parent
    p25.CFrame = v28
    v30:Destroy()
end
local v32 = {}
local u33 = RaycastParams.new()
u33.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
u33.FilterType = Enum.RaycastFilterType.Include
function v32.start(_, p34, p35, _, u36, u37, p38) --[[ Line: 100 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u33
        [3] = u5
        [4] = u6
        [5] = u24
        [6] = u4
        [7] = u2
        [8] = u31
    --]]
    if p34 == "Hold" then
        local v39 = p35:FindFirstChild("HumanoidRootPart")
        local v40 = p35:FindFirstChild("RightHand")
        p35:FindFirstChild("RightFoot")
        u7[p35] = {}
        local _ = v39.Position
        local u41 = u36.Value
        local u42 = CFrame.new(u41.Position)
        local v43 = workspace:Raycast(u41.Position + Vector3.new(0, 2, 0), Vector3.new(0, -50, 0), u33)
        if v43 then
            u42 = CFrame.new(v43.Position, v43.Position + v43.Normal) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -0.2, 0)
        end
        local v44 = script.HoldEffect:Clone()
        u5.apply(v44, p35)
        v44.CFrame = v40.CFrame
        local v45 = Instance.new("WeldConstraint")
        v45.Part0 = v44
        v45.Part1 = v40
        v45.Parent = v44
        v44.Parent = u6
        u24(v44, true)
        local v46 = u7[p35]
        table.insert(v46, v44)
        local v47 = script.SpawnEffect:Clone()
        u5.apply(v47, p35)
        v47.CFrame = v40.CFrame
        local v48 = Instance.new("WeldConstraint")
        v48.Part0 = v47
        v48.Part1 = v40
        v48.Parent = v47
        v47.Parent = u6
        _G.customEmit(v47)
        _G.destroy(v47, 2)
        local u49 = script["Light Ray"]:Clone()
        u5.apply(u49, p35)
        u49:PivotTo(u42)
        u49.Floor.CFrame = u42
        u49.Parent = u6
        u24(u49, true)
        _G.customEmit(u49["Light Beam"].Attachment3)
        local v50 = u7[p35]
        table.insert(v50, u49)
        local u51 = script.Debree:Clone()
        u5.apply(u51, p35)
        u51.CFrame = u49.Floor.CFrame * CFrame.Angles(3.141592653589793, 0, 0)
        u51.Parent = u6
        local v52 = u49.Floor
        local v53 = Instance.new("WeldConstraint")
        v53.Part0 = u51
        v53.Part1 = v52
        v53.Parent = u51
        local v54 = u7[p35]
        table.insert(v54, u51)
        _G.PlaySound(p35.PrimaryPart, script.LightRayStart).Parent = p35.PrimaryPart
        local v55 = script.LightRayLoop:Clone()
        v55.Parent = u49.Floor
        v55:Play()
        for _, v56 in u49:GetDescendants() do
            if v56.ClassName == "Beam" then
                v56.Enabled = true
                local v57 = v56.Width0
                local v58 = v56.Width1
                v56.Width0 = 0
                v56.Width1 = 0
                u4:Create(v56, TweenInfo.new(0.1, Enum.EasingStyle.Quint), {
                    ["Width0"] = v57,
                    ["Width1"] = v58
                }):Play()
            end
        end
        local u59 = script.FloorTrail:Clone()
        u5.apply(u59, p35)
        u59.CFrame = u41
        u59.Parent = workspace.Effects
        local u60 = p35 == game.Players.LocalPlayer.Character
        local u61 = Random.new()
        local u62 = u41.Position
        local u63 = 0
        local u64 = p38 == nil and 3 or p38
        local v76 = u2.Heartbeat:Connect(function(p65) --[[ Line: 185 ]]
            --[[
            Upvalues:
                [1] = u41
                [2] = u36
                [3] = u64
                [4] = u33
                [5] = u42
                [6] = u49
                [7] = u59
                [8] = u24
                [9] = u51
                [10] = u63
                [11] = u61
                [12] = u62
                [13] = u60
                [14] = u37
            --]]
            u41 = u41:Lerp(u36.Value, u64 * p65)
            local v66 = workspace:Raycast(u41.Position + Vector3.new(0, 25, 0), Vector3.new(0, -1000, 0), u33)
            if v66 then
                u42 = CFrame.new(v66.Position, v66.Position + v66.Normal) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -0.2, 0)
            end
            u49.Floor.CFrame = u42
            u49["Light Beam"].Attachment.WorldCFrame = CFrame.new(u42.Position)
            u49["Light Beam"].Attachment3.WorldCFrame = CFrame.new(u42.Position + Vector3.new(0, 50, 0))
            u59.CFrame = CFrame.new(u42.Position)
            if v66 then
                u24(u51, true)
                for _, v67 in u51["1"]:GetDescendants() do
                    if v67:IsA("ParticleEmitter") then
                        v67.Color = ColorSequence.new(v66.Instance.Color, v66.Instance.Color)
                    end
                end
                u59.Trail.Enabled = true
                if tick() - u63 >= 0.1 then
                    u63 = tick()
                    for _ = 1, 3 do
                        local v68 = _G.PlayEffect
                        local v69 = {
                            ["Position"] = u59.Position
                        }
                        local v70 = u61:NextNumber(-25, 25)
                        local v71 = u61:NextNumber(60, 100)
                        local v72 = u61
                        v69.Velocity = Vector3.new(v70, v71, v72:NextNumber(-25, 25))
                        v69.AngularVelocity = Random.new():NextUnitVector() * 3
                        v69.Material = v66.Instance.Material
                        local v73 = u61:NextNumber(0.5, 1)
                        local v74 = u61:NextNumber(0.5, 1)
                        local v75 = u61
                        v69.Size = Vector3.new(v73, v74, v75:NextNumber(0.5, 1))
                        v69.Color = v66.Instance.Color
                        v69.Duration = u61:NextInteger(0.3, 1)
                        v68("CreateRock", nil, v69)
                    end
                end
            else
                u24(u51, false)
                u59.Trail.Enabled = false
            end
            u62 = u41.Position
            if u60 == true and u37 then
                u37:FireServer("updateCFrame", u42)
            end
        end)
        local v77 = u7[p35]
        table.insert(v77, v76)
        tick()
        repeat
            task.wait()
        until p35:GetAttribute("PikaV2RayHold") == nil or p35:IsDescendantOf(workspace) == false
        _G.tween(v55, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Volume"] = 0
        })
        _G.destroy(v55, 0.25)
        local v78 = u7[p35]
        local v79, v80, v81, v82 = table.unpack(v78)
        u24(v81, false)
        _G.destroy(v81, 2)
        local v83 = script.SpawnEffect:Clone()
        u5.apply(v83, p35)
        v83.CFrame = v79.CFrame
        local v84 = Instance.new("WeldConstraint")
        v84.Part0 = v83
        v84.Part1 = v40
        v84.Parent = v83
        v83.Parent = u6
        _G.customEmit(v83)
        _G.destroy(v83, 2)
        u24(v80, false)
        _G.destroy(v80, 2)
        _G.destroy(u59, 2)
        v82:Disconnect()
        v79:Destroy()
        for _, v85 in v80:GetDescendants() do
            if v85.ClassName == "Beam" then
                u4:Create(v85, TweenInfo.new(0.1, Enum.EasingStyle.Quint), {
                    ["Width0"] = 0,
                    ["Width1"] = 0
                }):Play()
            end
        end
        _G.tween(v80.Floor.PointLight, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Brightness"] = 0,
            ["Range"] = 25
        })
        if u60 == true and u37 then
            u37:FireServer("updateCFrame", v80.PrimaryPart.CFrame)
        end
        task.wait(0.3)
        if _G.check:inspect(p35, true) == false then
            return
        end
        _G.PlaySound(v80.Floor, script.LightRayBoom)
        _G.shakenear(v80.Floor.Position, 125, 125, 100, -1.5)
        local v86 = script["Pika Explosion"]:Clone()
        u5.apply(v86, p35)
        v86.CFrame = v80.PrimaryPart.CFrame * CFrame.Angles(3.141592653589793, 0, 0)
        u31(v86, 1, 1.3)
        v86.Parent = u6
        _G.customEmit(v86)
        _G.destroy(v86, 5)
        _G.tween(v86.PointLight, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Brightness"] = 0,
            ["Range"] = 55
        })
        for _, u87 in v86:GetDescendants() do
            if u87.ClassName == "Beam" then
                u87.Enabled = true
                local v88 = u87.Width0
                local v89 = u87.Width1
                u87.Width0 = 0
                u87.Width1 = 0
                u4:Create(u87, TweenInfo.new(0.1, Enum.EasingStyle.Quint), {
                    ["Width0"] = v88,
                    ["Width1"] = v89
                }):Play()
                task.delay(u87:GetAttribute("EmitDuration"), function() --[[ Line: 314 ]]
                    --[[
                    Upvalues:
                        [1] = u4
                        [2] = u87
                    --]]
                    u4:Create(u87, TweenInfo.new(0.2), {
                        ["Width0"] = 0,
                        ["Width1"] = 0
                    }):Play()
                end)
            end
        end
        for v90 = 1, 8 do
            local v91 = v90 * 0.7853981633974483
            local u92 = script["Side Explosion"]:Clone()
            u5.apply(u92, p35)
            u92:PivotTo(v86.CFrame * CFrame.new(math.sin(v91) * 18, 0, math.cos(v91) * 18))
            u92.Parent = u6
            _G.destroy(u92, 5)
            task.delay(0.2, function() --[[ Line: 331 ]]
                --[[
                Upvalues:
                    [1] = u92
                    [2] = u31
                --]]
                _G.customEmit(u92)
                u31(u92["Pika Explosion"], 1, 1.3)
            end)
            for _, u93 in u92:GetDescendants() do
                if u93.ClassName == "Beam" then
                    u93.Enabled = true
                    local v94 = u93.Width0
                    local v95 = u93.Width1
                    u93.Width0 = 0
                    u93.Width1 = 0
                    u4:Create(u93, TweenInfo.new(0.1, Enum.EasingStyle.Quint), {
                        ["Width0"] = v94,
                        ["Width1"] = v95
                    }):Play()
                    task.delay(u93:GetAttribute("EmitDuration"), function() --[[ Line: 345 ]]
                        --[[
                        Upvalues:
                            [1] = u4
                            [2] = u93
                        --]]
                        u4:Create(u93, TweenInfo.new(0.2), {
                            ["Width0"] = 0,
                            ["Width1"] = 0
                        }):Play()
                    end)
                end
            end
        end
    end
end
return v32
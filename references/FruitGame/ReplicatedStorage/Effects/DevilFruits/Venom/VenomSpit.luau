 

local v1 = {}
local u2 = game:GetService("RunService")
local u3 = game:GetService("TweenService")
game:GetService("UserInputService")
local u4 = script.Parent.Puddles.Purple
local u5 = require(script.Parent.VenomSplash)
local u6 = script.Animations
game.Players.LocalPlayer:GetMouse()
function PlayAnim(p7, p8)
    --[[
    Upvalues:
        [1] = u6
    --]]
    local v9 = (p7:FindFirstChild("Humanoid") or p7:FindFirstChild("AnimationController")).Animator:LoadAnimation(u6[p8])
    v9:Play(0, 1, 1)
    return v9
end
local function u12(p10) --[[ Line: 24 ]]
    for _, v11 in p10:GetDescendants() do
        if v11:IsA("ParticleEmitter") then
            v11:Emit(v11:GetAttribute("EmitCount") / (_G.fastmode and 2 or 1))
        end
    end
end
local function u27(u13, u14, u15, u16) --[[ Line: 32 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
        [3] = u12
    --]]
    local v17 = u4:GetChildren()
    local u18 = v17[math.random(1, #v17)]:Clone()
    u18:PivotTo(CFrame.new(u13, u14 + u13) * CFrame.Angles(-1.5707963267948966, Random.new():NextNumber(-3.141592653589793, 3.141592653589793), 0))
    u18.Parent = workspace.Effects
    for _, v19 in u18:GetChildren() do
        local v20 = v19:FindFirstChildOfClass("MeshPart")
        local v21 = v20.Size
        v20.Size = Vector3.new()
        if v19.Name == "Out" then
            v21 = v21 * 1.02
        end
        if v19.Name == "Out" then
            v20.Material = Enum.Material.Glacier
        else
            v20.Material = Enum.Material.Neon
        end
        local v22 = v21 * u15
        v20.Transparency = v19.Name == "Out" and 0.45 or 0
        u3:Create(v20, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            ["Size"] = v22
        }):Play()
    end
    _G.PlaySound(CFrame.new(u13), script.Sounds["VenomDrip" .. math.random(1, 2)])
    task.spawn(function() --[[ Line: 57 ]]
        --[[
        Upvalues:
            [1] = u16
            [2] = u13
            [3] = u14
            [4] = u3
            [5] = u15
        --]]
        for _ = 1, (u16 and 3 or 0) + 1 do
            local v23 = script.Slash:Clone()
            v23.CFrame = CFrame.new(u13, u14 + u13) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.Angles(Random.new():NextNumber(-0.39269908169872414, 0.39269908169872414), 0, Random.new():NextNumber(-0.39269908169872414, 0.39269908169872414))
            v23.Parent = workspace.Effects
            v23.Mesh.Scale = Vector3.new(0, 0, 0)
            v23.Glow.Transparency = -3
            local v24 = Random.new():NextNumber(0.75, 1.35)
            _G.destroy(v23, 1.5)
            u3:Create(v23, TweenInfo.new(0.65 * v24), {
                ["CFrame"] = v23.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
            }):Play()
            u3:Create(v23.Mesh, TweenInfo.new(0.35 * v24), {
                ["Scale"] = Vector3.new(5.494, 17.352, 5.494) * u15
            }):Play()
            u3:Create(v23.Glow, TweenInfo.new(0.45 * v24), {
                ["Transparency"] = 1
            }):Play()
            task.wait()
        end
    end)
    local v25 = script.SplashPuddle:Clone()
    v25.CFrame = CFrame.new(u13, u14 + u13) * CFrame.Angles(-1.5707963267948966, 0, 0)
    v25.Parent = workspace.Effects
    _G.destroy(v25, 2)
    u12(v25)
    task.delay(2, function() --[[ Line: 82 ]]
        --[[
        Upvalues:
            [1] = u18
            [2] = u3
        --]]
        _G.destroy(u18, 1)
        for _, v26 in u18:GetChildren() do
            u3:Create(v26:FindFirstChildOfClass("MeshPart"), TweenInfo.new(0.95, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                ["Size"] = Vector3.new(),
                ["Transparency"] = 1
            }):Play()
        end
    end)
end
local function u37(p28, p29, p30) --[[ Line: 92 ]]
    local v31 = RaycastParams.new()
    local v32 = { workspace.Ships, workspace.Islands, workspace.Env }
    for v33 = 1, #p30 do
        local v34 = p30[v33]
        table.insert(v32, v34)
    end
    local v35 = Enum.RaycastFilterType.Whitelist
    v31.FilterDescendantsInstances = v32
    v31.FilterType = v35
    local v36 = (p28.Position - p29.PrimaryPart.Position).Magnitude
    return workspace:Raycast(p28.Position, CFrame.new(p28.Position, p29.PrimaryPart.Position).LookVector * v36, v31)
end
local function u45(p38, p39, p40) --[[ Line: 109 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v41 = {
        { Color3.fromRGB(95, 74, 255), Enum.Material.Neon, 0 },
        { Color3.fromRGB(105, 92, 255), Enum.Material.Glacier, 0.55 }
    }
    for v42 = 1, 2 do
        local v43 = Instance.new("Part")
        v43.Color = v41[v42][1]
        v43.Material = v41[v42][2]
        v43.Transparency = v41[v42][3]
        v43.Size = Vector3.new(1, 1, 1) * ((v42 - 1) * 0.08 + 1) * p40 / 2
        v43.CanCollide = false
        v43.CFrame = p38
        v43.Parent = p39.FX
        v43.Shape = Enum.PartType.Ball
        local v44 = Instance.new("WeldConstraint")
        v44.Part1 = p39.PrimaryPart
        v44.Part0 = v43
        v44.Parent = v43
        u3:Create(v43, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, true), {
            ["Size"] = Vector3.new(1, 1, 1) * ((v42 - 1) * 0.08 + 1) * p40
        }):Play()
        task.delay(0.4, v43.Destroy, v43)
    end
end
function v1.start(_, p46, p47, p48) --[[ Line: 132 ]]
    --[[
    Upvalues:
        [1] = u5
        [2] = u45
        [3] = u12
        [4] = u2
        [5] = u37
        [6] = u27
    --]]
    if _G.checkRenderDistance(p46.PrimaryPart.Position) == false then
        return
    elseif p46 then
        local v49 = p46:GetPrimaryPartCFrame()
        local u50 = script.Projectile:Clone()
        u50.Parent = workspace.Effects
        local v51 = _G.PlaySound(v49, script.Sounds.VenomSpitStart)
        local v52 = _G.PlaySound(v49, script.Sounds.VenomSpitHoldLoop)
        local v53 = tick()
        tick()
        local u54 = false
        local u55 = 1.25
        local v56 = false
        while p47.Parent ~= nil and p47.Name == "holdValue" do
            p46:GetPrimaryPartCFrame()
            local v57 = (tick() - v53) / 0.5
            u55 = math.clamp(v57, 0, 2) + 1.25
            u50.PrimaryPart.CFrame = p46.Head.CFrame * CFrame.new(0, 0, -(u55 * 0.85 / 2 + 0.25))
            u50.Out.Size = Vector3.new(1.08, 1.08, 1.08) * u55 / 2
            u50.In.Size = Vector3.new(1, 1, 1) * u55 / 2
            if Random.new():NextInteger(0, 40) == 1 then
                u5.Droplet(u50.PrimaryPart.CFrame * CFrame.new(Random.new():NextUnitVector() * 0.25 * u55))
            end
            if u55 >= 3 then
                tick()
                u45(u50.PrimaryPart.CFrame * CFrame.new(Random.new():NextUnitVector() * 0.1 * u55 / 2), u50, u55 / 2)
                if v56 == false then
                    local v58 = Instance.new("Highlight")
                    v58.DepthMode = Enum.HighlightDepthMode.Occluded
                    v58.FillColor = Color3.fromRGB(84, 62, 255)
                    v58.FillTransparency = 0
                    v58.OutlineTransparency = 1
                    v58.Parent = p46
                    _G.tween(v58, { 0.4, "Cubic", Enum.EasingDirection.Out }, {
                        ["FillTransparency"] = 1
                    })
                    _G.destroy(v58, 0.4)
                    _G.PlaySound(p46.PrimaryPart, script.Sounds.fullCharged)
                    v56 = true
                end
            end
            task.wait()
        end
        _G.tween(v51, {
            0.25,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Volume"] = 0
        }, nil, true)
        v52:Destroy()
        local v59 = p47.Value
        _G.PlaySound(v59, script.Sounds.VenomSpitShoot)
        task.spawn(function() --[[ Line: 197 ]]
            --[[
            Upvalues:
                [1] = u54
            --]]
            u54 = true
        end)
        local u60 = nil
        for _, v61 in u50:GetDescendants() do
            if table.find({ "ParticleEmitter", "Trail" }, v61.ClassName) then
                v61.Enabled = true
            end
        end
        local v62 = script.Spit:Clone()
        v62.CFrame = p46.Head.CFrame * CFrame.new(0, 0, -1)
        v62.Parent = workspace.Effects
        u12(v62)
        _G.destroy(v62, 1)
        local u63 = v59.LookVector * p48
        local u64 = _G.getTargets(p46)
        local _ = u2.Heartbeat:Connect(function(p65) --[[ Line: 217 ]]
            --[[
            Upvalues:
                [1] = u63
                [2] = u50
                [3] = u37
                [4] = u64
                [5] = u27
                [6] = u55
                [7] = u12
                [8] = u60
            --]]
            local v66 = u63
            local v67 = 196.2 / (1 / p65)
            u63 = v66 - Vector3.new(0, v67, 0)
            local v68 = u50:GetPrimaryPartCFrame()
            local v69 = u50.PrimaryPart.CFrame.Position + u63 * p65
            u50.PrimaryPart.CFrame = CFrame.new(v69, v69 + u63.Unit)
            local v70 = u37(v68, u50, u64)
            if v70 then
                local v71 = v70.Instance
                local v72 = v70.Normal
                local v73 = v70.Position
                u50.FX:ClearAllChildren()
                for _, v74 in u50:GetDescendants() do
                    if v74:IsA("BasePart") then
                        v74.Transparency = 1
                    elseif v74:IsA("ParticleEmitter") then
                        v74.Enabled = false
                    end
                end
                _G.PlaySound(CFrame.new(v73), script.Sounds["VenomSpitBoom" .. math.random(1, 2)])
                if not (v71:IsDescendantOf(workspace.PlayerCharacters) or v71:IsDescendantOf(workspace.NPCs)) then
                    u27(v73, v72, u55, true)
                end
                local v75 = script.Splash:Clone()
                v75.CFrame = CFrame.new(v73, v73 + v72) * CFrame.Angles(-1.5707963267948966, 0, 0)
                v75.Parent = workspace.Effects
                u12(v75)
                _G.destroy(v75, 2)
                _G.destroy(u50, 0.85)
                u60:Disconnect()
            end
        end)
    end
end
return v1
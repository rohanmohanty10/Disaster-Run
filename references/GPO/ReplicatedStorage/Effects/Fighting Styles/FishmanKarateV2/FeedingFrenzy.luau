 

local v1 = {}
local u2 = script.Parent.Assets
local _ = u2.Z
local u3 = require(game.ReplicatedStorage.Modules.Maid)
local u4 = game:GetService("TweenService")
local _ = game["Run Service"]
local u5 = RaycastParams.new()
u5.FilterType = Enum.RaycastFilterType.Include
u5.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
local function u14(p6, ...) --[[ Line: 12 ]]
    local v7 = { ... }
    local v8 = #v7 - 2
    if v8 >= 0 then
        local v9 = nil
        for v10 = 1, #v7 do
            local v11 = v8 + 1
            local v12 = (v10 == 1 or v10 == #v7) and 1 or v11
            local v13 = (1 - p6) ^ (v8 + 1 - (v10 - 1)) * p6 ^ (v8 - (-v10 + v8 + 1)) * v12 * v7[v10]
            if v9 then
                v9 = v9 + v13
            else
                v9 = v13
            end
        end
        return v9
    end
    warn("Not enough Points")
end
function v1.start(_, u15, p16, p17, u18) --[[ Line: 45 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u14
        [3] = u3
        [4] = u4
        [5] = u5
    --]]
    local u19 = u15.PrimaryPart
    local v20 = u15.Humanoid
    local _ = v20.Animator
    local u21 = u2.T
    if _G.checkRenderDistance(u15.PrimaryPart.Position) == false then
        return
    end
    if p16 ~= "hold" then
        if p16 == "shoot" then
            local u22 = Instance.new("Folder")
            u22.Parent = workspace.Effects
            local u23 = u3.new()
            local u24 = u21.SharkRig:Clone()
            local u25 = false
            for _, v26 in u24:GetChildren() do
                if v26:IsA("BasePart") and v26 ~= u24.PrimaryPart then
                    local v27 = Instance.new("WeldConstraint")
                    v27.Part0 = v26
                    v27.Part1 = u24.PrimaryPart
                    v26.Anchored = false
                end
            end
            u24:PivotTo(p17 * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -10, 0))
            u24.Parent = workspace.Effects
            u24.PrimaryPart.loopSFX:Play()
            _G.particleEnabled(u24, true, true)
            local u28 = u18.Part
            local u29 = u28:WaitForChild("CFrameValue", 5)
            local u30 = u24.PrimaryPart.Position
            local u31 = 0
            for _, v32 in u21:GetChildren() do
                if string.find(v32.Name, "Swirl") then
                    local v33 = v32:Clone()
                    v33.CFrame = p17 * CFrame.new(0, 0, -3) * CFrame.Angles(0, 0, math.random(-100, 100))
                    v33.Parent = u22
                    u4:Create(v33, TweenInfo.new(0.35), {
                        ["CFrame"] = v33.CFrame * CFrame.new(0, 0, -3) * CFrame.Angles(0, 0, -2.356194490192345),
                        ["Size"] = v33.Size * 1.3,
                        ["Transparency"] = 1
                    }):Play()
                end
            end
            u24.AnimationController.Animator:LoadAnimation(u24.Idle):Play(0.4)
            local u34 = u21.Bullet:Clone()
            u34.CFrame = p17
            u34.Anchored = true
            u34.Parent = workspace.Effects
            u23:AddTask(u34)
            u23:AddTask(u24)
            u23:AddTask(u22)
            _G.PlaySound(u24.PrimaryPart, script.Shoot:GetChildren()[math.random(1, 3)])
            local u35 = {}
            local u36 = CFrame.new(0, -0.5, 2)
            local u37 = u34.GroundAttach
            local function u41(p38) --[[ Line: 202 ]]
                --[[
                Upvalues:
                    [1] = u5
                    [2] = u37
                --]]
                local v39 = workspace:Raycast(p38, Vector3.new(0, -125, 0), u5)
                if v39 then
                    u37.WorldCFrame = CFrame.new(v39.Position, v39.Position + v39.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.1, 0)
                end
                for _, v40 in u37:GetDescendants() do
                    if v40:IsA("ParticleEmitter") then
                        v40.Enabled = v39 and true or false
                    end
                end
            end
            local u42 = tick()
            local u43 = tick()
            local u44 = tick()
            local function u48() --[[ Line: 216 ]]
                --[[
                Upvalues:
                    [1] = u24
                    [2] = u36
                    [3] = u42
                    [4] = u21
                    [5] = u22
                    [6] = u4
                    [7] = u43
                    [8] = u44
                --]]
                local v45 = u24.PrimaryPart.CFrame * u36
                if tick() - u42 >= 0.14 then
                    u42 = tick()
                    local v46 = u21.WindBurst:Clone()
                    v46.CFrame = v45 * CFrame.new(0, 0, -4) * CFrame.Angles(1.5707963267948966, 0, 0)
                    local v47 = v46.Mesh
                    v47.Scale = v47.Scale * 1.5
                    v46.Decal.Transparency = 0.5
                    v46.Parent = u22
                    u4:Create(v46.Mesh, TweenInfo.new(0.2), {
                        ["Scale"] = v46.Mesh.Scale * 1.5
                    }):Play()
                    u4:Create(v46.Decal, TweenInfo.new(0.2), {
                        ["Transparency"] = 1
                    }):Play()
                end
                local _ = tick() - u43 >= 0.4
                local _ = tick() - u44 >= 0.3
            end
            local u49 = tick()
            local u50 = os.clock()
            local function u56() --[[ Line: 291 ]]
                --[[
                Upvalues:
                    [1] = u35
                    [2] = u24
                    [3] = u36
                    [4] = u50
                --]]
                for v51, v52 in u35 do
                    local v53 = u24.PrimaryPart.CFrame * u36
                    local v54 = CFrame.Angles
                    local v55 = v51 * 180 + (os.clock() - u50) * 1250
                    v52.CFrame = v53 * v54(1.5707963267948966, math.rad(v55), 0) * CFrame.new(0, -3, -3)
                end
            end
            local v57 = u21.CurveCharge_Soar:Clone()
            v57.CFrame = u24.PrimaryPart.CFrame * u36
            v57.Parent = u22
            table.insert(u35, v57)
            local v58 = u21.CurveCharge_Soar:Clone()
            v58.CFrame = u24.PrimaryPart.CFrame * u36
            v58.Parent = u22
            table.insert(u35, v58)
            u56()
            u23:AddTask(u29.Changed:Connect(function(p59) --[[ Line: 314 ]]
                --[[
                Upvalues:
                    [1] = u29
                    [2] = u24
                    [3] = u41
                    [4] = u48
                    [5] = u49
                    [6] = u56
                    [7] = u31
                    [8] = u30
                --]]
                local v60 = u29:GetAttribute("DT")
                _G.tween(u24.PrimaryPart, {
                    v60,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["CFrame"] = p59
                })
                u41(p59.Position)
                u48()
                local v61 = (tick() - u49) * 3
                local v62 = math.min(v61, 1)
                u24:ScaleTo((math.clamp(v62, 0.01, 1)))
                u56()
                u31 = (u30 - p59.Position).Magnitude / v60
                u30 = p59.Position
            end))
            u23:AddTask(u28.BounceValue.Changed:Connect(function(_) --[[ Line: 338 ]]
                --[[
                Upvalues:
                    [1] = u24
                    [2] = u31
                    [3] = u5
                    [4] = u21
                    [5] = u18
                    [6] = u22
                --]]
                local v63 = workspace:Raycast(u24.PrimaryPart.Position, u24.PrimaryPart.CFrame.LookVector * u31, u5)
                if v63 then
                    local v64 = u21.Splash:Clone()
                    v64.CFrame = CFrame.new(v63.Position, v63.Position + v63.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.1, 0)
                    local v65 = _G.scaleParticle
                    local v66 = nil
                    local v67 = v66 == nil and 0.1 or v66
                    local v68 = u18.Velocity.Magnitude / u18.ScaleDiv
                    local v69 = u18.MaxScale
                    v65(v64, math.clamp(v68, v67, v69), true)
                    v64.Parent = u22
                    _G.customEmit(v64)
                    _G.PlaySound(v64, script.Hit:GetChildren()[math.random(1, 3)], {
                        ["Pitch"] = math.random(90, 110) / 100
                    })
                    _G.destroy(v64, 4)
                end
            end))
            local function v80(p70) --[[ Line: 353 ]]
                --[[
                Upvalues:
                    [1] = u25
                    [2] = u28
                    [3] = u24
                    [4] = u34
                    [5] = u4
                    [6] = u35
                    [7] = u21
                    [8] = u18
                    [9] = u22
                    [10] = u23
                --]]
                if u25 ~= true then
                    u25 = true
                    local v71 = u28
                    _G.PlaySound(v71, script.Hit:GetChildren()[math.random(1, 3)], {
                        ["Pitch"] = math.random(90, 110) / 100
                    })
                    u24.PrimaryPart.loopSFX:Stop()
                    _G.particleEnabled(u34, false)
                    for _, v72 in u24:GetDescendants() do
                        if v72:IsA("ParticleEmitter") or v72:IsA("Trail") then
                            v72.Enabled = false
                        elseif v72:IsA("BasePart") then
                            v72.Transparency = 1
                        elseif v72:IsA("Beam") then
                            u4:Create(v72, TweenInfo.new(0.5), {
                                ["Width0"] = 0,
                                ["Width1"] = 0
                            }):Play()
                        end
                    end
                    for _, v73 in u35 do
                        _G.particleEnabled(v73, false)
                    end
                    local v74 = u21.Explode:Clone()
                    v74.CFrame = p70 and CFrame.new(p70.Position, p70.Position + p70.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.1, 0) or CFrame.new(v71.Position)
                    local v75 = _G.scaleParticle
                    local v76 = 1
                    local v77 = v76 == nil and 0.1 or v76
                    local v78 = u18.Velocity.Magnitude / u18.ScaleDiv
                    local v79 = u18.MaxScale
                    v75(v74, math.clamp(v78, v77, v79), true)
                    v74.Parent = u22
                    _G.customEmit(v74)
                    _G.destroy(v74, 5)
                    task.wait(3)
                    u23:Destroy()
                end
            end
            u23:AddTask(u28.Destroying:Connect(v80))
        end
        return
    end
    tick()
    local v81 = tick()
    local v82 = script.Charge:Clone()
    v82:ScaleTo(0.4)
    v82.PrimaryPart.CFrame = u19.CFrame * CFrame.new(0, -(u19.Size.Y / 2 + v20.HipHeight), 0)
    v82.Parent = workspace.Effects
    _G.particleEnabled(v82, true)
    _G.PlaySound(u15.PrimaryPart, script["Audio/FishKBarrageStart"])
    local v83 = script.FishKBarrageChargeLoop:Clone()
    v83.Parent = v82.PrimaryPart
    v83:Play()
    while true do
        if tick() - v81 >= 1 then
            v81 = tick()
            v82:ScaleTo(v82:GetScale() + 0.2)
            local v84 = Instance.new("Highlight")
            v84.OutlineTransparency = 1
            v84.DepthMode = Enum.HighlightDepthMode.Occluded
            v84.FillTransparency = 0
            v84.FillColor = Color3.fromRGB(85, 170, 255)
            v84.Parent = u15
            _G.tween(v84, {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["FillTransparency"] = 1,
                ["OutlineTransparency"] = 1
            })
            _G.destroy(v84, 0.25)
            _G.PlaySound(u15.PrimaryPart, script.FishKBarrageChargeTick)
            for _ = 1, 4 do
                task.spawn(function() --[[ Line: 96 ]]
                    --[[
                    Upvalues:
                        [1] = u19
                        [2] = u21
                        [3] = u15
                        [4] = u14
                    --]]
                    local v85 = u19.Position
                    local v86 = Random.new():NextNumber(-2, 2)
                    local v87 = Random.new():NextNumber(-3, 3)
                    local v88 = Random.new()
                    local v89 = v85 + Vector3.new(v86, v87, v88:NextNumber(-2, 2)) * Random.new():NextNumber(5, 15)
                    local v90 = u21.CurveCharge:Clone()
                    v90.CFrame = CFrame.new(v89) * CFrame.Angles(math.random(-360, 360), math.random(-360, 360), math.random(-360, 360))
                    v90.Parent = workspace.Effects
                    _G.destroy(v90, 5)
                    local v91 = 0
                    repeat
                        local v92 = v91 + task.wait() * 4
                        v91 = math.clamp(v92, 0, 1)
                        local v93 = {
                            [1] = v90.Position,
                            [1] = v90.CFrame * CFrame.new(0.2, 0, -0.2).Position,
                            [2] = v90.CFrame * CFrame.new(0.4, 0, -0.4).Position,
                            [3] = v90.CFrame * CFrame.new(0.6000000000000001, 0, -0.6000000000000001).Position,
                            [#v93 + 1] = u15.Head.Position
                        }
                        v90.Position = u14(v91, unpack(v93))
                    until v91 == 1
                    _G.particleEnabled(v90, false)
                end)
                task.wait()
            end
        end
        local v94 = v82.PrimaryPart
        local v95 = u19.Position
        local v96 = -(u19.Size.Y / 2 + v20.HipHeight)
        v94.Position = v95 + Vector3.new(0, v96, 0)
        task.wait()
        if not u15:GetAttribute("FeedingFrenzy") then
            _G.tween(v83, {
                0.25,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Volume"] = 0
            })
            _G.particleEnabled(v82, false)
            _G.destroy(v82, 5)
            return
        end
    end
end
return v1
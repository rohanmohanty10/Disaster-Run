 

game:GetService("RunService")
game:GetService("TweenService")
Emit = _G.Emit
TweenCreate = _G.Ess.Tween
local v1 = {}
local function u5(p2) --[[ Line: 11 ]]
    p2.Archivable = true
    local u3 = p2:Clone()
    u3.PrimaryPart.Anchored = true
    task.spawn(function() --[[ Line: 15 ]]
        --[[
        Upvalues:
            [1] = u3
        --]]
        for _, v4 in u3:GetDescendants() do
            if v4:IsA("BodyVelocity") then
                v4:Destroy()
            elseif v4:IsA("BaseScript") then
                v4:Destroy()
            elseif v4:IsA("Weld") or v4:IsA("Motor6D") then
                if v4.Part1 and v4.Part1:IsDescendantOf(u3) == false then
                    v4:Destroy()
                end
            elseif v4:IsA("BasePart") then
                v4.CanTouch = false
                v4.CollisionGroupId = 6
                v4.CanCollide = false
                v4.CanQuery = false
                v4.CastShadow = false
                if v4.Transparency == 1 then
                    v4:SetAttribute("trans", true)
                else
                    v4.Transparency = 0
                end
                if v4:IsA("MeshPart") then
                    v4.TextureID = ""
                end
                v4.Color = Color3.fromRGB(255, 85, 0)
                v4.Material = Enum.Material.Neon
            elseif v4:IsA("Highlight") then
                v4:Destroy()
            elseif v4:IsA("Decal") then
                v4:Destroy()
            end
        end
    end)
    u3.Parent = workspace.Effects
    u3:PivotTo(p2:GetPrimaryPartCFrame())
    return u3
end
function v1.start(_, p6, p7, p8) --[[ Line: 57 ]]
    --[[
    Upvalues:
        [1] = u5
    --]]
    if _G.checkRenderDistance(p6.Position) == false then
        return
    end
    Random.new()
    local v9 = script.Thrust:Clone()
    v9.CFrame = p6 * CFrame.new(-1.1, -0.35, -3) * CFrame.Angles(0, 3.141592653589793, 0)
    v9.Parent = workspace.Effects
    local u10 = u5(p8)
    local v11 = Instance.new("Highlight")
    v11.OutlineTransparency = 1
    v11.DepthMode = Enum.HighlightDepthMode.Occluded
    v11.FillTransparency = 1
    v11.OutlineColor = Color3.fromRGB(0, 0, 0)
    v11.Parent = p7
    if u10 and u10:FindFirstChild("Humanoid") then
        local v12 = u10.Humanoid:LoadAnimation(script.soul)
        v12:Play(0)
        v12:AdjustWeight(5)
    end
    local v13 = script.Thrust.Thrust.InnerOrb.Size
    v9.Thrust.InnerOrb.Size = NumberSequence.new(0)
    Emit(v9.ThrustShockwave, true)
    Emit(v9.Attachment, true)
    Emit(v9.Thrust, false, 0.9)
    _G.tween(v11, {
        0.25,
        "Cubic",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["FillTransparency"] = 0.2
    })
    v9.PointLight.Range = 0
    _G.tween(v9.PointLight, {
        0.25,
        "Cubic",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Range"] = script.Thrust.PointLight.Range
    })
    _G.tween(v9.Thrust.InnerOrb, {
        1,
        "Quad",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Size"] = v13
    })
    local u14
    if p8 == game.Players.LocalPlayer.Character then
        u14 = script.ColorCorrection:Clone()
        u14.TintColor = Color3.fromRGB(255, 255, 255)
        u14.Parent = workspace.CurrentCamera
        _G.tween(u14, {
            0.25,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["TintColor"] = script.ColorCorrection.TintColor
        })
    else
        u14 = nil
    end
    local v15 = tick()
    local v16 = {}
    while true do
        if p8 ~= nil and (not p8 or p8:FindFirstChild("UpperTorso") ~= nil) and (p7 ~= nil and (not p7 or p7:FindFirstChild("RightHand") ~= nil)) then
            local v17 = Instance.new("Attachment")
            local v18 = math.random(-360, 360)
            local v19 = math.random(-360, 360)
            local v20 = math.random
            v17.Orientation = Vector3.new(v18, v19, v20(-360, 360))
            v17.Parent = p8.UpperTorso
            local v21 = v17:Clone()
            local v22 = math.random(-360, 360)
            local v23 = math.random(-360, 360)
            local v24 = math.random
            v21.Orientation = Vector3.new(v22, v23, v24(-360, 360))
            v21.Parent = p7.RightHand
            local v25 = script.beam:Clone()
            v25.Attachment0 = v17
            v25.Attachment1 = v21
            v25.CurveSize0 = math.random(3, 6) / 1.5
            if math.random(1, 2) == 1 then
                v25.CurveSize0 = -v25.CurveSize0
            end
            v25.CurveSize1 = v25.CurveSize0 * -2
            v25.Width1 = math.random(1, 3)
            v25.TextureSpeed = math.random(100, 150) / 100
            v25.Parent = workspace.Effects
            _G.tween(v25, {
                0.75,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CurveSize0"] = v25.CurveSize0 * -2,
                ["CurveSize1"] = v25.CurveSize1 * 2,
                ["Width0"] = 0
            })
            table.insert(v16, v25)
            _G.destroy({ v17, v21, v25 }, 1)
            task.wait()
        end
        if tick() - v15 >= 1 then
            _G.tween(v11, {
                0.25,
                "Cubic",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["FillTransparency"] = 1,
                ["OutlineTransparency"] = 1
            })
            _G.destroy(v11, 0.25)
            for v26 = 1, #v16 do
                if v16[v26] ~= nil then
                    local v27 = v16[v26]
                    _G.tween(v27, {
                        0.5,
                        "Quad",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Width0"] = 0,
                        ["Width1"] = 0
                    })
                end
            end
            task.delay(0.2, function() --[[ Line: 157 ]]
                --[[
                Upvalues:
                    [1] = u10
                    [2] = u14
                --]]
                local v28 = u10:GetDescendants()
                for v29 = 1, #v28 do
                    if v28[v29]:IsA("BasePart") then
                        _G.tween(v28[v29], {
                            0.25,
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["Transparency"] = 1,
                            ["Color"] = Color3.fromRGB(0, 0, 0)
                        })
                    end
                end
                if u14 then
                    _G.tween(u14, {
                        0.25,
                        "Quad",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["TintColor"] = Color3.fromRGB(255, 255, 255)
                    })
                    _G.destroy(u14, 0.25)
                end
                _G.destroy(u10, 0.25)
            end)
            _G.tween(v9.PointLight, {
                0.25,
                "Cubic",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Brightness"] = 0
            })
            Emit(v9.Pull, true)
            _G.destroy(v9, 1.85)
            return
        end
    end
end
return v1
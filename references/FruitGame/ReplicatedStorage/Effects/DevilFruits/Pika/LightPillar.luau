 

local v1 = {}
function setTwoEndPoints(p2, p3, p4)
    local _ = (p3 - p4).Magnitude
    p2.CFrame = CFrame.new(p3:Lerp(p4, 0.5), p4)
    return p2
end
local function u9(p5, p6) --[[ Line: 13 ]]
    local v7 = p5:GetChildren()
    for v8 = 1, #v7 do
        if v7[v8]:IsA("ParticleEmitter") or v7[v8]:IsA("PointLight") then
            v7[v8].Enabled = p6
        end
    end
end
local u10 = _G.getEffect("Shockwave2")
function v1.start(_, p11, p12, p13) --[[ Line: 23 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u9
    --]]
    local v14 = p11.Character
    if _G.checkRenderDistance(v14.HumanoidRootPart.Position) == false then
        return
    end
    local v15 = script.dust:Clone()
    v15.Attachment.glow.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 5, 0), NumberSequenceKeypoint.new(1, 10, 5) })
    v15.Attachment.glow2.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 5, 0), NumberSequenceKeypoint.new(1, 20, 5) })
    v15.Parent = workspace.Effects
    _G.tween(v15.Attachment.PointLight, {
        0.1,
        Enum.EasingStyle.Sine,
        Enum.EasingDirection.Out,
        -1,
        true,
        0
    }, {
        ["Range"] = 10
    })
    v15.laserloop:Play()
    _G.destroy(v15, 60)
    p12:WaitForChild("Part", 1)
    local v16 = CFrame.new(0, 25, 0)
    local v17 = nil
    local v18 = 0
    local v19 = nil
    local v20 = 0
    while true do
        _G.fw(0.01)
        local v21 = p13.Value
        if p11 == game.Players.LocalPlayer then
            v21 = _G.MouseCF.Position
        end
        if v14.PrimaryPart == nil then
            break
        end
        local v22 = (v21 - v14.Head.Position).Magnitude
        local v23 = math.clamp(v22, 0, 75)
        local v24 = v14.Head.Position + (v21 - v14.Head.Position).unit * v23
        if v17 then
            v24 = v17:Lerp(v24, 0.025)
        end
        if p12 == nil or p12 and p12.PrimaryPart == nil then
            break
        end
        local v25 = CFrame.new(v24) * CFrame.new(0, 25, 0)
        p12:PivotTo(v25 * CFrame.Angles(1.5707963267948966, 0, 0))
        p12.PrimaryPart.CFrame = p12.PrimaryPart.CFrame * CFrame.Angles(1.5707963267948966, 0, 0)
        p12.Part.CFrame = CFrame.new(p12.PrimaryPart.CFrame.Position)
        local v26 = Ray.new(v25.Position + Vector3.new(0, 25, 0), v25.UpVector * -100)
        local v27, v28
        v27, v17, v28 = _G.raycastWhitelist(v26, { workspace.Islands, workspace.Ships, workspace.Env })
        local v29 = (p12.Part.Position - v17).Magnitude
        local v30 = p12.Part
        local v31 = p12.Part.Size.X
        local v32 = p12.Part.Size.Z
        v30.Size = Vector3.new(v31, v29, v32)
        local v33 = p12.Part.Mesh
        local v34 = -v29 / 2
        v33.Offset = Vector3.new(0, v34, 0)
        local v35 = CFrame.new(v17)
        if tick() - v18 >= 0.1 then
            u10:start(v35, v35, BrickColor.new("Bright red"), Vector3.new(25, 0, 25), Vector3.new(0, 2, 0), 0.25, -2, Enum.EasingStyle.Exponential, Color3.fromRGB(218, 133, 65), Enum.Material.Neon, "Rings")
            v18 = tick()
        end
        if v27 then
            if v15.Attachment.Rocks.Enabled == false then
                u9(v15.Attachment, true)
            end
            v15.Attachment.sm2.Color = ColorSequence.new(v27.Color)
            v15.Attachment.Rocks.Color = ColorSequence.new(v27.Color)
            v15.CFrame = v35
            if v19 and ((v19 - v17).Magnitude > 0.1 and _G.fastmode == false) then
                local v36 = script.Part:Clone()
                v36.CFrame = CFrame.new(v17, v17 + v28) * CFrame.Angles(-1.5707963267948966, 0, 0)
                local v37 = v36.Position
                local v38 = v19.X
                local v39 = v36.Position.Y
                local v40 = v19.Z
                local v41 = (v37 - Vector3.new(v38, v39, v40)).Magnitude / 3
                local v42 = math.clamp(v41, 0, 1)
                if v19 then
                    local v43 = v19.Y - v36.Position.Y
                    if math.abs(v43) < 1 then
                        setTwoEndPoints(v36, v36.Position, v19)
                    end
                end
                v36.Mesh.Scale = Vector3.new(v42, v42, v42)
                _G.destroy(v36, 2)
                v36.Parent = workspace.Effects
                _G.tween(v36, {
                    2,
                    Enum.EasingStyle.Linear,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Color"] = Color3.fromRGB(0, 0, 0),
                    ["Transparency"] = 1
                })
                if tick() - v20 >= 0.1 then
                    local v44 = Instance.new("Attachment")
                    v44.Parent = v15
                    local v45 = v44:Clone()
                    v45.Parent = v15
                    local v46 = script.Beam:Clone()
                    local v47 = (v15.CFrame * v16).Position
                    local v48 = math.random(-25, 25)
                    local v49 = math.random(-25, 25)
                    local v50 = math.random
                    local v51 = v47 + Vector3.new(v48, v49, v50(-25, 25))
                    v46.Width0 = math.random(25, 50)
                    v46.Attachment0 = v44
                    v46.Attachment1 = v45
                    _G.destroy(v46, 0.25)
                    v46.Parent = p12
                    _G.tween(v45, {
                        0.25,
                        Enum.EasingStyle.Exponential,
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["WorldPosition"] = v51
                    })
                    _G.tween(v46, {
                        0.25,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Width0"] = 0,
                        ["Width1"] = 0
                    })
                    v20 = tick()
                end
            end
        else
            u9(v15.Attachment, false)
        end
        if p12.Parent == nil or p13.Parent == nil then
            break
        end
        v19 = v17
    end
    v15.laserloop:Stop()
    u9(v15.Attachment, false)
    _G.destroy(v15, 2)
end
return v1
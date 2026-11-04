 

local v1 = {}
game:GetService("TweenService")
script.Parent.Parent:WaitForChild("Rocks"):GetChildren()
local u2 = _G.customEmit
local v3 = RaycastParams.new()
local v4 = { workspace.Islands, workspace.Env, workspace.Ships }
local v5 = Enum.RaycastFilterType.Include
v3.FilterDescendantsInstances = v4
v3.FilterType = v5
local function u12(p6, _) --[[ Line: 22 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v7, v8, v9 = _G.getRayFloor(CFrame.new(p6), 15)
    if v7 then
        local v10 = script.StompVFX:Clone()
        v10.CFrame = CFrame.new(v8, v8 + v9) * CFrame.new(0, 0, -1.5) * CFrame.Angles(-1.5707963267948966, 0, 0)
        _G.recolorParticles(v10, v7.Color)
        v10.Parent = workspace.Effects
        u2(v10)
        _G.destroy(v10, 3)
        local v11 = script.Crack:Clone()
        v11.CFrame = CFrame.new(v8, v8 + v9) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -0.1, 0)
        v11.Parent = workspace.Effects
        u2(v11)
        _G.destroy(v11, 3)
    end
end
function CreateMesh(p13, p14)
    local v15 = script:WaitForChild("MeshImage"):Clone()
    v15.CFrame = p14 * CFrame.Angles(0, -1.5707963267948966, 0)
    v15.Parent = workspace.Effects
    v15.Decal.Texture = "rbxassetid://" .. p13
    return v15
end
function v1.start(_, p16, p17) --[[ Line: 94 ]]
    --[[
    Upvalues:
        [1] = u12
    --]]
    Random.new()
    local v18 = p17.Type
    if v18 == "Smash" then
        local v19 = p17.CFrame
        local v20 = p17.lookOffset
        local v21 = CFrame.lookAlong((v19 * CFrame.new(0, 0, -v20)).Position, Vector3.new(-0, -1, -0))
        local v22 = CreateMesh("9572542664", v21)
        v22.Mesh.Scale = Vector3.new(0.225, 0.578, 0.541)
        _G.tween(v22.Mesh, { 0.2, "Quint", Enum.EasingDirection.Out }, {
            ["Scale"] = Vector3.new(0.45, 0, 0)
        })
        _G.tween(v22, { 0.2, "Quint", Enum.EasingDirection.Out }, {
            ["CFrame"] = v22.CFrame * CFrame.new(5, 0, 0) * CFrame.Angles(3.141592653589793, 0, 0)
        })
        local v23 = CreateMesh("9626892087", v21)
        _G.tween(v23.Mesh, { 0.25, "Quint", Enum.EasingDirection.Out }, {
            ["Scale"] = Vector3.new(0.088, 0.678, 0.657)
        })
        _G.tween(v23.Decal, { 0.25, "Quint", Enum.EasingDirection.Out }, {
            ["Transparency"] = 1
        })
        _G.tween(v23, { 0.25, "Quint", Enum.EasingDirection.Out }, {
            ["CFrame"] = v23.CFrame * CFrame.new(-7, 0, 0) * CFrame.Angles(3.141592653589793, 0, 0)
        })
        _G.destroy({ v23, v22 }, 0.25)
        _G.PlaySound(p16.PrimaryPart, script.DragonTailSlamWhoosh)
        local u24 = p16:FindFirstChild("tailStompSwirl")
        if u24 then
            u24.Name = ""
            task.delay(0.1, function() --[[ Line: 122 ]]
                --[[
                Upvalues:
                    [1] = u24
                --]]
                _G.particleEnabled(u24, false, true)
                _G.destroy(u24, 4)
            end)
        end
        local v25 = p16.PrimaryPart:FindFirstChild("DragonTailSlamAirSpinLoop")
        if v25 then
            v25.Name = ""
            _G.tween(v25, { 0.25, "Quad", Enum.EasingDirection.Out }, {
                ["Volume"] = 0
            })
            _G.destroy(v25, 1)
        end
        local v26 = p17.castInfo
        if v26 then
            u12(v21.Position, 6)
            _G.shakenear(p16.HumanoidRootPart.CFrame.Position, 35, 75, 50, -1)
            _G.PlaySound(CFrame.new(v26.Position), script.DragonTailSlamGroundImpact)
            local v27 = v26.Position
            _G.PlayEffect("GroundRocks4", nil, {
                ["Segments"] = 20,
                ["Position"] = v27 + Vector3.new(0, 2, 0),
                ["DistanceRandomness"] = Vector2.new(0.3, 1),
                ["Duration"] = 4,
                ["TweenDuration"] = 1,
                ["Radius"] = 13,
                ["Direction"] = -v26.Normal * 15,
                ["Angle"] = -0.7853981633974483
            })
            _G.PlayEffect("RockDebris", nil, {
                ["PartCount"] = 8,
                ["RandomVelocityMagnitude"] = Vector2.new(-45, 45) * 1,
                ["Position"] = v27,
                ["Direction"] = Vector3.new(0, 75, 0),
                ["RaycastDirection"] = -v26.Normal * 15,
                ["Size"] = Vector3.new(0.6, 0.6, 0.6),
                ["TrailEnabled"] = true
            })
            return
        end
    elseif v18 == "Jump" then
        local v28, v29, v30 = _G.getRayFloor(p17.CFrame, 7)
        if v28 then
            local v31 = script.JumpVFX:Clone()
            v31.CFrame = CFrame.new(v29, v29 + v30) * CFrame.Angles(1.5707963267948966, 0, 0)
            v31.Parent = workspace.Effects
            _G.customEmit(v31)
            _G.destroy(v31, 3)
        end
        _G.PlaySound(p16.PrimaryPart, script.DragonTailSlamJump)
        local v32 = p16:FindFirstChild("Tail_9", true)
        if v32 then
            local v33 = script.TailTrail:Clone()
            v33.CFrame = v32.WorldCFrame
            v33.Name = "tailStompSwirl"
            v33.Parent = p16
            _G.customWeld(v33, v32, CFrame.new(), v33)
        end
        local v34 = script.DragonTailSlamAirSpinLoop:Clone()
        v34.Parent = p16.PrimaryPart
        v34:Play()
        _G.destroy(v34, 6)
    end
end
return v1
 

local u1 = game:GetService("RunService")
local u2 = {
    "rbxassetid://15213738655",
    "rbxassetid://15213738522",
    "rbxassetid://15213738403",
    "rbxassetid://15213734194",
    "rbxassetid://15213734060",
    "rbxassetid://15213733826",
    "rbxassetid://15213733725",
    "rbxassetid://15213733624",
    "rbxassetid://15213733511",
    "rbxassetid://15213728584",
    "rbxassetid://15213728465",
    "rbxassetid://15213728375",
    "rbxassetid://15213728250",
    "rbxassetid://15213728111",
    "rbxassetid://15213727976",
    ""
}
local function u6(p3, p4) --[[ Line: 25 ]]
    for _, v5 in pairs(p3:GetDescendants()) do
        if v5:IsA("ParticleEmitter") then
            if v5:GetAttribute("ChangeColor") == true and p4 then
                v5.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, p4), ColorSequenceKeypoint.new(1, p4) })
            end
            _G.customEmit(v5)
        end
    end
end
local u7 = RaycastParams.new()
u7.FilterType = Enum.RaycastFilterType.Include
u7.FilterDescendantsInstances = { workspace.Env, workspace.Islands, workspace.Ships }
local u8 = script
local v9 = {}
local u10 = game:GetService("TweenService")
local u11 = Random.new()
function v9.start(_, u12) --[[ Line: 53 ]]
    --[[
    Upvalues:
        [1] = u8
        [2] = u7
        [3] = u1
        [4] = u11
        [5] = u10
        [6] = u6
        [7] = u2
    --]]
    local u13 = Instance.new("Folder")
    u13.Parent = workspace.Effects
    u13.Name = "EffectsFolder"
    local u14 = u8.FloorWind:Clone()
    local u15 = 0
    local v16 = u15
    local v17 = u15
    local u18 = workspace:Raycast((u12 * CFrame.new(math.cos(v16) * 6, 0, math.sin(v17) * 6)).Position, Vector3.new(0, -10, 0), u7)
    local u19 = false
    local u20 = tick()
    local u21 = nil
    u21 = u1.Heartbeat:Connect(function(p22) --[[ Line: 70 ]]
        --[[
        Upvalues:
            [1] = u18
            [2] = u12
            [3] = u15
            [4] = u7
            [5] = u19
            [6] = u14
            [7] = u13
            [8] = u20
            [9] = u21
        --]]
        local v23 = u15
        local v24 = u15
        u18 = workspace:Raycast((u12 * CFrame.new(math.cos(v23) * 14, 0, math.sin(v24) * 14)).Position, Vector3.new(0, -10, 0), u7)
        if u18 then
            if u19 == false then
                u19 = true
                u14.Parent = u13
                for _, v25 in pairs(u14:GetDescendants()) do
                    if v25:IsA("ParticleEmitter") then
                        v25.Color = ColorSequence.new(u18.Instance.Color)
                        v25.Enabled = true
                    end
                end
            end
            u14.CFrame = CFrame.lookAt(u18.Position, u18.Position + u18.Normal)
        elseif u19 == true and not u18 then
            u19 = false
            for _, v26 in pairs(u14:GetDescendants()) do
                if v26:IsA("ParticleEmitter") then
                    v26.Enabled = false
                end
            end
        end
        u15 = u15 + 12.566370614359172 * p22
        if tick() - u20 >= 0.5 then
            for _, v27 in pairs(u14:GetDescendants()) do
                if v27:IsA("ParticleEmitter") then
                    v27.Enabled = false
                end
            end
            u21:Disconnect()
        end
        task.wait()
    end)
    task.wait(0.8)
    local v28 = tick()
    local v29 = 350
    local v30 = 0.5
    while tick() - v28 <= 1.8 do
        local v31, _, _ = _G.getRayFloor(u12, 9)
        if v31 then
            local u32 = u8.SpinWind:Clone()
            u32.Position = u12.Position
            local v33 = u11:NextNumber(0, 360)
            u32.Orientation = Vector3.new(0, v33, 0)
            u32.Rock.Color = ColorSequence.new(v31.Color)
            u32.Parent = u13
            local v34 = u10
            local v35 = TweenInfo.new(0.7, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
            local v36 = {}
            local v37 = u32.Orientation
            local v38 = u11:NextNumber(v29, v29 + 360)
            v36.Orientation = v37 + Vector3.new(0, v38, 0)
            local v39 = v34:Create(u32, v35, v36)
            v29 = v29 + 20
            task.delay(0.3, function() --[[ Line: 140 ]]
                --[[
                Upvalues:
                    [1] = u32
                --]]
                _G.particleEnabled(u32, false)
            end)
            v39:Play()
            task.delay(0.7, v39.Destroy, v39)
            task.delay(0.7, u32.Destroy, u32)
        end
        local v40 = u8.SwingParticles:Clone()
        v40.CFrame = u12 * CFrame.new(0, -3, 0)
        v40.Parent = u13
        u6(v40)
        for _ = 1, 5 do
            task.spawn(function() --[[ Line: 157 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u12
                    [3] = u11
                    [4] = u10
                    [5] = u13
                    [6] = u2
                --]]
                local v41 = u8.WindSwoosh:Clone()
                v41.CFrame = u12 * CFrame.Angles(0, u11:NextNumber(0, 6.283185307179586), 0) * CFrame.new(0, 5, 0)
                local v42 = u10
                local v43 = TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
                local v44 = {}
                local v45 = v41.Orientation
                local v46 = u11:NextNumber(180, 360)
                v44.Orientation = v45 + Vector3.new(0, v46, 0)
                v44.Position = (v41.CFrame * CFrame.new(0, -u11:NextNumber(8, 10), 0)).Position
                local v47 = v42:Create(v41, v43, v44)
                v47:Play()
                task.delay(0.5, v47.Destroy, v47)
                local v48 = u11:NextNumber(8, 16)
                local v49 = u11:NextNumber(15, 25)
                local v50 = v41.Mesh
                local v51 = u11:NextNumber(13, 17)
                v50.Scale = Vector3.new(v48, v51, v48)
                local v52 = math.random(0, 1)
                v41.Decal.Color3 = Color3.new(v52, v52, v52)
                v41.Decal.Transparency = u11:NextNumber(0.6, 0.9)
                v41.Parent = u13
                local v53 = u10
                local v54 = v41.Mesh
                local v55 = TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
                local v56 = {}
                local v57 = v41.Mesh.Scale.Y
                v56.Scale = Vector3.new(v49, v57, v49)
                local v58 = v53:Create(v54, v55, v56)
                v58:Play()
                task.delay(0.3, v58.Destroy, v58)
                for v59, v60 in pairs(u2) do
                    v41.Decal.Texture = v60
                    local v61 = #u2 * 0.4
                    if v59 == math.round(v61) then
                        local v62 = u10:Create(v41.Decal, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                            ["Transparency"] = 1
                        })
                        v62:Play()
                        task.delay(0.3, v62.Destroy, v62)
                    end
                    task.wait(0.01)
                end
            end)
        end
        v30 = v30 * 0.8
        task.wait(v30)
    end
    task.wait(1)
    local v63 = workspace:Raycast((u12 * CFrame.new(0, -3, -15)).Position + Vector3.new(0, 1, 0), Vector3.new(0, -3, 0), u7)
    if v63 then
        local v64 = v63.Instance.Color
        local v65 = u8.SlamParticles:Clone()
        v65.CFrame = CFrame.lookAt(v63.Position, v63.Position + v63.Normal) * CFrame.Angles(0, 0, u11:NextNumber(0, 6.283185307179586))
        v65.Parent = u13
        u6(v65, v64)
        local u66 = u8.Crack:Clone()
        u66.CFrame = CFrame.lookAt(v63.Position, v63.Position + v63.Normal) * CFrame.Angles(0, 0, u11:NextNumber(0, 6.283185307179586))
        u66.Parent = u13
        task.delay(1.5, function() --[[ Line: 224 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u66
            --]]
            local v67 = u10:Create(u66.Decal, TweenInfo.new(0.7, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                ["Transparency"] = 1
            })
            v67:Play()
            task.delay(0.7, u66.Destroy, u66)
            task.delay(0.7, v67.Destroy, v67)
        end)
        _G.PlayEffect("GroundRocks4", nil, {
            ["Segments"] = 15,
            ["Position"] = v65.Position + Vector3.new(0, 5, 0),
            ["DistanceRandomness"] = Vector2.new(0.5, 1),
            ["Duration"] = 3,
            ["TweenDuration"] = 1,
            ["Radius"] = 10,
            ["Direction"] = Vector3.new(0, -35, 0)
        })
        _G.PlayEffect("RockDebris", nil, {
            ["PartCount"] = 8,
            ["RandomVelocityMagnitude"] = Vector2.new(-25, 25),
            ["Position"] = v65.Position,
            ["Direction"] = Vector3.new(0, 75, 0),
            ["RaycastDirection"] = Vector3.new(0, -5, 0),
            ["Size"] = Vector3.new(0.825, 0.825, 0.825),
            ["TrailEnabled"] = true
        })
    end
    _G.destroy(u13, 4)
end
return v9
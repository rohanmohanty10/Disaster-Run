 

local u1 = game:GetService("TweenService")
local u2 = {}
u2.__index = u2
function u2.new(p3) --[[ Line: 6 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v4 = u2
    local v5 = setmetatable({}, v4)
    v5.Target = p3.Target
    local v6 = Random.new():NextUnitVector()
    local v7 = CFrame.new
    local v8 = v6.X
    local v9 = v6.Y
    local v10 = math.abs(v9)
    local v11 = v6.Z
    v5.Direction = v7(Vector3.new(0, 0, 0), (Vector3.new(v8, v10, v11)))
    v5.Radius = Random.new():NextNumber(100, 250)
    v5.Frames = 100
    v5.Duration = p3.Duration or 2
    v5.Parent = p3.Parent
    v5.Color = p3.Color
    v5.Part = v5:_createPart()
    return v5
end
function u2._createPart(p12) --[[ Line: 24 ]]
    local v13 = Instance.new("Part")
    v13.Anchored = true
    v13.CanCollide = false
    v13.Material = Enum.Material.Neon
    local v14 = Instance.new("SpecialMesh")
    v14.MeshType = Enum.MeshType.Cylinder
    v14.Parent = v13
    v13.Color = p12.Color
    v13.CastShadow = false
    return v13
end
function u2.start(u15) --[[ Line: 40 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local u16 = u15.Duration
    local _ = u15.Frames
    local u17 = u15.Part
    local u18 = Random.new():NextNumber(0.25, 5)
    task.spawn(function() --[[ Line: 48 ]]
        --[[
        Upvalues:
            [1] = u15
            [2] = u17
            [3] = u18
            [4] = u16
            [5] = u1
        --]]
        local v19 = 0
        local v20 = u15.Radius
        local v21 = 3.141592653589793 * v19
        local v22 = v20 * math.sin(v21)
        u17.CFrame = CFrame.fromAxisAngle(Vector3.new(0, 1, 0), v19) * u15.Direction * CFrame.new(0, 0, -(u15.Target.Size.X + v22) / 2) * CFrame.Angles(0, 1.5707963267948966, 0) + u15.Target.Position
        local v23 = u17
        local v24 = 2 * u18
        local v25 = 2 * u18
        v23.Size = Vector3.new(v22, v24, v25)
        u17.Parent = u15.Parent or workspace.Effects
        while v19 <= 1 do
            local v26 = task.wait() / u16
            v19 = v19 + v26
            local v27 = u15.Radius
            local v28 = 3.141592653589793 * v19
            local v29 = v27 * math.sin(v28)
            local v30 = u18 * (1 - v19)
            local v31 = u1
            local v32 = u17
            local v33 = TweenInfo.new(v26, Enum.EasingStyle.Sine)
            local v34 = {
                ["CFrame"] = CFrame.fromAxisAngle(Vector3.new(0, 1, 0), v19) * u15.Direction * CFrame.new(0, 0, -(u15.Target.Size.X + v29) / 2) * CFrame.Angles(0, 1.5707963267948966, 0) + u15.Target.Position
            }
            local v35 = 2 * v30
            local v36 = 2 * v30
            v34.Size = Vector3.new(v29, v35, v36)
            v31:Create(v32, v33, v34):Play()
        end
        u15.Part:Destroy()
    end)
end
return u2
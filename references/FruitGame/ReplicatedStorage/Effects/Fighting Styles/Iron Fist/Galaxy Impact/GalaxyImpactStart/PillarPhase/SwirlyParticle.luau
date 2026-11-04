 

local u1 = game:GetService("TweenService")
local u2 = Random.new()
local u3 = {}
u3.__index = u3
function u3.new(p4) --[[ Line: 7 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    local v5 = u3
    local v6 = setmetatable({}, v5)
    v6.Size = p4.Size or Vector3.new(25, 25, 25)
    v6.Parent = p4.Parent or workspace.Effects
    v6.Color = p4.Color
    v6.Target = p4.Target
    v6.Part = v6:_createPart()
    v6.Frames = 10
    v6.Duration = p4.Duration or 10
    v6.Mult = p4.Mult or 3
    v6.Y = p4.Y
    v6.HeightMult = p4.HeightMult or Random.new():NextNumber(0.025, 0.5)
    v6.Revolutions = p4.Revolutions or u2:NextNumber(0.15, 0.75)
    return v6
end
function u3._createPart(p7) --[[ Line: 26 ]]
    local v8 = script.Part:Clone()
    v8.Anchored = true
    v8.Size = Vector3.new(15, 15, 15)
    v8.Material = Enum.Material.Neon
    v8.Color = p7.Color or v8.Color
    v8.Parent = p7.Parent
    return v8
end
function u3.start(u9) --[[ Line: 37 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local u10 = u9.Alpha or 0
    local u11 = u9.Duration
    local u12 = u9.Frames
    local u13 = u11 / u12
    local u14 = u9.Target
    local u15 = u9.Part
    local u16 = u9.Y or u14.Size.Y * u9.HeightMult
    local u17 = math.random() * 3.141592653589793 * 2
    local u18 = u9.Revolutions
    local u19 = TweenInfo.new(u13, Enum.EasingStyle.Linear)
    task.spawn(function() --[[ Line: 57 ]]
        --[[
        Upvalues:
            [1] = u15
            [2] = u14
            [3] = u9
            [4] = u18
            [5] = u17
            [6] = u16
            [7] = u12
            [8] = u10
            [9] = u13
            [10] = u11
            [11] = u1
            [12] = u19
        --]]
        u15.Size = Vector3.new(0, 0, 0)
        local v20 = u15
        local v21 = u14.Size.X / u9.Mult
        v20.Position = (u9.Target.CFrame * CFrame.Angles(0, u18 * 3.141592653589793 * 0 + u17, 0) * CFrame.new(0, u16 * 0, -v21)).Position
        for v22 = 1, u12 do
            u10 = u13 * v22 / u11
            local v23 = CFrame.new
            local v24 = u10
            local v25 = u14.Size.X / u9.Mult
            local v26 = (u9.Target.CFrame * CFrame.Angles(0, u18 * 3.141592653589793 * v24 + u17, 0) * CFrame.new(0, u16 * v24, -v25)).Position
            local v27 = u10 + u13
            local v28 = u14.Size.X / u9.Mult
            local v29 = v23(v26, (u9.Target.CFrame * CFrame.Angles(0, u18 * 3.141592653589793 * v27 + u17, 0) * CFrame.new(0, u16 * v27, -v28)).Position)
            local v30 = u1
            local v31 = u15
            local v32 = u19
            local v33 = {
                ["CFrame"] = v29
            }
            local v34 = 3.141592653589793 * u10
            v33.Size = math.sin(v34) * u9.Size
            v30:Create(v31, v32, v33):Play()
            task.wait(u13)
        end
        u9.Part:Destroy()
    end)
end
return u3
 

local u1 = game:GetService("TweenService")
local v2 = {}
local function u18(p3) --[[ Line: 4 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    local v4 = p3.Position
    local v5 = p3.Velocity
    local v6 = p3.customModel
    local v7 = p3.AngularVelocity
    local v8 = p3.Size
    local v9 = p3.Material
    local _ = p3.Color
    local u10
    if v6 == nil then
        u10 = Instance.new("Part")
    else
        u10 = v6:Clone()
    end
    if p3.TargetPart == nil then
        u10.Material = v9
        u10.Color = p3.Color
    else
        _G.matchMaterial(u10, p3.TargetPart)
    end
    u10.Size = v8
    local v11 = CFrame.new(v4)
    local v12 = CFrame.Angles
    local v13 = math.random(0, 360)
    local v14 = math.rad(v13)
    local v15 = math.random(0, 360)
    local v16 = math.rad(v15)
    local v17 = math.random(0, 360)
    u10.CFrame = v11 * v12(v14, v16, (math.rad(v17)))
    u10.CollisionGroup = "Players"
    u10.Massless = true
    u10.Parent = workspace.Effects
    u10.AssemblyLinearVelocity = v5
    u10.AssemblyAngularVelocity = v7
    task.delay(p3.Duration or math.random(200, 400) / 100, function() --[[ Line: 36 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u1
        --]]
        _G.particleEnabled(u10, false, nil, {
            ["PointLight"] = true
        })
        u1:Create(u10, TweenInfo.new(1), {
            ["Size"] = Vector3.new(0, 0, 0)
        }):Play()
        _G.destroy(u10, 1)
    end)
    return u10
end
function v2.start(_, ...) --[[ Line: 51 ]]
    --[[
    Upvalues:
        [1] = u18
    --]]
    u18(...)
end
return v2
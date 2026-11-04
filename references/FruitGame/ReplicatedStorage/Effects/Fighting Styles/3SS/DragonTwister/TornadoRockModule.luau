 

local v1 = {}
local u2 = {
    ["SpawnInterval"] = 0.1,
    ["RocksPerInterval"] = 3,
    ["MinRadius"] = 5,
    ["MaxRadius"] = 15,
    ["SpawnHeight"] = 0,
    ["UpwardSpeed"] = 40,
    ["RotationSpeed"] = -250,
    ["SpinSpeed"] = 700,
    ["MaxHeight"] = 25,
    ["RockSize"] = Vector3.new(1, 1, 1),
    ["RandomSizeScale"] = NumberRange.new(0.2, 1)
}
local u3 = game:GetService("TweenService")
local u4 = game:GetService("RunService")
local function u15(p5) --[[ Line: 22 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v6 = math.random() * (u2.RandomSizeScale.Max - u2.RandomSizeScale.Min) + u2.RandomSizeScale.Min
    local v7 = Instance.new("Part")
    v7.Name = "TornadoRock"
    v7.Size = u2.RockSize * v6
    v7.Position = p5
    v7.CastShadow = false
    v7.Anchored = true
    v7.CanCollide = false
    local v8 = CFrame.new(p5)
    local v9 = CFrame.Angles
    local v10 = math.random(0, 360)
    local v11 = math.rad(v10)
    local v12 = math.random(0, 360)
    local v13 = math.rad(v12)
    local v14 = math.random(0, 360)
    v7.CFrame = v8 * v9(v11, v13, (math.rad(v14)))
    v7.Parent = workspace.Effects
    return v7
end
local function u35(u16, p17, p18) --[[ Line: 40 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u4
        [3] = u3
    --]]
    local v19 = math.random() * 360
    local v20 = math.random(u2.MinRadius, u2.MaxRadius)
    math.rad(v19)
    u16.Position = p18
    local v21 = math.random() * 360
    local v22 = math.random() * 360
    local v23 = math.random() * 360
    local v24 = math.random() < 0.5 and -1 or 1
    local v25 = math.random() < 0.5 and -1 or 1
    local v26 = math.random() < 0.5 and -1 or 1
    local v27 = p17.Y + 0.75 * u2.MaxHeight
    local v28 = false
    while p18.Y < p17.Y + u2.MaxHeight do
        local v29 = u4.Heartbeat:Wait()
        v19 = (v19 + u2.RotationSpeed * v29) % 360
        local v30 = math.rad(v19)
        local v31 = p17.X + v20 * math.cos(v30)
        local v32 = p18.Y + u2.UpwardSpeed * v29
        local v33 = p17.Z + v20 * math.sin(v30)
        p18 = Vector3.new(v31, v32, v33)
        u16.Position = p18
        v21 = (v21 + u2.SpinSpeed * v29 * v24) % 360
        v22 = (v22 + u2.SpinSpeed * v29 * v25) % 360
        v23 = (v23 + u2.SpinSpeed * v29 * v26) % 360
        u16.CFrame = CFrame.new(p18) * CFrame.Angles(math.rad(v21), math.rad(v22), (math.rad(v23)))
        if not v28 and v27 <= p18.Y then
            local v34 = u3:Create(u16, TweenInfo.new(0.25), {
                ["Size"] = Vector3.new(0, 0, 0)
            })
            v34:Play()
            v34.Completed:Connect(function() --[[ Line: 82 ]]
                --[[
                Upvalues:
                    [1] = u16
                --]]
                u16:Destroy()
            end)
            v28 = true
        end
    end
    if not v28 then
        u16:Destroy()
    end
end
function v1.startTornado(_, u36, p37) --[[ Line: 93 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u15
        [3] = u35
    --]]
    local v38 = 0
    while u36 and (u36.Parent and (not p37 or p37:IsDescendantOf(game) ~= false)) do
        if tick() - v38 >= u2.SpawnInterval then
            for _ = 1, u2.RocksPerInterval do
                local v39 = math.random() * 360
                local v40 = math.random(u2.MinRadius, u2.MaxRadius)
                local v41 = u36.Position
                local v42 = math.rad(v39)
                local v43 = v40 * math.cos(v42)
                local v44 = u2.SpawnHeight
                local v45 = math.rad(v39)
                local v46 = v40 * math.sin(v45)
                local v47 = v41 + Vector3.new(v43, v44, v46)
                local v48, u49, _ = _G.getRayFloor(CFrame.new(v47), 15 + u2.SpawnHeight)
                if v48 then
                    local u50 = u15(u49)
                    _G.matchMaterial(u50, v48)
                    coroutine.wrap(function() --[[ Line: 112 ]]
                        --[[
                        Upvalues:
                            [1] = u35
                            [2] = u50
                            [3] = u36
                            [4] = u49
                        --]]
                        u35(u50, u36.Position, u49)
                    end)()
                end
            end
            v38 = tick()
        end
        task.wait()
    end
end
return v1
 

local u1 = game:GetService("TweenService")
local u2 = RaycastParams.new()
u2.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
u2.FilterType = Enum.RaycastFilterType.Include
local function u28(p3) --[[ Line: 7 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
    --]]
    local v4 = p3.CFrame
    local v5 = p3.StartSize
    local v6 = p3.EndSize
    local v7 = p3.Side
    local v8 = p3.TiltToggle
    local v9 = p3.WaitDuration
    local v10 = p3.PartDuration
    local v11 = v4.Position
    local v12 = p3.CustomColor
    local v13 = p3.CustomMaterial
    local v14 = p3.Length
    local v15 = 1
    repeat
        local v16 = v5 + (v6 - v5) * v15 / 10
        local v17 = v4 * CFrame.new(0, 0, -v15 * v16.Z / 2)
        v15 = v15 + 1
    until v14 < (v17.Position - v11).Magnitude
    local v18 = p3.HeightCheck or 0
    for v19 = 1, v15 do
        local v20 = v5 + (v6 - v5) * v19 / 10
        local v21 = (v4 * CFrame.new(0, 0, -v19 * v20.Z / 2)).Position
        if v9 ~= 0 then
            task.wait(v9)
        end
        local u22 = workspace:Raycast(v21 + Vector3.new(0, 1, 0) * (v20.Y + 5 + v18), Vector3.new(0, 1, 0) * -(v20.Y + 25 + v18 * 2), u2)
        if u22 then
            local v23 = u22.Instance
            local u24 = script.Part:Clone()
            u24.Size = v20
            _G.matchMaterial(u24, v23)
            if v12 then
                u24.Color = v12
            end
            if v13 then
                u24.Material = v13
            end
            local v25 = v8 and 0 or (Random.new():NextNumber(-90, 90) or 0)
            local v26 = v8 and 0 or (Random.new():NextNumber(-90, 90) or 0)
            local v27 = v8 and v7 * 35 + Random.new():NextNumber(-15, 15) or Random.new():NextNumber(-90, 90)
            u24.CFrame = CFrame.new(u22.Position, u22.Position + u22.Normal:Cross(v4.RightVector)) * CFrame.Angles(math.rad(v25), math.rad(v26), (math.rad(v27)))
            u24.Parent = workspace.Effects
            task.delay(v10 + v19 / v15, function() --[[ Line: 66 ]]
                --[[
                Upvalues:
                    [1] = u1
                    [2] = u24
                    [3] = u22
                --]]
                u1:Create(u24, TweenInfo.new(1), {
                    ["Position"] = u24.Position - u22.Normal * u24.Size.Magnitude
                }):Play()
                task.wait(1)
                u24:Destroy()
            end)
        end
    end
end
return {
    ["start"] = function(_, p29) --[[ Name: start, Line 82 ]]
        --[[
        Upvalues:
            [1] = u28
        --]]
        local v30 = CFrame.new(Vector3.new(0, 0, 0), (Vector3.new(0, 1, 0)):Cross(p29.CFrame.RightVector)) + p29.CFrame.Position
        local v31 = p29.Width
        local v32 = p29.Angle
        local v33 = p29.WaitDuration or 0
        local v34 = p29.PartDuration or 1
        local v35 = p29.StartSize or Vector3.new(1, 1, 1)
        local v36 = p29.EndSize or Vector3.new(1, 1, 1)
        local v37 = p29.Tilt
        local v38 = p29.Length or 10
        if _G.checkRenderDistance(v30.Position) == false then
            return
        else
            task.spawn(u28, {
                ["CFrame"] = v30 * CFrame.new(v31, 0, 0) * CFrame.Angles(0, -math.rad(v32), 0),
                ["StartSize"] = v35,
                ["EndSize"] = v36,
                ["Side"] = 1,
                ["TiltToggle"] = v37,
                ["Length"] = v38,
                ["HeightCheck"] = p29.HeightCheck,
                ["CustomColor"] = p29.CustomColor,
                ["CustomMaterial"] = p29.CustomMaterial,
                ["WaitDuration"] = v33,
                ["PartDuration"] = v34
            })
            if v32 ~= 0 then
                task.spawn(u28, {
                    ["CFrame"] = v30 * CFrame.new(-v31, 0, 0) * CFrame.Angles(0, math.rad(v32), 0),
                    ["StartSize"] = v35,
                    ["EndSize"] = v36,
                    ["Side"] = -1,
                    ["TiltToggle"] = v37,
                    ["Length"] = v38,
                    ["HeightCheck"] = p29.HeightCheck,
                    ["CustomColor"] = p29.CustomColor,
                    ["CustomMaterial"] = p29.CustomMaterial,
                    ["WaitDuration"] = v33,
                    ["PartDuration"] = v34
                })
            end
        end
    end
}
 

local u1 = {}
local u2 = game:GetService("TweenService")
local u3 = Random.new()
local u4 = {
    Enum.NormalId.Back,
    Enum.NormalId.Front,
    Enum.NormalId.Left,
    Enum.NormalId.Right,
    Enum.NormalId.Top,
    Enum.NormalId.Bottom
}
local u5 = script:WaitForChild("Rocks", (1 / 0))
function Apply(p6, p7)
    --[[
    Upvalues:
        [1] = u4
    --]]
    p6.Material = p7.Instance.Material
    p6.Color = p7.Instance.Color
    if p7.Instance:FindFirstChildWhichIsA("Texture") then
        local v8 = p7.Instance:FindFirstChildWhichIsA("Texture")
        for _, v9 in next, u4 do
            local v10 = v8:Clone()
            v10.Face = v9
            v10.Parent = p6
        end
    end
end
local u11 = RaycastParams.new()
u11.FilterType = Enum.RaycastFilterType.Exclude
u11.FilterDescendantsInstances = { workspace.Effects }
local u12 = require(script.Parent:WaitForChild("SharedFunctions", (1 / 0)))
function u1.FlyingParts(p13) --[[ Line: 36 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u3
        [3] = u12
        [4] = u2
    --]]
    local v14 = p13.Rocks
    local v15 = p13.Size
    local v16 = p13.Radius
    local v17 = p13.Position
    for _ = 0, v14 do
        local v18 = workspace:Raycast(v17 + Vector3.new(0, 2.5, 0), Vector3.new(0, -15, 0), u11)
        if v18 and v18.Instance then
            local u19 = script.Part:Clone()
            u19.Anchored = false
            u19.Parent = workspace.Effects
            local v20 = u3:NextNumber(-v16, v16)
            local v21 = u3
            local v22 = -v16
            u19.Position = v17 + Vector3.new(v20, v15, v21:NextNumber(v22, v16))
            u19.Size = Vector3.new(0, 0, 0)
            local v23 = u12.PlayTween
            local v24 = u2
            local v25 = TweenInfo.new(0.2)
            local v26 = {}
            local v27 = u3:NextNumber(p13.Size / 2, p13.Size)
            local v28 = u3:NextNumber(p13.Size / 2, p13.Size)
            local v29 = u3
            local v30 = p13.Size / 2
            local v31 = p13.Size
            v26.Size = Vector3.new(v27, v28, v29:NextNumber(v30, v31))
            v23(v24:Create(u19, v25, v26))
            Apply(u19, v18)
            local v32 = Instance.new("BodyVelocity")
            v32.Parent = u19
            v32.MaxForce = Vector3.new(500000, 500000, 500000)
            local v33 = u3:NextNumber(-p13.Size * 8, p13.Size * 8)
            local v34 = u3:NextNumber(p13.Size * 3, p13.Size * 8)
            local v35 = u3
            local v36 = -p13.Size * 8
            local v37 = p13.Size * 8
            v32.Velocity = Vector3.new(v33, v34, v35:NextNumber(v36, v37))
            u12.AddObject(v32, 0.2)
            local v38 = u3:NextNumber(-15, 15)
            local v39 = u3:NextNumber(-15, 15)
            local v40 = u3
            u19.AssemblyAngularVelocity = Vector3.new(v38, v39, v40:NextNumber(-15, 15))
            task.delay(0.5, function() --[[ Line: 66 ]]
                --[[
                Upvalues:
                    [1] = u12
                    [2] = u2
                    [3] = u19
                --]]
                u12.PlayTween(u2:Create(u19, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {
                    ["Size"] = Vector3.new(0, 0, 0)
                }))
                task.wait(0.5)
                u19:Destroy()
            end)
        end
    end
end
function u1.MessyCrater(p41) --[[ Line: 77 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u1
        [3] = u3
        [4] = u12
        [5] = u2
    --]]
    local v42 = p41.Position
    if typeof(v42) ~= "Vector3" and v42:IsA("BasePart") then
        v42 = v42.Position
    end
    local v43 = p41.Radius
    local v44 = p41.Interval
    local v45 = p41.Parts
    local v46 = p41.Size
    local v47 = workspace:Raycast(v42, Vector3.new(0, -25, 0), u11)
    if v47 and v47.Instance then
        v42 = v47.Position + Vector3.new(0, 1, 0)
    end
    if p41.FlyingParts then
        u1.FlyingParts({
            ["Rocks"] = p41.FlyingParts,
            ["Size"] = p41.Size,
            ["Radius"] = v43,
            ["Position"] = v42
        })
    end
    local v48 = 360 / v45
    local v49 = 0
    for v50 = 1, v45 do
        if v50 % v44 == 0 then
            local v51 = CFrame.new(v42) * CFrame.Angles(0, math.rad(v49), 0) * CFrame.new(0, 0, -v43)
            local v52 = workspace:Raycast(v51.Position, Vector3.new(0, -100, 0), u11)
            if v52 then
                local v53 = CFrame.new(v52.Position) * CFrame.Angles(u3:NextNumber(-360, 360), u3:NextNumber(-360, 360), u3:NextNumber(-360, 360))
                local u54 = script.Part:Clone()
                Apply(u54, v52)
                u54.CFrame = v53
                u54.Size = Vector3.new(v46, v46, v46)
                u54.Parent = workspace.Effects
                task.delay(u3:NextNumber(1.5, 2), function() --[[ Line: 113 ]]
                    --[[
                    Upvalues:
                        [1] = u12
                        [2] = u2
                        [3] = u54
                        [4] = u3
                    --]]
                    u12.PlayTween(u2:Create(u54, TweenInfo.new(u3:NextNumber(0.65, 1.2)), {
                        ["Size"] = Vector3.new(0, 0, 0)
                    }))
                    u12.AddObject(u54, 1.2)
                end)
            end
        end
        v49 = v49 + v48
    end
end
function u1.OrganizedCrater(p55) --[[ Line: 124 ]]
    --[[
    Upvalues:
        [1] = u11
        [2] = u1
        [3] = u3
        [4] = u5
        [5] = u12
        [6] = u2
    --]]
    local v56 = p55.Position
    if typeof(v56) ~= "Vector3" and v56:IsA("BasePart") then
        v56 = v56.Position
    end
    local v57 = p55.Radius
    local v58 = p55.Parts
    local _ = p55.Size
    local v59 = workspace:Raycast(v56, Vector3.new(0, -25, 0), u11)
    if v59 and v59.Instance then
        v56 = v59.Position + Vector3.new(0, 1, 0)
    end
    if p55.FlyingParts then
        u1.FlyingParts({
            ["Rocks"] = p55.FlyingParts,
            ["Size"] = p55.Size,
            ["Radius"] = v57,
            ["Position"] = v56
        })
    end
    local v60 = 360 / v58
    local v61 = 0
    for _ = 1, v58 do
        local v62 = CFrame.new(v56 + Vector3.new(0, 1, 0)) * CFrame.Angles(0, math.rad(v61), 0) * CFrame.new(0, 0, -u3:NextNumber(v57 - 1, v57 + 1))
        local v63 = workspace:Raycast(v62.Position, Vector3.new(0, -100, 0), u11)
        if v63 then
            local u64 = u5[math.random(#u5:GetChildren())]:Clone()
            local v65 = CFrame.new
            local v66 = v63.Position
            local v67 = u64.Rock.Size.Y / 2 + u64.Surface.Size.Y / 2 - 1
            local v68 = v65(v66 - Vector3.new(0, v67, 0), v56) * CFrame.Angles(u3:NextNumber(-0.45, -0.1), u3:NextNumber(-0.15, 0.15), u3:NextNumber(-0.15, 0.15))
            Apply(u64.Surface, v63)
            local v69 = v63.Instance.Color
            u64.Rock.Color = Color3.new(0.647059 + v69.R / 10, 0.635294 + v69.G / 10, 0.584314 + v69.B / 10)
            u64:SetPrimaryPartCFrame(v68)
            u64.Parent = workspace.Effects
            task.delay(u3:NextNumber(1.5, 2), function() --[[ Line: 159 ]]
                --[[
                Upvalues:
                    [1] = u3
                    [2] = u12
                    [3] = u2
                    [4] = u64
                --]]
                local v70 = u3:NextNumber(0.65, 1.2)
                u12.PlayTween(u2:Create(u64.Rock, TweenInfo.new(v70), {
                    ["CFrame"] = u64.Rock.CFrame * CFrame.new(0, -u64.Rock.Size.Y, 0)
                }))
                u12.PlayTween(u2:Create(u64.Surface, TweenInfo.new(v70), {
                    ["CFrame"] = u64.Surface.CFrame * CFrame.new(0, -u64.Surface.Size.Y, 0)
                }))
                u12.AddObject(u64, v70)
            end)
        end
        v61 = v61 + v60
    end
end
return u1
 

game:GetService("RunService")
Emit = _G.Emit
Tween = _G.Ess.Tween
BeamToggle = _G.Ess.BeamToggle
local v1 = {}
local function u8(p2, p3, _) --[[ Line: 20 ]]
    local v4 = p2.Position
    local v5 = p2.LookVector:Cross(p3).Unit
    local v6 = (v5.Magnitude > 0.001 and v5 and v5 or p2.RightVector).Unit
    local v7 = v6:Cross(p3).Unit.Unit
    return CFrame.fromMatrix(v4, v6, p3, v7)
end
function v1.start(_, p9, p10, u11) --[[ Line: 49 ]]
    --[[
    Upvalues:
        [1] = u8
    --]]
    if _G.checkRenderDistance(p10) == false then
        return
    end
    Random.new()
    local v12 = p9:FindFirstChildWhichIsA("Humanoid")
    if v12 == nil then
        return
    end
    local v13 = v12.RootPart
    local u14 = TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)
    local u15 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local u16 = TweenInfo.new(0.15, Enum.EasingStyle.Cubic, Enum.EasingDirection.In)
    local u17 = TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut)
    TweenInfo.new(0.15, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
    local v18 = v13.Position
    local v19 = CFrame.new(v18, p10)
    local v20 = CFrame.new(p10, v19.Position)
    local v21 = (v19.Position - v20.Position).Magnitude
    local v22 = workspace:Raycast(v19.Position, v19.LookVector * (v21 + 5), _G.Ess.RaycastParams)
    local v23 = not v22 and Vector3.new(0, 1, 0) or v22.Normal
    local u24
    if p10 and v22 ~= nil then
        u24 = v22.Position
    else
        u24 = p10
    end
    local v25 = workspace:Raycast(p10 + Vector3.new(0, 5, 0), Vector3.new(0, -25, 0), _G.Ess.RaycastParams)
    if v22 and v25 then
        v23 = v25.Normal
    end
    if v22 and v25 then
        u24 = v25.Position
    end
    local _ = v25.Instance
    local u26 = script.Hand.PrimaryPart.Size.Y
    local u27 = script.Shadow:Clone()
    u27.CFrame = CFrame.new(u24, u24 + v23) * CFrame.Angles(-1.5707963267948966, 0, 0)
    u27.Parent = u11
    local v28 = u8
    local v29 = CFrame.new
    local v30 = p9.PrimaryPart.Position.X
    local v31 = u24.Y
    local v32 = p9.PrimaryPart.Position.Z
    local u33 = v28(v29(u24, (Vector3.new(v30, v31, v32))), v23) * CFrame.Angles(0, -1.5707963267948966, 0) * CFrame.new(3, 0, 0)
    u27.burst.WorldCFrame = u33
    u27.Attachment.WorldCFrame = u27.burst.WorldCFrame
    _G.PlaySound(u11.PrimaryPart, script.summon)
    for _, v34 in u27:GetDescendants() do
        if v34:IsA("Attachment") and (v34.Name ~= "Attachment" and (v34.Name ~= "burst" and v34.Name ~= "start")) then
            v34.Position = Vector3.new()
        end
    end
    task.wait()
    local v35 = nil
    local v36 = v35 == nil and "LMiddlePart1.001" or v35
    local v37 = u11:GetDescendants()
    local u38 = nil
    for v39 = 1, #v37 do
        if v37[v39].Name == v36 then
            u38 = v37[v39]
            break
        end
    end
    tick()
    task.delay(0.2, function() --[[ Line: 121 ]]
        --[[
        Upvalues:
            [1] = u27
            [2] = u17
            [3] = u14
            [4] = u33
            [5] = u15
            [6] = u11
            [7] = u24
            [8] = u38
            [9] = u16
            [10] = u26
        --]]
        Emit(u27.Attachment:GetDescendants(), false)
        Emit({ u27.bat }, false)
        task.delay(u17.Time, function() --[[ Line: 126 ]]
            --[[
            Upvalues:
                [1] = u27
                [2] = u14
                [3] = u33
                [4] = u15
                [5] = u11
                [6] = u24
                [7] = u38
                [8] = u16
                [9] = u26
            --]]
            Emit(u27.burst:GetChildren(), true)
            local v40 = {
                ["WorldCFrame"] = u33
            }
            Tween(u27.Attachment, u14, v40)
            task.delay(u15.Time + 0.25, function() --[[ Line: 138 ]]
                --[[
                Upvalues:
                    [1] = u11
                    [2] = u24
                    [3] = u38
                    [4] = u16
                    [5] = u26
                    [6] = u27
                --]]
                _G.PlaySound(u11.PrimaryPart, script.hit)
                _G.shakenear(u24, 75, 75, 90, -0.5)
                local v41, v42, v43 = _G.getRayFloor(u38.TransformedWorldCFrame * CFrame.new(0, 0, 15), 25)
                if v41 then
                    local v44 = script.Impact:Clone()
                    v44.CFrame = CFrame.new(v42, v42 + v43) * CFrame.Angles(-1.5707963267948966, 0, 0)
                    v44.Attachment.sm2.Color = ColorSequence.new(v41.Color)
                    v44.Attachment.sm3.Color = ColorSequence.new(v41.Color)
                    v44.Attachment.Rocks.Color = v44.Attachment.sm2.Color
                    v44.Parent = workspace.Effects
                    _G.destroy(v44, 3)
                    _G.customEmit(v44)
                end
                task.wait(u16.Time + 0.25)
                task.wait(0.1)
                Tween(u11.PrimaryPart, u16, {
                    ["CFrame"] = u11.PrimaryPart.CFrame * CFrame.new(0, -(u26 / 2 + 15), 0),
                    ["Size"] = u11.PrimaryPart.Size * Vector3.new(0.65, 0, 1)
                })
                Emit(u27.Attachment:GetDescendants(), false)
                Emit(u27.burst:GetChildren(), true)
                _G.destroy(u11, 0.4)
            end)
        end)
    end)
end
return v1
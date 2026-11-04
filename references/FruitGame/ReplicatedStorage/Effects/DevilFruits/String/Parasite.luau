 

local v1 = {}
local u2 = game:GetService("TweenService")
game:GetService("RunService")
local u3 = { "RightHand", "LeftHand", "UpperTorso" }
function v1.start(_, p4, p5) --[[ Line: 12 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    if _G.checkRenderDistance(p4.PrimaryPart.Position) == false then
        return
    elseif p4:FindFirstChild("RightHand") ~= nil then
        local v6 = script.Origin:Clone()
        local v7 = CFrame.new(p4.HumanoidRootPart.Position) * CFrame.new(0, 15, 0)
        local v8 = CFrame.Angles
        local v9 = math.random(0, 360)
        local v10 = math.rad(v9)
        local v11 = math.random(0, 360)
        local v12 = math.rad(v11)
        local v13 = math.random(0, 360)
        v6.CFrame = v7 * v8(v10, v12, (math.rad(v13)))
        v6.Parent = workspace.Effects
        local u14 = {}
        for v15 = 1, 3 do
            local v16 = script.Beam:Clone()
            local v17 = Instance.new("Attachment")
            local v18 = p4[u3[v15]]
            table.insert(u14, v16)
            v16.Parent = v6
            v17.Parent = v18
            v17.Position = v18.Position - v6.Position
            local v19 = math.rad(0, 360)
            local v20 = math.rad(0, 360)
            local v21 = math.rad(0, 360)
            v17.Orientation = Vector3.new(v19, v20, v21)
            v16.Attachment0 = v6.Attachment
            v16.Attachment1 = v17
            v17.WorldCFrame = v6.CFrame
            u2:Create(v16, TweenInfo.new(1, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
                ["CurveSize0"] = 0,
                ["CurveSize1"] = 0
            }):Play()
            _G.tween(v17, { 0.1, "Quad", Enum.EasingDirection.Out }, {
                ["Position"] = Vector3.new(0, 0, 0)
            })
            _G.destroy(v17, p5 + 1)
        end
        _G.destroy(v6, 3)
        task.delay(p5, function() --[[ Line: 40 ]]
            --[[
            Upvalues:
                [1] = u14
                [2] = u2
            --]]
            for _, v22 in u14 do
                _G.tween(v22, { 0.1, "Quad", Enum.EasingDirection.Out }, {
                    ["CurveSize0"] = 5,
                    ["CurveSize1"] = 5
                })
                _G.tween(v22, { 0.5, "Quad", Enum.EasingDirection.Out }, {
                    ["Transparency"] = NumberSequence.new(1)
                })
            end
            task.wait(0.1)
            for _, v23 in u14 do
                u2:Create(v23, TweenInfo.new(1, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
                    ["CurveSize0"] = 0,
                    ["CurveSize1"] = 0
                }):Play()
            end
        end)
    end
end
return v1
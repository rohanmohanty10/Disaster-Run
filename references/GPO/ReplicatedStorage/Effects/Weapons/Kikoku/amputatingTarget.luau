 

local v1 = {}
local u2 = game:GetService("TweenService")
function v1.start(_, u3, u4, u5, u6) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(u6.PrimaryPart.Position) then
        local u7 = script.Parent.amputatingCleave
        local _ = u3.LowerTorso.CFrame
        local u8 = u7.cutPart:Clone()
        u8.CFrame = u3.UpperTorso.CFrame
        u8.Parent = workspace.Effects
        _G.customEmit(u8.hitAttach, true)
        _G.destroy(u8, 4)
        local u9 = {
            u8.floatAttach.flareFill,
            u8.floatAttach.waveFill,
            u8.floatAttach.glowFill,
            u8.floatAttach.impulseFill,
            u8.lightning2
        }
        u8.Anchored = true
        _G.customWeld(u8, u3.UpperTorso, CFrame.new(), u8)
        for _ = 1, 3 do
            local v10 = Instance.new("Attachment")
            local v11 = Random.new():NextNumber(-u3.UpperTorso.Size.X / 2, u3.UpperTorso.Size.X / 2)
            local v12 = Random.new():NextNumber(-u3.UpperTorso.Size.Y / 2, u3.UpperTorso.Size.Y / 2)
            local v13 = Random.new()
            local v14 = -u3.UpperTorso.Size.Z / 2
            local v15 = u3.UpperTorso.Size.Z / 2
            v10.Position = Vector3.new(v11, v12, v13:NextNumber(v14, v15))
            local v16 = Random.new():NextNumber(-3.141592653589793, 3.141592653589793)
            local v17 = Random.new():NextNumber(-3.141592653589793, 3.141592653589793)
            local v18 = Random.new()
            v10.Orientation = Vector3.new(v16, v17, v18:NextNumber(-3.141592653589793, 3.141592653589793))
            v10.Parent = u3.UpperTorso
            local v19 = Instance.new("Attachment")
            local v20 = Random.new():NextNumber(-u3.LowerTorso.Size.X / 2, u3.LowerTorso.Size.X / 2)
            local v21 = Random.new():NextNumber(-u3.LowerTorso.Size.Y / 2, u3.LowerTorso.Size.Y / 2)
            local v22 = Random.new()
            local v23 = -u3.LowerTorso.Size.Z / 2
            local v24 = u3.LowerTorso.Size.Z / 2
            v19.Position = Vector3.new(v20, v21, v22:NextNumber(v23, v24))
            local v25 = Random.new():NextNumber(-3.141592653589793, 3.141592653589793)
            local v26 = Random.new():NextNumber(-3.141592653589793, 3.141592653589793)
            local v27 = Random.new()
            v19.Orientation = Vector3.new(v25, v26, v27:NextNumber(-3.141592653589793, 3.141592653589793))
            v19.Parent = u3.LowerTorso
            for _, v28 in pairs(u7.cutBeams:GetChildren()) do
                local u29 = v28:Clone()
                u29.Attachment0 = v10
                u29.Attachment1 = v19
                u29.CurveSize0 = Random.new():NextNumber(-3, 3)
                u29.CurveSize1 = Random.new():NextNumber(-3, 3)
                u29.Parent = u3
                _G.destroy(u29, 2)
                local u30 = Random.new():NextNumber(0.15, 0.4)
                local v31 = Random.new():NextNumber(10, 15)
                u2:Create(u29, TweenInfo.new(u30, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    ["Width0"] = u29.Width0 * v31,
                    ["Width1"] = u29.Width0 * v31
                }, true):Play()
                task.delay(u30, function() --[[ Line: 56 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u29
                        [3] = u30
                    --]]
                    u2:Create(u29, TweenInfo.new(0.4 + u30, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut), {
                        ["Width0"] = 0,
                        ["Width1"] = 0
                    }, true):Play()
                end)
            end
        end
        for _, v32 in pairs(u9) do
            v32.Enabled = true
            u2:Create(v32, TweenInfo.new(0.9, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
                ["Rate"] = v32.Rate * 100
            }, true):Play()
        end
        task.delay(0.6, function() --[[ Line: 72 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u7
                [3] = u4
                [4] = u6
                [5] = u9
                [6] = u5
                [7] = u8
            --]]
            task.wait(0.6)
            local v33 = script.Part:Clone()
            v33.CFrame = u3.UpperTorso.CFrame
            v33.Parent = workspace.Effects
            _G.customEmit(v33.squeezeAttach)
            _G.destroy(v33, 5)
            local v34 = u7.launchPart:Clone()
            v34.CFrame = CFrame.new(u3.UpperTorso.Position, u4.Position)
            v34.Parent = workspace.Effects
            _G.destroy(v34, 3)
            _G.customEmit(v34, true)
            local v35 = u7.bodyPart:Clone()
            v35.CFrame = u6.PrimaryPart.CFrame
            v35.Parent = workspace.Effects
            _G.customEmit(v35.hitAttach, true)
            _G.destroy(v35, 4)
            for _, v36 in pairs(u9) do
                v36.Enabled = false
            end
            task.wait(u5)
            _G.customEmit(u8.hitAttach, true)
        end)
    end
end
return v1
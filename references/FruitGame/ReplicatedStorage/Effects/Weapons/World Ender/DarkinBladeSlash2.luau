 

local v1 = {}
local u2 = _G.Ess.Tween
local u3 = _G.Emit
local function u10(p4, p5, _) --[[ Line: 5 ]]
    local v6 = p4.Position
    local v7 = p4.LookVector:Cross(p5).Unit
    local v8 = (v7.Magnitude > 0.001 and v7 and v7 or p4.RightVector).Unit
    local v9 = v8:Cross(p5).Unit.Unit
    return CFrame.fromMatrix(v6, v8, p5, v9)
end
function v1.start(_, p11) --[[ Line: 15 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u2
        [3] = u3
    --]]
    if _G.checkRenderDistance(p11.Position) ~= false then
        local v12 = Random.new()
        _G.PlaySound(p11, script.slashsfx)
        task.wait(0.2)
        local v13 = v12:NextInteger(-25, 25)
        math.rad(v13)
        local u14 = script.Slash:Clone()
        local u15 = script.Hit:Clone()
        local v16, v17, v18 = _G.getRayFloor(p11, 5)
        if v16 then
            u15.mid2.Rocks.Color = ColorSequence.new(v16.Color)
        else
            u15.mid2.Rocks.Transparency = NumberSequence.new(1)
        end
        local v19 = v18 == Vector3.new() and Vector3.new(0, 1, 0) or v18
        u14.CFrame = p11 * CFrame.new(0, 1.6, 0) * CFrame.fromOrientation(0.017453292519943295, 4.537856055185257, 0.08726646259971647)
        local v20 = u10(CFrame.new(Vector3.new(), p11.LookVector) + v17, v19)
        u14.Parent = workspace.Effects
        local v21 = CFrame.new(24, 0, -15)
        local u22 = u15.Ground
        u22.CFrame = v20 * v21 * CFrame.Angles(0, 1.5707963267948966, 0)
        u22.Size = u22.Size * Vector3.new(0.65, 1, 0)
        u15.CFrame = v20 * CFrame.new(-6, 0.65, 0) * v21
        u15.Parent = workspace.Effects
        task.delay(0.1, function() --[[ Line: 53 ]]
            --[[
            Upvalues:
                [1] = u15
                [2] = u2
                [3] = u22
                [4] = u3
            --]]
            _G.PlaySound(u15, script.boom)
            local v23 = u15.Attachment.PointLight
            v23.Enabled = true
            u2(v23, TweenInfo.new(0.35, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut, 0, false), {
                ["Brightness"] = 0
            })
            local v24 = script.Part2:Clone()
            v24.CFrame = u22.CFrame * CFrame.new(0, 0, -5)
            v24.Parent = workspace.Effects
            _G.PlayEffect("RockFollow", nil, v24, 0.9, 1.25)
            _G.tween(v24, {
                0.4,
                Enum.EasingStyle.Linear,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = u22.CFrame * CFrame.new(0, 0, -40)
            })
            _G.destroy(v24, 2)
            for _, v25 in u22:GetChildren() do
                _G.tween(v25, {
                    0.9,
                    Enum.EasingStyle.Exponential,
                    Enum.EasingDirection.In,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 1
                })
            end
            _G.tween(u22, {
                0.4,
                Enum.EasingStyle.Cubic,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = u22.CFrame * CFrame.new(0, 0, -25),
                ["Size"] = u22.Size + Vector3.new(5, 0, 40)
            })
            for _, v26 in u15.TrailTop:GetChildren() do
                _G.tween(v26, {
                    0.35,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.InOut,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = NumberSequence.new(1)
                })
            end
            _G.tween(u15, {
                0.4,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = u15.CFrame * CFrame.new(-36, 0, 0)
            })
            u3(u15:GetDescendants(), false, 0.2)
        end)
        task.delay(0.3, function() --[[ Line: 121 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u14
            --]]
            u2(u14.Black2, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false), {
                ["Transparency"] = 1
            })
            u2(u14.Black1, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false), {
                ["Transparency"] = 1
            })
            u2(u14.Colored, TweenInfo.new(0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false), {
                ["Transparency"] = 1
            })
        end)
        _G.tween(u14, {
            0.3,
            "Sine",
            Enum.EasingDirection.InOut,
            0,
            false,
            0
        }, {
            ["CFrame"] = u14.CFrame * CFrame.fromEulerAnglesXYZ(0.17453292519943295, 3.138454199390403, 0)
        })
        _G.destroy(u14, 0.8)
        _G.destroy(u15, 1.25)
    end
end
return v1
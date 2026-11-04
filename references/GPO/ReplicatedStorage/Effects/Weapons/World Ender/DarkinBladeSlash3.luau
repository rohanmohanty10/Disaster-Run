 

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
function v1.start(_, p11, _, _) --[[ Line: 15 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u3
        [3] = u2
    --]]
    if _G.checkRenderDistance(p11.Position) ~= false then
        Random.new()
        _G.PlaySound(p11, script.slashsfx)
        task.wait(0.2)
        local u12 = script.Slash:Clone()
        local u13 = script.Hit:Clone()
        local v14, v15, v16 = _G.getRayFloor(p11, 5)
        if v14 then
            u13.mid2.Rocks.Color = ColorSequence.new(v14.Color)
        else
            u13.mid2.Rocks.Transparency = NumberSequence.new(1)
        end
        local v17 = v16 == Vector3.new() and Vector3.new(0, 1, 0) or v16
        u12:PivotTo(p11 * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 1.5533430342749532))
        u13.CFrame = u10(CFrame.new(Vector3.new(), p11.LookVector) + v15, v17) * CFrame.new(0, 0.1, -19)
        u12.Parent = workspace.Effects
        u13.Parent = workspace.Effects
        task.delay(0.2, function() --[[ Line: 44 ]]
            --[[
            Upvalues:
                [1] = u13
                [2] = u3
            --]]
            _G.PlaySound(u13, script.boom)
            _G.tween(u13.PointLight, {
                0.1,
                Enum.EasingStyle.Cubic,
                Enum.EasingDirection.Out,
                0,
                true
            }, {
                ["Color"] = Color3.new(0.987213, 0.221912, 0.0289769),
                ["Brightness"] = 60,
                ["Range"] = 25
            })
            for _, u18 in u13.Ground:GetChildren() do
                _G.tween(u18, {
                    0.25,
                    Enum.EasingStyle.Sine,
                    Enum.EasingDirection.In,
                    0,
                    false
                }, {
                    ["Transparency"] = 0,
                    ["Color3"] = Color3.new(0, 0, 0)
                })
                task.delay(1, function() --[[ Line: 58 ]]
                    --[[
                    Upvalues:
                        [1] = u18
                    --]]
                    _G.tween(u18, {
                        0.6,
                        Enum.EasingStyle.Cubic,
                        Enum.EasingDirection.InOut,
                        0,
                        false,
                        0
                    }, {
                        ["Transparency"] = 1
                    })
                end)
            end
            u3(u13:GetDescendants(), true)
        end)
        task.delay(0.1, function() --[[ Line: 75 ]]
            --[[
            Upvalues:
                [1] = u2
                [2] = u12
            --]]
            u2(u12.Black2, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false), {
                ["Transparency"] = 1
            })
            u2(u12.Black1, TweenInfo.new(0.22727272727272727, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false), {
                ["Transparency"] = 1
            })
            u2(u12.Colored, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false), {
                ["Transparency"] = 1
            })
        end)
        _G.tween(u12, {
            0.25,
            "Cubic",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = u12.CFrame * CFrame.new(0, 0, 8) * CFrame.Angles(0, 3.141592653589793, 0)
        })
        _G.destroy(u12, 0.5)
        _G.destroy(u13, 3)
    end
end
return v1
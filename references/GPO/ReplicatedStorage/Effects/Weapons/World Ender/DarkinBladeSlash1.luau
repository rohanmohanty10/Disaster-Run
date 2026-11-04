 

local v1 = {}
local u2 = _G.Emit
local u3 = _G.Ess.Tween
local function u10(p4, p5, _) --[[ Line: 6 ]]
    local v6 = p4.Position
    local v7 = p4.LookVector:Cross(p5).Unit
    local v8 = (v7.Magnitude > 0.001 and v7 and v7 or p4.RightVector).Unit
    local v9 = v8:Cross(p5).Unit.Unit
    return CFrame.fromMatrix(v6, v8, p5, v9)
end
function v1.start(_, p11, _) --[[ Line: 16 ]]
    --[[
    Upvalues:
        [1] = u10
        [2] = u3
        [3] = u2
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
            u15.Rocks.Color = ColorSequence.new(v16.Color)
        else
            u15.Rocks.Transparency = NumberSequence.new(1)
        end
        local v19 = v18 == Vector3.new() and Vector3.new(0, 1, 0) or v18
        u14:PivotTo(p11 * CFrame.Angles(0, 3.141592653589793, 1.5533430342749532))
        u15.CFrame = u10(CFrame.new(Vector3.new(), p11.LookVector) + v17, v19) * CFrame.new(0, 0, -15)
        u14.Parent = workspace.Effects
        u15.Parent = workspace.Effects
        task.delay(0.225, function() --[[ Line: 45 ]]
            --[[
            Upvalues:
                [1] = u15
                [2] = u3
                [3] = u2
            --]]
            _G.PlaySound(u15, script.boom)
            u3(u15.PointLight, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, true), {
                ["Color"] = Color3.new(0.9879, 0.299229, 0.0301061),
                ["Brightness"] = 30,
                ["Range"] = 20
            })
            local v20 = script.Part2:Clone()
            v20.CFrame = u15.A1.WorldCFrame
            v20.Parent = workspace.Effects
            _G.PlayEffect("RockFollow", nil, v20, 0.1, 1.25)
            _G.tween(v20, {
                0.2,
                Enum.EasingStyle.Linear,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = u15.A2.WorldCFrame
            })
            _G.destroy(v20, 2)
            for _, u21 in u15.Ground:GetChildren() do
                u3(u21, TweenInfo.new(0.45, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false), {
                    ["Transparency"] = 0,
                    ["Color3"] = Color3.new(0, 0, 0)
                })
                task.delay(0.45, function() --[[ Line: 68 ]]
                    --[[
                    Upvalues:
                        [1] = u3
                        [2] = u21
                    --]]
                    u3(u21, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut, 0, false, 0), {
                        ["Transparency"] = 1
                    })
                end)
            end
            u2(u15:GetDescendants(), true)
        end)
        task.delay(0.1, function() --[[ Line: 82 ]]
            --[[
            Upvalues:
                [1] = u3
                [2] = u14
            --]]
            u3(u14.Black2, TweenInfo.new(0.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, 0, false), {
                ["Transparency"] = 1
            })
            u3(u14.Black1, TweenInfo.new(0.22727272727272727, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, false), {
                ["Transparency"] = 1
            })
            u3(u14.Colored, TweenInfo.new(0.25, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false), {
                ["Transparency"] = 1
            })
        end)
        _G.tween(u14, {
            0.25,
            "Cubic",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["CFrame"] = u14.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
        })
        _G.destroy(u14, 0.5)
        _G.destroy(u15, 1.6)
    end
end
return v1
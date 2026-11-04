 

local u1 = script
local v2 = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local _ = workspace.Effects
game:GetService("Debris")
game:GetService("TweenService")
local u3 = require(v2.Modules.EffectsUtil)
local v4 = {}
local u5 = Random.new()
function v4.start(_, p6, u7) --[[ Line: 14 ]]
    --[[
    Upvalues:
        [1] = u1
        [2] = u5
        [3] = u3
    --]]
    if _G.checkRenderDistance(p6.PrimaryPart.Position) ~= false then
        local u8 = p6.HumanoidRootPart
        _G.PlaySound(u8, script.DragonDashGrabStart).Parent = u8
        local v9 = u1.Lines:Clone()
        v9.Parent = workspace.Effects
        v9.CFrame = u8.CFrame * CFrame.Angles(0, 3.141592653589793, 0)
        local u10 = u1.Particles.Attachment:Clone()
        u10.Parent = u8
        if u7 == false then
            u10.yellow.Enabled = false
            u10.smoke.Enabled = false
            u10.ColorLines.Enabled = true
            v9.ColorLines.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
        end
        task.spawn(function() --[[ Line: 35 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u1
                [3] = u8
            --]]
            for _ = 1, 7 do
                for _ = 1, 2 do
                    local v11 = u5:NextNumber(2, 3)
                    local v12 = u1.WindSide:Clone()
                    v12.Parent = workspace.Effects
                    local v13 = v12.Mesh
                    local v14 = v13.Scale
                    local v15 = v11 * 0.5
                    local v16 = u5
                    v13.Scale = v14 * Vector3.new(v11, v15, v16:NextNumber(0.75, 1.75))
                    v12.CFrame = u8.CFrame * CFrame.new(0, v11 * -0.25, u5:NextNumber(-0, 3)) * CFrame.Angles(0, -1.5707963267948966, 0) * CFrame.Angles(3.141592653589793, 0, 0)
                    _G.tween(v12.Mesh, { u5:NextNumber(1, 1.5), "Quart", Enum.EasingDirection.Out }, {
                        ["Scale"] = v12.Mesh.Scale * Vector3.new(2, 1, 1.25)
                    })
                    _G.tween(v12, { u5:NextNumber(1, 2), "Quart", Enum.EasingDirection.Out }, {
                        ["CFrame"] = v12.CFrame * CFrame.new(v12.Mesh.Scale.X * 0.25, 0, 0)
                    })
                    _G.tween(v12.Decal, { u5:NextNumber(0.7, 1.5), "Sine", Enum.EasingDirection.Out }, {
                        ["Transparency"] = 1
                    })
                    _G.destroy(v12, 2)
                end
                task.wait(0.02)
            end
        end)
        u3:Emit(v9)
        _G.destroy(v9, 2)
        task.spawn(function() --[[ Line: 54 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u3
                [3] = u10
            --]]
            task.wait(u7 and 0.5 or 0.4)
            u3:ToggleEnabled(u10, false)
            _G.destroy(u10, 3)
        end)
    end
end
return v4
 

local v1 = {}
local u2 = game:GetService("RunService").Heartbeat
function v1.start(_, p3, p4, p5, p6, p7) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(p3.HumanoidRootPart.Position) then
        if p6 == nil then
            _G.PlaySound(p3.HumanoidRootPart, script.Pistol)
        else
            _G.PlaySound(p3.HumanoidRootPart, script.rocket)
        end
        p3:WaitForChild("GumRight", 3)
        local u8 = p4 * 0.5
        local _ = p3.GumRight.targetAttachment.WorldCFrame.Position
        local u9 = p5 * CFrame.Angles(1.5707963267948966, 0, 0)
        if p3 == game.Players.LocalPlayer then
            local _ = p6 == nil
        end
        if p7 then
            u9 = CFrame.new(p3.RightHand.Position, p7.Position) * CFrame.Angles(1.5707963267948966, 0, 0)
        end
        local v10 = u8 / 20
        local v11 = math.clamp(v10, 13, 30)
        local v12 = u8 / 10
        local v13 = math.clamp(v12, 1, 10)
        local v14 = u8 / 20
        local u15 = u8 / 2
        task.spawn(function() --[[ Line: 41 ]]
            --[[
            Upvalues:
                [1] = u9
                [2] = u15
                [3] = u8
                [4] = u2
            --]]
            local u16 = script.pistol:Clone()
            u16:SetPrimaryPartCFrame(u9 * CFrame.Angles(-1.5707963267948966, 0, 0))
            u16.Parent = workspace.Effects
            _G.tween(u16.Ring, {
                0.4,
                "EntranceExpressive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = u16.Ring.CFrame * CFrame.new(0, -9, 0),
                ["Size"] = Vector3.new(14, 0, 14),
                ["Transparency"] = 1
            })
            local v17 = _G.tween
            local v18 = u16.Sharp
            local v19 = {
                0.2,
                "EntranceExpressive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v20 = {
                ["CFrame"] = u16.Sharp.CFrame * CFrame.new(-u15 * 2, 0, 0)
            }
            local v21 = u8 * 2
            v20.Size = Vector3.new(v21, 0, 0)
            v20.Transparency = 1
            v17(v18, v19, v20)
            local v22 = _G.tween
            local v23 = u16.Shock
            local v24 = {
                0.1,
                "EntranceExpressive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v25 = {
                ["CFrame"] = u16.Shock.CFrame * CFrame.new(u15 * 2, 0, 0)
            }
            local v26 = u8 * 2
            v25.Size = Vector3.new(v26, 9, 9)
            v25.Transparency = 1
            v22(v23, v24, v25)
            _G.destroy(u16, 1)
            spawn(function() --[[ Line: 50 ]]
                --[[
                Upvalues:
                    [1] = u16
                    [2] = u2
                --]]
                local v27 = u16.SwooshA
                local v28 = u16.SwooshB
                for v29 = 0, 1, 0.1 do
                    v27.Mesh.Scale = v27.Mesh.Scale + Vector3.new(0.2, 0.2, 0.2)
                    v28.Mesh.Scale = v27.Mesh.Scale + Vector3.new(1, 1, 1)
                    v27.Decal.Transparency = v29
                    v28.Decal.Transparency = v29
                    v27.CFrame = v27.CFrame * CFrame.Angles(0, 0.6, 0)
                    v28.CFrame = v28.CFrame * CFrame.Angles(0, -0.4, 0)
                    u2:Wait()
                end
            end)
        end)
        for v30 = 1, v13 do
            local v31 = u9 * CFrame.new(0, -v14 * v30, 0)
            local v32 = 1 - v30 / v13
            local v33 = _G.PlayEffect
            local v34 = v31 * CFrame.new(0, (v14 + 1) * v30, 0)
            local v35 = BrickColor.new("White")
            local v36 = Vector3.new(v11, 0.5, v11) * v32
            local v37 = v11 / 4
            local v38 = v11 / 4
            v33("Shockwave2", nil, v34, v31, v35, v36, Vector3.new(v37, 0.5, v38) * v32, 0.25, 0, Enum.EasingStyle.Quad, Color3.fromRGB(255, 255, 255), Enum.Material.Neon, "Rings")
            u9 = u9 * CFrame.new(0, -u8 / 10 * v30, 0)
            game["Run Service"].Heartbeat:Wait()
        end
    end
end
return v1
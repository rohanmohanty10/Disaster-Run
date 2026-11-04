 

local v1 = {}
game:GetService("TweenService")
game:GetService("RunService")
function crater(p2)
    local v3 = {}
    for v4 = 1, 14 do
        local v5 = v4 / 14 * 360
        local v6 = script.Rock1:Clone()
        local v7 = p2 * CFrame.new(0, -2, 0) * CFrame.Angles(0, math.rad(v5), 0) * CFrame.new(0, 0, -16) * CFrame.Angles(-0.3490658503988659, 0, 0)
        local v8 = CFrame.Angles
        local v9 = math.random(-15, 15)
        local v10 = math.rad(v9)
        local v11 = math.random(-15, 15)
        local v12 = math.rad(v11)
        local v13 = math.random(-15, 15)
        v6:PivotTo(v7 * v8(v10, v12, (math.rad(v13))))
        table.insert(v3, v6)
        v6.Parent = workspace.Effects
    end
    for v14 = 1, 15 do
        local v15 = v14 / 15 * 360
        local v16 = script.Rock2:Clone()
        local v17 = p2 * CFrame.new(0, -1.5, 0) * CFrame.Angles(0, math.rad(v15), 0) * CFrame.new(0, 0, -12) * CFrame.Angles(0.3490658503988659, 0, 0)
        local v18 = CFrame.Angles
        local v19 = math.random(-15, 15)
        local v20 = math.rad(v19)
        local v21 = math.random(-15, 15)
        local v22 = math.rad(v21)
        local v23 = math.random(-15, 15)
        v16:PivotTo(v17 * v18(v20, v22, (math.rad(v23))))
        table.insert(v3, v16)
        v16.Parent = workspace.Effects
    end
    return v3
end
local u24 = RaycastParams.new()
u24.FilterType = Enum.RaycastFilterType.Whitelist
u24.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
function v1.start(_, _, p25, p26) --[[ Line: 32 ]]
    --[[
    Upvalues:
        [1] = u24
    --]]
    if _G.checkRenderDistance(p25.Position) ~= false then
        _G.PlaySound(p25, script.OverheatSmash)
        local v27 = script.Holder:Clone()
        v27.Parent = workspace.Effects
        v27.CFrame = p25
        _G.customEmit(v27)
        _G.destroy(v27, 4)
        _G.tween(v27.Lights.Glow, { 0.4, "Quad", Enum.EasingDirection.Out }, {
            ["Brightness"] = 0,
            ["Range"] = 60
        })
        _G.shakenear(p25.Position, 125, 75, 100, -0.8)
        if p26 then
            local v28 = CFrame.new(p25.Position)
            local v29 = Ray.new(v28.Position + Vector3.new(0, 10, 0), Vector3.new(0, -20, 0))
            local v30, v31, v32 = _G.raycastWhitelist(v29, { workspace.Islands, workspace.Env, workspace.Ships })
            if v30 then
                v28 = CFrame.new(v31, v31 + v32) * CFrame.Angles(-1.5707963267948966, 0, 0)
                v27.Attachment.Rocks.Color = ColorSequence.new(v30.Color)
                v27.Attachment.sm2.Color = ColorSequence.new(v30.Color)
            else
                v27.Attachment.sm2:Clear()
                v27.Attachment.Rocks:Clear()
            end
            local u33 = crater(v28 * CFrame.new(0, -1, 0))
            for v34, v35 in u33 do
                local v36 = workspace:Raycast(v35.PrimaryPart.Position + Vector3.new(0, 6, 0), Vector3.new(0, -8, 0), u24)
                if v36 then
                    _G.matchMaterial(v35.Top, v36.Instance)
                    v35:PivotTo(v35.PrimaryPart.CFrame * CFrame.new(0, -4, 0))
                    local v37 = 0.05 + math.random(0, 50) / 1000
                    if v35.Name == "Rock1" then
                        v37 = v37 + 0.06666666666666667
                    end
                    _G.tween(v35.PrimaryPart, { v37, "Quad", Enum.EasingDirection.Out }, {
                        ["CFrame"] = v35.PrimaryPart.CFrame * CFrame.new(0, 4, 0)
                    })
                else
                    v35:Destroy()
                    u33[v34] = nil
                end
            end
            task.delay(1.5, function() --[[ Line: 84 ]]
                --[[
                Upvalues:
                    [1] = u33
                --]]
                for _, v38 in u33 do
                    _G.tween(v38.PrimaryPart, { 0.5 + math.random(0, 200) / 1000, "Quint", Enum.EasingDirection.In }, {
                        ["CFrame"] = v38.PrimaryPart.CFrame * CFrame.new(0, -6, 0)
                    })
                    _G.destroy(v38, 0.6)
                end
            end)
        end
    end
end
return v1
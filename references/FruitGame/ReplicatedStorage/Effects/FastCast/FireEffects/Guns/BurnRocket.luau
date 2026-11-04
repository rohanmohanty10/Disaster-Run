 

local v1 = {}
local u2 = {}
function v1.impact(p3, p4, p5, _) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if u2[p3] then
        u2[p3] = nil
    end
    _G.PlaySound(p3, script.explode)
    _G.destroy(p3, 1)
    p3.Parent:Destroy()
    if p4 then
        _G.PlayEffect("BombExplosion", nil, CFrame.new(p5), 10, 20, 0.25, 1.5, nil, nil, Color3.fromRGB(0, 85, 255))
    end
end
function v1.splash(p6, p7) --[[ Line: 17 ]]
    _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.Splash]:start({
        ["obj"] = p6,
        ["Strength"] = 50,
        ["Size"] = 20,
        ["cf"] = p7
    })
end
function v1.move(p8, p9) --[[ Line: 21 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if _G.checkRenderDistance(p9.Position) == false then
        return
    else
        if u2[p8] == nil then
            u2[p8] = { p9, p9 }
        end
        local v10 = u2[p8][1]
        if (v10.p - p9.p).magnitude > 5 then
            local v11 = script.Part:Clone()
            local v12 = (v10.p - p9.p).magnitude
            v11.Mesh.Scale = Vector3.new(0, v12, 0)
            v11.CFrame = CFrame.new(v10.p, p9.p) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -v12 / 2, 0)
            if (u2[p8][2].p - p9.p).magnitude >= 20 then
                local v13 = v11.CFrame * CFrame.Angles(3.141592653589793, 0, 0)
                _G.PlayEffect("Shockwave2", nil, v13, v13, BrickColor.new("White"), Vector3.new(10, 0.5, 10), Vector3.new(0, 0.5, 0), 0.5, 0, Enum.EasingStyle.Quad, Color3.fromRGB(255, 255, 255), Enum.Material.Neon, "Rings")
                u2[p8][2] = v13
            end
            v11.Mesh.Scale = Vector3.new(0.6, v12, 0.6)
            v11.Parent = workspace.Effects
            _G.tween(v11.Mesh, {
                0.25,
                "EntranceProductive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Scale"] = Vector3.new(0, v12, 0)
            })
            _G.tween(v11, {
                0.25,
                "EntranceProductive",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Color"] = Color3.new(0, 0, 0)
            })
            _G.destroy(v11, 0.25)
            u2[p8][1] = p9
        end
    end
end
function v1.Fire(_, p14, p15) --[[ Line: 56 ]]
    local v16 = script.fire:Clone()
    v16.Parent = p15
    v16:Play()
    p14.Hole.Attachment.Spark:Emit(2)
    p14.Hole.Attachment.Smoke:Emit(25)
end
return v1
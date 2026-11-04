 

local v1 = {}
local _ = {
    [Enum.Material.Metal] = true,
    [Enum.Material.CorrodedMetal] = true
}
function v1.impact(p2, p3, p4, _, _) --[[ Line: 5 ]]
    if p3 then
        if _G.checkRenderDistance(p4) == false then
            return
        end
        for _ = 1, 5 do
            local u5 = script.Rockk:Clone()
            u5.Parent = workspace.Effects
            u5.CFrame = p2.CFrame * CFrame.new(math.random(-2, 2), math.random(-2, 2), math.random(-2, 2))
            local v6 = math.random(1, 3)
            u5.Size = Vector3.new(v6, v6, v6)
            local v7 = math.random(-45, 45)
            local v8 = math.random(50, 85)
            local v9 = math.random
            u5.Velocity = Vector3.new(v7, v8, v9(-45, 45))
            local v10 = math.random(-7, 7)
            local v11 = math.random(-7, 7)
            local v12 = math.random
            u5.RotVelocity = Vector3.new(v10, v11, v12(-7, 7))
            spawn(function() --[[ Line: 21 ]]
                --[[
                Upvalues:
                    [1] = u5
                --]]
                task.wait(0.25)
                _G.tween(u5, {
                    0.5,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Size"] = Vector3.new(0, 0, 0)
                })
            end)
            _G.destroy(u5, 0.75)
        end
        local v13 = script.Part:Clone()
        v13.Parent = workspace.Effects
        v13.CFrame = p2.CFrame
        v13.sm2:Emit(50)
        v13.sm3:Emit(50)
        _G.destroy(v13, 2)
        _G.PlaySound(v13, script.icyexplosion2)
        local v14 = script.sphere:Clone()
        v14.Parent = workspace.Effects
        v14.CFrame = p2.CFrame
        _G.tween(v14.Mesh, {
            0.25,
            "EntranceProductive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Scale"] = Vector3.new(25, 25, 25)
        })
        _G.tween(v14, {
            0.25,
            "EntranceProductive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1
        })
        _G.destroy(v14, 0.25)
    end
    p2.Parent:Destroy()
end
function v1.splash(p15, p16) --[[ Line: 47 ]]
    _G.PlayEffect("FloorFreeze", nil, p16, 100, 29, 30, true)
    p15.Parent:Destroy()
end
local u17 = _G.getEffect("IcedEffect")
function v1.Fire(_, _, p18) --[[ Line: 52 ]]
    --[[
    Upvalues:
        [1] = u17
    --]]
    local v19 = p18.Parent.AnimationController:LoadAnimation(script.fly)
    v19:Play()
    v19:AdjustSpeed(2)
    u17:start(p18)
    p18.roar:Play()
    _G.PlaySound(p18, script.icey)
end
function v1.move(_, p20) --[[ Line: 61 ]]
    _G.PlayEffect("FloorFreeze", nil, p20, 20, 10, 20, nil, 4)
end
return v1
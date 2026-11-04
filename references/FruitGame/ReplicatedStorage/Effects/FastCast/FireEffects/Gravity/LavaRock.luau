 

local v1 = {}
local u2 = {}
_G.getEffect("Shockwave")
local u3 = _G.getEffect("Shockwave2")
local _ = _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.RockDebs2]
function v1.impact(p4, _, p5, p6, p7) --[[ Line: 8 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if u2[p4] then
        u2[p4] = nil
    end
    _G.PlaySound(p4, script["b" .. math.random(1, 3)])
    p4.Parent:Destroy()
    CFrame.new(p5)
    local v8 = CFrame.new(p5, p5 + p6) * CFrame.Angles(-1.5707963267948966, 0, 0)
    local v9 = CFrame.new(p5, p7.startpos) * CFrame.Angles(-1.5707963267948966, 0, 0)
    local v10 = script.impact:Clone()
    v10.CFrame = v8
    v10.flare.WorldCFrame = v9
    v10.Parent = workspace.Effects
    _G.customEmit(v10)
    _G.destroy(v10, 5)
    _G.PlayEffect("GroundRocks2", nil, v8, 10, 15, 3, 0.15, 4)
end
function v1.move(p11, p12) --[[ Line: 38 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    if _G.checkRenderDistance(p12.Position) == false then
        return
    else
        if u2[p11] == nil then
            u2[p11] = { CFrame.new(0, 0, 0), CFrame.new(0, 0, 0) }
        end
        if (u2[p11][2].Position - p12.p).magnitude > 15 then
            local v13 = p11.CFrame * CFrame.new(10, 0, 0) * CFrame.Angles(0, 0, 1.5707963267948966)
            u2[p11][2] = p12
            u3:start(v13 * CFrame.new(0, 0, 0), v13, BrickColor.new("White"), Vector3.new(22.5, 1, 22.5), Vector3.new(5, 2, 5), 0.25, 0, Enum.EasingStyle.Quad, Color3.fromRGB(170, 85, 0), Enum.Material.Neon, "Rings")
        end
        if (u2[p11][1].Position - p12.p).magnitude >= 2 then
            u2[p11][1] = p12
            local v14 = p11.CFrame * CFrame.new(10, 0, 0)
            local v15 = CFrame.Angles
            local v16 = math.random(-360, 360)
            local v17 = v14 * v15(math.rad(v16), 0, 1.5707963267948966)
            local u18 = script.Shock:Clone()
            u18.CFrame = v17
            u18.Anchored = true
            u18.Size = Vector3.new(0, 1, 0)
            u18.Parent = workspace.Effects
            _G.tween(u18, {
                0.1,
                Enum.EasingStyle.Exponential,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = Vector3.new(12.5, 5, 12.5),
                ["Transparency"] = 0.2
            })
            task.spawn(function() --[[ Line: 64 ]]
                --[[
                Upvalues:
                    [1] = u18
                --]]
                task.wait(0.1)
                _G.tween(u18, {
                    0.25,
                    "EntranceProductive",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Size"] = Vector3.new(0, 35, 0),
                    ["Transparency"] = 1,
                    ["CFrame"] = u18.CFrame * CFrame.new(0, -15, 0),
                    ["Color"] = Color3.fromRGB(255, 0, 0)
                })
                _G.destroy(u18, 0.25)
            end)
        end
    end
end
function v1.splash(p19, p20) --[[ Line: 73 ]]
    _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.Splash]:start({
        ["obj"] = p19,
        ["Strength"] = 200,
        ["Size"] = 100,
        ["cf"] = p20,
        ["PSize"] = NumberSequence.new(35)
    })
end
function v1.Fire(_, _, p21) --[[ Line: 78 ]]
    _G.customEmit(p21)
    _G.PlaySound(p21, script["s" .. math.random(1, 2)])
end
return v1
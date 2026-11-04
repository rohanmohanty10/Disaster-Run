 

local v1 = {}
local u2 = {}
_G.getEffect("Shockwave")
local u3 = _G.getEffect("Shockwave2")
local _ = _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.RockDebs2]
function v1.impact(p4, p5, p6, _, p7) --[[ Line: 8 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    if u2[p4] then
        u2[p4] = nil
    end
    _G.PlaySound(p4, script.explode)
    p4.Parent:Destroy()
    local v8 = CFrame.new(p6)
    local v9 = CFrame.new(p6, p7.startpos) * CFrame.Angles(-1.5707963267948966, 0, 0)
    local v10 = script.Part2:Clone()
    v10.CFrame = v8
    v10.Parent = workspace.Effects
    _G.tween(v10.Attachment.PointLight, {
        0.4,
        "Smooth",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Range"] = 60,
        ["Brightness"] = 0
    })
    _G.destroy(v10, 0.5)
    local v11 = script.sphere:Clone()
    v11.CFrame = v9
    v11.Mesh.Scale = Vector3.new(30, 30, 30)
    v11.Parent = workspace.Effects
    _G.tween(v11.Mesh, {
        0.5,
        "EntranceProductive",
        Enum.EasingDirection.In,
        0,
        false,
        0
    }, {
        ["Scale"] = Vector3.new(65, 65, 65)
    })
    _G.tween(v11, {
        0.5,
        "Smoother",
        Enum.EasingDirection.In,
        0,
        false,
        0
    }, {
        ["Transparency"] = 1
    })
    _G.destroy(v11, 0.5)
    local v12 = script.sphere:Clone()
    v12.Material = Enum.Material.ForceField
    v12.Mesh.Scale = Vector3.new(30, 30, 30)
    v12.CFrame = v9
    v12.Parent = workspace.Effects
    _G.tween(v12.Mesh, {
        0.25,
        "Quad",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Scale"] = Vector3.new(97.5, 97.5, 97.5)
    })
    _G.tween(v12, {
        0.25,
        "Quad",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Transparency"] = 1
    })
    _G.destroy(v12, 0.25)
    _G.PlayEffect("GroundRocks", nil, v8, 35, 10, 20, 5)
    _G.PlayEffect("Spheres", nil, {
        ["cf"] = v8,
        ["ti"] = 0.35,
        ["ti2"] = 0.1,
        ["range"] = 35,
        ["minThick"] = 10,
        ["maxThick"] = 25,
        ["part"] = v12,
        ["color"] = Color3.fromRGB(213, 88, 46),
        ["am"] = 15
    })
    if p5 then
        local v13 = script.dust:Clone()
        v13.CFrame = CFrame.new(p6, p7.startpos) * CFrame.Angles(-1.5707963267948966, 0, 0)
        v13.Attachment.sm2.Color = ColorSequence.new(p5.Color)
        v13.Attachment.Rocks.Color = ColorSequence.new(p5.Color)
        v13.Attachment.BurningPart.Size = NumberSequence.new(20, 0)
        v13.Parent = workspace.Effects
        _G.customEmit(v13)
        _G.destroy(v13, 3)
        local v14 = v13.CFrame * CFrame.Angles(3.141592653589793, 0, 0)
        _G.PlayEffect("Shockwave2", nil, v14 * CFrame.new(0, -50, 0), v14, BrickColor.new("White"), Vector3.new(75, 4, 75), Vector3.new(37.5, 2, 37.5), 1, 0, Enum.EasingStyle.Quad, BrickColor.new("Neon orange").Color, Enum.Material.Neon, "Rings")
    end
end
function v1.move(p15, p16) --[[ Line: 73 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    if _G.checkRenderDistance(p16.Position) == false then
        return
    else
        if u2[p15] == nil then
            u2[p15] = { CFrame.new(0, 0, 0), CFrame.new(0, 0, 0) }
        end
        if (u2[p15][2].Position - p16.p).magnitude > 8 then
            local v17 = p15.CFrame * CFrame.new(10, 0, 0) * CFrame.Angles(0, 0, 1.5707963267948966)
            u2[p15][2] = p16
            u3:start(v17 * CFrame.new(0, 0, 0), v17, BrickColor.new("White"), Vector3.new(45, 2, 45), Vector3.new(5, 2, 5), 0.25, 0, Enum.EasingStyle.Quad, Color3.fromRGB(170, 85, 0), Enum.Material.Neon, "Rings")
        end
        if (u2[p15][1].Position - p16.p).magnitude >= 8 then
            u2[p15][1] = p16
            local v18 = p15.CFrame * CFrame.new(10, 0, 0)
            local v19 = CFrame.Angles
            local v20 = math.random(-360, 360)
            local v21 = v18 * v19(math.rad(v20), 0, 1.5707963267948966)
            local u22 = script.Shock:Clone()
            u22.CFrame = v21
            u22.Anchored = true
            u22.Size = Vector3.new(0, 1, 0)
            u22.Parent = workspace.Effects
            _G.tween(u22, {
                0.1,
                Enum.EasingStyle.Exponential,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Size"] = Vector3.new(25, 10, 25),
                ["Transparency"] = 0.2
            })
            task.spawn(function() --[[ Line: 99 ]]
                --[[
                Upvalues:
                    [1] = u22
                --]]
                task.wait(0.1)
                _G.tween(u22, {
                    0.25,
                    "EntranceProductive",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Size"] = Vector3.new(0, 35, 0),
                    ["Transparency"] = 1,
                    ["CFrame"] = u22.CFrame * CFrame.new(0, 0, 0),
                    ["Color"] = Color3.fromRGB(255, 0, 0)
                })
                _G.destroy(u22, 0.25)
            end)
        end
    end
end
function v1.splash(p23, p24) --[[ Line: 106 ]]
    _G.clientimpacts[game.ReplicatedStorage.ClientImpacts.Splash]:start({
        ["obj"] = p23,
        ["Strength"] = 200,
        ["Size"] = 100,
        ["cf"] = p24,
        ["PSize"] = NumberSequence.new(35)
    })
end
function v1.Fire(_, _, p25) --[[ Line: 111 ]]
    p25.sfx:Play()
end
return v1
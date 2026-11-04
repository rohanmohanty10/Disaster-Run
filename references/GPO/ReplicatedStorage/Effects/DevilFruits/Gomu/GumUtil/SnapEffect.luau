 

local u1 = {
    ["pistol"] = CFrame.new(0.725000203, 0.724998891, 1.67499959, 0.19751671, -0.123796843, -0.972451568, -0.931846559, 0.284304231, -0.225462362, 0.304383457, 0.950707853, -0.0592049025),
    ["bazooka"] = CFrame.new(0.331114441, 0.524041414, 0.54845041, -0.887057066, 0.141587764, -0.4394117, -0.289836049, 0.570054471, 0.768786907, 0.359339267, 0.809315026, -0.464633822)
}
u1.gatling = u1.bazooka
return function(p2, p3) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u1
    --]]
    _G.PlaySound(p2, script.SnapSound)
    local v4 = script.snap:Clone()
    v4:PivotTo(p2.CFrame * u1[p3])
    v4.Parent = workspace.Effects
    _G.destroy(v4, 1)
    _G.tween(v4.SwooshA, {
        0.2,
        "EntranceProductive",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["CFrame"] = v4.SwooshA.CFrame * CFrame.Angles(0, -3.11, 0)
    })
    _G.tween(v4.SwooshB, {
        0.1,
        "EntranceExpressive",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["CFrame"] = v4.SwooshB.CFrame * CFrame.Angles(0, -3.11, 0)
    })
    _G.tween(v4.SwooshA.Decal, {
        0.2,
        "EntranceExpressive",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Transparency"] = 1
    })
    _G.tween(v4.SwooshB.Decal, {
        0.1,
        "EntranceProductive",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Transparency"] = 1
    })
    _G.tween(v4.SwooshA.Mesh, {
        0.2,
        "EntranceExpressive",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Scale"] = v4.SwooshA.Mesh.Scale + Vector3.new(1.2, 1.2, 1.2)
    })
    _G.tween(v4.SwooshB.Mesh, {
        0.1,
        "EntranceProductive",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Scale"] = v4.SwooshB.Mesh.Scale + Vector3.new(1.2, 1.2, 1.2)
    })
end
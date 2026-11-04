 

local v1 = {}
local u2 = {
    ["pistol"] = CFrame.new(0.725000203, 0.724998891, 1.67499959, 0.19751671, -0.123796843, -0.972451568, -0.931846559, 0.284304231, -0.225462362, 0.304383457, 0.950707853, -0.0592049025),
    ["bazooka"] = CFrame.new(0.331114441, 0.524041414, 0.54845041, -0.887057066, 0.141587764, -0.4394117, -0.289836049, 0.570054471, 0.768786907, 0.359339267, 0.809315026, -0.464633822)
}
local _ = game:GetService("RunService").Heartbeat
local function u7(p3, p4) --[[ Line: 10 ]]
    local v5 = p3:FindFirstChild("GumRight")
    if v5 then
        v5.Transparency = 1
    end
    local v6 = script.snap:Clone()
    v6:PivotTo(p4)
    v6.Parent = workspace.Effects
    _G.PlaySound(p3.HumanoidRootPart, script.Snap)
    _G.destroy(v6, 1)
    _G.tween(v6.SwooshA, {
        0.2,
        "EntranceProductive",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["CFrame"] = v6.SwooshA.CFrame * CFrame.Angles(0, -3.11, 0)
    })
    _G.tween(v6.SwooshB, {
        0.1,
        "EntranceExpressive",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["CFrame"] = v6.SwooshB.CFrame * CFrame.Angles(0, -3.11, 0)
    })
    _G.tween(v6.SwooshA.Decal, {
        0.2,
        "EntranceExpressive",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Transparency"] = 1
    })
    _G.tween(v6.SwooshB.Decal, {
        0.1,
        "EntranceProductive",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Transparency"] = 1
    })
    _G.tween(v6.SwooshA.Mesh, {
        0.2,
        "EntranceExpressive",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Scale"] = v6.SwooshA.Mesh.Scale + Vector3.new(1.2, 1.2, 1.2)
    })
    _G.tween(v6.SwooshB.Mesh, {
        0.1,
        "EntranceProductive",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Scale"] = v6.SwooshB.Mesh.Scale + Vector3.new(1.2, 1.2, 1.2)
    })
    if (p4.Position - workspace.CurrentCamera.CFrame.Position).Magnitude < 25 then
        task.spawn(function() --[[ Line: 30 ]]
            _G.camshake(35, 35, -1)
        end)
    end
end
function v1.start(_, p8, p9) --[[ Line: 36 ]]
    --[[
    Upvalues:
        [1] = u7
        [2] = u2
    --]]
    if _G.checkRenderDistance(p8.HumanoidRootPart.Position) == false then
        return
    elseif p9 == "pistol" then
        u7(p8, p8.HumanoidRootPart.CFrame * u2[p9])
    else
        local v10 = 2 * p8.Humanoid.BodyWidthScale.Value
        local v11 = 1
        for _ = 1, 2 do
            local v12 = u7
            local v13 = p8.HumanoidRootPart.CFrame * CFrame.new(-v10 * v11, 0, 1)
            local v14 = CFrame.Angles
            local v15 = math.random(-360, 360)
            local v16 = math.rad(v15)
            local v17 = math.random(-360, 360)
            v12(p8, v13 * v14(1.5707963267948966, v16, (math.rad(v17))))
            v11 = v11 * -1
        end
    end
end
return v1
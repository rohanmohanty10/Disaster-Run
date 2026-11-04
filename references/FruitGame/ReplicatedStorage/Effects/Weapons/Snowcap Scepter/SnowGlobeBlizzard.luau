 

local v1 = {}
local u2 = {
    "rbxassetid://118732307151738",
    "rbxassetid://114035057746894",
    "rbxassetid://106717354409278",
    "rbxassetid://81199216780261",
    "rbxassetid://104476442544598",
    "rbxassetid://70544940294292",
    "rbxassetid://112556412201115",
    "rbxassetid://115568724978659",
    "rbxassetid://119869359296731",
    "rbxassetid://82027411543852",
    "rbxassetid://138272338101918",
    "rbxassetid://113931752975960",
    "rbxassetid://139049414760924",
    "rbxassetid://109409212174645",
    "rbxassetid://137361232696165",
    "rbxassetid://140082944371169",
    "rbxassetid://130476731732678",
    "rbxassetid://104357469293344",
    "rbxassetid://110185360006550",
    "rbxassetid://73588216196745",
    "rbxassetid://132932505422870",
    "rbxassetid://99145391194660",
    "rbxassetid://89332408324061",
    "rbxassetid://115680339578677",
    "rbxassetid://96195681741140"
}
local function u7(p3) --[[ Line: 46 ]]
    local v4 = script.MeshV1:Clone()
    local v5 = CFrame.Angles
    local v6 = math.random(-180, 180)
    v4.CFrame = p3 * v5(0, math.rad(v6), 0)
    v4.Size = v4.Size * 0.5
    v4.Parent = workspace.Effects
    _G.tween(v4, {
        0.5,
        "Cubic",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Size"] = v4.Size * 1.25,
        ["Transparency"] = 1,
        ["CFrame"] = v4.CFrame * CFrame.Angles(0, 1.5707963267948966, 0)
    })
    _G.destroy(v4, 0.5)
end
local function u12(p8) --[[ Line: 56 ]]
    local v9 = script.MeshV3:Clone()
    local v10 = CFrame.Angles
    local v11 = math.random(-180, 180)
    v9.CFrame = p8 * v10(0, math.rad(v11), 0)
    v9.Size = v9.Size * 0.5
    v9.Parent = workspace.Effects
    _G.tween(v9, {
        0.75,
        "Cubic",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Size"] = v9.Size * 1.25 + Vector3.new(0, 20, 0),
        ["Transparency"] = 1,
        ["CFrame"] = v9.CFrame * CFrame.new(0, 10, 0) * CFrame.Angles(0, 1.5707963267948966, 0)
    })
    _G.destroy(v9, 0.75)
end
local function u25(p13, p14) --[[ Line: 67 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v15 = script.TJSphere3:Clone()
    local v16 = CFrame.Angles
    local v17 = math.random(-180, 180)
    v15.CFrame = p13 * v16(0, math.rad(v17), 0)
    v15.Parent = workspace.Effects
    local v18 = nil
    if p14 then
        v18 = v15.Mesh.Scale * 0.5
        local v19 = v15.Mesh
        v19.Scale = v19.Scale * 0
    else
        local v20 = v15.Mesh
        v20.Scale = v20.Scale * 0.5
    end
    _G.tween(v15, {
        0.5,
        "Quad",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["CFrame"] = v15.CFrame * CFrame.Angles(0, -3.141592653589793, 0)
    })
    if p14 then
        _G.tween(v15.Mesh, {
            0.5,
            "Exponential",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Scale"] = v18
        })
    else
        _G.tween(v15.Mesh, {
            0.5,
            "Exponential",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Scale"] = v15.Mesh.Scale * 1.25
        })
    end
    local u21 = u2
    local u22 = v15.Decal
    local u23 = 0.022222222222222223
    task.spawn(function() --[[ Line: 35 ]]
        --[[
        Upvalues:
            [1] = u21
            [2] = u22
            [3] = u23
        --]]
        for v24 = 1, #u21 - 1 do
            u22.Texture = u21[v24]
            task.wait(u23)
        end
        _G.destroy(u22.Parent, 0)
    end)
end
function v1.start(_, p26, p27, p28) --[[ Line: 107 ]]
    --[[
    Upvalues:
        [1] = u25
        [2] = u7
        [3] = u12
    --]]
    local v29 = script.Blizzard:Clone()
    v29:PivotTo(p26)
    v29:ScaleTo(0.5)
    v29.Parent = workspace.Effects
    _G.customEmit(v29)
    _G.particleEnabled(v29, true, true)
    local v30, v31, v32 = _G.getRayFloor(p26, 8)
    if v30 then
        v29.Main.SmokeAttachment.WorldCFrame = CFrame.new(v31, v31 + v32) * CFrame.Angles(1.5707963267948966, 0, 0)
    else
        v29.Main.SmokeAttachment:Destroy()
    end
    _G.tween(v29.Sparkles, {
        1.5,
        "Linear",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Orientation"] = v29.Sparkles.Orientation + Vector3.new(0, 720, 0)
    })
    _G.tween(v29.Trails, {
        1.5,
        "Linear",
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Orientation"] = v29.Sparkles.Orientation + Vector3.new(0, 720, 0)
    })
    _G.destroy(v29, 3)
    u25(v29:GetPivot(), true)
    local u33 = Instance.new("Model")
    local v34 = Instance.new("Highlight")
    v34.Enabled = false
    v34.Parent = u33
    u33.Parent = workspace.Effects
    _G.enableSwordTrails(p28, true)
    local v35 = tick()
    local v36 = p27 - workspace:GetServerTimeNow()
    local v37 = _G.PlaySound(p26, script.SnowglobeRodBlizzard)
    local v38 = _G.PlaySound(p28.PrimaryPart, script.SnowGlobeRodBlizzardStartBSpinLoop)
    v38.Parent = p28.PrimaryPart
    local v39 = 0
    local v40 = 0
    local v41 = 0
    local v42 = 0
    local function v45(p43) --[[ Line: 142 ]]
        --[[
        Upvalues:
            [1] = u33
        --]]
        local v44 = script.Distortion:Clone()
        v44.CFrame = p43
        v44.Size = v44.Size * 0.5
        v44.Parent = u33
        _G.tween(v44, {
            0.25,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Size"] = v44.Size * 1.25,
            ["Transparency"] = 1
        })
        _G.destroy(v44, 0.25)
    end
    while true do
        if v39 == 5 then
            v45(v29:GetPivot())
            v39 = 0
        else
            v39 = v39 + 1
        end
        if v40 == 2 then
            u7(v29:GetPivot())
            v40 = 0
        else
            v40 = v40 + 1
        end
        if v41 == 3 then
            u12(v29:GetPivot() * CFrame.new(0, -3, 0))
            v41 = 0
        else
            v41 = v41 + 1
        end
        if v42 == 4 then
            u25(v29:GetPivot())
            v42 = 0
        else
            v42 = v42 + 1
        end
        task.wait(0.05)
        if p28:FindFirstChild("PB") or v36 <= tick() - v35 then
            _G.enableSwordTrails(p28, false)
            _G.particleEnabled(v29, false, true)
            if v37 then
                _G.tween(v37, {
                    1,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Volume"] = 0
                })
                _G.destroy(v37, 1)
            end
            if v38 then
                _G.tween(v38, {
                    0.25,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Volume"] = 0
                })
                _G.destroy(v38, 0.25)
            end
            _G.destroy(u33, 0.25)
            return
        end
    end
end
return v1
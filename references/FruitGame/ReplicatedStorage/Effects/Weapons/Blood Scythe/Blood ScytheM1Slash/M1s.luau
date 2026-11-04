 

game:GetService("ReplicatedStorage")
require(script.BoatTween)
local u1 = script.M1Assets
local u2 = {
    ["Slashes"] = {
        u1.Slashes.Slash1,
        u1.Slashes.Slash2,
        u1.Slashes.Slash3,
        u1.Slashes.Slash4,
        u1.Slashes.Slash2,
        u1.Slashes.Slash4,
        u1.Slashes.Slash4
    },
    ["Beams"] = {
        u1.Beam1,
        u1.Beam2,
        u1.Beam3,
        u1.Beam3,
        u1.Beam2,
        u1.Beam3,
        u1.Beam3
    },
    ["Offsets"] = {
        CFrame.Angles(0, 0, -0.7853981633974483),
        CFrame.Angles(0, 0, -0.2617993877991494),
        CFrame.Angles(0, 0, 0.7853981633974483),
        CFrame.Angles(0, 0, 0.7853981633974483),
        CFrame.Angles(0, 0, -0.2617993877991494),
        CFrame.Angles(0, 0, 1.5707963267948966),
        CFrame.Angles(0, 0, 0.7853981633974483)
    },
    ["RotationOffsets"] = {
        CFrame.Angles(0, 2.9670597283903604, 0),
        CFrame.Angles(0, -2.356194490192345, 0),
        CFrame.Angles(0, -2.356194490192345, 0),
        CFrame.Angles(0, 2.9670597283903604, 0),
        CFrame.Angles(0, -2.356194490192345, 0),
        CFrame.Angles(0, 2.9670597283903604, 0),
        CFrame.Angles(0, 2.9670597283903604, 0)
    }
}
local function u5(p3) --[[ Line: 58 ]]
    for _, v4 in ipairs(p3:GetDescendants()) do
        if v4:IsA("ParticleEmitter") then
            v4:Emit(v4:GetAttribute("EmitCount") or 0)
        end
    end
end
local function u9(p6) --[[ Line: 66 ]]
    local v7 = {}
    for _, v8 in ipairs(p6:GetDescendants()) do
        if v8:IsA("Beam") then
            v8.Enabled = true
            table.insert(v7, v8)
        end
    end
    return v7
end
local function u12(p10) --[[ Line: 77 ]]
    for _, v11 in ipairs(p10) do
        _G.tween(v11, {
            0.23,
            Enum.EasingStyle.Sine,
            "Out",
            0,
            false,
            0
        }, {
            ["Width0"] = 0,
            ["Width1"] = 0
        })
    end
end
local function u15(p13, p14) --[[ Line: 86 ]]
    _G.tween(p13, {
        0.4,
        Enum.EasingStyle.Quad,
        "Out",
        0,
        false,
        0
    }, {
        ["CFrame"] = p13.CFrame * p14
    })
    _G.tween(p13.Decal, {
        0.6,
        Enum.EasingStyle.Sine,
        "Out",
        0,
        false,
        0
    }, {
        ["Transparency"] = 1
    })
end
return function(p16) --[[ Line: 94 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
        [3] = u5
        [4] = u9
        [5] = u15
        [6] = u12
    --]]
    local v17 = p16.Root
    local v18 = p16.Count or 1
    local u19 = Instance.new("Folder", workspace.Effects)
    local v20 = v18 == "Dash" and 1 or (v18 == "Air-4" and 6 or (v18 == "Air-5" and 7 or v18))
    local v21 = tonumber(v20)
    local u22 = u2.Slashes[v21]:Clone()
    local v23 = u2.Beams[v21]:Clone()
    local v24 = u1.mesh:Clone()
    u22.Parent = v17
    u5(u22)
    local v25 = u9(v23)
    v23.Parent = u19
    v23.CFrame = v17.CFrame * u2.Offsets[v21]
    v24.Parent = u19
    v24.CFrame = v23.CFrame
    _G.tween(v23, {
        0.4,
        Enum.EasingStyle.Quad,
        "Out",
        0,
        false,
        0
    }, {
        ["CFrame"] = v23.CFrame * u2.RotationOffsets[v21]
    })
    u15(v24, u2.RotationOffsets[v21])
    u12(v25)
    task.delay(1.5, function() --[[ Line: 134 ]]
        --[[
        Upvalues:
            [1] = u22
            [2] = u19
        --]]
        u22:Destroy()
        u19:Destroy()
    end)
end
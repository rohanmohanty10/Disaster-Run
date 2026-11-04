 

local v1 = game:GetService("ReplicatedStorage")
local u2 = game:GetService("RunService")
local u3 = require(v1.Modules.BezierFormula)
local u4 = require(v1.Modules.Client.WeaponVFXRecolor)
local u5 = workspace.Effects
local u6 = Random.new()
local u7 = {
    "rbxassetid://13262712654",
    "rbxassetid://13262712402",
    "rbxassetid://13262712266",
    "rbxassetid://13262712105",
    "rbxassetid://13262706765",
    "rbxassetid://13262706656",
    "rbxassetid://13262706530",
    "rbxassetid://13262706358",
    "rbxassetid://13262715553",
    "rbxassetid://13262706009",
    "rbxassetid://13262701091",
    "rbxassetid://13262700920",
    "rbxassetid://13262700770",
    "rbxassetid://13262715411",
    "rbxassetid://13262700469",
    "rbxassetid://13262700290"
}
local u8 = {
    "rbxassetid://13262749732",
    "rbxassetid://13262749544",
    "rbxassetid://13262749155",
    "rbxassetid://13262748673",
    "rbxassetid://13262743695",
    "rbxassetid://13262743508",
    "rbxassetid://13262743373",
    "rbxassetid://13262742953",
    "rbxassetid://13262742798",
    "rbxassetid://13262742287",
    "rbxassetid://13262737878",
    "rbxassetid://13262737606",
    "rbxassetid://13262737406",
    "rbxassetid://13262737158",
    "rbxassetid://13262736902",
    "rbxassetid://13262736729"
}
local function u19(p9, p10, p11) --[[ Line: 49 ]]
    local function v17(u12, p13, p14) --[[ Line: 50 ]]
        for _, v15 in ipairs(u12:GetDescendants()) do
            if v15:IsA("ParticleEmitter") or v15:IsA("Trail") then
                v15.Enabled = p13
            end
        end
        if p14 then
            task.delay(p14, function() --[[ Line: 58 ]]
                --[[
                Upvalues:
                    [1] = u12
                --]]
                for _, v16 in ipairs(u12:GetDescendants()) do
                    if v16:IsA("ParticleEmitter") or v16:IsA("Trail") then
                        v16.Enabled = false
                    end
                end
            end)
        end
    end
    if typeof(p9) == "table" then
        for _, v18 in p9 do
            v17(v18, p10, p11)
        end
    else
        v17(p9, p10, p11)
    end
end
return {
    ["start"] = function(_, u20, u21, u22, p23) --[[ Name: start, Line 87 ]]
        --[[
        Upvalues:
            [1] = u4
            [2] = u5
            [3] = u7
            [4] = u19
            [5] = u8
            [6] = u6
            [7] = u2
            [8] = u3
        --]]
        local u24 = p23
        if not u24 then
            if u20 then
                u24 = u20.Parent
            else
                u24 = u20
            end
        end
        if _G.checkRenderDistance(u21.Position) ~= false then
            if (u21.Position - workspace.CurrentCamera.CFrame.Position).Magnitude <= 125 then
                _G.camShake:ShakeOnce(4, 12, 0.1, 0.3)
            end
            local u25 = (u21.Position - u22.Position).Magnitude / 125
            local u26 = script.Initial:Clone()
            u4.apply(u26, u24)
            u26:PivotTo(u21)
            u26.Parent = u5
            _G.flipbook(u26.Mesh2, u7, 16)
            _G.flipbook(u26.Mesh1, u7, 32, true)
            _G.customEmit(u26)
            _G.destroy(u26, 2)
            local v27 = script.Dash:Clone()
            u4.apply(v27, u24)
            v27:PivotTo(u21 * CFrame.new(0, 0, -5))
            v27.Parent = u5
            u19(v27, true, 0.25)
            local v28 = u20.CFrame
            local v29 = Instance.new("WeldConstraint")
            v29.Part0 = v27
            v29.Part1 = u20
            v29.Part1.CFrame = v28
            v29.Parent = v27
            _G.destroy(v27, 0.81 + u25)
            pcall(function() --[[ Line: 116 ]]
                --[[
                Upvalues:
                    [1] = u26
                    [2] = u25
                --]]
                _G.tween(u26.Mesh2.Mesh, {
                    0.6666666666666666,
                    "EntranceProductive",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Scale"] = u26.Mesh2.Mesh.Scale * 3
                })
                local v30 = _G.tween
                local v31 = u26.Mesh1.Mesh
                local v32 = {
                    u25,
                    "EntranceProductive",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }
                local v33 = {}
                local v34 = u26.Mesh1.Mesh.Scale.X * 1.5
                local v35 = u26.Mesh1.Mesh.Scale.Z * 1.5
                v33.Scale = Vector3.new(v34, 130, v35)
                v30(v31, v32, v33)
                _G.tween(u26.Mesh2, {
                    0.6666666666666666,
                    "EntranceProductive",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["CFrame"] = u26.Mesh2.CFrame * CFrame.new(0, 3.141592653589793, 0),
                    ["Transparency"] = 1
                })
                _G.tween(u26.Mesh1, {
                    u25,
                    "EntranceProductive",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["CFrame"] = u26.Mesh2.CFrame * CFrame.new(0, -15, 0)
                })
            end)
            task.delay(u25 / 1.5, function() --[[ Line: 125 ]]
                --[[
                Upvalues:
                    [1] = u4
                    [2] = u24
                    [3] = u20
                    [4] = u5
                    [5] = u8
                --]]
                local v36 = script.Wave:Clone()
                u4.apply(v36, u24)
                v36:PivotTo(u20.CFrame * CFrame.new(0, 0, -5))
                v36.Parent = u5
                _G.destroy(v36, 0.5)
                local u37 = v36.Wave2
                local u38 = v36.Wave3
                local v39 = u38.CFrame
                local v40 = CFrame.Angles
                local v41 = math.random(-360, 360)
                u38.CFrame = v39 * v40(0, math.rad(v41), 0)
                _G.flipbook(u37, u8, 32)
                _G.flipbook(u38, u8, 32)
                _G.tween(u37, {
                    0.5,
                    "Quint",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["CFrame"] = u37.CFrame * CFrame.new(0, 5, 0)
                })
                _G.tween(u38, {
                    0.5,
                    "Quint",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["CFrame"] = u38.CFrame * CFrame.new(0, 12, 0) * CFrame.Angles(0, 4.014257279586958, 0)
                })
                _G.tween(u37.Mesh, {
                    1,
                    "Quint",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Scale"] = u37.Mesh.Scale * 4
                })
                _G.tween(u38.Mesh, {
                    1,
                    "Quint",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Scale"] = u38.Mesh.Scale + Vector3.new(5, 20, 5)
                })
                task.delay(0.125, function() --[[ Line: 146 ]]
                    --[[
                    Upvalues:
                        [1] = u38
                        [2] = u37
                    --]]
                    _G.tween(u38, {
                        0.25,
                        "Quint",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Transparency"] = 1
                    })
                    _G.tween(u37, {
                        0.25,
                        "Quint",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Transparency"] = 1
                    })
                end)
            end)
            local v42 = (u21.Position - u22.Position).Magnitude
            math.clamp(v42, 0, 45)
            for _ = 1, 4 do
                local u43 = script.BloodTrail:Clone()
                u4.apply(u43, u24)
                u43.CFrame = u21 * CFrame.new(math.random(-10, 10), math.random(5, 5), math.random(-2, 2))
                u43.TRAILS["Trail Rotation"].TrailParent.Trail.Lifetime = u6:NextNumber(0.2, 0.5)
                u43.Parent = u5
                u19(u43, true)
                local u44 = u6:NextNumber(2, 2.5)
                local u45 = 0
                local u46 = (CFrame.lookAt(u43.Position:Lerp(u22.Position, 0.25), u22.Position) * CFrame.new(math.random(-20, 20), math.random(10, 20), 0)).Position
                local u47 = (CFrame.lookAt(u43.Position:Lerp(u22.Position, 0.75), u22.Position) * CFrame.new(math.random(-20, 20), 0, 0)).Position
                local u48 = nil
                u48 = u2.Heartbeat:Connect(function(p49) --[[ Line: 182 ]]
                    --[[
                    Upvalues:
                        [1] = u45
                        [2] = u44
                        [3] = u3
                        [4] = u21
                        [5] = u46
                        [6] = u47
                        [7] = u22
                        [8] = u48
                        [9] = u43
                        [10] = u19
                    --]]
                    u45 = u45 + p49 * u44
                    local v50 = u3.CubicBezier(u45, u21.Position, u46, u47, u22.Position)
                    if u45 >= 1 then
                        u48:Disconnect()
                        u43.Position = u22.Position
                        u19(u43, false)
                        _G.destroy(u43, 1)
                    else
                        u43.CFrame = CFrame.new(v50, u3.CubicBezier(u45 + 0.01, u21.Position, u46, u47, u22.Position))
                    end
                end)
            end
        end
    end
}
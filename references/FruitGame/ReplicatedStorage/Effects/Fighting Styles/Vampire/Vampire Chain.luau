 

local v1 = game:GetService("Players")
game:GetService("RunService")
local v2 = game:GetService("ReplicatedStorage")
require(v2.Modules.BezierFormula)
local u3 = require(v2.Modules.Client.WeaponVFXRecolor)
local _ = v1.LocalPlayer
local u4 = workspace.Effects
local u5 = {
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
local u6 = {
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
local function u17(p7, p8, p9) --[[ Line: 48 ]]
    local function v15(u10, p11, p12) --[[ Line: 49 ]]
        for _, v13 in ipairs(u10:GetDescendants()) do
            if v13:IsA("ParticleEmitter") or v13:IsA("Trail") then
                v13.Enabled = p11
            end
        end
        if p12 then
            task.delay(p12, function() --[[ Line: 57 ]]
                --[[
                Upvalues:
                    [1] = u10
                --]]
                for _, v14 in ipairs(u10:GetDescendants()) do
                    if v14:IsA("ParticleEmitter") or v14:IsA("Trail") then
                        v14.Enabled = false
                    end
                end
            end)
        end
    end
    if typeof(p7) == "table" then
        for _, v16 in p7 do
            v15(v16, p8, p9)
        end
    else
        v15(p7, p8, p9)
    end
end
return {
    ["start"] = function(_, u18, p19, _) --[[ Name: start, Line 78 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u4
            [3] = u17
            [4] = u6
            [5] = u5
        --]]
        if _G.checkRenderDistance(u18.PrimaryPart.Position) ~= false then
            local u20 = u18.HumanoidRootPart
            u18:FindFirstChild("Humanoid")
            local v21 = p19.HumanoidRootPart
            p19:FindFirstChild("Humanoid")
            local v22 = u18.RightHand
            local v23 = Instance.new("BodyVelocity")
            v23.MaxForce = Vector3.new(inf, inf, inf)
            v23.P = 100000
            v23.Velocity = -v21.CFrame.LookVector * 100
            v23.Parent = v21
            _G.destroy(v23, 0.25)
            local u24 = script.Chain:Clone()
            u3.apply(u24, u18)
            u24:PivotTo(v22.CFrame)
            u24.Parent = u4
            u17(u24, true)
            u24.Victim.CFrame = p19.UpperTorso.CFrame
            local v25 = Instance.new("WeldConstraint")
            v25.Part0 = u24.PrimaryPart
            v25.Part1 = v22
            v25.Part1.CFrame = v22.CFrame
            v25.Parent = u24.PrimaryPart
            local v26 = Instance.new("WeldConstraint")
            local v27 = u24.Victim
            local v28 = p19.UpperTorso
            v26.Part0 = v27
            v26.Part1 = v28
            v26.Part1.CFrame = p19.UpperTorso.CFrame
            v26.Parent = u24.Victim
            task.wait(0.8)
            _G.tween(u24.Victim, {
                0.5,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = u20.CFrame * CFrame.new(1.5, 0, -3) * CFrame.Angles(0, 3.141592653589793, 0)
            })
            task.delay(0.5, function() --[[ Line: 113 ]]
                --[[
                Upvalues:
                    [1] = u17
                    [2] = u24
                    [3] = u3
                    [4] = u18
                    [5] = u20
                    [6] = u4
                    [7] = u6
                    [8] = u5
                --]]
                u17(u24, false)
                u24.Player.Attachment.Beam.Enabled = false
                _G.destroy(u24, 2)
                task.wait(1)
                local u29 = script.Slam:Clone()
                u3.apply(u29, u18)
                u29:PivotTo(u20.CFrame * CFrame.new(1, 0, -3))
                _G.customEmit(u29)
                _G.destroy(u29, 2)
                u29.Parent = u4
                _G.flipbook(u29.InnerWave, u6, 32)
                _G.flipbook(u29.OuterWave1, u5, 32)
                _G.flipbook(u29.OuterWave2, u5, 32)
                local v30 = u29.InnerWave.Mesh
                local v31 = u29.InnerWave.Mesh.Scale.X
                local v32 = u29.InnerWave.Mesh.Scale.Y * 2
                local v33 = u29.InnerWave.Mesh.Scale.Z
                v30.Scale = Vector3.new(v31, v32, v33)
                local v34 = u29.OuterWave1.Mesh
                local v35 = u29.OuterWave1.Mesh.Scale.X
                local v36 = u29.OuterWave1.Mesh.Scale.Y * 3
                local v37 = u29.OuterWave1.Mesh.Scale.Z
                v34.Scale = Vector3.new(v35, v36, v37)
                local v38 = _G.tween
                local v39 = u29.InnerWave.Mesh
                local v40 = {
                    0.75,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }
                local v41 = {}
                local v42 = u29.InnerWave.Mesh.Scale.X * 3
                local v43 = u29.InnerWave.Mesh.Scale.Z * 3
                v41.Scale = Vector3.new(v42, 0, v43)
                v38(v39, v40, v41)
                _G.tween(u29.InnerWave, {
                    0.75,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["CFrame"] = u29.InnerWave.CFrame * CFrame.new(0, -4, 0)
                })
                local v44 = _G.tween
                local v45 = u29.OuterWave1.Mesh
                local v46 = {
                    0.75,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }
                local v47 = {}
                local v48 = u29.OuterWave1.Mesh.Scale.X * 2
                local v49 = u29.OuterWave1.Mesh.Scale.Y * 1.3
                local v50 = u29.OuterWave1.Mesh.Scale.Z * 2
                v47.Scale = Vector3.new(v48, v49, v50)
                v44(v45, v46, v47)
                _G.tween(u29.OuterWave1, {
                    0.75,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["CFrame"] = u29.InnerWave.CFrame * CFrame.new(0, 2, 0)
                })
                local v51 = _G.tween
                local v52 = u29.OuterWave2.Mesh
                local v53 = {
                    0.75,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }
                local v54 = {}
                local v55 = u29.OuterWave2.Mesh.Scale.X * 2
                local v56 = u29.OuterWave2.Mesh.Scale.Y * 2
                local v57 = u29.OuterWave2.Mesh.Scale.Z * 2
                v54.Scale = Vector3.new(v55, v56, v57)
                v51(v52, v53, v54)
                _G.tween(u29.OuterWave2, {
                    0.75,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["CFrame"] = u29.OuterWave2.CFrame * CFrame.new(0, 2, 0)
                })
                task.delay(0.4, function() --[[ Line: 144 ]]
                    --[[
                    Upvalues:
                        [1] = u29
                    --]]
                    _G.tween(u29.InnerWave, {
                        0.75,
                        "Quint",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Transparency"] = 1
                    })
                    _G.tween(u29.OuterWave1, {
                        0.75,
                        "Quint",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Transparency"] = 1
                    })
                    _G.tween(u29.OuterWave2, {
                        0.75,
                        "Quint",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Transparency"] = 1
                    })
                end)
                _G.PlayEffect("GroundRocks2", nil, u29:GetPivot(), 13, 8, 1.5, 0.1, 3)
                for _ = 1, 7 do
                    local v58 = _G.PlayEffect
                    local v59 = u29:GetPivot().Position + Vector3.new(0, 0.2, 0)
                    local v60 = math.random(-30, 30)
                    local v61 = math.random(35, 80)
                    local v62 = math.random
                    v58("VampireBloodSplat", nil, 1, v59, 5, 25, 50, { -100, 15 }, Vector3.new(v60, v61, v62(-30, 30)), u18)
                end
            end)
        end
    end
}
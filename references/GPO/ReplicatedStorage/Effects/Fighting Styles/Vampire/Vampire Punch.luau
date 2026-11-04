 

local v1 = game:GetService("Players")
local u2 = game:GetService("RunService")
local v3 = game:GetService("ReplicatedStorage")
local u4 = require(v3.Modules.BezierFormula)
local u5 = require(v3.Modules.Client.WeaponVFXRecolor)
local _ = v1.LocalPlayer
local u6 = workspace.Effects
Random.new()
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
function Flipbook(p9, u10, u11, u12)
    local u13 = p9:FindFirstChildOfClass("SpecialMesh")
    if u13 and u10 then
        task.spawn(function() --[[ Line: 54 ]]
            --[[
            Upvalues:
                [1] = u10
                [2] = u13
                [3] = u11
                [4] = u12
            --]]
            for v14 = 1, #u10 do
                u13.TextureId = u10[v14]
                task.wait(1 / u11)
            end
            if u12 == true then
                u13.Parent:Destroy()
            end
        end)
    end
end
local function u25(p15, p16, p17) --[[ Line: 68 ]]
    local function v23(u18, p19, p20) --[[ Line: 69 ]]
        for _, v21 in ipairs(u18:GetDescendants()) do
            if v21:IsA("ParticleEmitter") or v21:IsA("Trail") then
                v21.Enabled = p19
            end
        end
        if p20 then
            task.delay(p20, function() --[[ Line: 77 ]]
                --[[
                Upvalues:
                    [1] = u18
                --]]
                for _, v22 in ipairs(u18:GetDescendants()) do
                    if v22:IsA("ParticleEmitter") or v22:IsA("Trail") then
                        v22.Enabled = false
                    end
                end
            end)
        end
    end
    if typeof(p15) == "table" then
        for _, v24 in p15 do
            v23(v24, p16, p17)
        end
    else
        v23(p15, p16, p17)
    end
end
return {
    ["start"] = function(_, p26, p27) --[[ Name: start, Line 105 ]]
        --[[
        Upvalues:
            [1] = u5
            [2] = u6
            [3] = u25
            [4] = u2
            [5] = u4
            [6] = u8
            [7] = u7
        --]]
        if _G.checkRenderDistance(p26.PrimaryPart.Position) ~= false then
            local u28 = p26.HumanoidRootPart
            p26:FindFirstChild("Humanoid")
            local u29 = p26.RightHand
            for _ = 1, 4 do
                local u30 = script.BloodTrail:Clone()
                u5.apply(u30, p26)
                u30.CFrame = u28.CFrame * CFrame.new(math.random(-10, 10), math.random(5, 5), math.random(-2, 2))
                u30.TRAILS["Trail Rotation"].TrailParent.Trail.Lifetime = Random.new():NextNumber(0.2, 0.5)
                u30.Parent = u6
                u25(u30, true)
                local u31 = Random.new():NextNumber(1, 2)
                local u32 = 0
                local u33 = (CFrame.lookAt(u30.Position:Lerp(u29.Position, 0.25), u29.Position) * CFrame.new(math.random(-5, 7) * 5.5, math.random(15, 25), math.random(-5, 7) * 5.5)).Position
                local u34 = (CFrame.lookAt(u30.Position:Lerp(u29.Position, 0.75), u29.Position) * CFrame.new(math.random(-5, 5) * 5, math.random(0, 5), math.random(-5, 5) * 5)).Position
                local u35 = nil
                u35 = u2.Heartbeat:Connect(function(p36) --[[ Line: 132 ]]
                    --[[
                    Upvalues:
                        [1] = u32
                        [2] = u31
                        [3] = u4
                        [4] = u28
                        [5] = u33
                        [6] = u34
                        [7] = u29
                        [8] = u35
                        [9] = u30
                        [10] = u25
                    --]]
                    u32 = u32 + p36 * u31
                    local v37 = u4.CubicBezier(u32, u28.Position, u33, u34, u29.Position)
                    if u32 >= 1 then
                        u35:Disconnect()
                        u30.Position = u29.Position
                        u25(u30, false)
                        _G.destroy(u30, 1)
                    else
                        u30.CFrame = CFrame.new(v37, u4.CubicBezier(u32 + 0.01, u28.Position, u33, u34, u29.Position))
                    end
                end)
                task.wait(0.125)
            end
            local u38 = script.Strike:Clone()
            u5.apply(u38, p26)
            u38:PivotTo(p27 * CFrame.Angles(1.5707963267948966, 0, 0))
            u38.Parent = u6
            _G.customEmit(u38)
            _G.destroy(u38, 0.75)
            if (workspace.CurrentCamera.CFrame.Position - p26.PrimaryPart.Position).Magnitude <= 75 then
                _G.camShake:ShakeOnce(4, 10, 0.2, 0.4)
            end
            Flipbook(u38.Shock, u8, 32)
            Flipbook(u38.OuterShock, u8, 32)
            Flipbook(u38.InnerWave, u8, 32)
            Flipbook(u38.InnerWave2, u8, 32)
            Flipbook(u38.Wave, u7, 32)
            u38.OuterShock.CFrame = u38.OuterShock.CFrame * CFrame.new(0, -5, 0)
            local v39 = u38.Shock.Mesh
            local v40 = u38.Shock.Mesh.Scale.X * 10
            local v41 = u38.Shock.Mesh.Scale.Y / 2
            local v42 = u38.Shock.Mesh.Scale.Z * 10
            v39.Scale = Vector3.new(v40, v41, v42)
            local v43 = u38.OuterShock.Mesh
            local v44 = u38.OuterShock.Mesh.Scale.X / 3
            local v45 = u38.OuterShock.Mesh.Scale.Y * 2
            local v46 = u38.OuterShock.Mesh.Scale.Z / 3
            v43.Scale = Vector3.new(v44, v45, v46)
            local v47 = u38.Wave.Mesh
            local v48 = u38.Wave.Mesh.Scale.X / 2
            local v49 = u38.Wave.Mesh.Scale.Y
            local v50 = u38.Wave.Mesh.Scale.Z / 2
            v47.Scale = Vector3.new(v48, v49, v50)
            local v51 = _G.tween
            local v52 = u38.Shock.Mesh
            local v53 = {
                0.5,
                "Quint",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v54 = {}
            local v55 = u38.Shock.Mesh.Scale.Y * 2
            v54.Scale = Vector3.new(0, v55, 0)
            v51(v52, v53, v54)
            _G.tween(u38.Shock, {
                0.5,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Transparency"] = 1
            })
            local v56 = _G.tween
            local v57 = u38.OuterShock.Mesh
            local v58 = {
                0.5,
                "Quint",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v59 = {}
            local v60 = u38.Shock.Mesh.Scale.X / 3
            local v61 = u38.Shock.Mesh.Scale.Z / 3
            v59.Scale = Vector3.new(v60, 0, v61)
            v56(v57, v58, v59)
            _G.tween(u38.OuterShock, {
                0.5,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = u38.OuterShock.CFrame * CFrame.new(0, 7, 0)
            })
            local v62 = _G.tween
            local v63 = u38.InnerWave.Mesh
            local v64 = {
                0.5,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }
            local v65 = {}
            local v66 = u38.InnerWave.Mesh.Scale.X
            local v67 = u38.InnerWave.Mesh.Scale.Y + 12
            local v68 = u38.InnerWave.Mesh.Scale.Z
            v65.Scale = Vector3.new(v66, v67, v68)
            v62(v63, v64, v65)
            _G.tween(u38.InnerWave, {
                0.5,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = u38.InnerWave.CFrame * CFrame.new(0, 5, 0)
            })
            _G.tween(u38.Wave.Mesh, {
                0.5,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Scale"] = u38.Wave.Mesh.Scale * 3
            })
            _G.tween(u38.Wave, {
                0.5,
                "Quad",
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["CFrame"] = u38.Wave.CFrame * CFrame.new(0, -7, 0)
            })
            task.delay(0.25, function() --[[ Line: 180 ]]
                --[[
                Upvalues:
                    [1] = u38
                --]]
                _G.tween(u38.OuterShock, {
                    0.19047619047619047,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 1
                })
                _G.tween(u38.InnerWave, {
                    0.25,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 1
                })
                _G.tween(u38.InnerWave2, {
                    0.25,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 1
                })
                _G.tween(u38.Wave, {
                    0.5,
                    "Quad",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Transparency"] = 1
                })
            end)
        end
    end
}
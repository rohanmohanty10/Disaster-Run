 

local v1 = game:GetService("ReplicatedStorage")
local u2 = require(v1.Modules.Client.WeaponVFXRecolor)
local v3 = {}
local u4 = script.FirstMesh
local _ = script.SecMesh
local u5 = script.TMesh
local u6 = require(v1.Modules.VFXUtility.beam_emit)
local u7 = require(v1.Modules.VFXUtility.pointlight_emit)
local u8 = require(script.FlipbookMesh)
local function u15(p9, p10, _) --[[ Line: 14 ]]
    local v11 = p9.Position
    local v12 = p9.LookVector:Cross(p10).Unit
    local v13 = (v12.Magnitude > 0.001 and v12 and v12 or p9.RightVector).Unit
    local v14 = v13:Cross(p10).Unit.Unit
    return CFrame.fromMatrix(v11, v13, p10, v14)
end
local function u19(p16) --[[ Line: 28 ]]
    local v17 = p16:GetDescendants()
    for v18 = 1, #v17 do
        if v17[v18]:IsA("ParticleEmitter") then
            v17[v18].LockedToPart = false
        end
    end
end
local function u23(p20) --[[ Line: 37 ]]
    local v21 = p20:GetDescendants()
    for v22 = 1, #v21 do
        if v21[v22]:IsA("ParticleEmitter") then
            v21[v22].LockedToPart = true
        end
    end
end
function v3.start(_, u24, p25) --[[ Line: 46 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u23
        [3] = u8
        [4] = u4
        [5] = u19
        [6] = u15
        [7] = u7
        [8] = u6
        [9] = u5
    --]]
    local v26 = p25.SlashType
    local v27 = p25.weaponType
    if u24.PrimaryPart == nil then
        return
    else
        local u28 = script.SFX.Normal:FindFirstChild(v26)
        if v27:match("Prestige") ~= nil then
            u28 = script.SFX.Prestige:FindFirstChild(v26)
        end
        if u28 then
            local v29 = workspace:GetServerTimeNow() - p25.serverTimeNow
            local u30 = u24.PrimaryPart
            local u31 = script.SlashesFolder[v27]
            local u32 = script.GroundVFX[v27]
            local u33 = script.CrackLines[v27]
            local _ = p25.ColorType
            local v34 = 0.2 - v29
            local v35 = p25.explodeTime - v29
            local u36 = p25.dmgRemote
            local v37 = u24 == game.Players.LocalPlayer.Character
            local u38 = Color3.fromRGB(195, 0, 0)
            if v27 == "Hollow\'s World Ender" then
                u38 = Color3.fromRGB(0, 255, 0)
            elseif v27 == "Prestige World Ender" then
                u38 = Color3.fromRGB(85, 85, 255)
            end
            u23(u31)
            _G.PlaySound(u30, u28.slashsfx).Parent = u30
            if v37 then
                task.delay(v35, function() --[[ Line: 102 ]]
                    --[[
                    Upvalues:
                        [1] = u36
                        [2] = u24
                    --]]
                    u36:FireServer(u24.PrimaryPart.CFrame)
                end)
            end
            local function u46(p39, p40) --[[ Line: 107 ]]
                --[[
                Upvalues:
                    [1] = u33
                    [2] = u2
                    [3] = u24
                    [4] = u8
                --]]
                local v41 = u33:GetChildren()
                local v42 = p40 or 1
                for v43 = 1, #v41 do
                    local v44 = v41[v43]:Clone()
                    u2.apply(v44, u24)
                    v44.Parent = p39
                    for _, v45 in pairs(v44:GetChildren()) do
                        v45.Attachment0 = p39.Attachment0
                        v45.Attachment1 = p39.Attachment1
                        v45.Width0 = v45.Width0 * v42
                        v45.Width1 = v45.Width1 * v42
                    end
                    u8:Play({
                        ["Model"] = v44,
                        ["Speed"] = 0.125,
                        ["Looped"] = false
                    })
                end
            end
            if v26 == "Slash1" then
                local u47 = nil
                task.delay(v34 + 0.1, function() --[[ Line: 135 ]]
                    --[[
                    Upvalues:
                        [1] = u47
                        [2] = u31
                        [3] = u2
                        [4] = u24
                        [5] = u30
                        [6] = u4
                    --]]
                    local v48 = u31.T1:Clone()
                    u2.apply(v48, u24)
                    v48.Parent = u30
                    _G.customEmit(v48)
                    _G.destroy(v48, 5)
                    u47 = v48
                    u4.Slash1.CFrame = u30.CFrame * CFrame.new(0, 0, 0) * CFrame.Angles(0, 1.5707963267948966, 0)
                end)
                task.delay(v35, function() --[[ Line: 142 ]]
                    --[[
                    Upvalues:
                        [1] = u47
                        [2] = u19
                        [3] = u30
                        [4] = u32
                        [5] = u2
                        [6] = u24
                        [7] = u15
                        [8] = u46
                        [9] = u7
                        [10] = u38
                        [11] = u28
                        [12] = u4
                        [13] = u6
                    --]]
                    if u47 then
                        u19(u47)
                    end
                    local v49, v50, v51 = _G.getRayFloor(u30.CFrame, 15)
                    if v49 then
                        local v52 = u32.T1FX:Clone()
                        u2.apply(v52, u24)
                        v52.CFrame = u15(CFrame.new(Vector3.new(), u30.CFrame.LookVector) + v50, v51) * CFrame.new(0, 0.1, -14)
                        _G.recolorParticles(v52, v49.Color, "UseGroundColor")
                        v52.Parent = workspace.Effects
                        u46(v52.Beams)
                        _G.customEmit(v52)
                        local v53 = v52:FindFirstChild("TailorLight")
                        u7(v52, v53 and v53.Color or u38, 0.25, 15, 25, 5)
                        _G.destroy(v52, 5)
                        _G.PlaySound(v52, u28.boom)
                        local v54 = u4.Beams1
                        v54.CFrame = u15(CFrame.new(Vector3.new(), u30.CFrame.LookVector) + u30.Position, v51) * CFrame.Angles(3.141592653589793, 3.141592653589793, 0)
                        u6(v54, {
                            ["Properties"] = {
                                ["Brightness"] = 0,
                                ["LightEmission"] = 1,
                                ["TextureSpeed"] = 0.5,
                                ["Width0"] = 3,
                                ["Width1"] = 9
                            },
                            ["RotationSpeed"] = 0,
                            ["Rotation"] = true,
                            ["Offset"] = CFrame.new(0, 0, 0),
                            ["Duration"] = 1.3,
                            ["Easing"] = "Sine",
                            ["EasingDirection"] = "Out"
                        })
                        _G.shakenear(v52.Position, 125, 75, 60, -0.5)
                    end
                end)
            elseif v26 == "Slash2" then
                local u55 = nil
                task.delay(v34 + 0.1, function() --[[ Line: 193 ]]
                    --[[
                    Upvalues:
                        [1] = u55
                        [2] = u31
                        [3] = u2
                        [4] = u24
                        [5] = u30
                    --]]
                    local v56 = u31.T2:Clone()
                    u2.apply(v56, u24)
                    v56.Parent = u30
                    _G.customEmit(v56)
                    _G.destroy(v56, 5)
                    u55 = v56
                end)
                task.delay(v35, function() --[[ Line: 197 ]]
                    --[[
                    Upvalues:
                        [1] = u55
                        [2] = u19
                        [3] = u30
                        [4] = u32
                        [5] = u2
                        [6] = u24
                        [7] = u15
                        [8] = u46
                        [9] = u7
                        [10] = u38
                        [11] = u28
                    --]]
                    if u55 then
                        u19(u55)
                    end
                    local v57, v58, v59 = _G.getRayFloor(u30.CFrame, 15)
                    if v57 then
                        local u60 = u32.T2FX:Clone()
                        u2.apply(u60, u24)
                        u60.CFrame = u15(CFrame.new(Vector3.new(), u30.CFrame.LookVector) + v58, v59)
                        _G.recolorParticles(u60, v57.Color, "UseGroundColor")
                        u60.Parent = workspace.Effects
                        u46(u60.One, 0.75)
                        task.delay(0.1, function() --[[ Line: 214 ]]
                            --[[
                            Upvalues:
                                [1] = u46
                                [2] = u60
                            --]]
                            u46(u60.Two, 0.75)
                        end)
                        task.delay(0.2, function() --[[ Line: 218 ]]
                            --[[
                            Upvalues:
                                [1] = u46
                                [2] = u60
                            --]]
                            u46(u60.Three, 0.75)
                        end)
                        local v61 = u60:FindFirstChild("TailorLight")
                        u7(u60, v61 and v61.Color or u38, 0.25, 15, 25, 5)
                        _G.customEmit(u60)
                        _G.destroy(u60, 5)
                        _G.PlaySound(u60, u28.boom)
                    end
                end)
            elseif v26 == "Slash3" then
                local u62 = nil
                task.delay(v34, function() --[[ Line: 236 ]]
                    --[[
                    Upvalues:
                        [1] = u62
                        [2] = u31
                        [3] = u2
                        [4] = u24
                        [5] = u30
                    --]]
                    local v63 = u31.T3:Clone()
                    u2.apply(v63, u24)
                    v63.Parent = u30
                    _G.customEmit(v63)
                    _G.destroy(v63, 5)
                    u62 = v63
                end)
                task.delay(v35, function() --[[ Line: 240 ]]
                    --[[
                    Upvalues:
                        [1] = u62
                        [2] = u19
                        [3] = u30
                        [4] = u32
                        [5] = u2
                        [6] = u24
                        [7] = u15
                        [8] = u28
                        [9] = u7
                        [10] = u38
                        [11] = u5
                        [12] = u6
                    --]]
                    if u62 then
                        u19(u62)
                    end
                    local v64, v65, v66 = _G.getRayFloor(u30.CFrame * CFrame.new(0, 4, -14), 15)
                    if v64 then
                        local v67 = u32.Ground:Clone()
                        u2.apply(v67, u24)
                        v67.CFrame = u15(CFrame.new(Vector3.new(), u30.CFrame.LookVector) + v65, v66) * CFrame.new(0, 0.1, 0)
                        _G.recolorParticles(v67, v64.Color, "UseGroundColor")
                        v67.Parent = workspace.Effects
                        _G.customEmit(v67)
                        _G.destroy(v67, 5)
                        _G.PlaySound(v67, u28.boom)
                        local v68 = v67:FindFirstChild("TailorLight")
                        u7(v67, v68 and v68.Color or u38, 0.25, 15, 35, 5)
                        local v69 = u5.Beams1
                        v69.CFrame = v67.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 1, 0)
                        u6(v69, {
                            ["Properties"] = {
                                ["Brightness"] = 0,
                                ["LightEmission"] = 1,
                                ["TextureSpeed"] = 1,
                                ["Width0"] = 5,
                                ["Width1"] = 15
                            },
                            ["RotationSpeed"] = 100,
                            ["Rotation"] = true,
                            ["Offset"] = CFrame.new(0, 0, 0),
                            ["Duration"] = 1,
                            ["Easing"] = "Sine",
                            ["EasingDirection"] = "Out"
                        })
                        local v70 = u5.Beams2
                        v70.CFrame = v67.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 1, 0)
                        u6(v70, {
                            ["Properties"] = {
                                ["Brightness"] = 0,
                                ["LightEmission"] = 1,
                                ["TextureSpeed"] = 0,
                                ["Width0"] = 0,
                                ["Width1"] = 0
                            },
                            ["RotationSpeed"] = 100,
                            ["Rotation"] = true,
                            ["Offset"] = CFrame.new(0, 0, 0),
                            ["Duration"] = 1.9,
                            ["Easing"] = "Sine",
                            ["EasingDirection"] = "Out"
                        })
                        _G.PlayEffect("GroundRocks4", nil, {
                            ["Segments"] = 15,
                            ["Position"] = v67.Position + Vector3.new(0, 5, 0),
                            ["DistanceRandomness"] = Vector2.new(0.5, 1),
                            ["Duration"] = 3,
                            ["TweenDuration"] = 1,
                            ["Radius"] = 12,
                            ["Direction"] = Vector3.new(0, -35, 0)
                        })
                        _G.PlayEffect("RockDebris", nil, {
                            ["PartCount"] = 8,
                            ["RandomVelocityMagnitude"] = Vector2.new(-35, 35),
                            ["Position"] = v67.Position,
                            ["Direction"] = Vector3.new(0, 75, 0),
                            ["RaycastDirection"] = Vector3.new(0, -5, 0),
                            ["Size"] = Vector3.new(0.825, 0.825, 0.825),
                            ["TrailEnabled"] = true
                        })
                        _G.shakenear(v67.Position, 125, 90, 75, -0.5)
                    end
                end)
            end
        end
    end
end
return v3
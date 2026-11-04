 

local v1 = game:GetService("ReplicatedStorage")
local u2 = require(v1.Modules.Client.WeaponVFXRecolor)
local v3 = {}
local u4 = require(v1.Modules.VFXUtility.beam_emit)
local u5 = require(v1.Modules.VFXUtility.pointlight_emit)
local u6 = require(v1.Modules.VFXUtility.mesh_emit)
require(v1.Modules.VFXUtility.bezier_projectile_util)
local u7 = require(v1.Modules.VFXUtility.highlight_emit)
local u8 = script.mesh
local function u13(p9, u10) --[[ Line: 22 ]]
    p9.Archivable = true
    local u11 = p9:Clone()
    u11.PrimaryPart.Anchored = true
    task.spawn(function() --[[ Line: 27 ]]
        --[[
        Upvalues:
            [1] = u11
            [2] = u10
        --]]
        for _, v12 in u11:GetDescendants() do
            if v12:IsA("BodyVelocity") then
                v12:Destroy()
            elseif v12:IsA("BaseScript") then
                v12:Destroy()
            elseif v12:IsA("Weld") or v12:IsA("Motor6D") then
                if v12.Part1 and v12.Part1:IsDescendantOf(u11) == false then
                    v12:Destroy()
                end
            elseif v12:IsA("BasePart") then
                v12.CanTouch = false
                v12.CollisionGroupId = 6
                v12.CanCollide = false
                v12.CanQuery = false
                v12.CastShadow = false
                if v12.Transparency == 1 then
                    v12:SetAttribute("trans", true)
                else
                    v12.Transparency = 0
                end
                if v12:IsA("MeshPart") then
                    v12.TextureID = ""
                end
                v12.Color = u10
                v12.Material = Enum.Material.Neon
            elseif v12:IsA("ParticleEmitter") or v12:IsA("BillboardGui") then
                v12:Destroy()
            elseif v12:IsA("Highlight") then
                v12:Destroy()
            elseif v12:IsA("Decal") then
                v12:Destroy()
            end
        end
    end)
    u11:PivotTo(p9.PrimaryPart.CFrame)
    u11.Parent = workspace.Effects
    u11:PivotTo(p9:GetPrimaryPartCFrame())
    return u11
end
function v3.start(_, u14, p15) --[[ Line: 73 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u13
        [3] = u6
        [4] = u8
        [5] = u4
        [6] = u7
        [7] = u5
    --]]
    if u14.PrimaryPart == nil then
        return
    end
    local v16 = workspace:GetServerTimeNow() - p15.serverTimeNow
    local v17 = u14.PrimaryPart
    local v18 = p15.endTime - v16
    local v19 = p15.Target
    local v20 = p15.weaponType
    local v21 = script.ColorableVFX:FindFirstChild(v20)
    local v22 = script.CharacterVFX:FindFirstChild(v20)
    local v23, v24, v25 = _G.getRayFloor(u14.PrimaryPart.CFrame, 7)
    local v26 = CFrame.new(v24, v24 + v25) * CFrame.Angles(-1.5707963267948966, 0, 0)
    local v27 = Color3.fromRGB(255, 85, 0)
    if v20 == "Hollow\'s World Ender" then
        v27 = Color3.fromRGB(0, 255, 0)
    elseif v20 == "Prestige World Ender" then
        v27 = Color3.fromRGB(85, 85, 255)
    end
    local u28 = u13(v19, v27)
    local v29 = v21.Enable:Clone()
    u2.apply(v29, u14)
    u6.new(v29):EmitRate(15, 1, v17.CFrame * CFrame.new(v29:GetAttribute("Offset")))
    local v30 = u8.Shockwave:Clone()
    u6.new(v30):Emit(v17.CFrame * CFrame.new(v30:GetAttribute("Offset")))
    local v31 = v22.HumanoidRootPart.SwordThrust:Clone()
    u2.apply(v31, u14)
    if v23 == nil then
        _G.removeGroundParticles(v31)
    else
        _G.recolorParticles(v31, v23.Color, "UseGroundColor")
    end
    v31.Parent = v17
    if v23 then
        local v32 = { v31.Smoke, v31.Wind }
        for v33 = 1, #v32 do
            v32[v33].Parent = workspace.Terrain
            v32[v33].WorldCFrame = v26
            _G.customEmit(v32[v33])
            _G.destroy(v32[v33], 5)
        end
    end
    _G.customEmit(v31)
    _G.destroy(v31, 5)
    local v34 = v22.playerTorso.Suck:Clone()
    u2.apply(v34, u14)
    v34.Parent = u14.UpperTorso
    _G.particleEnabled(v34, true)
    local v35 = v22.targetTorso.Eater:Clone()
    u2.apply(v35, u14)
    if v19:FindFirstChild("UpperTorso") then
        v35.Parent = v19.UpperTorso
    else
        v35.Parent = v19.PrimaryPart
    end
    _G.particleEnabled(v35, true)
    local v36 = script.mesh.Wind1
    v36.CFrame = v17.CFrame * CFrame.new(0, 0, -12) * CFrame.Angles(3.141592653589793, 3.141592653589793, 0)
    u4(v36, {
        ["Properties"] = {
            ["Brightness"] = 0,
            ["LightEmission"] = 1,
            ["TextureSpeed"] = 0.5,
            ["Width0"] = 3,
            ["Width1"] = 9
        },
        ["RotationSpeed"] = 150,
        ["Rotation"] = true,
        ["Offset"] = CFrame.new(0, 0, 0),
        ["Duration"] = 1,
        ["Easing"] = "Sine",
        ["EasingDirection"] = "Out"
    })
    local v37 = script.mesh.Beams2
    v37.CFrame = v17.CFrame * CFrame.new(0, 0, -8) * CFrame.Angles(3.141592653589793, 3.141592653589793, 0)
    u4(v37, {
        ["Properties"] = {
            ["Brightness"] = 0,
            ["LightEmission"] = 1,
            ["TextureSpeed"] = 2,
            ["Width0"] = 1,
            ["Width1"] = 8
        },
        ["RotationSpeed"] = 25,
        ["Rotation"] = true,
        ["Offset"] = CFrame.new(0, 0, 0),
        ["Duration"] = 2,
        ["Easing"] = "Sine",
        ["EasingDirection"] = "Out"
    })
    local v38 = v21.Sucks
    u2.apply(v38, u14)
    v38.CFrame = v17.CFrame * CFrame.new(0, 0, -8) * CFrame.Angles(3.141592653589793, 3.141592653589793, 0)
    u4(v38, {
        ["Properties"] = {
            ["Brightness"] = 6,
            ["LightEmission"] = 0,
            ["TextureSpeed"] = 2,
            ["Width0"] = 2,
            ["Width1"] = 0
        },
        ["RotationSpeed"] = 150,
        ["Rotation"] = true,
        ["Offset"] = CFrame.new(0, 0, 0),
        ["Duration"] = 1.6,
        ["Easing"] = "Sine",
        ["EasingDirection"] = "Out"
    })
    local u39
    if v19 == game.Players.LocalPlayer.Character then
        u39 = script.ColorCorrection:Clone()
        u39.TintColor = Color3.fromRGB(255, 255, 255)
        u39.Parent = workspace.CurrentCamera
        _G.tween(u39, {
            0.25,
            "Quad",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["TintColor"] = v27
        })
    else
        u39 = nil
    end
    if u28 and u28:FindFirstChild("Humanoid") then
        local v40 = u28.Humanoid:GetPlayingAnimationTracks()
        for v41 = 1, #v40 do
            v40[v41]:Stop(0)
        end
        local v42 = u28.Humanoid:LoadAnimation(script.soul)
        v42:Play(0)
        v42:AdjustWeight(5)
    end
    local v43 = tick()
    local v44 = 0
    local v45 = {}
    while true do
        if tick() - v44 >= 0.035 then
            if v19 == nil or v19 and v19:FindFirstChild("UpperTorso") == nil then
                task.wait()
            else
                if u14 ~= nil and (not u14 or u14:FindFirstChild("RightHand") ~= nil) then
                    local v46 = Instance.new("Attachment")
                    local v47 = math.random(-360, 360)
                    local v48 = math.random(-360, 360)
                    local v49 = math.random
                    v46.Orientation = Vector3.new(v47, v48, v49(-360, 360))
                    v46.Parent = v19.UpperTorso
                    local v50 = v46:Clone()
                    local v51 = math.random(-360, 360)
                    local v52 = math.random(-360, 360)
                    local v53 = math.random
                    v50.Orientation = Vector3.new(v51, v52, v53(-360, 360))
                    v50.Parent = u14.RightHand
                    local v54 = v22.beam:Clone()
                    u2.apply(v54, u14)
                    v54.Attachment0 = v46
                    v54.Attachment1 = v50
                    v54.CurveSize0 = math.random(3, 6) / 1.5
                    if math.random(1, 2) == 1 then
                        v54.CurveSize0 = -v54.CurveSize0
                    end
                    v54.CurveSize1 = v54.CurveSize0 * -2
                    v54.Width1 = math.random(1, 3)
                    v54.TextureSpeed = math.random(100, 150) / 100
                    v54.Parent = workspace.Effects
                    _G.tween(v54, {
                        0.75,
                        "Quad",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["CurveSize0"] = v54.CurveSize0 * -2,
                        ["CurveSize1"] = v54.CurveSize1 * 2,
                        ["Width0"] = 0
                    })
                    table.insert(v45, v54)
                    _G.destroy({ v46, v50, v54 }, 1)
                    v44 = tick()
                end
                task.wait()
            end
        else
            task.wait()
        end
        if v18 <= tick() - v43 then
            local v55 = u7.tweenHighlight(u14, v27, v27, 0.25, Enum.HighlightDepthMode.Occluded, "In", 0.5)
            local v56 = v22:FindFirstChild("SoulHighlight")
            local v57 = v55 and v56 and v56:GetAttribute("UniqueID")
            if v57 then
                v55:SetAttribute("UniqueID", v57)
                u2.apply(v55, u14)
            end
            for v58 = 1, #v45 do
                if v45[v58] ~= nil then
                    local v59 = v45[v58]
                    _G.tween(v59, {
                        0.5,
                        "Quad",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Width0"] = 0,
                        ["Width1"] = 0
                    })
                end
            end
            task.delay(0.2, function() --[[ Line: 340 ]]
                --[[
                Upvalues:
                    [1] = u28
                    [2] = u39
                --]]
                local v60 = u28:GetDescendants()
                for v61 = 1, #v60 do
                    if v60[v61]:IsA("BasePart") then
                        _G.tween(v60[v61], {
                            0.25,
                            Enum.EasingStyle.Quad,
                            Enum.EasingDirection.Out,
                            0,
                            false,
                            0
                        }, {
                            ["Transparency"] = 1,
                            ["Color"] = Color3.fromRGB(0, 0, 0)
                        })
                    end
                end
                if u39 then
                    _G.tween(u39, {
                        0.25,
                        "Quad",
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["TintColor"] = Color3.fromRGB(255, 255, 255)
                    })
                    _G.destroy(u39, 0.25)
                end
                _G.destroy(u28, 0.25)
            end)
            local v62 = u8.Ring:Clone()
            u6.new(v62):Emit(v17.CFrame * CFrame.new(v62:GetAttribute("Offset")))
            local v63 = u8.GoUp:Clone()
            u6.new(v63):Emit(v17.CFrame * CFrame.new(v63:GetAttribute("Offset")))
            local v64 = u8.PullShock:Clone()
            u6.new(v64):Emit(v17.CFrame * CFrame.new(v64:GetAttribute("Offset")))
            local v65 = script.mesh.Beams3
            v65.CFrame = v17.CFrame * CFrame.new(0, 0, 0) * CFrame.Angles(0, 0, 0)
            u4(v65, {
                ["Properties"] = {
                    ["Brightness"] = 0,
                    ["LightEmission"] = 1,
                    ["TextureSpeed"] = 1,
                    ["Width0"] = 0,
                    ["Width1"] = 12
                },
                ["RotationSpeed"] = 0,
                ["Rotation"] = true,
                ["Offset"] = CFrame.new(0, 0, 0),
                ["Duration"] = 1,
                ["Easing"] = "Sine",
                ["EasingDirection"] = "Out"
            })
            local v66 = v22.playerTorso.Finish
            local v67 = u14.UpperTorso
            local v68 = v66:Clone()
            u2.apply(v68, u14)
            v68.Parent = v67
            _G.customEmit(v68)
            _G.destroy(v68, 5)
            local v69 = v22.HumanoidRootPart.PullOut:Clone()
            u2.apply(v69, u14)
            if v23 == nil then
                _G.removeGroundParticles(v69)
            else
                _G.recolorParticles(v69, v23.Color, "UseGroundColor")
            end
            v69.Parent = v17
            if v23 then
                local v70 = { v69.Smoke, v69.Wind }
                for v71 = 1, #v70 do
                    v70[v71].Parent = workspace.Terrain
                    v70[v71].WorldCFrame = v26
                    _G.customEmit(v70[v71])
                    _G.destroy(v70[v71], 5)
                end
            end
            _G.customEmit(v69)
            _G.destroy(v69, 5)
            _G.particleEnabled(v34, false)
            _G.destroy(v34, 5)
            _G.particleEnabled(v35, false)
            _G.destroy(v35, 5)
            local v72 = Random.new()
            for _ = 1, 6 do
                local v73 = _G.PlayEffect
                local v74 = {
                    ["origin"] = v19.PrimaryPart.CFrame,
                    ["Amount"] = 1,
                    ["Velocity"] = 15,
                    ["TimeUntilDelete"] = 2
                }
                local v75 = -u14.PrimaryPart.CFrame.LookVector * v72:NextNumber(25, 50)
                local v76 = v72:NextNumber(-35, 35)
                local v77 = v72:NextNumber(5, 15)
                v74.CustomVelocity = v75 + Vector3.new(v76, v77, v72:NextNumber(-35, 35)) * 0.1
                v74.Projectile = script.TrailPart
                v74.HitVFX = script.BloodExplode
                function v74.CustomHitFunction(p78) --[[ Line: 437 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u14
                        [3] = u5
                    --]]
                    local v79 = script.BloodExplode:Clone()
                    u2.apply(v79, u14)
                    v79.CFrame = p78
                    v79.Parent = workspace.Effects
                    u5(v79, Color3.fromRGB(208, 43, 43), 1, 1, 3, 3)
                    _G.destroy(v79, 4)
                end
                v73("CustomImpactDroplet", nil, v74)
            end
            for _ = 1, 5 do
                task.wait(0.3)
                local v80 = _G.PlayEffect
                local v81 = {
                    ["origin"] = v19.PrimaryPart.CFrame,
                    ["Amount"] = 1,
                    ["Velocity"] = 15,
                    ["TimeUntilDelete"] = 2
                }
                local v82 = -v19.PrimaryPart.CFrame.LookVector * v72:NextNumber(2, 4)
                local v83 = v72:NextNumber(-5, 5)
                local v84 = v72:NextNumber(3, 5)
                v81.CustomVelocity = v82 + Vector3.new(v83, v84, v72:NextNumber(-5, 5))
                v81.Projectile = script.TrailPart
                v81.HitVFX = script.BloodExplode
                function v81.CustomHitFunction(p85) --[[ Line: 460 ]]
                    --[[
                    Upvalues:
                        [1] = u2
                        [2] = u14
                        [3] = u5
                    --]]
                    local v86 = script.BloodExplode:Clone()
                    u2.apply(v86, u14)
                    v86.CFrame = p85
                    v86.Parent = workspace.Effects
                    u5(v86, Color3.fromRGB(208, 43, 43), 1, 1, 3, 3)
                    _G.destroy(v86, 4)
                end
                v80("CustomImpactDroplet", nil, v81)
            end
            return
        end
    end
end
return v3
 

local v1 = {}
game:GetService("Debris")
local u2 = game:GetService("TweenService")
game:GetService("RunService")
local u3 = script:WaitForChild("VFX")
workspace:WaitForChild("Effects")
require(script.Parent:WaitForChild("Shared"))
local u4 = require(script.Parent.NapSoulLightning)
local _ = script.Parent.LightningHits
local u5 = Random.new()
local u6 = RaycastParams.new()
u6.FilterType = Enum.RaycastFilterType.Include
u6.FilterDescendantsInstances = { workspace.Islands, workspace.Ships, workspace.Env }
function v1.start(_, p7, p8) --[[ Line: 41 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u5
        [3] = u2
        [4] = u6
        [5] = u4
    --]]
    local _ = p8.State
    local v9 = p7:FindFirstChild(script.Parent.Name .. "Sword")
    local _ = p8.Remote
    local v10 = p8.aimTag
    local _ = p7 == game.Players.LocalPlayer.Character
    local u11 = p7:GetAttribute("SoulCleaverBlazed") == true
    local v12 = script.SFX.Normal
    if u11 == true then
        v12 = script.SFX.Fire
    end
    _G.PlaySound(p7.PrimaryPart, v12.Start).Parent = p7.PrimaryPart
    task.wait(p8.beamStartTime - workspace:GetServerTimeNow())
    local v13, v14, v15, v16
    if u11 == true then
        v13 = u3.FireVariants.FireElectricityCharging:Clone()
        v14 = u3.FireVariants.FireElecHit:Clone()
        v15 = ColorSequence.new(Color3.fromRGB(255, 122, 55))
        v16 = u3.FireVariants.FireElectricityStartPos
    else
        v13 = u3.ElectricityCharging:Clone()
        v14 = u3.ElecHit:Clone()
        v15 = ColorSequence.new(Color3.fromRGB(102, 42, 255))
        v16 = u3.ElectricityStartPos
    end
    if v9 then
        v13.Weld.Part0 = v9.RootPart
        for _, v17 in pairs(v13:QueryDescendants("ParticleEmitter")) do
            v17.Rate = 25
            v17.Enabled = true
        end
        v13.Parent = workspace.Effects
    else
        v13:Destroy()
        v13 = nil
    end
    local v18 = { u3.Swirly1, u3.Swirly2 }
    local v19 = {
        -90,
        90,
        -180,
        180
    }
    for _ = 1, 3 do
        local v20 = u5:NextNumber(0.75, 1.5)
        local v21 = u5:NextNumber(2, 3.25)
        local v22 = u5:NextNumber(0.175, 0.3)
        local v23 = v18[math.random(1, #v18)]:Clone()
        local v24 = 5 * v20
        local v25 = 2.5 * v20
        local v26 = 5 * v20
        v23.Size = Vector3.new(v24, v25, v26)
        v23.CFrame = p7.HumanoidRootPart.CFrame * CFrame.new(0, u5:NextNumber(-2, -1), 0) * CFrame.Angles(0, u5:NextNumber(-180, -180), 0)
        v23.Color = Color3.fromRGB(185, 185, 185)
        v23.Parent = workspace.Effects
        local v27 = u2
        local v28 = TweenInfo.new(v22, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out)
        local v29 = {}
        local v30 = 10 * v21
        local v31 = 5 * (v21 / u5:NextNumber(1, 1.25))
        local v32 = 10 * v21
        v29.Size = Vector3.new(v30, v31, v32)
        local v33 = v23.CFrame * CFrame.new(0, -1, 0)
        local v34 = CFrame.Angles
        local v35 = u5:NextNumber(-2.5, 2.5)
        local v36 = math.rad(v35)
        local v37 = v19[math.random(1, #v19)]
        local v38 = math.rad(v37)
        local v39 = u5:NextNumber(-2.5, 2.5)
        v29.CFrame = v33 * v34(v36, v38, (math.rad(v39)))
        v29.Transparency = 1
        v27:Create(v23, v28, v29):Play()
        task.delay(v22, v23.Destroy, v23)
    end
    local v40 = v16:Clone()
    if v9 then
        v40.Weld.Part0 = v9.RootPart
        v9:QueryDescendants("BaseParts")
    else
        v40.Weld.Part0 = p7.PrimaryPart
        p7:QueryDescendants("BaseParts")
    end
    v40.Parent = workspace.Effects
    v14.Parent = workspace.Effects
    local v41 = p8.maxRange
    local _ = CFrame.identity
    local u42 = v14.Attachment
    local v43 = v40.Attachment
    local v44 = u2:Create(v14.Attachment.PointLight, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true), {
        ["Range"] = v14.Attachment.PointLight.Range * 1.25
    })
    v44:Play()
    local v45 = v12.BeamLoop:Clone()
    v45.Parent = p7.PrimaryPart
    v45:Play()
    local v46 = v12.GroundBurnLoop:Clone()
    v46.Parent = v14
    v46.Volume = 0
    v46:Play()
    local v47 = v14:FindFirstChild("FaceCamera")
    local v48 = u2:Create(v46, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Volume"] = 0.35
    })
    local v49 = u2:Create(v46, TweenInfo.new(0.15, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        ["Volume"] = 0
    })
    local v50 = 0
    local u51 = {}
    local v52 = 0
    local v53 = 0
    while true do
        local v54 = task.wait()
        v10:GetAttribute("MousePosition")
        local v55 = (p7.PrimaryPart.CFrame * CFrame.new(0, 0, -(v41 + 50))).Position
        if v55 then
            local v56 = RaycastParams.new()
            local v57 = Enum.RaycastFilterType.Include
            local v58 = _G.getTargetsWithENV(p7)
            v56.FilterType = v57
            v56.FilterDescendantsInstances = v58
            local v59 = CFrame.new(p7.PrimaryPart.Position, v55)
            local v60 = v59.LookVector * v41
            local v61 = workspace:Raycast(v59.Position, v60, v56)
            if v61 and v61.Instance then
                local v62 = v61.Instance
                if v62:IsDescendantOf(workspace.NPCs) or v62:IsDescendantOf(workspace.PlayerCharacters) then
                    local v63, v64, v65 = _G.getRayFloor(CFrame.new(v61.Position), 5)
                    v61 = v63 and {
                        ["Instance"] = v63,
                        ["Position"] = v64,
                        ["Normal"] = v65
                    } or v61
                end
                local v66 = v61.Position
                local v67 = v61.Normal
                v14.CFrame = CFrame.new(v66, v66 + v67) * CFrame.Angles(-1.5725416560468908, 0, 0) * CFrame.new(0, 0.1, 0)
                v14.Attachment.PointLight.Enabled = true
                _G.particleEnabled(v14, true)
                if v46.Volume < 0.35 and v48.PlaybackState ~= Enum.PlaybackState.Playing then
                    v48:Play()
                end
            else
                local v68 = v59.Position + v60
                v14.CFrame = CFrame.new(v68, v68 + Vector3.new(0, 1, 0)) * CFrame.Angles(-1.5707963267948966, 0, 0) * CFrame.new(0, 0.1, 0)
                v14.Attachment.PointLight.Enabled = false
                _G.particleEnabled(v14, false)
                if v46.Volume > 0 and v49.PlaybackState ~= Enum.PlaybackState.Playing then
                    v49:Play()
                end
            end
            if v47 then
                v47.WorldCFrame = CFrame.new(v47.WorldPosition, v43.WorldPosition)
            end
            local v69 = v43.WorldPosition
            local v70 = v61 and v61.Position or v59.Position + v60
            v52 = v52 + v54
            v53 = v53 + v54
            v50 = v50 + v54
            if v53 >= 0.1 then
                CFrame.Angles(0, 0, 6.283185307179586 * math.random())
                v53 = 0
            end
            if v50 >= 0.1 and v61 then
                v50 = 0
                for _ = 1, math.random(2) do
                    local v71 = Vector3.new(0, 1, 0)
                    local v72 = v71:Dot(v61.Normal)
                    local v73 = (math.abs(v72) > 0.99 and Vector3.new(1, 0, 0) or v71):Cross(v61.Normal).Unit
                    local v74 = v73:Cross(v61.Normal).Unit
                    local v75 = -v61.Normal * 6 + (v73 + v74) * u5:NextUnitVector() * 15
                    local u76 = workspace:Raycast(v70 + v61.Normal * 5, v75, u6)
                    if u76 then
                        local _ = u76.Position
                        local v77 = u76.Normal:Cross(v75.Unit)
                        local u78 = Instance.new("Attachment")
                        u78.WorldCFrame = CFrame.fromMatrix(v70, v77, u76.Normal) * CFrame.Angles(0, 0, 1.5707963267948966)
                        u78.Parent = workspace.Terrain
                        task.spawn(function() --[[ Line: 268 ]]
                            --[[
                            Upvalues:
                                [1] = u78
                                [2] = u42
                            --]]
                            while u78.Parent do
                                u78.WorldPosition = u42.WorldPosition
                                task.wait()
                            end
                        end)
                        local u79 = Instance.new("Attachment")
                        u79.WorldCFrame = CFrame.fromMatrix(u76.Position, -v77, u76.Normal) * CFrame.Angles(0, 0, 1.5707963267948966)
                        u79.Parent = workspace.Terrain
                        local v80 = u5:NextNumber(2, 5)
                        local v81 = u4.new({
                            ["Attachment0"] = u78,
                            ["Attachment1"] = u79,
                            ["CurveSize0"] = v80,
                            ["CurveSize1"] = -v80,
                            ["Width"] = NumberRange.new(u5:NextNumber(0.4, 0.6)),
                            ["BoltDuration"] = u5:NextNumber(0.1, 0.25),
                            ["RadiusOffset"] = NumberRange.new(1, 2),
                            ["BeamColor"] = v15
                        })
                        task.delay(0.1, function() --[[ Line: 294 ]]
                            --[[
                            Upvalues:
                                [1] = u76
                                [2] = u11
                            --]]
                            _G.PlayEffect("NapLightningHitFloor", nil, u76, u11)
                        end)
                        v81.Destroyed:Once(function() --[[ Line: 298 ]]
                            --[[
                            Upvalues:
                                [1] = u78
                                [2] = u79
                            --]]
                            u78:Destroy()
                            u79:Destroy()
                        end)
                    end
                end
            end
            if v52 >= 0.05 then
                local v82 = math.random() * 360
                local v83 = (v69 - v70).Magnitude * 0.25
                local v84 = math.min(v83, 15)
                local u85 = u4.new({
                    ["Rotate0"] = v82,
                    ["Rotate1"] = v82,
                    ["Attachment0"] = v43,
                    ["Attachment1"] = u42,
                    ["CurveSize0"] = -v84,
                    ["CurveSize1"] = -v84,
                    ["Width"] = NumberRange.new(0.5, 1),
                    ["TextureSpeed"] = 5,
                    ["Duration"] = 0.1,
                    ["RadiusOffset"] = NumberRange.new(2, 5),
                    ["BeamColor"] = v15
                })
                u51[u85] = true
                u85.Destroyed:Once(function() --[[ Line: 328 ]]
                    --[[
                    Upvalues:
                        [1] = u51
                        [2] = u85
                    --]]
                    u51[u85] = nil
                end)
                local u86 = u4.new({
                    ["Attachment0"] = v43,
                    ["Attachment1"] = u42,
                    ["Width"] = NumberRange.new(2),
                    ["TextureSpeed"] = 2,
                    ["Duration"] = 0.1,
                    ["RadiusOffset"] = NumberRange.new(2),
                    ["BeamColor"] = v15
                })
                u51[u86] = true
                u86.Destroyed:Once(function() --[[ Line: 344 ]]
                    --[[
                    Upvalues:
                        [1] = u51
                        [2] = u86
                    --]]
                    u51[u86] = nil
                end)
                v52 = 0
            end
        else
            task.wait()
        end
        if p7:GetAttribute("MaserRayHold") == nil and v10:GetAttribute("EndCFrame") ~= nil then
            u2:Create(v45, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                ["Volume"] = 0
            }):Play()
            _G.destroy(v45, 0.25)
            u2:Create(v46, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                ["Volume"] = 0
            }):Play()
            _G.destroy(v46, 0.25)
            v44:Cancel()
            for v87 in u51 do
                v87:CancelUpdate()
                local u88 = u5:NextNumber(0.2, 0.3)
                for _, v89 in v87.Data do
                    for _, v90 in v89.Segments do
                        local u91 = v90.Beam
                        local v92 = v90.Attachment
                        task.spawn(function() --[[ Line: 367 ]]
                            --[[
                            Upvalues:
                                [1] = u91
                                [2] = u2
                                [3] = u88
                            --]]
                            local _ = u91.Width0
                            local _ = u91.Width1
                            u91.TextureSpeed = 1
                            u2:Create(u91, TweenInfo.new(u88, Enum.EasingStyle.Sine), {
                                ["Width0"] = 0,
                                ["Width1"] = 0
                            }):Play()
                        end)
                        local v93 = v43.WorldPosition:Lerp(u42.WorldPosition, v90.SegmentAlpha)
                        local v94 = (v92.WorldPosition - v93).Unit
                        u2:Create(v92, TweenInfo.new(u88, Enum.EasingStyle.Sine), {
                            ["WorldPosition"] = v92.WorldPosition + v94 * u5:NextNumber(5, 10) + (u42.WorldPosition - v43.WorldPosition).Unit * u5:NextNumber(0, 2.5)
                        }):Play()
                    end
                end
                task.delay(u88, v87.Destroy, v87)
            end
            u2:Create(v14.Attachment.PointLight, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["Brightness"] = 0,
                ["Range"] = 25
            }):Play()
            _G.particleEnabled(v14, false)
            _G.destroy(v14, 3)
            _G.particleEnabled(v40, false)
            _G.destroy(v40, 3)
            if v13 then
                _G.particleEnabled(v13, false)
                _G.destroy(v13, 3)
            end
            local v95, v96
            if p7:GetAttribute("SoulCleaverBlazed") == true then
                ColorSequence.new(Color3.fromRGB(255, 122, 55))
                v95 = u3.FireVariants.FireElecFinalHit:Clone()
                v96 = u3.FireVariants.FireElectricityEnding:Clone()
            else
                ColorSequence.new(Color3.fromRGB(102, 42, 255))
                v95 = u3.ElecFinalHit:Clone()
                v96 = u3.ElectricityEnding:Clone()
            end
            local v97 = v10:GetAttribute("EndCFrame")
            if v97 and v97 ~= "None" then
                v95.CFrame = v97
                v95.Parent = workspace.Effects
                u2:Create(v95.Attachment.PointLight, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    ["Brightness"] = 0,
                    ["Range"] = 25
                }):Play()
                _G.customEmit(v95)
                _G.destroy(v95, 3)
                local v98 = v97.UpVector
                _G.PlayEffect("GroundRocks4", nil, {
                    ["Segments"] = 15,
                    ["Position"] = v95.Position,
                    ["DistanceRandomness"] = Vector2.new(0.3, 1),
                    ["Duration"] = 4,
                    ["TweenDuration"] = 1,
                    ["Radius"] = 8,
                    ["Direction"] = -v98 * 15,
                    ["Angle"] = -0.7853981633974483
                })
                _G.PlayEffect("RockDebris", nil, {
                    ["PartCount"] = 5,
                    ["RandomVelocityMagnitude"] = Vector2.new(-45, 45) * 1,
                    ["Position"] = v95.Position,
                    ["Direction"] = v98 * 35,
                    ["RaycastDirection"] = -v98 * 15,
                    ["Size"] = Vector3.new(0.6, 0.6, 0.6),
                    ["TrailEnabled"] = true
                })
                _G.shakenear(v97.Position, 100, 75, 50, -1)
                _G.PlaySound(v97, v12.BeamEnd)
            else
                v95:Destroy()
            end
            if v97 == "None" then
                v97 = p7.PrimaryPart.CFrame * CFrame.new(0, 0, -1000)
            end
            v96.CFrame = CFrame.new(v40.Position, v97.Position) * CFrame.Angles(-1.5707963267948966, 0, 0)
            v96.Parent = workspace.Effects
            _G.customEmit(v96)
            _G.destroy(v96, 3)
            return
        end
    end
end
return v1
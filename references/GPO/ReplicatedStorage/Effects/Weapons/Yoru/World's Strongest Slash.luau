 

local v1 = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local v2 = game:GetService("Players")
game:GetService("TweenService")
require(game:GetService("ReplicatedStorage").Modules.CameraShaker)
require(v1.Modules.CraterHandler)
require(v1.Modules.ParticleTween)
local u3 = require(game.ReplicatedStorage.Modules.Client.WeaponVFXRecolor)
local _ = v2.LocalPlayer
local u4 = workspace.Effects
local function u15(p5, p6, p7) --[[ Line: 40 ]]
    local function v13(u8, p9, p10) --[[ Line: 41 ]]
        for _, v11 in ipairs(u8:GetDescendants()) do
            if v11:IsA("ParticleEmitter") or v11:IsA("Trail") then
                v11.Enabled = p9
            end
        end
        if p10 then
            task.delay(p10, function() --[[ Line: 49 ]]
                --[[
                Upvalues:
                    [1] = u8
                --]]
                for _, v12 in ipairs(u8:GetDescendants()) do
                    if v12:IsA("ParticleEmitter") or v12:IsA("Trail") then
                        v12.Enabled = false
                    end
                end
            end)
        end
    end
    if typeof(p5) == "table" then
        for _, v14 in p5 do
            v13(v14, p6, p7)
        end
    else
        v13(p5, p6, p7)
    end
end
local u16 = RaycastParams.new()
u16.FilterType = Enum.RaycastFilterType.Include
u16.FilterDescendantsInstances = { workspace.Terrain, workspace.Islands, workspace.Env }
local v17 = {}
local u18 = game:GetService("TweenService")
local function u26(p19) --[[ Line: 78 ]]
    --[[
    Upvalues:
        [1] = u18
    --]]
    local v20 = p19.Position
    local v21 = p19.Velocity
    local v22 = p19.AngularVelocity
    local v23 = p19.Size
    local v24 = p19.Material
    local _ = p19.Color
    local u25 = Instance.new("Part")
    u25.Material = v24
    u25.Size = v23
    u25.Position = v20
    u25.CollisionGroup = "Players"
    u25.Color = p19.Color
    u25.Massless = true
    u25.Parent = workspace.Effects
    u25.AssemblyLinearVelocity = v21
    u25.AssemblyAngularVelocity = v22
    task.delay(p19.Duration or math.random(200, 400) / 100, function() --[[ Line: 98 ]]
        --[[
        Upvalues:
            [1] = u18
            [2] = u25
        --]]
        u18:Create(u25, TweenInfo.new(1), {
            ["Size"] = Vector3.new(0, 0, 0)
        }):Play()
        _G.destroy(u25, 1)
    end)
    return u25
end
function v17.start(_, p27) --[[ Line: 112 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u4
        [3] = u15
        [4] = u16
        [5] = u18
        [6] = u26
    --]]
    local v28 = p27.Task
    local u29 = p27.char
    local v30 = p27.Start
    local u31 = p27.Goal
    local _ = p27.MaxDistance
    local u32 = p27.Speed
    local u33 = p27.swordModel
    local u34 = p27.totalSlices
    local v35 = u29.PrimaryPart
    local u36 = p27.Color
    if u29 == nil then
        return
    elseif _G.checkRenderDistance(u29.PrimaryPart.Position) == false then
        return
    elseif v28 == "Hold" then
        local u37 = 0.5 * u29.PrimaryPart.Size.Y + u29.Humanoid.HipHeight
        local _, v38, v39 = _G.getRayFloor(u29.PrimaryPart.CFrame, u37)
        local v40 = (u29.PrimaryPart.Position - v38).Magnitude - 1.75
        local v41 = math.clamp(v40, 0, 8)
        local v42 = CFrame.new(v38, v38 + v39) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -0.1, 0)
        local v43 = CFrame.new(v35.Position) * CFrame.new(0, -v41, 0)
        local v44 = script.Activation:Clone()
        v44.CFrame = v43
        if u36 then
            _G.recolorParticles(v44, u36)
            u3.apply(v44, u29)
        end
        v44.Parent = u4
        _G.customEmit(v44)
        _G.destroy(v44, 2)
        local u45 = script.Charge:Clone()
        u45.CFrame = v43
        u45.FloorAttachment.WorldCFrame = v42
        if u36 then
            _G.recolorParticles(u45, u36)
            u3.apply(u45, u29)
        end
        u45.Parent = u4
        u15(u45, true)
        local v46 = script.YoruGiantSlashStanceLoop:Clone()
        v46.Parent = u29.PrimaryPart
        v46:Play()
        local v47 = _G.PlaySound(u29.PrimaryPart, script.YoruGiantSlashStance)
        local u48 = script.weaponTrail:Clone()
        if u36 then
            u3.apply(u48, u29)
        end
        u48.CFrame = v35.CFrame
        u48.Parent = workspace.Effects
        local u49 = false
        local u50 = not (u33 and u33:FindFirstChild("Blade")) and 4 or u33.Blade.Size.Y
        task.spawn(function() --[[ Line: 175 ]]
            --[[
            Upvalues:
                [1] = u49
                [2] = u29
                [3] = u37
                [4] = u45
                [5] = u33
                [6] = u50
                [7] = u16
                [8] = u48
            --]]
            tick()
            while u49 == false and u29:IsDescendantOf(workspace) do
                local _, v51, v52 = _G.getRayFloor(u29.PrimaryPart.CFrame, u37)
                local v53 = (u29.PrimaryPart.Position - v51).Magnitude - 1.75
                math.clamp(v53, 0, 8)
                local v54 = CFrame.new(v51, v51 + v52) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -0.1, 0)
                u45.FloorAttachment.WorldCFrame = v54
                if u33 and u33:IsDescendantOf(workspace) then
                    local v55 = (u33.Blade.CFrame * CFrame.new(0, -u33.Blade.Size.Y / 2, 0)).Position
                    local v56 = workspace:Raycast(v55, u33.Blade.CFrame.UpVector * (u50 + 0.2), u16)
                    if v56 and v56.Instance then
                        u48.Trail2.Enabled = true
                        u48.CFrame = CFrame.new(v56.Position)
                        u48.Sparks.WorldCFrame = CFrame.new(v56.Position, v55)
                        _G.particleEnabled(u48.Sparks, true)
                    else
                        u48.Trail2.Enabled = false
                        _G.particleEnabled(u48.Sparks, false)
                    end
                end
                task.wait()
            end
            u48.Trail2.Enabled = false
            _G.destroy(u48, 2)
        end)
        repeat
            task.wait()
        until u29:GetAttribute("holdingStrongSlash") == nil
        u15(u45, false)
        _G.destroy(u45, 2)
        _G.tween(v46, {
            0.25,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Volume"] = 0
        })
        _G.destroy(v46, 0.25)
        _G.particleEnabled(u48.Sparks, false)
        if v47 then
            _G.tween(v47, {
                0.25,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Volume"] = 0
            })
            _G.destroy(v47, 0.25)
        end
        task.wait(0.5)
        local _ = true
        return
    elseif v28 == "TriggerTriple" then
        local v57 = Instance.new("Highlight")
        v57.FillColor = Color3.fromRGB(85, 255, 127)
        if u36 then
            v57.FillColor = u36
        end
        v57.OutlineTransparency = 1
        v57.FillTransparency = 0
        v57.OutlineTransparency = 1
        v57.OutlineColor = Color3.fromRGB(0, 0, 0)
        v57.DepthMode = Enum.HighlightDepthMode.Occluded
        v57.Parent = u29
        _G.tween(v57, {
            0.5,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["FillTransparency"] = 1,
            ["OutlineTransparency"] = 1
        })
        _G.destroy(v57, 0.5)
        local v58 = script.Activation2:Clone()
        v58.CFrame = v35.CFrame * CFrame.new(0, -1, 0)
        if u36 then
            _G.recolorParticles(v58, u36)
            u3.apply(v58, u29)
        end
        v58.Parent = u4
        _G.customEmit(v58)
        _G.destroy(v58, 2)
        _G.PlaySound(u29.PrimaryPart, script.YoruGiantSlashTick)
        return
    elseif v28 == "SlashStart" then
        local v59 = script.YRelease:Clone()
        v59.CFrame = CFrame.new(v30.Position, u31.Position) * CFrame.new(0, 0, -6)
        if u36 then
            _G.recolorParticles(v59, u36)
            u3.apply(v59, u29)
        end
        v59.Parent = u4
        _G.customEmit(v59)
        _G.destroy(v59, 1)
        for _, v60 in v59:GetDescendants() do
            if v60.ClassName == "Beam" then
                local _ = v60.Width0
                local _ = v60.Width1
                u18:Create(v60, TweenInfo.new(0.2), {
                    ["Width0"] = 0,
                    ["Width1"] = 0
                }):Play()
            end
        end
        local v61 = script.YReleaseExtra:Clone()
        v61.CFrame = CFrame.new(v30.Position, u31.Position) * CFrame.new(0, -1, 2) * CFrame.Angles(0, 3.141592653589793, 0)
        if u36 then
            _G.recolorParticles(v61, u36)
            u3.apply(v61, u29)
        end
        v61.Parent = u4
        _G.customEmit(v61)
        _G.destroy(v61, 5)
        for _, u62 in v61:GetDescendants() do
            if u62.ClassName == "Beam" then
                local v63 = u62.Width0
                local v64 = u62.Width1
                u62.Width0 = 0
                u62.Width1 = 0
                u18:Create(u62, TweenInfo.new(0.2), {
                    ["Width0"] = v63,
                    ["Width1"] = v64
                }):Play()
                task.delay(0.2, function() --[[ Line: 295 ]]
                    --[[
                    Upvalues:
                        [1] = u18
                        [2] = u62
                    --]]
                    u18:Create(u62, TweenInfo.new(0.2), {
                        ["Width0"] = 0,
                        ["Width1"] = 0
                    }):Play()
                end)
            end
        end
    elseif v28 == "Slash" then
        local v65 = CFrame.new(0, 5, 0)
        local u66 = script.Slash:Clone()
        u66:PivotTo(CFrame.new(v30.Position, u31.Position) * v65)
        if u36 then
            _G.recolorParticles(u66, u36)
            u3.apply(u66, u29)
        end
        u66.Parent = workspace.Effects
        _G.PlayEffect("RockFollow", nil, u66, 4, 2, nil, 0.25)
        u18:Create(u66, TweenInfo.new(u32, Enum.EasingStyle.Linear), {
            ["CFrame"] = u31 * v65
        }):Play()
        local v67 = _G.PlaySound(u66, script.YoruGiantSlashProjectileTravel, {
            ["Pitch"] = math.random(90, 110) / 100
        })
        v67.Parent = u66
        _G.tween(v67, {
            0.5,
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["RollOffMinDistance"] = 50
        })
        task.delay(u32 * 0.8, function() --[[ Line: 324 ]]
            --[[
            Upvalues:
                [1] = u66
                [2] = u18
                [3] = u32
            --]]
            for _, v68 in u66.Beams:GetDescendants() do
                if v68.ClassName == "Beam" then
                    local _ = v68.Width0
                    local _ = v68.Width1
                    u18:Create(v68, TweenInfo.new(u32 * 0.2), {
                        ["Width0"] = 0,
                        ["Width1"] = 0
                    }):Play()
                end
            end
            for _, v69 in u66.WindBeams:GetDescendants() do
                if v69.ClassName == "Beam" then
                    _G.tween(v69, {
                        u32 * 0.2,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Transparency"] = NumberSequence.new(1)
                    })
                end
            end
            for _, v70 in u66.Trails:GetDescendants() do
                if v70:IsA("Trail") then
                    _G.tween(v70, {
                        u32 * 0.2,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["WidthScale"] = NumberSequence.new(0)
                    })
                end
            end
            _G.tween(u66.PointLight, {
                u32 * 0.2,
                Enum.EasingStyle.Quad,
                Enum.EasingDirection.Out,
                0,
                false,
                0
            }, {
                ["Brightness"] = 0,
                ["Range"] = 45
            })
        end)
        task.spawn(function() --[[ Line: 347 ]]
            --[[
            Upvalues:
                [1] = u66
                [2] = u36
                [3] = u3
                [4] = u29
                [5] = u34
                [6] = u31
                [7] = u26
                [8] = u32
            --]]
            local v71 = tick()
            local v72 = script.trail:Clone()
            v72.CFrame = u66.CFrame
            if u36 then
                _G.recolorParticles(v72, u36)
                u3.apply(v72, u29)
            end
            v72.Parent = workspace.Effects
            local v73 = { v72.Trail, v72.Trail2 }
            local v74 = u66:GetDescendants()
            local v75 = 0
            local v76
            if u34 >= 3 then
                v76 = 0.06
            else
                v76 = 0.03
            end
            while true do
                local v77, v78, _ = _G.getRayFloor(u66.CFrame * CFrame.new(0, 30, 0), 65)
                if v77 then
                    for v79 = 1, #v74 do
                        if v74[v79]:IsA("ParticleEmitter") ~= false then
                            if v74[v79]:GetAttribute("recolorableGround") then
                                v74[v79].Color = ColorSequence.new(v77.Color)
                                if v74[v79]:GetAttribute("splitColor") == nil then
                                    v74[v79].Enabled = true
                                end
                                if v74[v79].Parent:IsA("Attachment") then
                                    local v80 = v74[v79].Parent.WorldPosition
                                    local v81 = v74[v79].Parent
                                    local v82 = v80.X
                                    local v83 = v78.Y
                                    local v84 = v80.Z
                                    v81.WorldPosition = Vector3.new(v82, v83, v84)
                                end
                            elseif v74[v79]:GetAttribute("requiresGround") then
                                v74[v79].Enabled = true
                            end
                        end
                    end
                    v72.CFrame = CFrame.new(v78, u31.Position)
                    for v85 = 1, #v73 do
                        v73[v85].Enabled = true
                    end
                else
                    for v86 = 1, #v74 do
                        if v74[v86]:IsA("ParticleEmitter") ~= false then
                            if v74[v86]:GetAttribute("recolorableGround") then
                                v74[v86].Enabled = false
                            elseif v74[v86]:GetAttribute("requiresGround") then
                                v74[v86].Enabled = false
                            end
                        end
                    end
                    for v87 = 1, #v73 do
                        v73[v87].Enabled = false
                    end
                end
                if v76 <= tick() - v75 then
                    if v77 then
                        for _ = 1, 2 do
                            local v88 = u26
                            local v89 = {
                                ["Position"] = v78,
                                ["Velocity"] = (Vector3.new(0, 1, 0)):Cross(u66.CFrame.LookVector) * (math.random(2) == 1 and 1 or -1) * math.random(35, 45) + Vector3.new(0, 1, 0) * math.random(30, 90),
                                ["AngularVelocity"] = Random.new():NextUnitVector() * 3,
                                ["Material"] = v77.Material
                            }
                            local v90 = math.random(3)
                            local v91 = math.random(3)
                            local v92 = math.random
                            v89.Size = Vector3.new(v90, v91, v92(3))
                            v89.Color = v77.Color
                            v88(v89)
                            local v93 = require(script.YoruTrail)
                            local v94 = {
                                ["Direction"] = -u66.CFrame.LookVector
                            }
                            local v95 = u66.Position
                            local v96 = math.random(-250, 250) / 10
                            v94.Position = v95 + Vector3.new(0, v96, 0)
                            v94.Color = u36
                            v94.Character = u29
                            v93(v94)
                        end
                        for v97 = 1, #v74 do
                            if v74[v97]:IsA("ParticleEmitter") ~= false and (v74[v97]:GetAttribute("recolorableGround") and v74[v97]:GetAttribute("splitColor")) then
                                v74[v97].Enabled = false
                                local v98 = v74[v97]:Clone()
                                v98:SetAttribute("recolorableGround", nil)
                                v98.Parent = v74[v97].Parent
                                if v98.Name == "Rock" then
                                    v98:Emit(1)
                                else
                                    v98:Emit(4)
                                end
                                _G.destroy(v98, 3)
                            end
                        end
                    end
                    v75 = tick()
                end
                task.wait()
                if u32 <= tick() - v71 then
                    task.wait(1)
                    _G.destroy(v72, 5)
                    return
                end
            end
        end)
        task.wait(u32)
        _G.particleEnabled(u66, false)
        _G.destroy(u66, 2)
    end
end
return v17
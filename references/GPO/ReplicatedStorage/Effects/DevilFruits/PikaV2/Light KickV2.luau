 

local v1 = game:GetService("ReplicatedStorage")
game:GetService("RunService")
local v2 = game:GetService("Players")
game:GetService("TweenService")
require(game:GetService("ReplicatedStorage").Modules.CameraShaker)
require(v1.Modules.CraterHandler)
require(v1.Modules.ParticleTween)
local u3 = require(v1.Modules.Client.WeaponVFXRecolor)
local _ = v2.LocalPlayer
local u4 = workspace.Effects
local u5 = {}
function Flipbook(p6, u7, u8, u9)
    local u10 = p6:FindFirstChildOfClass("SpecialMesh")
    if u10 and u7 then
        task.spawn(function() --[[ Line: 23 ]]
            --[[
            Upvalues:
                [1] = u7
                [2] = u10
                [3] = u8
                [4] = u9
            --]]
            for v11 = 1, #u7 do
                u10.TextureId = u7[v11]
                task.wait(1 / u8)
            end
            if u9 == true then
                u10.Parent:Destroy()
            end
        end)
    end
end
local function u22(p12, p13, p14) --[[ Line: 37 ]]
    local function v20(u15, p16, p17) --[[ Line: 38 ]]
        for _, v18 in ipairs(u15:GetDescendants()) do
            if v18:IsA("ParticleEmitter") or v18:IsA("Trail") then
                v18.Enabled = p16
            end
        end
        if p17 then
            task.delay(p17, function() --[[ Line: 46 ]]
                --[[
                Upvalues:
                    [1] = u15
                --]]
                for _, v19 in ipairs(u15:GetDescendants()) do
                    if v19:IsA("ParticleEmitter") or v19:IsA("Trail") then
                        v19.Enabled = false
                    end
                end
            end)
        end
    end
    if typeof(p12) == "table" then
        for _, v21 in p12 do
            v20(v21, p13, p14)
        end
    else
        v20(p12, p13, p14)
    end
end
local v23 = RaycastParams.new()
v23.FilterType = Enum.RaycastFilterType.Include
v23.FilterDescendantsInstances = { workspace.Ships, workspace.Islands, workspace.Env }
return {
    ["start"] = function(_, p24, p25, u26, u27, p28, p29) --[[ Name: start, Line 81 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u5
            [3] = u4
            [4] = u22
        --]]
        if p24 == "charged" then
            if _G.checkRenderDistance(p25.PrimaryPart.Position) ~= false then
                local v30
                if script:FindFirstChild("ChargedHighlight") then
                    v30 = script.ChargedHighlight:Clone()
                    u3.apply(v30, p25)
                else
                    v30 = Instance.new("Highlight")
                    v30.FillColor = Color3.fromRGB(255, 255, 175)
                    v30.OutlineColor = Color3.fromRGB(255, 255, 255)
                end
                v30.OutlineTransparency = 1
                v30.FillTransparency = 0
                v30.DepthMode = Enum.HighlightDepthMode.Occluded
                v30.Parent = p25
                _G.tween(v30, {
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
                _G.destroy(v30, 0.5)
            end
        else
            if p24 == "Hold" then
                local v31 = p25:FindFirstChild("RightFoot")
                if v31 == nil then
                    return
                end
                u5[p25] = {}
                local v32 = script.HoldEffect:Clone()
                u3.apply(v32, p25)
                v32.CFrame = v31.CFrame
                v32.Parent = u4
                v32.loop:Play()
                u22(v32, true)
                local v33 = Instance.new("WeldConstraint")
                v33.Part0 = v32
                v33.Part1 = v31
                v33.Parent = v32
                local v34 = u5[p25]
                table.insert(v34, v32)
                local v35 = script.SpawnEffect:Clone()
                u3.apply(v35, p25)
                v35.CFrame = v31.CFrame
                v35.Parent = u4
                _G.customEmit(v35)
                _G.destroy(v35, 2)
                local v36 = Instance.new("WeldConstraint")
                v36.Part0 = v35
                v36.Part1 = v31
                v36.Parent = v35
                _G.PlaySound(p25.PrimaryPart, script["Audio/LightKickStart"])
            elseif p24 == "Shoot" then
                local u37 = (u26.Position - u27.Position).Magnitude
                local _ = u37 / 800
                if u5[p25] == nil then
                    return
                end
                local v38 = u5[p25]
                local v39 = table.unpack(v38)
                if v39 then
                    v39.loop:Stop()
                    _G.PlayEffect("TweenParticles", nil, v39, NumberSequence.new(0), 0.25)
                    _G.particleEnabled(v39, false)
                    _G.tween(v39.PointLight, {
                        0.25,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Brightness"] = 0
                    })
                    _G.destroy(v39, 2)
                end
                local v40 = script.KickRelease:Clone()
                u3.apply(v40, p25)
                v40.CFrame = CFrame.new(u26.Position, u27.Position)
                v40.Parent = u4
                _G.customEmit(v40)
                _G.destroy(v40, 2)
                local u41 = script.Projectile:Clone()
                u3.apply(u41, p25)
                u41.CFrame = u26
                u41.Parent = u4
                u22(u41, true)
                local v42 = u37 / 85
                local v43 = math.clamp(v42, 0, 1)
                local v44 = script.cyn:Clone()
                u3.apply(v44, p25)
                v44.CFrame = CFrame.new(u26.Position, u27.Position) * CFrame.Angles(1.5707963267948966, 0, 0)
                local v45 = v44.Mesh
                local v46 = -u37 / 2
                v45.Offset = Vector3.new(0, v46, 0)
                v44.Mesh.Scale = Vector3.new(v43, u37, v43)
                v44.Parent = workspace.Effects
                local v47 = _G.tween
                local v48 = v44.Mesh
                local v49 = {
                    0.15,
                    Enum.EasingStyle.Quad,
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }
                local v50 = {
                    ["Scale"] = Vector3.new(0, 0, 0)
                }
                local v51 = -u37
                v50.Offset = Vector3.new(0, v51, 0)
                v47(v48, v49, v50)
                _G.destroy(v44, 1)
                local v52 = script.Part:Clone()
                u3.apply(v52, p25)
                v52.CFrame = CFrame.new(u26.Position, u27.Position) * CFrame.Angles(1.5707963267948966, 0, 0) * CFrame.new(0, -u37 / 2, 0)
                v52.Size = Vector3.new(v43, u37, v43)
                v52.Parent = workspace.Effects
                v52.Star:Emit(15 + u37 / 50)
                _G.destroy(v52, 1)
                local u53 = CFrame.new(u26.Position, u27.Position)
                task.spawn(function() --[[ Line: 188 ]]
                    --[[
                    Upvalues:
                        [1] = u37
                        [2] = u53
                        [3] = u27
                        [4] = u26
                    --]]
                    if u37 >= 20 then
                        local v54 = u37
                        math.clamp(v54, 0, 250)
                        local v55 = u37 / 10
                        local v56 = u37 / 10
                        local v57 = Vector3.new(v55, 0.5, v56)
                        for v58 = 1, 3 do
                            local v59 = u53:Lerp(CFrame.new(u27.Position, u26.Position) * CFrame.Angles(3.141592653589793, 0, 0), v58 / 3) * CFrame.Angles(-1.5707963267948966, 0, 0)
                            _G.PlayEffect("Shockwave2", nil, v59 * CFrame.new(0, -u37 / 15, 0), v59, BrickColor.new("Brick yellow"), v57, Vector3.new(0, 0, 0), 0.25, -5, Enum.EasingStyle.Quad, BrickColor.new("White").Color, Enum.Material.Neon, "Rings")
                            v57 = v57 * 0.75
                            task.wait()
                        end
                    end
                end)
                _G.PlaySound(u26, script["Audio/LightKickShoot"], {
                    ["RandomPitch"] = true
                })
                task.wait()
                u41.CFrame = u27
                task.delay(0.01, function() --[[ Line: 206 ]]
                    --[[
                    Upvalues:
                        [1] = u22
                        [2] = u41
                    --]]
                    u22(u41, false)
                end)
                _G.destroy(u41, 2)
                CFrame.new(u41.Position)
                local v60 = p29 or p28
                if v60 then
                    local v61 = script.Explosion:Clone()
                    u3.apply(v61, p25)
                    v61.CFrame = u27
                    v61.Parent = u4
                    _G.customEmit(v61)
                    _G.destroy(v61, 5)
                    _G.tween(v61.PointLight, {
                        0.25,
                        Enum.EasingStyle.Quad,
                        Enum.EasingDirection.Out,
                        0,
                        false,
                        0
                    }, {
                        ["Range"] = 50,
                        ["Brightness"] = 0
                    })
                    _G.shakenear(v61.Position, 75, 125, 100, -1.5)
                    _G.PlaySound(v61, script["Audio/LightKickBoom"], {
                        ["RandomPitch"] = true
                    })
                    local v62 = v60.Pos
                    local v63 = v60.Nor
                    local v64 = CFrame.new(v62, v62 + v63) * CFrame.Angles(-1.5707963267948966, 0, 0)
                    local v65 = script.Debree:Clone()
                    u3.apply(v65, p25)
                    v65.CFrame = v64
                    _G.recolorParticles(v65["1"], v60.Color)
                    v65.Parent = u4
                    _G.customEmit(v65)
                    _G.destroy(v65, 4)
                    _G.PlayEffect("GroundRocks4", nil, {
                        ["Segments"] = 20,
                        ["Position"] = v65.Position + Vector3.new(0, 1, 0),
                        ["DistanceRandomness"] = Vector2.new(0.25, 1),
                        ["Duration"] = 2,
                        ["TweenDuration"] = 1,
                        ["Radius"] = 25,
                        ["Direction"] = v65.CFrame.UpVector * -30,
                        ["Angle"] = -0.4363323129985824
                    })
                    _G.PlayEffect("RockDebris", nil, {
                        ["PartCount"] = 8,
                        ["RandomVelocityMagnitude"] = Vector2.new(-80, 80),
                        ["Position"] = v65.Position,
                        ["Direction"] = v65.CFrame.UpVector * 75,
                        ["RaycastDirection"] = v65.CFrame.UpVector * -30,
                        ["Size"] = Vector3.new(1.25, 2.142857, 1.25),
                        ["TrailEnabled"] = true
                    })
                end
            end
            return
        end
    end
}
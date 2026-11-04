 

local v1 = {}
game:GetService("Debris")
local u2 = game:GetService("TweenService")
game:GetService("RunService")
local v3 = game:GetService("Players")
script:WaitForChild("Models")
local u4 = script:WaitForChild("VFX")
local _ = v3.LocalPlayer
workspace:WaitForChild("Effects")
require(script.Parent:WaitForChild("Shared"))
require(script.Parent.SoulLightningModule)
local u5 = Random.new()
local u6 = RaycastParams.new()
u6.FilterType = Enum.RaycastFilterType.Include
u6.FilterDescendantsInstances = { workspace.Islands, workspace.Env, workspace.Ships }
function v1.start(_, u7, u8, p9) --[[ Line: 28 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u5
        [3] = u4
        [4] = u2
    --]]
    local v10 = workspace:Raycast(u7.Position + Vector3.new(0, 0.1, 0), Vector3.new(0, -125, 0), u6)
    if v10 == nil then
        return
    elseif v10.Instance ~= nil then
        local u11 = CFrame.new(v10.Position, v10.Position + v10.Normal)
        local u12 = p9 == nil and 1 or p9
        if u12 == 1 then
            task.spawn(function() --[[ Line: 46 ]]
                --[[
                Upvalues:
                    [1] = u8
                    [2] = u7
                    [3] = u12
                    [4] = u11
                    [5] = u5
                --]]
                local v13 = (u8.Position - u7.Position).Magnitude / 200
                local v14 = math.clamp(v13, 1, 100000000000)
                for _ = 1, 3 * u12 do
                    _G.PlayEffect("DeadLightning", nil, {
                        ["StartPosition"] = u8.Position,
                        ["EndPosition"] = u11.Position,
                        ["Points"] = 4,
                        ["Size"] = u5:NextNumber(1.5, 3),
                        ["Branches"] = true,
                        ["RandomSize"] = NumberRange.new(0.5, 1),
                        ["Offset"] = NumberRange.new(v14 + 0.5, v14 + 1),
                        ["MainColor"] = Color3.fromRGB(255, 255, 255),
                        ["GlowColor"] = Color3.fromRGB(151, 65, 255),
                        ["LightningDuration"] = 0.1,
                        ["WaitFunction"] = function(p15, _) --[[ Name: WaitFunction, Line 64 ]]
                            if p15 % 2 == 0 then
                                task.wait()
                            end
                        end
                    })
                    task.wait(0.1)
                end
            end)
        end
        local u16 = u4.Strike:Clone()
        u16.CFrame = u11 * CFrame.new(0, 0.5, 0) * CFrame.Angles(-1.5707963267948966, 0, 0)
        _G.recolorParticles(u16, v10.Instance.Color)
        u16.Parent = workspace.Effects
        u2:Create(u16.PointLight, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            ["Brightness"] = 0,
            ["Range"] = u16.PointLight.Range * 2
        }):Play()
        _G.customEmit(u16)
        if u12 == 1 then
            _G.PlaySound(u16, script.SoulZeusLightningBolt)
        else
            _G.PlaySound(u16, script.Ult["SoulZeusUltLightningStrike" .. math.random(1, 5)])
        end
        if u12 == 1 then
            task.spawn(function() --[[ Line: 93 ]]
                --[[
                Upvalues:
                    [1] = u12
                    [2] = u16
                    [3] = u5
                --]]
                local v17 = 15
                for _ = 1, 6 * u12 do
                    local v18 = _G.PlayEffect
                    local v19 = {
                        ["StartPosition"] = u16.Position
                    }
                    local v20 = u16.Position
                    local v21 = u5:NextNumber(-v17, v17)
                    local v22 = u5:NextNumber(v17, v17 * 2)
                    local v23 = u5
                    local v24 = -v17
                    v19.EndPosition = v20 + Vector3.new(v21, v22, v23:NextNumber(v24, v17))
                    v19.Points = 3
                    v19.Size = u5:NextNumber(1.5, 3) / 1.5
                    v19.Branches = true
                    v19.RandomSize = NumberRange.new(0.15, 1)
                    v19.Offset = NumberRange.new(1, 2)
                    v19.MainColor = Color3.fromRGB(255, 255, 255)
                    v19.GlowColor = Color3.fromRGB(151, 65, 255)
                    v19.LightningDuration = math.random(100, 200) / 2000
                    function v19.WaitFunction(p25, _) --[[ Line: 111 ]]
                        if p25 % 2 == 0 then
                            task.wait(math.random(100, 300) / 10000)
                        end
                    end
                    v18("DeadLightning", nil, v19)
                    v17 = v17 + 3
                    task.wait(0.05)
                end
            end)
        end
        local v26 = CFrame.new(v10.Position, v10.Position + v10.Normal) * CFrame.new(0, 0, -1.1) * CFrame.Angles(-1.5690509975429023, 0, 0)
        local v27 = v26.Position
        _G.PlayEffect("GroundRocks4", nil, {
            ["Segments"] = 20,
            ["Position"] = v27 + Vector3.new(0, 2, 0),
            ["DistanceRandomness"] = Vector2.new(0.5, 1),
            ["Duration"] = 4,
            ["TweenDuration"] = 1,
            ["Radius"] = 20,
            ["Direction"] = -v10.Normal * 45,
            ["Angle"] = -0.6108652381980153
        })
        _G.PlayEffect("RockDebris", nil, {
            ["PartCount"] = 5 * u12,
            ["RandomVelocityMagnitude"] = Vector2.new(-45, 45) * 2,
            ["Position"] = v27,
            ["Direction"] = Vector3.new(0, 15, 0),
            ["RaycastDirection"] = -v10.Normal * 15,
            ["Size"] = Vector3.new(0.8, 0.8, 0.8),
            ["TrailEnabled"] = true
        })
        _G.shakenear(v26.Position, 175, 100, 75, -1)
        local v28 = u4.SmokeMeshDeformed:Clone()
        local v29 = v26 * CFrame.new(0, 10, 0)
        local v30 = CFrame.Angles
        local v31 = u5:NextNumber(-179, 179)
        v28.CFrame = v29 * v30(0, math.rad(v31), 0)
        v28.Transparency = 0
        v28.Mesh.Scale = Vector3.new(0, 35, 0)
        v28.Parent = workspace.Effects
        u2:Create(v28.Mesh, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            ["Scale"] = Vector3.new(35, 17.5, 35)
        }):Play()
        local v32 = u2
        local v33 = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local v34 = {}
        local v35 = v28.CFrame
        local v36 = CFrame.Angles
        local v37 = u5:NextNumber(-179, 179)
        v34.CFrame = v35 * v36(0, math.rad(v37), 0)
        v32:Create(v28, v33, v34):Play()
        u2:Create(v28, TweenInfo.new(0.5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {
            ["Transparency"] = 1,
            ["CFrame"] = v26 * CFrame.new(0, 0.5, 0)
        }):Play()
        _G.destroy(v28, 0.5)
        local v38 = u4.ShockwaveCylinder1:Clone()
        v38.Transparency = 0.75
        local v39 = v26 * CFrame.new(0, 1, 0)
        local v40 = CFrame.Angles
        local v41 = u5:NextNumber(-179, 179)
        v38.CFrame = v39 * v40(0, math.rad(v41), 0)
        v38.Size = Vector3.new(35, 0, 35)
        v38.Parent = workspace.Effects
        local v42 = u2
        local v43 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
        local v44 = {
            ["Size"] = Vector3.new(7, 21, 7)
        }
        local v45 = v26 * CFrame.new(0, 4.55, 0)
        local v46 = CFrame.Angles
        local v47 = u5:NextNumber(-179, 179)
        v44.CFrame = v45 * v46(0, math.rad(v47), 0)
        v44.Transparency = 1
        v42:Create(v38, v43, v44):Play()
        _G.destroy(v38, 0.25)
        local v48 = u4.ShockwaveCylinder2:Clone()
        local v49 = v26 * CFrame.new(0, 7.5, 0)
        local v50 = CFrame.Angles
        local v51 = u5:NextNumber(-179, 179)
        v48.CFrame = v49 * v50(0, math.rad(v51), 0)
        v48.Transparency = 0
        v48.Size = Vector3.new(0, 35, 0)
        v48.Parent = workspace.Effects
        u2:Create(v48, TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            ["Transparency"] = 1,
            ["CFrame"] = v26 * CFrame.new(0, 0, 0),
            ["Size"] = Vector3.new(35, 0, 35)
        }):Play()
        _G.destroy(v48, 0.2)
        local v52 = { Enum.EasingStyle.Linear, Enum.EasingStyle.Sine, Enum.EasingStyle.Quad }
        local v53 = { u4.Swirl, u4.Swirl2 }
        for _ = 1, 2 * u12 do
            local v54 = u5:NextNumber(0.2, 0.3)
            local v55 = u5:NextNumber(35, 40) * 1 * 0.7
            local v56 = u5:NextNumber(60, 75) * 1 * 0.7
            local v57 = v53[math.random(1, #v53)]:Clone()
            v57.Color = Color3.fromRGB(147, 85, 255)
            v57.Transparency = -1
            local v58 = v26 * CFrame.new(0, 0, 0)
            local v59 = CFrame.Angles
            local v60 = u5:NextNumber(-5, 5)
            local v61 = math.rad(v60)
            local v62 = u5:NextNumber(-179, 179)
            local v63 = math.rad(v62)
            local v64 = u5:NextNumber(-5, 5)
            v57.CFrame = v58 * v59(v61, v63, (math.rad(v64)))
            local v65 = v55 * u5:NextNumber(1, 2)
            v57.Size = Vector3.new(v55, v65, v55)
            v57.Parent = workspace.Effects
            local v66 = u2
            local v67 = TweenInfo.new(v54, v52[math.random(1, #v52)], Enum.EasingDirection.Out)
            local v68 = {}
            local v69 = u5:NextNumber(1, 10)
            v68.Size = Vector3.new(v56, v69, v56)
            local v70 = v26 * CFrame.new(0, u5:NextNumber(1, v56 / 3), 0) * v57.CFrame.Rotation
            local v71 = CFrame.Angles
            local v72 = u5:NextNumber(-22.5, -180)
            v68.CFrame = v70 * v71(0, math.rad(v72), 0)
            v66:Create(v57, v67, v68):Play()
            u2:Create(v57, TweenInfo.new(v54, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                ["Transparency"] = 1,
                ["Color"] = Color3.fromRGB(0, 0, 0)
            }):Play()
            _G.destroy(v57, v54)
        end
        _G.destroy(u16, 5)
    end
end
return v1
 

local u1 = game:GetService("TweenService")
local v2 = game:GetService("ReplicatedStorage")
local v3 = {}
local u4 = workspace.Effects
require(v2.Modules.BoatTween)
local u5 = require(game.ReplicatedStorage.Modules.LightningBolt)
local u6 = require(game.ReplicatedStorage.Modules.LightningBolt.LightningSparks)
require(game.ReplicatedStorage.Modules.LightningBolt.LightningExplosion)
require(game.ReplicatedStorage.Modules.sBeat)
local function u10(p7, p8) --[[ Line: 14 ]]
    local v9 = Instance.new("Attachment")
    v9.Parent = workspace.Terrain
    _G.destroy(v9, 5)
    if p8 then
        v9.Parent = p8
    elseif typeof(p7) == "CFrame" then
        v9.WorldCFrame = p7
    end
    if typeof(p7) == "Vector3" then
        v9.Position = p7
    end
    return v9
end
local function u16(p11, p12) --[[ Line: 31 ]]
    local v13 = game.Players.LocalPlayer.Character
    if v13 ~= nil then
        if (v13.HumanoidRootPart.Position - p11).Magnitude < 200 * p12 then
            task.spawn(function() --[[ Line: 40 ]]
                local v14 = script.Lighting.PesadoCC:Clone()
                local v15 = script.Lighting.pesadoblur:Clone()
                v14.Parent = game.Lighting
                _G.destroy(v14, 3)
                _G.destroy(v15, 3)
                _G.tween(v14, {
                    0.1,
                    "EntranceProductive",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Brightness"] = 0,
                    ["Contrast"] = 1,
                    ["TintColor"] = Color3.fromRGB(255, 0, 0)
                })
                task.wait(0.1)
                _G.tween(v14, {
                    0.1,
                    "EntranceProductive",
                    Enum.EasingDirection.Out,
                    0,
                    false,
                    0
                }, {
                    ["Brightness"] = 0,
                    ["Contrast"] = 0,
                    ["Saturation"] = 0,
                    ["TintColor"] = Color3.fromRGB(255, 255, 255)
                })
            end)
        end
    end
end
function v3.start(_, u17, p18, p19) --[[ Line: 57 ]]
    --[[
    Upvalues:
        [1] = u16
        [2] = u4
        [3] = u1
        [4] = u10
        [5] = u5
        [6] = u6
    --]]
    if _G.checkRenderDistance(u17.Position) ~= false then
        u16(u17.Position, p18)
        local v20 = script.Spiral:Clone()
        v20.CFrame = u17.CFrame * CFrame.new(0, 2.5, 0) * CFrame.Angles(0, 0, 1.5707963267948966)
        v20.Parent = u4
        _G.destroy(v20, 0.6)
        local v21 = TweenInfo.new(0.6, Enum.EasingStyle.Exponential)
        u1:Create(v20.Texture, v21, {
            ["Transparency"] = 1
        }):Play()
        u1:Create(v20.Mesh, v21, {
            ["Scale"] = Vector3.new(0.1, 2.2, 2)
        }):Play()
        local v22 = u1
        local v23 = {
            ["Position"] = v20.Position + Vector3.new(0, -3, 0)
        }
        local v24 = v20.Orientation
        local v25 = v20.Orientation.Y + 750
        v23.Orientation = v24 + Vector3.new(0, v25, 0)
        v22:Create(v20, v21, v23):Play()
        u17.Material = Enum.Material.ForceField
        u17.Transparency = -15
        u17.Explode.WorldCFrame = CFrame.new(u17.Position)
        local v26 = _G.scaleParticle
        local v27 = u17.Explode
        local v28 = p18 * 0.7
        v26(v27, (math.clamp(v28, 1, 7)))
        _G.customEmit(u17.Explode)
        local v29 = u17.Explode:GetDescendants()
        for v30 = 1, #v29 do
            v29[v30]:SetAttribute("EmitCount", v29[v30]:GetAttribute("EmitCount") * p18)
        end
        if p19 then
            u17.Explode.Rocks.Color = ColorSequence.new(p19.Color)
        else
            u17.Explode.Rocks:Destroy()
        end
        task.delay(0.1, function() --[[ Line: 95 ]]
            --[[
            Upvalues:
                [1] = u17
            --]]
            u17.Explode.Sparks:SetAttribute("EmitCount", 50)
            _G.customEmit(u17.Explode.Sparks)
        end)
        local v31 = {
            ["Size"] = Vector3.new(55, 55, 49) * p18,
            ["Transparency"] = 0.5
        }
        _G.tween(u17, { 0.35, "Quad", "Out" }, v31)
        _G.destroy(u17, 8)
        task.delay(0.6, function() --[[ Line: 102 ]]
            --[[
            Upvalues:
                [1] = u17
            --]]
            _G.tween(u17, { 0.35, "Quad", "Out" }, {
                ["Size"] = Vector3.new(0, 0, 0),
                ["Transparency"] = 1
            })
        end)
        task.spawn(function() --[[ Line: 105 ]]
            --[[
            Upvalues:
                [1] = u17
            --]]
            local v32 = tick()
            repeat
                local v33 = u17
                local v34 = u17.CFrame
                local v35 = CFrame.Angles
                local v36 = _G.ScaleWithFPS(5)
                v33.CFrame = v34 * v35(0, math.rad(v36), 0)
                task.wait()
            until tick() - v32 >= 0.95
        end)
        local v37 = CFrame.new(u17.Position)
        _G.PlayEffect("GroundRocks2", nil, v37, 20 * p18, 40 * p18, 5 * p18, 0.15, 7 * p18)
        _G.PlayEffect("GroundRocks2", nil, v37, 10 * p18, 20 * p18, 7 * p18, 0.15, 7 * p18)
        _G.shakenear(v37.Position, 250 * p18, 150 * p18, 150 * p18, -1)
        _G.tween(u17.PointLight, { 0.25, "Quad", "Out" }, {
            ["Range"] = 55 * p18,
            ["Brightness"] = 0
        })
        local v38 = script.invert:Clone()
        v38.CFrame = v37
        v38.Size = Vector3.new(125, 125, 125) * p18 / 2
        v38.Parent = workspace.Effects
        _G.tween(v38, { 0.5, "Quad", "Out" }, {
            ["Size"] = Vector3.new(125, 125, 125) * p18,
            ["Transparency"] = 1
        })
        _G.destroy(v38, 0.5)
        _G.PlayEffect("Spheres", nil, {
            ["cf"] = CFrame.new(u17.Position),
            ["ti"] = 0.25,
            ["ti2"] = 0.25,
            ["range"] = 55 * p18,
            ["minThick"] = 3 * p18,
            ["maxThick"] = 10 * p18,
            ["part"] = nil,
            ["color"] = u17.Color,
            ["am"] = 30
        })
        for _ = 1, 30 do
            local v39 = math.random(50, 100) * p18
            local v40 = u17.CFrame
            local v41 = u10(v40, u17)
            local v42 = CFrame.Angles
            local v43 = math.random(-360, 360)
            local v44 = math.rad(v43)
            local v45 = math.random(-360, 360)
            local v46 = math.rad(v45)
            local v47 = math.random(-360, 360)
            local v48 = v40 * v42(v44, v46, (math.rad(v47)))
            local v49 = u10(v40, u17)
            local _ = math.random(250, 750) / 1000
            v49.WorldCFrame = v48 * CFrame.new(0, 0, math.random(50, 100) * p18)
            local v50 = u5.new(v41, v49, 5)
            v50.CurveSize0 = 0
            v50.CurveSize1 = 0
            v50.PulseSpeed = math.random(25, 60)
            v50.AnimationSpeed = math.random(15, 20)
            v50.PulseLength = math.random(5, 10)
            v50.FadeLength = 0.1
            v50.Thickness = math.random(100, 400) / 900 * p18
            v50.Color = Color3.fromRGB(255, 126, 126)
            v50.Frequency = math.random(10, 50) * 5
            v50.MinThicknessMultiplier = 0.75
            v50.MaxThicknessMultiplier = 1
            v50.MinRadius = 0
            v50.MaxRadius = math.random(5, 15) * p18
            v50.ContractFrom = 0.5
            local v51 = u6.new(v50)
            v51.MaxDistance = v39
            v51.MinDistance = v39 / 4
            v51.MaxSparkCount = 2
            v51.MaxSpeed = 1
            task.wait()
        end
    end
end
return v3
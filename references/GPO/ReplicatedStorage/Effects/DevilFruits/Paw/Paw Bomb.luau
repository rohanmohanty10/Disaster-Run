 

local u1 = game:GetService("TweenService")
game:GetService("ReplicatedStorage")
local v2 = {}
local u3 = workspace.Effects
local u4 = require(game.ReplicatedStorage.Modules.LightningBolt)
local u5 = require(game.ReplicatedStorage.Modules.LightningBolt.LightningSparks)
require(game.ReplicatedStorage.Modules.LightningBolt.LightningExplosion)
require(game.ReplicatedStorage.Modules.sBeat)
local function u9(p6, p7) --[[ Line: 12 ]]
    local v8 = Instance.new("Attachment")
    v8.Parent = workspace.Terrain
    _G.destroy(v8, 5)
    if p7 then
        v8.Parent = p7
    elseif typeof(p6) == "CFrame" then
        v8.WorldCFrame = p6
    end
    if typeof(p6) == "Vector3" then
        v8.Position = p6
    end
    return v8
end
function v2.start(_, p10, p11) --[[ Line: 29 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u1
        [3] = u9
        [4] = u4
        [5] = u5
    --]]
    if _G.checkRenderDistance(p10.PrimaryPart.Position) ~= false then
        p10:WaitForChild("HumanoidRootPart")
        local v12 = script.Paw:Clone()
        v12.CFrame = p10.HumanoidRootPart.CFrame * CFrame.new(0, 0, -13)
        v12.Size = Vector3.new(11.25, 11.25, 9.5) * p11
        v12.Transparency = -100
        v12.Parent = u3
        _G.scaleParticle(v12.Explode, p11)
        _G.customEmit(v12.Explode)
        _G.tween(v12, { 0.25, "MozillaCurve", "Out" }, {
            ["Size"] = Vector3.new(22.5, 22.5, 19) * p11,
            ["Transparency"] = 1
        })
        _G.destroy(v12, 1)
        _G.tween(v12.PointLight, { 0.25, "Quad", "Out" }, {
            ["Range"] = 55 * p11,
            ["Brightness"] = 0
        })
        local v13 = script.Spiral:Clone()
        v13.CFrame = v12.CFrame * CFrame.new(0, 2.5, 0) * CFrame.Angles(0, 0, 1.5707963267948966)
        v13.Parent = u3
        _G.destroy(v13, 0.5)
        local v14 = TweenInfo.new(0.5, Enum.EasingStyle.Exponential)
        u1:Create(v13.Texture, v14, {
            ["Transparency"] = 1
        }):Play()
        u1:Create(v13.Mesh, v14, {
            ["Scale"] = Vector3.new(0.075, 1.6500001, 1.5) * p11
        }):Play()
        local v15 = u1
        local v16 = {
            ["Position"] = v13.Position + Vector3.new(0, -3, 0)
        }
        local v17 = v13.Orientation
        local v18 = v13.Orientation.Y + 750
        v16.Orientation = v17 + Vector3.new(0, v18, 0)
        v15:Create(v13, v14, v16):Play()
        _G.PlaySound(v12, script.explode)
        _G.PlayEffect("GroundRocks2", nil, CFrame.new(v12.Position), 15, 15 * p11, 4 * p11, 0, 4)
        _G.PlayEffect("Spheres", nil, {
            ["cf"] = CFrame.new(v12.Position),
            ["ti"] = 0.25,
            ["ti2"] = 0.25,
            ["range"] = 20 * p11,
            ["minThick"] = 0.2,
            ["maxThick"] = 5,
            ["part"] = nil,
            ["color"] = v12.Color,
            ["am"] = 20
        })
        for _ = 1, 10 do
            local v19 = math.random(50, 100) / 10
            local v20 = v12.CFrame
            local v21 = u9(v20, v12)
            local v22 = CFrame.Angles
            local v23 = math.random(-360, 360)
            local v24 = math.rad(v23)
            local v25 = math.random(-360, 360)
            local v26 = math.rad(v25)
            local v27 = math.random(-360, 360)
            local v28 = v20 * v22(v24, v26, (math.rad(v27)))
            local v29 = u9(v20, v12)
            local _ = math.random(250, 750) / 1000
            v29.WorldCFrame = v28 * CFrame.new(0, 0, math.random(25, 45) * p11)
            local v30 = u4.new(v21, v29, 5)
            v30.CurveSize0 = 0
            v30.CurveSize1 = 0
            v30.PulseSpeed = math.random(5, 10) * 4
            v30.AnimationSpeed = math.random(15, 20)
            v30.PulseLength = math.random(1, 4)
            v30.FadeLength = 1
            v30.Thickness = math.random(100, 400) / 2000 * p11
            v30.Color = Color3.fromRGB(255, 0, 0)
            v30.Frequency = math.random(10, 50) / 2
            v30.MinThicknessMultiplier = 0.75
            v30.MaxThicknessMultiplier = 1
            v30.MinRadius = 0
            v30.MaxRadius = 2
            v30.ContractFrom = 1
            local v31 = u5.new(v30)
            v31.MaxDistance = v19
            v31.MinDistance = v19 / 2
            v31.MaxSparkCount = 3
            v31.MaxSpeed = 2
        end
    end
end
return v2
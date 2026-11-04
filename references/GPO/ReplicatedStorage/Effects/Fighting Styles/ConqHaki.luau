 

local v1 = {}
local u2 = game:GetService("Lighting")
local u3 = game:GetService("TweenService")
local u4 = Random.new()
local u5 = require(game.ReplicatedStorage.Modules.LightningBolt)
local u6 = require(game.ReplicatedStorage.Modules.LightningBolt.LightningSparks)
function Lightning(p7, p8, p9, p10)
    --[[
    Upvalues:
        [1] = u5
        [2] = u6
    --]]
    local u11 = Instance.new("Part")
    u11.Anchored = true
    u11.CanCollide = false
    u11.Transparency = 1
    u11.Position = p7
    u11.Parent = workspace.Effects
    local u12 = Instance.new("Part")
    u12.Anchored = true
    u12.CanCollide = false
    u12.Transparency = 1
    u12.Position = p8
    u12.Parent = workspace.Effects
    local v13 = Instance.new("Attachment")
    v13.Parent = u11
    local v14 = Instance.new("Attachment")
    v14.Parent = u12
    local v15 = u5.new(v13, v14, 6)
    local v16 = -(p10 / 2)
    v15.CurveSize0 = p10
    v15.CurveSize1 = v16
    v15.PulseSpeed = 7
    v15.PulseLength = 0.5
    v15.FadeLength = 0.25
    v15.Color = p9
    u6.new(v15)
    task.delay(4, function() --[[ Line: 36 ]]
        --[[
        Upvalues:
            [1] = u11
            [2] = u12
        --]]
        u11:Destroy()
        u12:Destroy()
    end)
end
function v1.start(_, p17, p18) --[[ Line: 42 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
        [3] = u4
    --]]
    if _G.checkRenderDistance(p18.Position, 700) ~= false then
        local v19 = Instance.new("Model")
        v19.Name = "ConqHaki"
        v19.Parent = workspace.Effects
        local u20 = script.Head:Clone()
        local v21 = script.Bottom:Clone()
        u20.Position = p17.Head.Position
        v21.Position = p17.Head.Position - Vector3.new(0, 2, 0)
        u20.Parent = v19
        v21.Parent = v19
        local v22 = u2.Blur.Size
        local v23 = u2.ColorCorrection.TintColor
        local v24 = Instance.new("BlurEffect")
        v24.Size = v22
        v24.Parent = workspace.CurrentCamera
        local v25 = Instance.new("ColorCorrectionEffect")
        v25.TintColor = v23
        v25.Parent = workspace.CurrentCamera
        u3:Create(v24, TweenInfo.new(0.25), {
            ["Size"] = 7.5
        }):Play()
        u3:Create(v25, TweenInfo.new(0.25), {
            ["TintColor"] = Color3.fromRGB(255, 0, 0)
        }):Play()
        _G.PlaySound(p17.PrimaryPart, script["HaoshokuHaki" .. math.random(1, 5)])
        local u26 = false
        task.spawn(function() --[[ Line: 75 ]]
            --[[
            Upvalues:
                [1] = u26
                [2] = u20
                [3] = u4
            --]]
            while not u26 do
                local v27 = Lightning
                local v28 = u20.Position
                local v29 = u20.Position
                local v30 = u4:NextNumber(-225, 225)
                local v31 = u4:NextNumber(0, 200)
                local v32 = u4
                v27(v28, v29 + Vector3.new(v30, v31, v32:NextNumber(-225, 225)), Color3.fromRGB(255, 0, 0), 5)
                local v33 = Lightning
                local v34 = u20.Position
                local v35 = u20.Position
                local v36 = u4:NextNumber(-225, 225)
                local v37 = u4:NextNumber(0, 200)
                local v38 = u4
                v33(v34, v35 + Vector3.new(v36, v37, v38:NextNumber(-225, 225)), Color3.fromRGB(0, 0, 0), 5)
                task.wait(0.05)
            end
        end)
        task.wait(1)
        u26 = true
        local v39 = next
        local v40, v41 = v19:GetDescendants()
        for _, v42 in v39, v40, v41 do
            if v42:IsA("ParticleEmitter") then
                v42.Enabled = false
            end
        end
        u3:Create(v24, TweenInfo.new(0.5), {
            ["Size"] = v22
        }):Play()
        u3:Create(v25, TweenInfo.new(0.5), {
            ["TintColor"] = v23
        }):Play()
        task.wait(0.5)
        v24:Destroy()
        v25:Destroy()
        task.wait(1.5)
        v19:Destroy()
    end
end
return v1
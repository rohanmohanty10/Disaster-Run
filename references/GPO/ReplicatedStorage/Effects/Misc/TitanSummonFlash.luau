 

local v1 = game:GetService("ReplicatedStorage")
local v2 = {}
local u3 = require(v1.Modules.VFXUtility.highlight_emit)
local function u9(p4, p5, p6, _, _) --[[ Line: 6 ]]
    local v7 = {
        ["PulseSpeed"] = 6,
        ["AnimationSpeed"] = 35,
        ["PulseLength"] = 5,
        ["FadeLength"] = 0.1,
        ["Thickness"] = p5,
        ["Color"] = BrickColor.new("Neon orange").Color,
        ["Frequency"] = 3,
        ["MinThicknessMultiplier"] = 0.5,
        ["MaxThicknessMultiplier"] = 4,
        ["MinRadius"] = 15 * p5,
        ["MaxRadius"] = 35 * p5,
        ["ContractFrom"] = 0.4
    }
    local v8 = {
        ["MaxDistance"] = p6,
        ["MinDistance"] = p6 / 3,
        ["MaxSparkCount"] = 5,
        ["MaxSpeed"] = 5
    }
    _G.PlayEffect("LightningV2", nil, CFrame.new((p4.HumanoidRootPart.CFrame * CFrame.new(0, 1000, 0)).Position), p4.Head, v7, 15, v8)
end
local function u17(p10, p11, p12, p13, p14) --[[ Line: 33 ]]
    local v15 = {
        ["PulseSpeed"] = 6,
        ["AnimationSpeed"] = 35,
        ["PulseLength"] = 5,
        ["FadeLength"] = 0.1,
        ["Thickness"] = p11,
        ["Color"] = BrickColor.new("Neon orange").Color,
        ["Frequency"] = 4,
        ["MinThicknessMultiplier"] = 0.1,
        ["MaxThicknessMultiplier"] = 3,
        ["MinRadius"] = p14 * 2,
        ["MaxRadius"] = p14 * 4,
        ["ContractFrom"] = 0.1
    }
    local v16 = {
        ["MaxDistance"] = p12,
        ["MinDistance"] = p12 / 3,
        ["MaxSparkCount"] = 5,
        ["MaxSpeed"] = 5
    }
    _G.PlayEffect("LightningV2", nil, p10.HumanoidRootPart.CFrame * CFrame.new(0, -p13, 0), p10.Head, v15, 15, v16)
end
function v2.start(_, p18) --[[ Line: 59 ]]
    --[[
    Upvalues:
        [1] = u9
        [2] = u17
        [3] = u3
    --]]
    local v19 = p18.scale or 40
    local v20 = p18.height or 200
    local u21 = p18.big or 600
    local u22 = p18.thick or 1
    local v23 = p18.startTime
    local v24 = p18.char
    local u25 = p18.charPosition
    local v26 = v23 - workspace:GetServerTimeNow()
    u9(v24, u22, u21, v20, v19)
    u17(v24, u22, u21, v20, v19)
    task.wait(v26)
    u3.tweenHighlight(v24, Color3.fromRGB(255, 128, 17), Color3.fromRGB(255, 128, 17), 0.25, Enum.HighlightDepthMode.Occluded, "Out", 0.25)
    pcall(function() --[[ Line: 85 ]]
        --[[
        Upvalues:
            [1] = u25
            [2] = u22
            [3] = u21
        --]]
        local v27 = script.Part:Clone()
        v27.CFrame = CFrame.new(u25)
        local v28 = v27.Mesh
        local v29 = 65 * u22
        local v30 = 65 * u22
        v28.Scale = Vector3.new(v29, 10000, v30)
        v27.Parent = workspace.Effects
        _G.tween(v27.Mesh, {
            0.1,
            "EntranceProductive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Scale"] = Vector3.new(0, 10000, 0)
        })
        _G.tween(v27.PointLight, {
            0.1,
            "EntranceProductive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Range"] = 500,
            ["Brightness"] = 0
        })
        _G.destroy(v27, 0.2)
        local v31 = script.Part2:Clone()
        v31.CFrame = CFrame.new(u25)
        local v32 = u21
        local v33 = u21
        local v34 = u21
        v31.Mesh.Scale = Vector3.new(v32, v33, v34) / 2
        v31.Parent = workspace.Effects
        local v35 = u21
        _G.tween(v31.Mesh, {
            0.25,
            "EntranceProductive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Scale"] = Vector3.new(v35, v35, v35)
        })
        _G.tween(v31, {
            0.25,
            "EntranceProductive",
            Enum.EasingDirection.Out,
            0,
            false,
            0
        }, {
            ["Transparency"] = 1
        })
        _G.destroy(v31, 0.25)
    end)
end
return v2
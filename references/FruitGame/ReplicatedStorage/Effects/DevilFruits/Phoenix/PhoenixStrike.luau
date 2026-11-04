 

local v1 = {}
local u2 = game:GetService("RunService")
local u3 = game:GetService("ReplicatedStorage"):WaitForChild("Refrences"):WaitForChild("Phoenix")
local u4 = require(game:GetService("ReplicatedStorage"):WaitForChild("Util").Misc)
require(game:GetService("ReplicatedStorage").Util.ShakeCamera)
local _ = workspace.CurrentCamera
local u5 = require(u3.Modules.Trail)
local u6 = require(u3.Modules.Slash)
require(game.ReplicatedStorage.Util.Tween)
require(u3.Effects.Flare)
function v1.start(_, p7, p8, p9, p10) --[[ Line: 13 ]]
    --[[
    Upvalues:
        [1] = u4
        [2] = u3
        [3] = u5
        [4] = u6
        [5] = u2
    --]]
    if _G.checkRenderDistance(p7.Position) == false then
        return
    end
    local v11 = p8 or 10
    local v12 = p9 or 1
    if p10 then
        local v13 = math.max(0.6, v12)
        u4.PlaySound(p7, u3.Sounds["Audio/PhoUltFinalWhoosh"], {
            ["PlaybackSpeed"] = 1 / v13
        })
    else
        local v14 = math.max(0.6, v12)
        u4.PlaySound(p7, u3.Sounds["Audio/PhoUltWhoosh1"], {
            ["PlaybackSpeed"] = 1 / v14
        })
    end
    u5.new({
        ["Anchor"] = p7,
        ["Scale"] = v11 * 0.4,
        ["Lifetime"] = v12 * (p10 and 1.5 or 1.25)
    }):Emit()
    local v15 = p7.Position - Vector3.new(0, 0, 1)
    local v16 = v15
    local v17 = nil
    local v18 = 0.016666666666666666
    while true do
        local v19 = tick()
        v17 = v17 or v19
        if not (p7 and p7.Parent) then
            break
        end
        local v20 = (v19 - v17) / v12
        local v21 = math.min(1, v20)
        local v22 = p7.Position
        v15 = v15:Lerp(v22, v18 * 8)
        local v23 = CFrame.new(v22, v15)
        if (v23.Position - v16).Magnitude > v11 * 0.25 then
            if p10 then
                u6.new(5, {
                    ["CFrame"] = v23 * CFrame.Angles(1.5707963267948966, 0, 0),
                    ["Scale"] = v11,
                    ["Accent"] = Color3.fromRGB(255, 170, 0),
                    ["Offset"] = CFrame.new(0, -v11, 0),
                    ["Color"] = Color3.fromRGB(0, 170, 255),
                    ["Transparency"] = 0.3,
                    ["Duration"] = 0.5,
                    ["RotationDirection"] = 2
                }):Emit()
                for v24 = 1, 3 do
                    u6.new(math.random(1, 3), {
                        ["CFrame"] = v23 * CFrame.Angles(-1.5707963267948966, 0, 0),
                        ["Scale"] = v11 * (v24 / 3),
                        ["Offset"] = CFrame.new(0, v11 * (v24 / 3), 0),
                        ["Color"] = Color3.fromRGB(255, 170, 0),
                        ["Transparency"] = 0.01,
                        ["Duration"] = 0.4,
                        ["RotationDirection"] = 2
                    }):Emit()
                end
            end
            v16 = v23.Position
        end
        if v21 == 1 then
            break
        end
        u2.RenderStepped:Wait()
        v18 = tick() - v19
    end
end
return v1
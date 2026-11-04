 

local u1 = game:GetService("RunService")
local u2 = game.ReplicatedStorage.Refrences.Phoenix
local u3 = require(script.Parent.Parent.Modules.Slash)
local u4 = require(game.ReplicatedStorage.Util.Misc)
local u5 = require(u2.Modules.Trail)
local u6 = workspace.CurrentCamera
return function(p7, p8, p9, p10) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u6
        [2] = u4
        [3] = u2
        [4] = u5
        [5] = u3
        [6] = u1
    --]]
    local v11 = p8 or 10
    local v12 = p9 or 1
    if p10 then
        local v13 = math.max(0.6, v12)
        u4.PlaySound(p7, u2.Sounds["Audio/PhoUltFinalWhoosh"], {
            ["PlaybackSpeed"] = 1 / v13
        })
    else
        local v14 = math.max(0.6, v12)
        u4.PlaySound(p7, u2.Sounds["Audio/PhoUltWhoosh1"], {
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
        local v24 = v23.p or Vector3.new()
        if (u6.CFrame.p - v24).Magnitude < 25 + v11 * 5 and (v23.p - v16).Magnitude > v11 * 0.25 then
            if p10 then
                u3.new(5, {
                    ["CFrame"] = v23 * CFrame.Angles(1.5707963267948966, 0, 0),
                    ["Scale"] = v11,
                    ["Accent"] = Color3.fromRGB(255, 170, 0),
                    ["Offset"] = CFrame.new(0, -v11, 0),
                    ["Color"] = Color3.fromRGB(0, 170, 255),
                    ["Transparency"] = 0.3,
                    ["Duration"] = 0.5,
                    ["RotationDirection"] = 2
                }):Emit()
                for v25 = 1, 3 do
                    u3.new(math.random(1, 3), {
                        ["CFrame"] = v23 * CFrame.Angles(-1.5707963267948966, 0, 0),
                        ["Scale"] = v11 * (v25 / 3),
                        ["Offset"] = CFrame.new(0, v11 * (v25 / 3), 0),
                        ["Color"] = Color3.fromRGB(255, 170, 0),
                        ["Transparency"] = 0.01,
                        ["Duration"] = 0.4,
                        ["RotationDirection"] = 2
                    }):Emit()
                end
            end
            v16 = v23.p
        end
        if v21 == 1 then
            break
        end
        u1.RenderStepped:Wait()
        v18 = tick() - v19
    end
end
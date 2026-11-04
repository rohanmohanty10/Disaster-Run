 

local v1 = {}
game:GetService("TweenService")
local v2 = game:GetService("ReplicatedStorage")
local u3 = require(v2.Modules.VFXUtility.highlight_emit)
function v1.start(_, p4, p5) --[[ Line: 8 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    local v6 = 0
    while true do
        local v7 = workspace:GetServerTimeNow() - p5
        local v8 = v7 * 2
        local v9 = math.floor(v8)
        if v6 < v9 then
            local v10 = Color3.fromRGB(56, 25, 255)
            u3.tweenHighlight(p4, v10, v10, 0.25, Enum.HighlightDepthMode.Occluded, "In", 0.1)
            local v11 = script.Activation:Clone()
            v11.CFrame = p4.PrimaryPart.CFrame
            v11.Parent = workspace.Effects
            _G.customEmit(v11)
            _G.destroy(v11, 4)
            _G.PlaySound(p4.PrimaryPart, script.DragonLightningStrike3, {
                ["Pitch"] = 1.5 + v7 / 2
            })
        else
            v9 = v6
        end
        task.wait()
        if p4:GetAttribute("holdingThunderfall") == nil then
            return
        end
        v6 = v9
    end
end
return v1
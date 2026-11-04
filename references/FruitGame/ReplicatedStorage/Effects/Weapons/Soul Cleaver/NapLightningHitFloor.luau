 

local v1 = {}
game:GetService("Debris")
local u2 = game:GetService("TweenService")
game:GetService("RunService")
workspace:WaitForChild("Effects")
require(script.Parent.NapSoulLightning)
local u3 = script.Parent.LightningHits
Random.new()
function v1.start(_, p4, p5) --[[ Line: 12 ]]
    --[[
    Upvalues:
        [1] = u3
        [2] = u2
    --]]
    local v6 = u3.ElecHit
    if p5 == true then
        v6 = u3.FireElecHit
    end
    local v7 = v6:Clone()
    v7.CFrame = CFrame.lookAlong(p4.Position + p4.Normal * 0.05, p4.Normal) * CFrame.Angles(-1.5807963267948966, 0, 0)
    v7.Parent = workspace.Effects
    _G.customEmit(v7)
    u2:Create(v7.Attachment.PointLight, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
        ["Brightness"] = 0,
        ["Range"] = 2
    }):Play()
    _G.destroy(v7, 2)
end
return v1
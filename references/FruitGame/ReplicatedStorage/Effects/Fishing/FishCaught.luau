 

local v1 = {}
local v2 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
game:GetService("HttpService")
local v3 = v2.Fishing.Assets
local _ = v3.Rewards
local u4 = v3.SFX.Nibble:GetChildren()
function v1.start(_, p5) --[[ Line: 23 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    local v6 = p5.Hook
    if v6 then
        local _ = p5.Reward
        local v7 = script.Splash:Clone()
        v7.Parent = workspace.Effects
        while v6.Parent and v6:GetAttribute("Caught") do
            v7.Position = Vector3.new(0, 1, 0) * _G.getWavePosition(v6.Position) + v6.Position * Vector3.new(1, 0, 1)
            _G.customEmit(v7)
            _G.PlaySound(v7, u4[math.random(#u4)], {
                ["RandomPitch"] = true
            })
            task.wait(0.5)
        end
        task.delay(3, v7.Destroy, v7)
    end
end
return v1
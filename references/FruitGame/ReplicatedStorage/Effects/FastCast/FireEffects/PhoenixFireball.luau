 

local v1 = {}
require(game.ReplicatedStorage.Refrences.Fishman.Modules.SpikyFoam)
local function u4(p2) --[[ Line: 5 ]]
    local v3 = p2:Clone()
    p2.Enabled = false
    v3.Parent = p2.Parent
    v3.Enabled = false
    v3.Lifetime = NumberRange.new(0.5, 1.5)
    v3.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 10, 5), NumberSequenceKeypoint.new(1, 0, 0) })
    v3.Speed = NumberRange.new(100, 200)
    v3.Drag = 5
    v3.SpreadAngle = Vector2.new(-360, 360)
    v3:Emit(25)
end
function v1.impact(p5, p6, _, _, _) --[[ Line: 19 ]]
    --[[
    Upvalues:
        [1] = u4
    --]]
    local v7 = require(script.Explode)
    p5.sfx:Stop()
    p5.Anchored = true
    p5.Parent = workspace.Effects
    p5.FireExplosion:Play()
    u4(p5.BurningPart)
    u4(p5.Attachment.BurningPart)
    v7:start(p5.CFrame, p5.CFrame, p5, p6)
    _G.tween(p5.PointLight, {
        0.25,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out,
        0,
        false,
        0
    }, {
        ["Range"] = 50,
        ["Brightness"] = 0
    })
    _G.destroy(p5, 2)
end
function v1.splash(p8, p9) --[[ Line: 34 ]]
    local v10 = p8:GetDescendants()
    for v11 = 1, #v10 do
        if v10[v11]:IsA("ParticleEmitter") then
            v10[v11].Enabled = false
        end
    end
    _G.destroy(p8, 2)
    p8.Parent = workspace.Effects
    Instance.new("BoolValue", p8).Name = "FinishHit"
    local v12 = script.smoke:Clone()
    v12.Parent = workspace.Effects
    v12.CFrame = p9
    v12.Attachment.sm2:Emit(35)
    _G.destroy(v12, 2)
end
function v1.Fire(_, _, p13) --[[ Line: 52 ]]
    p13.sfx:Play()
end
return v1
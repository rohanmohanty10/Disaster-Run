 

local v1 = {}
local _ = _G.tween
function v1.start(_, p2, p3) --[[ Line: 16 ]]
    local v4 = p2.PrimaryPart.CFrame
    local v5 = script.FIREBALL:Clone()
    v5.CFrame = CFrame.new(p3.PrimaryPart.Position, v4.Position)
    local v6 = (p3.PrimaryPart.Position - v4.Position).Magnitude
    local v7 = v6 / 200
    v5.Parent = workspace.Effects
    local v8 = math.clamp(v7, 0, 3)
    _G.PlaySound(v5, script.BaalFireballSnakesShoot).Parent = v5
    game.TweenService:Create(v5, TweenInfo.new(v8, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        ["CFrame"] = CFrame.new(p3.PrimaryPart.Position, v4.Position) * CFrame.new(0, 0, -v6)
    }):Play()
    task.wait(v8)
    _G.customEmit(v5.Explosion)
    _G.PlaySound(p2.PrimaryPart, script["BaalFireballBoom" .. math.random(1, 3)])
    _G.particleEnabled(v5, false, true)
    _G.destroy(v5, 4)
end
return v1
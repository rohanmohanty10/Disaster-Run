 

local v1 = {}
local _ = _G.tween
function v1.start(_, u2, p3) --[[ Line: 16 ]]
    local v4 = u2.PrimaryPart.CFrame
    local v5 = script.Fx:Clone()
    v5:PivotTo(v4)
    local v6 = (p3.PrimaryPart.Position - v4.Position).Magnitude
    local v7 = v6 / 200
    v5.RootPart.CFrame = CFrame.new(p3.PrimaryPart.Position, v4.Position)
    local v8, v9, v10 = _G.getRayFloor(v4, 5)
    local v11 = CFrame.new(v9, v9 + v10) * CFrame.Angles(-1.5707963267948966, 0, 0)
    v5.exp.CFrame = v11
    if v8 then
        _G.recolorParticles(v5, v8.Color)
    end
    v5.Parent = workspace.Effects
    local v12 = math.clamp(v7, 0, 3)
    _G.PlaySound(v5.RootPart, script.PumpkinMeteorFall).Parent = v5.RootPart
    game.TweenService:Create(v5.RootPart, TweenInfo.new(v12, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
        ["CFrame"] = CFrame.new(p3.PrimaryPart.Position, v4.Position) * CFrame.new(0, 0, -v6)
    }):Play()
    task.wait(v12 * 0.9)
    _G.customEmit(v5.exp)
    for _, v13 in v5.exp:GetDescendants() do
        if v13.ClassName == "PointLight" then
            game.TweenService:Create(v13, TweenInfo.new(1), {
                ["Brightness"] = 0
            }):Play()
        end
    end
    _G.PlaySound(u2.PrimaryPart, script.PumpkinMeteorBoomqq)
    task.delay(0.25, function() --[[ Line: 48 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        _G.PlaySound(u2.PrimaryPart, script.PumpkinMeteorScream)
    end)
    _G.particleEnabled(v5.RootPart, false)
    for _, v14 in v5:GetDescendants() do
        if v14:IsA("BasePart") then
            v14.Transparency = 1
        end
    end
    _G.destroy(v5, 4)
end
return v1
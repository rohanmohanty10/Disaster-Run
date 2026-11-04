 

function PlayFlipbook(p1, p2, p3, p4, p5)
    for v6 = p4, p5 do
        local v7
        if p2:FindFirstChild((tostring(v6))) then
            v7 = v6
        else
            v7 = v6 + 1
        end
        p1.Texture = p2[tostring(v7)].Texture
        task.wait(p3)
    end
end
Emit = _G.Emit
TweenCreate = _G.Ess.Tween
local u8 = require(script.Crater)
return {
    ["start"] = function(_, _, p9, p10, p11) --[[ Name: start, Line 18 ]]
        --[[
        Upvalues:
            [1] = u8
        --]]
        if _G.checkRenderDistance(p9.PrimaryPart.Position) then
            Random.new()
            local v12 = p9.Humanoid.RootPart
            local v13 = p11.Position + Vector3.new(0, 6, 0)
            local v14 = v13 + Vector3.new(0, 15, 0)
            local v15 = (v12.Position - v14).Magnitude
            local v16 = (v13 - v14).Magnitude
            local v17 = script.JumpWind:Clone()
            v17.CFrame = CFrame.new(p10.Position, v14) * CFrame.Angles(-1.5707963267948966, 0, 0)
            v17.Parent = workspace.Effects
            v17.Line.Speed = NumberRange.new(v15 * 2, v15 * 7 + 30)
            Emit(v17:GetDescendants(), true)
            _G.destroy(v17, 1.2)
            _G.PlaySound(p9.PrimaryPart, script["Audio/JetStampTP"])
            task.wait(0.25)
            local v18 = CFrame.new(v14, v13)
            local _ = v18 * CFrame.new(0, 0, -v16)
            local v19 = workspace:Raycast(v14 + Vector3.new(0, -4, 0), v18.LookVector * v16 * 2, _G.Ess.RaycastParams)
            if v19 then
                local v20 = script.Impact:Clone()
                v20:PivotTo(CFrame.new(v19.Position, v19.Position + v19.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0) + Vector3.new(0, 0.1, 0))
                v20.Parent = workspace.Effects
                v20.Impact.Ground.Rocks.Color = ColorSequence.new(v19.Instance.Color)
                _G.customEmit(v20, true)
                u8:start(v20.PrimaryPart.CFrame + Vector3.new(0, 1, 0), 2, v19)
                _G.destroy(v20, 5)
                _G.PlaySound(v20.PrimaryPart, script.hitFloor)
            end
        end
    end
}
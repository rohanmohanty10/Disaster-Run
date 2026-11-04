 

return {
    ["start"] = function(_, p1) --[[ Name: start, Line 3 ]]
        local v2 = p1.char
        local v3 = p1.cf
        if _G.checkRenderDistance(v3.p) == false then
            return
        elseif v2.PrimaryPart == nil then
            return
        else
            local v4 = v2:GetScale() - 1
            if p1.Flip == nil then
                _G.PlaySound(v2.PrimaryPart, script.Sounds:GetChildren()[math.random(1, #script.Sounds:GetChildren())])
                local v5 = v2.HumanoidRootPart.Velocity.Y / 100
                local v6 = math.abs(v5)
                local v7 = v6 >= 10 and 10 or (v6 < 1 and 1 or v6)
                local v8 = script.SplashEffect:Clone()
                v8:PivotTo(CFrame.new(v3.p.X, _G.getWavePosition(v3), v3.p.Z))
                v8:ScaleTo(v7 + v4)
                v8.Parent = workspace.Effects
                _G.customEmit(v8)
                _G.destroy(v8, 5)
            else
                local v9 = script.Flip:Clone()
                v9:PivotTo(CFrame.new(v3.p.X, _G.getWavePosition(v3), v3.p.Z))
                v9:ScaleTo(v4 + v9:GetScale())
                v9.Parent = workspace.Effects
                _G.customEmit(v9)
                _G.destroy(v9, 5)
                _G.PlaySound(v2.PrimaryPart, game.ReplicatedStorage.Util.Swim.Jumps:GetChildren()[math.random(1, #game.ReplicatedStorage.Util.Swim.Jumps:GetChildren())])
            end
        end
    end
}
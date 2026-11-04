 

local v1 = game:GetService("ReplicatedStorage")
game:GetService("TweenService")
local u2 = v1.Fishing.Assets.SFX.Splash
return {
    ["start"] = function(_, p3) --[[ Name: start, Line 11 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        local v4 = p3.Hook
        if v4 ~= nil then
            local v5 = workspace.Env.WaterStuff.Falls.Position.Y + 1
            if v5 < v4.Position.Y then
                local v6 = tick()
                repeat
                    task.wait()
                until v4.Position.Y < v5 or tick() - v6 >= 2
            end
            local v7 = _G.getWavePosition and _G.getWavePosition(v4.Position) or workspace.Env.WaterStuff.Falls.Position.Y
            local v8 = script.Splash:Clone()
            local v9 = v4.Position.X
            local v10 = v4.Position.Z
            v8.Position = Vector3.new(v9, v7, v10)
            v8.Parent = workspace.Effects
            _G.customEmit(v8)
            task.delay(3, v8.Destroy, v8)
            local v11 = u2:GetChildren()
            local v12 = v11[math.random(#v11)]:Clone()
            v12:Play()
            v12.Parent = v4
            task.delay(5, v12.Destroy, v12)
        end
    end
}
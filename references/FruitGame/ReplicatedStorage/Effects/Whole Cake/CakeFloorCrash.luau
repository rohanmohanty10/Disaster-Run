 

game:GetService("RunService")
game:GetService("TweenService")
local u1 = require(game:GetService("ReplicatedStorage").Modules.CameraShaker)
return {
    ["start"] = function(_, p2) --[[ Name: start, Line 8 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v3 = p2.CFrame
        local v4 = script.Part:Clone()
        v4.CFrame = v3
        v4.Parent = workspace.Effects
        _G.customEmit(v4)
        task.delay(5, v4.Destroy, v4)
        _G.camShake:Shake(u1.Presets.Explosion)
    end
}
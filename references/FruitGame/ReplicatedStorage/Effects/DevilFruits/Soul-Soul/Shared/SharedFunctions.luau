 

local v1 = {}
game:GetService("RunService")
local _ = game.Players.LocalPlayer
function v1.AddObject(u2, p3) --[[ Line: 6 ]]
    task.delay(p3, function() --[[ Line: 7 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        if u2 and u2.Parent then
            u2:Destroy()
        end
    end)
end
function v1.PlayTween(p4) --[[ Line: 14 ]]
    p4:Play()
    p4:Destroy()
end
return v1
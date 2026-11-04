 

local v1 = {}
game:GetService("Players")
game:GetService("TweenService")
game:GetService("TweenService")
local _ = _G.particleEnabled
function v1.start(_, p2, p3) --[[ Line: 9 ]]
    if _G.checkRenderDistance(p2.PrimaryPart.Position) ~= false then
        local v4 = p2.PrimaryPart
        repeat
            local v5 = math.random(90, 110) / 100
            local v6 = v4.CFrame * CFrame.new(math.random(-10, 10), math.random(-1, 10), -math.random(1.5, 3))
            _G.PlayEffect("StarkCero", nil, p2, v6, v5, true)
            task.wait(math.random(100, 500) / 10000)
        until p3.Parent == nil or p3:IsDescendantOf(game) == false
    end
end
return v1
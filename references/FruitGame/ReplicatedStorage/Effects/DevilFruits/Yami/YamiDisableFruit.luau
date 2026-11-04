 

local v1 = {}
game:GetService("RunService")
function v1.start(_, p2, p3) --[[ Line: 4 ]]
    local v4 = tick()
    local v5 = game.Players.LocalPlayer
    _G.PlayEffect("YamiScreen", nil, p3)
    while p2 ~= nil and (not p2 or p2.Parent ~= nil) do
        p2.Parent = v5.Backpack
        game["Run Service"].RenderStepped:Wait()
        if p3 <= tick() - v4 then
            return
        end
    end
end
return v1
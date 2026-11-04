 

local v1 = {}
local u2 = game.Players.LocalPlayer
local u3 = game:GetService("ContentProvider")
task.spawn(function() --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u3
    --]]
    u3:PreloadAsync({ script })
end)
function v1.start(_, p4) --[[ Line: 10 ]]
    --[[
    Upvalues:
        [1] = u2
    --]]
    local v5 = u2.Character
    local v6 = script.SFX:FindFirstChild(p4)
    if v6 then
        if p4 == "Compliments" and math.random(1, 100) <= 1 then
            _G.PlaySound(v5.PrimaryPart, script.SFX.burp).Parent = v5.PrimaryPart
            return
        end
        _G.PlaySound(v5.PrimaryPart, v6, {
            ["RandomSound"] = true
        }).Parent = v5.PrimaryPart
    end
end
return v1
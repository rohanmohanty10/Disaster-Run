 

game:GetService("RunService")
game:GetService("TweenService")
local _ = workspace.Effects
return {
    ["start"] = function(_, p1) --[[ Name: start, Line 34 ]]
        local v2 = p1.CupidQueen
        for _, v3 in v2:QueryDescendants("BasePart") do
            v3:SetAttribute("OriginalTransparency", v3.Transparency)
            v3.Transparency = 1
        end
        task.wait(1)
        for _, v4 in v2:QueryDescendants("BasePart") do
            v4.Transparency = v4:GetAttribute("OriginalTransparency") or 0
        end
    end
}
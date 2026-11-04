 

game:GetService("RunService")
game:GetService("TweenService")
return {
    ["start"] = function(_, p1) --[[ Name: start, Line 6 ]]
        for _, v2 in p1.Floor:GetDescendants() do
            if v2:IsA("ProximityPrompt") then
                v2.Enabled = true
            end
        end
    end
}
 

game:GetService("RunService")
game:GetService("TweenService")
return {
    ["start"] = function(_, p1) --[[ Name: start, Line 6 ]]
        local v2 = p1.Floor
        local v3 = p1.Model
        for _, v4 in v2:GetDescendants() do
            if v4:IsA("ProximityPrompt") then
                v4.Enabled = v4:IsDescendantOf(v3)
            end
        end
    end
}
 

game:GetService("Players")
game:GetService("RunService")
return {
    ["start"] = function(_, p1) --[[ Name: start, Line 5 ]]
        local v2 = p1.Item:FindFirstChild("Model")
        if v2 then
            v2:Destroy()
        end
    end
}
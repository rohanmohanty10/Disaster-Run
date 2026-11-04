 

return {
    ["start"] = function(_, _, _) --[[ Name: start, Line 3 ]]
        script:GetChildren()[math.random(1, #script:GetChildren())]:Play()
    end
}
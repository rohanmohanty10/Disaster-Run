 

local u1 = game:GetService("Players")
return {
    ["start"] = function(_, p2) --[[ Name: start, Line 4 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        for _, v3 in pairs(u1:GetPlayers()) do
            if p2.Player ~= v3 then
                p2.Prompt.Enabled = p2.Enabled
            end
        end
    end
}
 

local u1 = game:GetService("Players")
return {
    ["getPlayerGui"] = function() --[[ Name: getPlayerGui, Line 9 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v2 = u1.LocalPlayer
        if not v2 then
            error("No localPlayer")
        end
        return v2:FindFirstChildOfClass("PlayerGui") or error("No PlayerGui")
    end
}
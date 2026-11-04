 

local u1 = script.SFX
return {
    ["start"] = function(_, p2) --[[ Name: start, Line 5 ]]
        --[[
        Upvalues:
            [1] = u1
        --]]
        local v3 = p2.FlagName
        local v4 = ""
        local v5 = nil
        if p2.Type == "GainedPoint" then
            v4 = p2.Player .. " has captured " .. v3 .. " for your crew!"
            v5 = Color3.new(0.152941, 1, 0.109804)
            u1.Captured:GetChildren()[math.random(#u1.Captured:GetChildren())]:Play()
        elseif p2.Type == "LostPoint" then
            v4 = "Your crew has lost " .. v3
            v5 = Color3.new(1, 0, 0)
            u1.FlagLost:Play()
        elseif p2.Type == "Contesting" then
            v4 = v3 .. " is currently being contested"
            v5 = Color3.new(1, 0.576471, 0.14902)
            u1.FlagContested:Play()
        end
        local v6 = _G.PlayEffect
        local v7 = v5.R * 255
        local v8 = math.ceil(v7)
        local v9 = v5.G * 255
        local v10 = math.ceil(v9)
        local v11 = v5.B * 255
        v6("ClientChatMessage", nil, "<font color=\'rgb(" .. v8 .. "," .. v10 .. "," .. math.ceil(v11) .. ")\'>" .. v4 .. "</font>")
    end
}
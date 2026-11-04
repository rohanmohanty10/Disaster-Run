 

local u1 = game:GetService("RunService")
local u10 = {
    ["Initialize"] = function(_, p2) --[[ Name: Initialize, Line 5 ]]
        --[[
        Upvalues:
            [1] = u10
            [2] = u1
        --]]
        local u3 = {}
        for _, v4 in script:GetChildren() do
            local v5 = v4.Name
            if v5 ~= "Shared" then
                u10[v5] = require(v4).new(p2)
                local v6 = u10[v5]
                table.insert(u3, v6)
            end
        end
        u1.Heartbeat:Connect(function() --[[ Name: Update, Line 15 ]]
            --[[
            Upvalues:
                [1] = u3
            --]]
            for _, v7 in u3 do
                local v8 = v7.Update
                local v9 = game.Players.LocalPlayer.Character
                if v9 ~= nil and (not v9 or v9.PrimaryPart ~= nil) and v8 then
                    v8(v7)
                end
            end
        end)
    end
}
return u10
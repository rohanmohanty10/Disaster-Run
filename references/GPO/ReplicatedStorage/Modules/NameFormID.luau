 

local u1 = game:GetService("Players")
local u2 = {}
if game["Run Service"]:IsClient() == true then
    script.RemoteEvent.OnClientEvent:Connect(function(p3, p4) --[[ Line: 6 ]]
        --[[
        Upvalues:
            [1] = u2
        --]]
        u2[p3] = p4
    end)
end
return function(u5) --[[ Line: 11 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u1
    --]]
    if u2[u5] then
        return u2[u5]
    end
    local v6 = u1:GetPlayerByUserId(u5)
    if v6 then
        u2[u5] = v6.Name
        return v6.Name
    end
    local u7 = "N/A"
    local v8, _ = pcall(function() --[[ Line: 21 ]]
        --[[
        Upvalues:
            [1] = u7
            [2] = u1
            [3] = u5
        --]]
        u7 = u1:GetNameFromUserIdAsync(u5)
    end)
    if v8 == true then
        u2[u5] = u7
    end
    if game["Run Service"]:IsClient() == false and v8 == true then
        pcall(function() --[[ Line: 28 ]]
            --[[
            Upvalues:
                [1] = u5
                [2] = u7
            --]]
            script.RemoteEvent:FireClient(u5, u7)
        end)
    end
    return u7
end
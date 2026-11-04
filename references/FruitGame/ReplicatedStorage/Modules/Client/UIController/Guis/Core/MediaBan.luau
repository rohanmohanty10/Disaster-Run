 

local v1 = game:GetService("Players")
game:GetService("ReplicatedStorage")
local u2 = v1.LocalPlayer
local u3 = u2:WaitForChild("PlayerGui")
local u10 = {
    ["Initialized"] = false,
    ["Maintenance"] = false,
    ["Initialize"] = function(p4) --[[ Name: Initialize, Line 12 ]]
        --[[
        Upvalues:
            [1] = u3
            [2] = u2
            [3] = u10
        --]]
        local v5 = u3:WaitForChild("MediaBan", 360)
        local v6 = v5:WaitForChild("Frame")
        v5.Enabled = true
        local v7 = false
        for v8, _ in pairs(p4:GetWhitelist()) do
            if v8 == u2.UserId then
                v5.Enabled = false
                v7 = true
                break
            end
            task.wait()
        end
        if v7 == false and game.GameId ~= 2097989947 then
            v5.Enabled = u10.Maintenance
        end
        if v5.Enabled then
            for _, v9 in pairs(v6:GetChildren()) do
                if v9:IsA("TextLabel") then
                    v9.Text = u2.Name
                end
                task.wait()
            end
        else
            v5:Destroy()
        end
        u10.Initialized = true
    end
}
return u10
 

return {
    ["check"] = function(_) --[[ Name: check, Line 3 ]]
        local v1 = game.Players.LocalPlayer
        local v2 = v1.Character
        if game.ReplicatedStorage:FindFirstChild("Stats" .. v1.Name).Stats.Team.Value ~= "Marine" then
            return {
                {
                    ["talkname"] = "PIRATE",
                    ["talknumber"] = 1,
                    ["talkend"] = 1
                }
            }
        end
        local v3 = false
        local v4
        if v2:FindFirstChild("ragcarry") then
            local v5 = game.ReplicatedStorage:FindFirstChild("Stats" .. v2:FindFirstChild("ragcarry").Value.Name)
            v3 = v5 and v5.Stats.Team.Value == "Marine" and true or v3
            v4 = game.ReplicatedStorage.Events.Jail.GetCD:InvokeServer(v2:FindFirstChild("ragcarry").Value)
        else
            v4 = false
        end
        if v2:FindFirstChild("ragcarry") == nil then
            return {
                {
                    ["talkname"] = "NoCarry",
                    ["talknumber"] = 1,
                    ["talkend"] = 1
                }
            }
        end
        if v3 == true then
            return {
                {
                    ["talkname"] = "IsMarine",
                    ["talknumber"] = 1,
                    ["talkend"] = 1
                }
            }
        end
        if v4 == true then
            return {
                {
                    ["talkname"] = "JailCD",
                    ["talknumber"] = 2,
                    ["talkend"] = 2
                }
            }
        end
        if not v2:FindFirstChild("ragcarry") or (not v2:FindFirstChild("ragcarry").Value or v2:FindFirstChild("ragcarry").Value:FindFirstChild("Cuffed") ~= nil) then
            return nil
        end
        local _ = v2.ragcarry.Value
        return {
            {
                ["talkname"] = "NoWork",
                ["talknumber"] = 2,
                ["talkend"] = 2
            }
        }
    end
}
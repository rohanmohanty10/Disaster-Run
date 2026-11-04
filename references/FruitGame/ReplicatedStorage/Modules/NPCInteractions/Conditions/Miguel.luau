 

local v1 = {}
require(game.ReplicatedStorage.Modules.Skills)
function v1.check(_) --[[ Line: 4 ]]
    local v2 = game.Players.LocalPlayer
    local _ = v2.Character
    local v3 = game.ReplicatedStorage:FindFirstChild("Stats" .. v2.Name)
    local v4 = v3.Skills["Abyssal Karate"].Value > 0
    if v3.Customization.Race.Value:match("Fishman") == nil then
        return {
            {
                ["talkname"] = "NotFishman",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        }
    end
    if v3.Stats.FightingStyle.Value == "Abyssal Karate" then
        return {
            {
                ["talkname"] = "AlreadyGave",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        }
    end
    if v3.Stats.FightingStyle.Value ~= "FishmanKarate" and v4 == false then
        return {
            {
                ["talkname"] = "NotFishmanKarate",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        }
    end
    if v3.Skills.FishmanKarate.Value < 5 and v4 == false then
        return {
            {
                ["talkname"] = "NotMaxFishmanKarate",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        }
    end
    if _G.arena == false then
        local v5 = _G.CheckItemAmmount(game.Players.LocalPlayer, "Megalodon Teeth")
        if v4 == false and v5 >= 10 then
            return {
                {
                    ["talkname"] = "GiveTeeth",
                    ["talknumber"] = 1,
                    ["talkend"] = 1
                }
            }
        end
    end
    game.ReplicatedStorage:FindFirstChild("Stats" .. v2.Name)
    if v4 == true and _G.arena == false then
        return {
            {
                ["talkname"] = "learnAbyssalKarate1",
                ["talknumber"] = 1,
                ["talkend"] = 2
            },
            {
                ["talkname"] = "learnAbyssalKarate2",
                ["talknumber"] = 2,
                ["talkend"] = 2
            }
        }
    end
    if _G.arena ~= true then
        return nil
    end
    local v6 = v2:GetAttribute("playersEliminated")
    return (v6 == nil and 0 or v6) < 3 and {
        {
            ["talkname"] = "NotEnoughGrips",
            ["talknumber"] = 1,
            ["talkend"] = 1
        }
    } or {
        {
            ["talkname"] = "BRTalk1",
            ["talknumber"] = 1,
            ["talkend"] = 2
        },
        {
            ["talkname"] = "BRTalk2",
            ["talknumber"] = 2,
            ["talkend"] = 2
        }
    }
end
return v1
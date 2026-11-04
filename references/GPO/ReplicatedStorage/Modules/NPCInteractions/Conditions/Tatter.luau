 

local v1 = {}
require(game.ReplicatedStorage.Modules.Skills)
function v1.check(_) --[[ Line: 4 ]]
    local v2 = game.Players.LocalPlayer
    local _ = v2.Character
    local v3 = game.ReplicatedStorage:FindFirstChild("Stats" .. v2.Name)
    local v4 = v3.Skills.Kamishiki.Value > 0
    if v3.Stats.FightingStyle.Value ~= "Rokushiki" and (v4 == false or _G.arena == true) then
        return {
            {
                ["talkname"] = "NotRokushiki",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        }
    end
    if v3.Skills.Rokushiki.Value < 5 and v4 == false then
        return {
            {
                ["talkname"] = "NotMax",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        }
    end
    local v5 = _G.CheckItemAmmount(game.Players.LocalPlayer, "Soul King\'s Guitar")
    if _G.arena == false and (v4 == false and v5 >= 1) then
        return {
            {
                ["talkname"] = "GiveGuitar1",
                ["talknumber"] = 1,
                ["talkend"] = 2
            },
            {
                ["talkname"] = "GiveGuitar2",
                ["talknumber"] = 2,
                ["talkend"] = 2
            }
        }
    end
    game.ReplicatedStorage:FindFirstChild("Stats" .. v2.Name)
    if _G.arena == false and v4 == true then
        return {
            {
                ["talkname"] = "learnRokuV21",
                ["talknumber"] = 1,
                ["talkend"] = 2
            },
            {
                ["talkname"] = "learnRokuV22",
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
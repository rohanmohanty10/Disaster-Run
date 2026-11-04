 

local v1 = {}
require(game.ReplicatedStorage.Modules.Skills)
function v1.check(_) --[[ Line: 5 ]]
    local v2 = game.Players.LocalPlayer
    local _ = v2.Character
    local v3 = game.ReplicatedStorage:FindFirstChild("Stats" .. v2.Name)
    if v3.Customization.Race.Value:match("Mink") == nil then
        return {
            {
                ["talkname"] = "NotMink",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        }
    end
    if v3.Stats.FightingStyle.Value ~= "Electro" and v3.SulongQuest.OfferingPercent.Value < 100 then
        return {
            {
                ["talkname"] = "NotElectro",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        }
    end
    if v3.Skills.Electro.Value < 5 then
        return {
            {
                ["talkname"] = "NotMaxElectro",
                ["talknumber"] = 1,
                ["talkend"] = 1
            }
        }
    end
    if _G.arena == true then
        local v4 = v2:GetAttribute("playersEliminated")
        return (v4 == nil and 0 or v4) < 3 and {
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
    local v5 = _G.CheckItemAmmount(game.Players.LocalPlayer, "Carrot")
    local v6 = game.ReplicatedStorage:FindFirstChild("Stats" .. v2.Name)
    return v6.SulongQuest.ShrineActivated.Value == true and ((v6.Stats.FightingStyle.Value == "Sulong" or v6.SulongQuest.OfferingPercent.Value < 100) and {
        {
            ["talkname"] = "AlreadyGave",
            ["talknumber"] = 1,
            ["talkend"] = 1
        }
    } or {
        {
            ["talkname"] = "learnSulong1",
            ["talknumber"] = 1,
            ["talkend"] = 2
        },
        {
            ["talkname"] = "learnSulong2",
            ["talknumber"] = 2,
            ["talkend"] = 2
        }
    }) or (v5 >= 100 and {
        {
            ["talkname"] = "GiveCarrots",
            ["talknumber"] = 1,
            ["talkend"] = 1
        }
    } or nil)
end
return v1
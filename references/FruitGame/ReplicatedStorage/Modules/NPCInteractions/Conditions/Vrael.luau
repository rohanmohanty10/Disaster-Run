 

local v1 = {}
local u2 = {
    "Dragon Fist",
    "Dragon Breath",
    "Dragon Claw Stance",
    "Dragon Claw Slash",
    "Dragon Rush",
    "Reverse Dragon",
    "Dragon Skull Crusher"
}
local u3 = require(game.ReplicatedStorage.Modules.Skills)
function v1.check(_) --[[ Line: 5 ]]
    --[[
    Upvalues:
        [1] = u2
        [2] = u3
    --]]
    local v4 = game.Players.LocalPlayer
    local _ = v4.Character
    local v5 = game.ReplicatedStorage:FindFirstChild("Stats" .. v4.Name)
    local v6 = game.ReplicatedStorage.Events.CheckRoyaleData:InvokeServer("Misc", "BRArenaCombinedWins")
    print(v6)
    local v7 = v6 or 0
    if v5.Stats.FightingStyle.Value == "DragonClaw" then
        if v5.Skills.DragonClaw.Value >= #u2 and v5.Inventory.ClaimedPipe.Value == false then
            return {
                {
                    ["talkname"] = "getpipe",
                    ["talknumber"] = 1,
                    ["talkend"] = 1
                }
            }
        end
        if v5.Skills.DragonClaw.Value >= #u2 then
            warn("maxed out")
            return {
                {
                    ["talkname"] = "maxed",
                    ["talknumber"] = 1,
                    ["talkend"] = 1
                }
            }
        end
        if v5.Skills.DragonClaw.Value < #u2 then
            warn("can learn")
            u3.GetM(u2[v5.Skills.DragonClaw.Value + 1])
            if v7 < v5.Skills.DragonClaw.Value + 1 then
                return {
                    {
                        ["talkname"] = "notReq",
                        ["talknumber"] = 1,
                        ["talkend"] = 1
                    }
                }
            end
            warn("learning skill " .. u2[v5.Skills.DragonClaw.Value + 1])
            return {
                {
                    ["talkname"] = "learn" .. u2[v5.Skills.DragonClaw.Value + 1],
                    ["talknumber"] = 1,
                    ["talkend"] = 2
                },
                {
                    ["talkname"] = "learnedSkill",
                    ["talknumber"] = 2,
                    ["talkend"] = 2
                }
            }
        end
    end
end
return v1
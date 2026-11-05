  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Promise);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");

local function toHMS(p3) -- Line: 14
    return string.format("%02i:%02i", p3 / 60 % 60, p3 % 60);
end;

return {
    Start = "start",
    Title = "Hecate",
    Nodes = {
        start = {
            Mutable = true,
            Text = "What is it that you need...?",
            Options = { {
                    Response = "Nevermind, it was nothing."
                } },

            Transformer = function(p4, p5) -- Line: 37, Name: Transformer
                -- upvalues: u2 (copy)
                local v6 = u2:GetQuestlineInfo("Slayer_Quest"):expect();
                local v7 = not v6 and {} or v6.Metadata;
                local v8 = v7.Slayers and (v7.Slayers[v7.Slayer] or {}) or {};

                if (not v6 and 1 or v6.Step) == 2 then
                    p5.Text = `Did you slay {v8.Slayer} yet? Hint: You might want to defeat some {v8.FodderNPC}`;

                    return;
                end;

                table.insert(p5.Options, 1, {
                    Response = "Do you know of any contracts that I may undertake?",
                    Next = "quest_picker"
                });
            end
        },
        quest_picker = {
            Mutable = true,
            Text = "I have been made aware of the following SLAYER contracts that you may undertake.",
            Options = { {
                    Response = "Nevermind"
                } },

            Transformer = function(p9, p10) -- Line: 63, Name: Transformer
                -- upvalues: u2 (copy), Players (copy), u1 (copy)
                local v11 = {};

                for i, v in u2:GetQuestlineInfo("Slayer_Quest"):expect().Metadata.Slayers do
                    if v.Level <= Players.LocalPlayer.Data.Ability:GetAttribute("AbilityLevel") then
                        local v15 = {
                            Name = `[CONTRACT] {v.Slayer} (Level {v.Level}+)`,
                            Level = v.Level,

                            Callback = function(p12, p13) -- Line: 76, Name: Callback
                                -- upvalues: u1 (ref), i (copy)
                                local v14 = u1:CheckDialogue("Slayer_Quest", i):expect();

                                if v14 then
                                    if typeof(v14) == "number" then
                                        p13.Next = {
                                            Text = `You have to wait {string.format("%02i:%02i", v14 / 60 % 60, v14 % 60)} minutes to retake this contract ({i})`
                                        };
                                    end;

                                    return;
                                end;

                                p13.Next = {
                                    Text = "Sorry but your ability level is not high enough for this contract"
                                };
                            end
                        };
                        table.insert(v11, v15);
                    end;
                end;

                table.sort(v11, function(p16, p17) -- Line: 88
                    return p17.Level > p16.Level;
                end);

                if #v11 > 0 then
                    for i = 1, #v11 do
                        table.insert(p10.Options, i, {
                            Response = v11[i].Name,
                            Callback = v11[i].Callback,
                            Next = {
                                Text = "I\'ve updated your contracts.",
                                Options = { {
                                        Response = "Thanks",
                                        Next = nil
                                    } }
                            }
                        });
                    end;

                    return;
                end;

                p10.Text = "You are too underleveled to take on any SLAYER contracts [LVL 25 MINIMUM REQUIRED]";
            end
        }
    }
};
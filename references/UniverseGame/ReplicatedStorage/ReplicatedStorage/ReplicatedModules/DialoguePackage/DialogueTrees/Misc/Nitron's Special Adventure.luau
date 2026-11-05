  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(ReplicatedStorage.ReplicatedModules.UIHandler);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");
local LocalPlayer = game.Players.LocalPlayer;

return {
    Start = "start",
    Title = "EpicNitronX360",
    Nodes = {
        start = {
            Text = "Choose",
            Options = { {
                    Response = "Cursed Gemstone",
                    Next = "cursed_gemstone_quest"
                }, {
                    Response = "Garou Quest",
                    Next = "garou_quest"
                } }
        },
        cursed_gemstone_quest = {
            Mutable = true,
            Text = "Yo.. you seem strong enough for my tasks, are you interested in helping me out?",

            Transformer = function(p3, p4) -- Line: 33, Name: Transformer
                -- upvalues: LocalPlayer (copy), u2 (copy), u1 (copy)
                local v5 = LocalPlayer.Data.Ability:GetAttribute("AbilityLevel");
                local v6 = u2:GetCurrentStep(script.Name):expect() or 1;
                local v7, v8 = u2:GetTaskProgress({
                    QuestLine = "Nitron\'s Special Adventure",
                    Quest = "Nitron\'s Request",
                    Task = "Defeat Whitebeard & return his Bisento to Nitron"
                }):expect();

                if v5 < 200 and v6 == 1 then
                    p4.Text = "You are not strong enough, come back when you have trained to your maximum potential. [NEEDS LEVEL 200 ABILITY EQUIPPED TO START THE QUEST]";
                    p4.Options = nil;

                    return;
                end;

                if v6 == 2 then
                    p4.Text = "Have you completed your trial?";
                    p4.Options = nil;

                    return;
                end;

                if v6 == 3 then
                    p4.Text = "It seems you are ready enough, you\'ve proven yourself by passing your trial. I will now tell you why I chose you; you\'re one with great potential & my task needed someone with that sort of potential. The motive is to find and deal with these strong & cursed escaped prisoners. You may find them around the village or the Joestar Mansion.";
                    p4.Options = {
                        {
                            Response = "Okay.",

                            Callback = function(p9, p10) -- Line: 54, Name: Callback
                                -- upvalues: u1 (ref)
                                u1:CheckDialogue(script.Name):expect();
                            end,

                            Next = {
                                Text = "Come back when you\'ve finished the tasks."
                            }
                        }
                    };

                    return;
                end;

                if v6 == 4 then
                    if v7 and v8 then
                        local _ = v8 - v7;
                        p4.Text = "Thank you for the Bisento!";
                    else
                        p4.Text = "Have you dealt with those prisoners & retrieved the bisento yet?";
                    end;

                    p4.Options = nil;

                    return;
                end;

                if v6 == 5 then
                    if LocalPlayer.Character:GetAttribute("QuestCD") then
                        p4.Text = "...";
                        p4.Options = nil;

                        return;
                    end;

                    p4.Text = "It seems that you have reincarnated, this is all according to plan. Your body now projects cursed energy, which (soon) you\'ll be able to see it\'s true power.. The last thing you have to do before you can kill \'Shadow\' is to amass gemstones & consume them. You can obtain these gemstones by talking to \'Z4\', who\'s located somewhere around the village but you will have to sacrifice the required abilities. You require the abilities: Locke, Dragon Knight, Dawn, Reaper & Xeno. Good luck, soldier!";
                    p4.Options = {
                        {
                            Response = "Okay, thanks for the information.",

                            Callback = function(p11, p12) -- Line: 81, Name: Callback
                                -- upvalues: u1 (ref)
                                u1:CheckDialogue(script.Name):expect();
                            end,

                            Next = {
                                Text = "Good luck."
                            }
                        }
                    };

                    return;
                end;

                if v6 ~= 6 then
                    if v6 == 7 then
                        p4.Text = "Alright, now take this cursed gemstone. I would recommend going to Burger & asking him for his quest, he will give you the slime energy for Cid if you manage to kill him for Bur. After that, go to the boss spawner & use this + 2.5 million uCoins to summon \'Shadow\', be very careful of his strong abilities & especially his atomic powers. Also I do not recommend using the ability \'Sakuya Izayoi\' to fight him. He has a defense mechanism set for that ability and to be fair you shouldn\'t even be using it in the first place.";
                        p4.Options = {
                            {
                                Response = "Awesome.",

                                Callback = function(p13, p14) -- Line: 105, Name: Callback
                                    -- upvalues: u1 (ref)
                                    u1:CheckDialogue(script.Name):expect();
                                end,

                                Next = {
                                    Text = "Here you go, good luck."
                                }
                            }
                        };
                    end;

                    return;
                end;

                p4.Text = "Have you consumed the gemstones yet?";
                p4.Options = { {
                        Response = "I have.",
                        Next = {
                            Text = "It doesn\'t seem like it!"
                        }
                    } };
            end,

            Options = {
                {
                    Response = "Yeah",
                    Next = {
                        Text = "Ok before you continue I need you to pass my trial, do the tasks of killing certain bosses & come back to me.",
                        Options = {
                            {
                                Response = "I am ready.",

                                Callback = function(p15, p16) -- Line: 124, Name: Callback
                                    -- upvalues: u1 (copy)
                                    u1:CheckDialogue(script.Name):expect();
                                end,

                                Next = {
                                    Text = "Alright, good luck."
                                }
                            }
                        }
                    }
                },
                {
                    Response = "Nah, I\'m good.",
                    Next = {
                        Text = "Lol weak."
                    }
                }
            }
        },
        garou_quest = {
            Mutable = true,
            Text = "To start the quest, you will need to 1m UCoins and UShards",

            Transformer = function(p17, p18) -- Line: 146, Name: Transformer
                -- upvalues: u2 (copy)
                local v19 = u2:GetCurrentStep("Garou Quest"):expect();

                if v19 == 3 then
                    p18.Text = "I will now give you Garou, make sure your ability inventory has space";

                    return;
                end;

                if v19 == 2 then
                    p18.Text = "Talk to me again when you complete the quest";
                    p18.Options = nil;
                end;
            end,

            Options = {
                {
                    Response = "Of course.",

                    Callback = function(p20, p21) -- Line: 158, Name: Callback
                        -- upvalues: u1 (copy), u2 (copy)
                        local v22 = u1:CheckDialogue("Garou Quest"):expect();
                        local v23 = u2:GetCurrentStep("Garou Quest"):expect();

                        if v22 == true and v23 == 2 then
                            p21.Next = {
                                Text = "Quest has been given, talk to me again when you complete the quest"
                            };

                            return;
                        end;

                        if type(v22) == "string" then
                            p21.Next = {
                                Text = v22
                            };
                        end;
                    end
                }
            }
        }
    }
};
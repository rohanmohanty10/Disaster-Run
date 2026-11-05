  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local Core = require(ReplicatedStorage.ReplicatedRoot:WaitForChild("Core"));
local ItemData = require(ReplicatedStorage.ReplicatedModules.ItemData);
local u1 = Core.GetClientService("LabService");
local u2 = Core.GetLegacyService("QuestLineService");
local u3 = Core.GetLegacyService("DialogueService");

local function GetItemRichText(p4) -- Line: 13
    -- upvalues: ItemData (copy)
    local v5 = ItemData.GetItemInfo(p4);

    if not v5 then
        return "";
    end;

    local v6 = ItemData.Rarities[v5.Rarity];
    local v7 = v5.Name or "";

    if v6 then
        v7 = `<Color=#{v6.Color:ToHex()}>{v7}<Color=/>`;
    end;

    return v7;
end;

local function GetIntroProgress() -- Line: 26
    -- upvalues: u2 (copy)
    return u2:GetCurrentStep("Khronos Labs"):expect() or 0;
end;

return {
    Title = "Facility Administrator",

    Start = function() -- Line: 32, Name: Start
        -- upvalues: u1 (copy), u2 (copy)
        local v8 = u1:HasTalkedToLabNPC("Administrator"):expect();
        local v9 = u1:GetClearance():expect();

        if v8 and v9 >= 1 then
            return "start";
        end;

        if v8 or v9 < 1 then
            return "invalid";
        end;

        local v10 = u2:GetCurrentStep("Khronos Labs"):expect() or 0;

        return v10 == 0 and "first_time" or (v10 == 2 and "in_intro" or (v10 == 3 and "intro_completed" or "first_time"));
    end,

    Nodes = {
        first_time = {
            Text = "You must be new here, I was told of a new arrival.",
            Options = {
                {
                    Response = "Yeah, that\'s me.",
                    Next = {
                        Text = "Good. Now, we\'ve been investigating some things in these regions and you happen to have stumbled upon a key material of that research. If you are willing, you can help us.",
                        Options = {
                            {
                                Response = "The material I salvaged from a meteorite?",
                                Next = {
                                    Text = "Precisely. The material originates from a mysterious place that is normally hard to detect and unreachable. However, we managed to use that material for technology that allows us to bypass those limitations. Our goal is to uncover more about this place and enhance our technology.",
                                    Options = {
                                        {
                                            Response = "Interesting.",
                                            Next = {
                                                Text = "So, do you want to be of assistance? This will benefit you too, of course.",
                                                Options = {
                                                    {
                                                        Response = "What\'s in for me?",
                                                        Next = {
                                                            Text = "You will be able to use our services here, assuming you do deliver on the work. Also, we may have some rewards to give you.",
                                                            Options = {
                                                                {
                                                                    Response = "Sounds good, I guess I\'ll see what I can do.",
                                                                    Next = {
                                                                        Text = "Wonderful. Though, you should prove that you\'re capable of getting things done first.",
                                                                        Options = {
                                                                            {
                                                                                Response = "Okay. What do you want me to do?",
                                                                                Next = {
                                                                                    Text = "To prepare you for some upcoming tasks, we want you to salvage another <Color=Purple>Camellite Meteorite<Color=/> and defeat some Curses, those creatures have been meddling with our logistics.",
                                                                                    Options = {
                                                                                        {
                                                                                            Response = "I will get it done.",
                                                                                            Next = Dialogue.PLACEHOLDER,

                                                                                            Callback = function(p11, p12) -- Line: 101, Name: Callback
                                                                                                -- upvalues: u3 (copy)
                                                                                                print("ACCEPTED TASK");
                                                                                                u3:CheckDialogue("Khronos Labs"):expect();
                                                                                            end
                                                                                        },
                                                                                        {
                                                                                            Response = "Nevermind, I can\'t right now.",
                                                                                            Next = nil
                                                                                        }
                                                                                    }
                                                                                }
                                                                            },
                                                                            {
                                                                                Response = "Nevermind, I can\'t right now.",
                                                                                Next = nil
                                                                            }
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }
                                                    },
                                                    {
                                                        Response = "About that \"mysterious place\"...",
                                                        Next = "island_info",

                                                        Callback = function(p13, p14) -- Line: 126, Name: Callback
                                                            local v15 = p13:GetMetadata();
                                                            local v16 = p13:GetCurrentNode();

                                                            if not v15.OriginNode then
                                                                v15.OriginNode = v16;
                                                            end;
                                                        end
                                                    },
                                                    {
                                                        Response = "I\'ll have to think about it.",
                                                        Next = nil
                                                    }
                                                }
                                            }
                                        },
                                        {
                                            Response = "Got to go.",
                                            Next = nil
                                        }
                                    }
                                }
                            },
                            {
                                Response = "I don\'t know what you\'re talking about.",
                                Next = {
                                    Text = "You can just say no."
                                }
                            }
                        }
                    }
                },
                {
                    Response = "Got to go.",
                    Next = nil
                }
            }
        },
        in_intro = {
            Text = "Have you completed your tasks yet?",
            Options = { {
                    Response = "Not yet.",
                    Next = nil
                } }
        },
        intro_completed = {
            Text = "Good work with those tasks, I guess we can rely on you.",
            Options = {
                {
                    Response = "Of course.",

                    Callback = function(p17, p18) -- Line: 180, Name: Callback
                        -- upvalues: u1 (copy), u3 (copy), ReplicatedStorage (copy)
                        u1:SetTalkedToLabNPC("Administrator");
                        u3:CheckDialogue("Khronos Labs"):expect();
                        ReplicatedStorage.Remotes.ClientUIOutput:Fire("ShowInformationPrompt", "Reputation");
                    end,

                    Next = {
                        Text = "Alright, you will be granted access to <Color=Green>Analytics<Color=/>, where you can begin proper work. If you have questions or want information regarding your <Color=Yellow>Reputation<Color=/> here, you can ask me.",
                        Options = { {
                                Response = "Understood, thank you.",
                                Next = nil
                            } }
                    }
                }
            }
        },
        island_info = {
            Mutable = true,
            Text = "Ask away.",
            Options = {
                {
                    Response = "What else do you know about it?",
                    Next = {
                        Text = "What exactly lies in that region is still unknown, as any electric surveillance equipment could not withstand the conditions. Thus, we can assume that it\'s a very hostile environment with threats waiting to be found.",
                        Options = { {
                                Response = "Understood.",
                                Next = "island_info"
                            } }
                    }
                },
                {
                    Response = "How did you find it?",
                    Next = {
                        Text = "A cult surfaced some time ago that has mentioned things seemingly related to that place. We have decided to track them and any correlating energy signatures and sure enough, we were able to pinpoint a location. When we analyzed the signatures, we were able to infer that the material you have found in that meteorite also exists on what we call \"The Fractured Island\".",
                        Options = { {
                                Response = "Understood.",
                                Next = "island_info"
                            } }
                    }
                },
                {
                    Response = "Nevermind.",
                    Next = Dialogue.PLACEHOLDER,

                    Callback = function(p19, p20) -- Line: 230, Name: Callback
                        local v21 = p19:GetMetadata();

                        if v21.OriginNode then
                            p20.Next = v21.OriginNode;
                            v21.OriginNode = nil;
                        end;
                    end
                },
                {
                    Response = "Got to go.",
                    Next = nil
                }
            }
        },
        start = {
            Text = "Need anything?",
            Mutable = true,
            Options = {
                {
                    Response = "Can you update my keycard?",
                    Next = Dialogue.PLACEHOLDER,

                    Callback = function(p22, p23) -- Line: 253, Name: Callback
                        -- upvalues: u1 (copy)
                        local v24 = u1:UpdateKeycardClearance():expect();

                        if v24 == true then
                            p23.Next = {
                                Text = "Done.",
                                Options = { {
                                        Response = "Thanks.",
                                        Next = nil
                                    } }
                            };

                            return;
                        end;

                        if v24 == "Same" then
                            p23.Next = {
                                Text = "It\'s already updated.",
                                Options = { {
                                        Response = "Okay.",
                                        Next = nil
                                    } }
                            };

                            return;
                        end;

                        if not v24 then
                            p23.Next = {
                                Text = "Seems like you have no keycard, get a replacement from the Guardian.",
                                Options = { {
                                        Response = "Okay.",
                                        Next = nil
                                    } }
                            };
                        end;
                    end
                },
                {
                    Response = "I want to see information regarding my reputation.",
                    Next = Dialogue.PLACEHOLDER,

                    Callback = function(p25, p26) -- Line: 291, Name: Callback
                        -- upvalues: u1 (copy)
                        u1:DisplayRankRewards();
                    end
                },
                {
                    Response = "About that \"mysterious place\"...",
                    Next = "island_info",

                    Callback = function(p27, p28) -- Line: 298, Name: Callback
                        local v29 = p27:GetMetadata();

                        if not v29.OriginNode then
                            v29.OriginNode = "start";
                        end;
                    end
                },
                {
                    Response = "Tell me about Reputation again.",
                    Next = Dialogue.PLACEHOLDER,

                    Callback = function(p30, p31) -- Line: 309, Name: Callback
                        -- upvalues: ReplicatedStorage (copy)
                        ReplicatedStorage.Remotes.ClientUIOutput:Fire("ShowInformationPrompt", "Reputation");
                    end
                },
                {
                    Response = "No.",
                    Next = nil
                }
            }
        },
        invalid = {
            Text = "...",
            Options = { {
                    Response = "...",
                    Next = nil
                } }
        }
    }
};
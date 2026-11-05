  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local Core = require(ReplicatedStorage.ReplicatedRoot:WaitForChild("Core"));
local ItemData = require(ReplicatedStorage.ReplicatedModules.ItemData);
local u1 = Core.GetClientService("LabService");
local u2 = Core.GetLegacyService("DialogueService");
local u3 = Core.GetLegacyService("QuestLineService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);

local function GetItemRichText(p4, p5) -- Line: 11
    -- upvalues: ItemData (copy)
    local v6 = ItemData.GetItemInfo(p4);

    if not v6 then
        return "";
    end;

    local v7 = ItemData.Rarities[v6.Rarity];
    local v8 = v6.Name or "";

    if v7 then
        v8 = `<Color=#{v7.Color:ToHex()}>{p5 and "x" .. p5 .. " " or " "}{v8}<Color=/>`;
    end;

    return v8;
end;

local function GetItemText(p9) -- Line: 24
    -- upvalues: ItemData (copy)
    local v10 = ItemData.GetItemInfo(p9);

    if not v10 then
        return "";
    end;

    local v11 = ItemData.Rarities[v10.Rarity];
    local v12 = v10.Name or "";

    if v11 then
        v12 = `<font color="#{v11.Color:ToHex()}">{v12}</font>`;
    end;

    return v12;
end;

local function toMS(p13) -- Line: 37
    return string.format("%02i:%02i", p13 / 60 % 60, p13 % 60);
end;

return {
    Title = "Analytics Overseer",

    Start = function() -- Line: 42, Name: Start
        -- upvalues: u1 (copy)
        local v14 = u1:HasTalkedToLabNPC("Overseer_A"):expect();

        return u1:GetClearance():expect() < 2 and "invalid" or (v14 and "start" or "first_time");
    end,

    Nodes = {
        first_time = {
            Text = "Ah, you\'re the one they mentioned. New asset and sample carrier.",
            Options = {
                {
                    Response = "You analyze the materials?",
                    Next = {
                        Text = "Correct. This division processes and archives anomalous substances. In return, you get <Color=Yellow>Reputation<Color=/>. Also, certain technologies can be unlocked here.",
                        Options = {
                            {
                                Response = "What do you need from me?",
                                Next = {
                                    Text = "Any special samples you\'ve gathered. Camellite, remnants, other items of interest - especially anything from the Fractured Island. You can turn them in here.",
                                    Options = {
                                        {
                                            Response = "And I get reputation for that?",
                                            Next = {
                                                Text = "Yes. The more valuable the sample, the more you gain. Reputation determines your access level within the facility.",
                                                Options = {
                                                    {
                                                        Response = "Understood.",
                                                        Next = {
                                                            Text = "Very well. When you\'re ready, just provide me what you have gathered. I\'ll handle the rest.",
                                                            Options = {
                                                                {
                                                                    Response = "Alright. I\'ll come back with something.",
                                                                    Next = {
                                                                        Text = "Talk to me if you have questions."
                                                                    },

                                                                    Callback = function(p15, p16) -- Line: 89, Name: Callback
                                                                        -- upvalues: u1 (copy), ReplicatedStorage (copy)
                                                                        u1:SetTalkedToLabNPC("Overseer_A");
                                                                        ReplicatedStorage.Remotes.ClientUIOutput:Fire("ShowInformationPrompt", "Analytics");
                                                                    end
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
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
        start = {
            Mutable = true,
            Text = "What\'s up?",

            Transformer = function(p17, p18) -- Line: 116, Name: Transformer
                -- upvalues: u3 (copy)
                if u3:GetCurrentStep("Space Crucible"):expect() == 3 then
                    table.insert(p18.Options, 1, {
                        Response = "I was asked to run a cognitive scan.",
                        Next = "anomaly"
                    });
                end;
            end,

            Options = {
                {
                    Response = "I have samples to exchange.",
                    Next = Dialogue.PLACEHOLDER,

                    Callback = function(p19, p20) -- Line: 137, Name: Callback
                        -- upvalues: ReplicatedStorage (copy)
                        ReplicatedStorage.Remotes.ClientUIOutput:Fire("ShowReputationExchange");
                    end
                },
                {
                    Response = "I would like to access research.",
                    Next = Dialogue.PLACEHOLDER,

                    Callback = function(p21, p22) -- Line: 144, Name: Callback
                        -- upvalues: ReplicatedStorage (copy)
                        ReplicatedStorage.Remotes.ClientUIOutput:Fire("ShowLabResearch");
                    end
                },
                {
                    Response = "I have an item you might want to take a look at.",
                    Next = "show_object"
                },
                {
                    Response = "I want to take a <b>Sample Contract</b>.",
                    Next = "sample_contract"
                },
                {
                    Response = "I want to see the information about this place again.",

                    Callback = function() -- Line: 158, Name: Callback
                        -- upvalues: ReplicatedStorage (copy)
                        ReplicatedStorage.Remotes.ClientUIOutput:Fire("ShowInformationPrompt", "Analytics");
                    end,

                    Next = Dialogue.PLACEHOLDER
                },
                {
                    Response = "Nevermind.",
                    Next = nil
                }
            }
        },
        anomaly = {
            Text = "Alright, sure. May I ask why, though?",
            Options = {
                {
                    Response = "I had an interaction with an anomalous shrine on the Fractured Island.",
                    Next = {
                        Text = "Ah.. I suppose you are the curious kind. Okay, one moment.\n.<AnimateYield=0.5>.<AnimateYield=0.5>.\nOkay, ready to start the reading.",
                        Options = {
                            {
                                Response = "You can start.",

                                Callback = function() -- Line: 180, Name: Callback
                                    -- upvalues: EffectsHandler (copy)
                                    task.delay(0.35, EffectsHandler.CallEffect, "Yuki_Vignette", {
                                        LifeTime = 0.75,
                                        Transparency = 0.3,
                                        TweenIn = { 0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In },
                                        TweenOut = { 3, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut },
                                        Size = UDim2.fromScale(1, 1),
                                        Color = Color3.fromRGB(73, 106, 198),
                                        Color2 = Color3.fromRGB(198, 68, 68)
                                    });
                                end,

                                Next = {
                                    Text = "Starting now.\n<AnimateYield=0.9>Strange... there\'s residual structuring in this signature. Not just interference -<AnimateYield=0.65> it\'s patterned. Like a schematic.",
                                    Options = {
                                        {
                                            Response = "A schematic?",
                                            Next = {
                                                Text = "It seems like... a device. Perhaps whatever you made contact with asked you to have this? That is all I can think of.",
                                                Options = {
                                                    {
                                                        Response = "...",
                                                        Next = {
                                                            Text = "We\'ll extract what we can. You may be able to fabricate it -<AnimateYield=0.65> this could be your way forward.",
                                                            Options = {
                                                                {
                                                                    Response = "Okay.",

                                                                    Callback = function() -- Line: 209, Name: Callback
                                                                        -- upvalues: u3 (copy), u2 (copy)
                                                                        if u3:GetCurrentStep("Space Crucible"):expect() == 3 then
                                                                            u2:CheckDialogue("Space Crucible"):expect();
                                                                        end;
                                                                    end
                                                                }
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        },
        show_object = {
            Mutable = true,
            Text = "What do you have?",

            Transformer = function(p23, p24) -- Line: 234, Name: Transformer
                -- upvalues: u2 (copy), ItemData (copy)
                for i, v in {
                    ITEM_911 = {
                        Ref = "crystalline_core_shown"
                    },
                    ITEM_916 = {
                        Ref = "cultist_weapon_shown"
                    },
                    ITEM_917 = {
                        Ref = "cultist_weapon_shown"
                    }
                } do
                    local v25 = u2:CheckRequirement("ItemCountCheck", i):expect();

                    if v25 and v25 >= 1 then
                        local Options = p24.Options;
                        local v26 = {};
                        local v27 = ItemData.GetItemInfo(i);
                        local v28;

                        if v27 then
                            local v29 = ItemData.Rarities[v27.Rarity];
                            v28 = v27.Name or "";

                            if v29 then
                                v28 = `<font color="#{v29.Color:ToHex()}">{v28}</font>`;
                            end;
                        else
                            v28 = "";
                        end;

                        v26.Response = `<i>Show <b>{v28}</b></i>`;
                        v26.Next = v.Ref;
                        table.insert(Options, 1, v26);
                    end;
                end;
            end,

            Options = { {
                    Response = "Nevermind.",
                    Next = nil
                } }
        },
        crystalline_core_shown = {
            Mutable = true,
            Text = "...",

            Transformer = function(p30, p31) -- Line: 270, Name: Transformer
                -- upvalues: u1 (copy), ItemData (copy), Dialogue (copy), u2 (copy)
                local v32 = u1:GetReputationInfo():expect();
                local v33 = u1:GetUnlockedResearch():expect();

                if not v32 or v32.Rank < 5 then
                    p31.Text = "This is indeed interesting, though, I feel like you are not ready for the process involving material like this yet. Come back when you have reached the rank of Researcher.";
                    p31.Options = { {
                            Response = "Okay.",
                            Next = nil
                        } };

                    return;
                end;

                if v33 and v33.Mats2 then
                    p31.Text = "It is interesting, yes. But we\'ve already gone over it. You should go ahead and infuse it with a stand arrow.";
                    p31.Options = { {
                            Response = "Okay.",
                            Next = nil
                        } };

                    return;
                end;

                local v34 = ItemData.GetItemInfo("ITEM_910");
                local v35;

                if v34 then
                    local v36 = ItemData.Rarities[v34.Rarity];
                    v35 = v34.Name or "";

                    if v36 then
                        v35 = `<Color=#{v36.Color:ToHex()}> {v35}<Color=/>`;
                    end;
                else
                    v35 = "";
                end;

                p31.Text = `This is interesting indeed. The energy emitted from these objects is truly fascinating. I know that you possess artifacts referred to as "Stand Arrows" which grant you unique powers, I believe you should try infusing them with this material and some {v35}. I will grant you the refining instructions to do so.`;
                p31.Options = {
                    {
                        Response = "Sounds good. I will go ahead and try that.",
                        Next = Dialogue.PLACEHOLDER,

                        Callback = function(p37, p38) -- Line: 301, Name: Callback
                            -- upvalues: u2 (ref)
                            local v39, v40 = u2:CheckRequirement("DialogueResearchUnlock", "CamelliteInfusion"):expect();
                            print(v39, v40);
                        end
                    },
                    {
                        Response = "How do you know about that?",
                        Next = {
                            Text = "It\'s simple. Do you think we\'ve set up here without investigating the area first?",
                            Options = { {
                                    Response = "Fair enough.",
                                    Next = "crystalline_core_shown"
                                } }
                        }
                    },
                    {
                        Response = "Why is your first idea for me to use this on myself?",
                        Next = {
                            Text = "Well, aren\'t strength and new powers the reason you came here in the first place?",
                            Options = { {
                                    Response = "...",
                                    Next = "crystalline_core_shown"
                                } }
                        }
                    },
                    {
                        Response = "Got to go.",
                        Next = nil
                    }
                };
            end
        },
        cultist_weapon_shown = {
            Mutable = true,
            Text = "...",

            Transformer = function(p41, p42) -- Line: 342, Name: Transformer
                -- upvalues: u1 (copy), Dialogue (copy), u2 (copy)
                local v43 = u1:GetReputationInfo():expect();
                local v44 = u1:GetUnlockedResearch():expect();

                if not v43 or v43.Rank < 6 then
                    p42.Text = "These armaments are unlike anything we\'ve seen before, though I believe you\'re not yet cleared for handling objects of this complexity. Return once you’ve attained the rank of Senior Researcher.";
                    p42.Options = { {
                            Response = "Okay.",
                            Next = nil
                        } };

                    return;
                end;

                if v44 and v44.Mats3 then
                    p42.Text = "We\'ve analysed these already. If you want to know more, you should try to reactivate these weapons.";
                    p42.Options = { {
                            Response = "Okay.",
                            Next = nil
                        } };

                    return;
                end;

                p42.Text = "Unusual material... the signature is reminiscent of other known anomalies, yet inert. Their structure remains intact, suggesting prior energy flow. I believe they once served as conduits. You should attempt to restore them - infuse them with other materials that are related to the cultists. I will ughorize access to the necessary refining procedures.";
                p42.Options = {
                    {
                        Response = "Understood. I\'ll get to it.",
                        Next = Dialogue.PLACEHOLDER,

                        Callback = function(p45, p46) -- Line: 373, Name: Callback
                            -- upvalues: u2 (ref)
                            local v47, v48 = u2:CheckRequirement("DialogueResearchUnlock", "ReverseEngineering"):expect();
                            print(v47, v48);
                        end
                    },
                    {
                        Response = "Is reactivating them safe?",
                        Next = {
                            Text = "No process involving artifacts like these is entirely safe. But the potential insight could outweigh the risk.",
                            Options = { {
                                    Response = "...Fair enough.",
                                    Next = "cultist_weapon_shown"
                                } }
                        }
                    },
                    {
                        Response = "Got to go.",
                        Next = nil
                    }
                };
            end
        },
        sample_contract = {
            Mutable = true,
            Text = "...",

            Transformer = function(p49, p50) -- Line: 402, Name: Transformer
                -- upvalues: u3 (copy), u1 (copy), ItemData (copy), u2 (copy), Dialogue (copy)
                local v51 = u3:GetCurrentStep("Sample Contract"):expect();

                if v51 and v51 >= 1 then
                    p50.Text = "You current have an active sample contract. Please complete it before taking another.";

                    return;
                end;

                local v52, v53 = u1:GetSampleContractInfo():expect();
                local v54 = "";

                for i, v in v52 do
                    local v55 = ItemData.GetItemInfo(i);
                    local v56;

                    if v55 then
                        local v57 = ItemData.Rarities[v55.Rarity];
                        v56 = v55.Name or "";

                        if v57 then
                            v56 = `<Color=#{v57.Color:ToHex()}>{v and "x" .. v .. " " or " "}{v56}<Color=/>`;
                        end;
                    else
                        v56 = "";
                    end;

                    v54 = v54 .. v56 .. ", ";
                end;

                p50.Text = `Very well. Currently we're looking for: {string.sub(v54, 1, #v54 - 2)}.\nA new contract will be available in {string.format("%02i:%02i", v53 / 60 % 60, v53 % 60)}.`;
                table.insert(p50.Options, 1, {
                    Response = "I\'ll do it.",

                    Callback = function(p58, p59) -- Line: 423, Name: Callback
                        -- upvalues: u2 (ref)
                        local v60, v61 = u2:CheckDialogue("Sample Contract"):expect();

                        if v60 == false then
                            p59.Next = {
                                Text = `You have just completed a sample contract. Please wait {string.format("%02i:%02i", v61 / 60 % 60, v61 % 60)} before taking another.`,
                                Options = { {
                                        Response = "Okay.",
                                        Next = nil
                                    } }
                            };
                        end;
                    end,

                    Next = Dialogue.PLACEHOLDER
                });
            end,

            Options = { {
                    Response = "Nevermind.",
                    Next = nil
                } }
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
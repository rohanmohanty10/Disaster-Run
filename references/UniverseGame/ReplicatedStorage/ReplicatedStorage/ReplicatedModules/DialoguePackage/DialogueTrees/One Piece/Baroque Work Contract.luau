  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");
local u3 = Knit.GetService("TitleService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
require(PathShortcuts.ItemDataModule);

local function GuideToSanji() -- Line: 12
    -- upvalues: LocalPlayer (copy)
    local Sanji = workspace.NPCS.Sanji;
    local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;

    if HumanoidRootPart:FindFirstChild("SanjiWaypoint") then
        return;
    end;

    local u4 = script.SanjiWaypoint:Clone();
    u4.Parent = HumanoidRootPart;
    task.spawn(function() -- Line: 19
        -- upvalues: Sanji (copy), HumanoidRootPart (copy), u4 (copy)
        while true do
            task.wait();
            local Position = Sanji.HumanoidRootPart.Position;
            local Magnitude = (Position - HumanoidRootPart.Position).Magnitude;

            if Magnitude < 50 then
                u4.Transparency = 1 - math.max(0, (Magnitude - 15) / 50);
            end;

            u4.CFrame = CFrame.new(HumanoidRootPart.Position, Position) * CFrame.new(0, 0, -10) * CFrame.Angles(0, 1.5707963267948966, 0);

            if not u4:IsDescendantOf(game) then
                return;
            end;
        end;
    end);
end;

return {
    Title = "Den Den Mushi",

    Start = function() -- Line: 32, Name: GetStart
        -- upvalues: u2 (copy)
        return `step_{u2:GetCurrentStep("Baroque Work Contract"):expect() or 1}`;
    end,

    Nodes = {
        step_1 = {
            Mutable = true,
            Text = "Ahem. Is this the contractor hired by Miss All Sunday?",
            Options = {
                {
                    Response = "...Who are you?",
                    Next = {
                        Text = "I will not repeat myself again.",
                        Options = {
                            {
                                Response = "Uh, yeah. I\'m the contractor. Whats up?",
                                Next = {
                                    Text = "Good... good. Then I assume you know what to do. Get in contact with me once you have got rid of those pesks. You better be quick about it, too.",
                                    Options = {
                                        {
                                            Response = "For sure.",

                                            Callback = function(p5, p6, p7) -- Line: 57, Name: Callback
                                                -- upvalues: u1 (copy)
                                                u1:CheckDialogue("Baroque Work Contract"):expect();
                                                p6.Next = {
                                                    Text = "Just keep in mind... I will not tolerate such disrespect in the future."
                                                };
                                            end,

                                            Next = Dialogue.PLACEHOLDER
                                        }
                                    }
                                }
                            }
                        }
                    }
                },
                {
                    Response = "No thats not me.",
                    Next = {
                        Text = "Get off this line, kid."
                    }
                }
            }
        },
        step_2 = {
            Text = "The other side appears to be silent. You think to yourself that you should complete your assigment first."
        },
        step_3 = {
            Mutable = true,
            Text = "Great job on making a quick work of those fools. Miss All Sunday never misses when it comes to hiring contractors.",
            Options = {
                {
                    Response = "What is the next assignment?",
                    Next = {
                        Text = "Hm... I have some unfinished business with someone who dared to betray me. I am quite the busy man so I cannot make any time to get rid of him myself. I want you to interrogate the fool to make sure.",
                        Options = {
                            {
                                Response = "I will do so.",

                                Callback = function(p8, p9, p10) -- Line: 93, Name: Callback
                                    -- upvalues: u1 (copy)
                                    task.delay(0.1, function() -- Line: 94
                                        -- upvalues: u1 (ref)
                                        u1:CheckDialogue("Baroque Work Contract"):expect();
                                    end);
                                    p9.Next = {
                                        Text = "Show that traitor that no one betrays Baroque Works."
                                    };
                                end,

                                Next = Dialogue.PLACEHOLDER
                            }
                        }
                    }
                }
            }
        },
        step_4 = {
            Mutable = true,
            Text = "You have proven to be insanely useful so far... You will be rewarded greatly if you complete this last assignment.",
            Options = {
                {
                    Response = "What is the next assignment?",
                    Next = {
                        Text = "I have a personal matter that is urgent. There are certain individuals threatening my reign of the Kingdom of Alabasta. They are taunting me through calls and going after my men. I need you to get rid of this anonymous caller who seems to be their leader, named \"Mr Prince\". Your capability will be determined by this objective. I wish you luck. [SPAWN AT THE BOSS ALTAR]",
                        Options = {
                            {
                                Response = "Understood. I will get rid of Mr Prince.",

                                Callback = function(p11, p12, p13) -- Line: 119, Name: Callback
                                    -- upvalues: u1 (copy), u3 (copy), GuideToSanji (copy)
                                    u1:CheckDialogue("Baroque Work Contract"):expect();

                                    if not (u3:GetOwnedTitles():expect() or {}).TITLE_31 then
                                        p12.Next = {
                                            Text = "He shall realize who we are."
                                        };

                                        return;
                                    end;

                                    GuideToSanji();
                                    p12.Next = {
                                        Title = "Mr 0",
                                        Text = "Good job slaying Mr Prince. I no longer have the need for your help, Contractor. [TALK TO SANJI AT THE DESERT\'S APPROACH TO CONTINUE QUESTLINE"
                                    };
                                end,

                                Next = Dialogue.PLACEHOLDER
                            }
                        }
                    }
                }
            }
        },
        step_5 = {
            Text = "The other side appears to be silent. You think to yourself that you should complete your assigment first."
        }
    }
};
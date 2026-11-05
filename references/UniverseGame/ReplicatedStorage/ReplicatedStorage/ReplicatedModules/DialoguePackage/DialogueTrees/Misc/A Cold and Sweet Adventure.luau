  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
local u2 = Knit.GetService("QuestLineService");
Knit.GetService("AbilityService");
local u3 = Knit.GetService("EventCandyService");
local _ = game:GetService("Players").LocalPlayer;

return {
    Title = "Santa Claus",

    Start = function() -- Line: 11, Name: GetStart
        -- upvalues: u2 (copy)
        return `step_{u2:GetCurrentStep("A Cold and Sweet Adventure"):expect() or 1}`;
    end,

    Nodes = {
        step_1 = {
            Mutable = true,
            Text = "Ho-ho-ho! Merry Christmas! Wait.. It isn\'t Christmas anymore.. Right.. My home got taken away from me...",
            Options = {
                {
                    Response = "Oh. That\'s awful to hear.. How can I be of help to you?",
                    Next = {
                        Text = "I don\'t know... I\'m stuck here in this random place here... Well.. to be honest.. I\'ve lost my Christmas Spirit.. My sleigh was wrecked by thugs, A big.. creature took my candy cane sword away.. Wait.. Do you think you can help me?",
                        Options = {
                            {
                                Response = "Uhhh sure, that depends..",

                                Callback = function(p4, p5, p6) -- Line: 31, Name: Callback
                                    -- upvalues: u1 (copy)
                                    u1:CheckDialogue("A Cold and Sweet Adventure"):expect();
                                    p5.Next = {
                                        Text = "Okay, here\'s the deal. If you can get back on those hooligans I crashed landed near at the Port, I\'ll see you fit to fighting this creature."
                                    };
                                end,

                                Next = Dialogue.PLACEHOLDER
                            }
                        }
                    }
                },
                {
                    Response = "I want to exchange my candy",
                    Next = {
                        Text = "Let me see what I can do...",
                        Options = {
                            {
                                Response = "Exchange now",

                                Callback = function(p7, p8, p9) -- Line: 49, Name: Callback
                                    -- upvalues: u3 (copy)
                                    local v10 = u3:ExchangeCandy():expect() or 0;

                                    if v10 > 0 then
                                        p8.Next = {
                                            Text = `I can give you <Color=255,85,255>{v10}uE<Color=/> for your candy.`,
                                            Options = {
                                                {
                                                    Response = "Alright!",

                                                    Callback = function() -- Line: 58, Name: Callback
                                                        -- upvalues: u3 (ref)
                                                        u3:ExchangeCandy(true):expect();
                                                    end,

                                                    Next = {
                                                        Text = "There you go."
                                                    }
                                                },
                                                {
                                                    Response = "Nevermind",
                                                    Next = {
                                                        Text = "Maybe next time!"
                                                    }
                                                }
                                            }
                                        };

                                        return;
                                    end;

                                    p8.Next = {
                                        Text = "You have nothing to exchange."
                                    };
                                end,

                                Next = Dialogue.PLACEHOLDER
                            }
                        }
                    }
                }
            }
        },
        step_2 = {
            Text = "Hey.. Did you take care of those Hooligans like I asked you to?"
        },
        step_3 = {
            Mutable = true,
            Text = "You\'re right.. I\'m feeling a lot more jolly at this moment. We\'re getting there.",
            Options = {
                {
                    Response = "Anything else?",
                    Next = {
                        Text = "I see you fit for this final task. Go and defeat Grimpus. He\'s located at the Ice Fortress. Once you do, return back to me. He should drop an item that you can return to me that I can use to make my sword whole again.",

                        Callback = function() -- Line: 97, Name: Callback
                            -- upvalues: u1 (copy)
                            u1:CheckDialogue("A Cold and Sweet Adventure"):expect();
                        end,

                        Options = { {
                                Response = "How do I get there?",
                                Next = {
                                    Text = "Speak to Bawx. He\'s in the main area under the huge christmas tree."
                                }
                            } }
                    }
                }
            }
        },
        step_4 = {
            Mutable = true,
            Text = "Do you have the fragment of the sword I asked you to go get?",
            Options = {
                {
                    Response = "Yes here it is.",

                    Callback = function(p11, p12, p13) -- Line: 118, Name: Callback
                        -- upvalues: u1 (copy)
                        local v14 = u1:CheckDialogue("A Cold and Sweet Adventure"):expect();

                        if not v14 then
                            p12.Next = {
                                Text = "It doesn\'t seem like you do.. Otherwise it would\'ve already floated out and merged with it. Come back when you really do."
                            };

                            return;
                        end;

                        if v14 == "ClearSpace" then
                            p12.Next = {
                                Text = "(YOU HAVE NO ABILITY INVENTORY SPACE, PLEASE CLEAR A SPACE BEFOREHAND)"
                            };

                            return;
                        end;

                        p12.Next = {
                            Text = "Perfect! It clicked together and good as new. You know what.. You deserve it. Take it and use it with great honor. You\'ve saved Christmas!"
                        };
                    end,

                    Next = Dialogue.PLACEHOLDER
                }
            }
        }
    }
};
  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local Core = require(ReplicatedStorage.ReplicatedRoot:WaitForChild("Core"));
local ItemData = require(ReplicatedStorage.ReplicatedModules.ItemData);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = Knit.GetService("DialogueService");
Knit.GetService("QuestLineService");
Knit.GetService("InventoryService");
local u2 = Core.GetClientService("LabService");

local function GetItemRichText(p3) -- Line: 15
    -- upvalues: ItemData (copy)
    local v4 = ItemData.GetItemInfo(p3);

    if not v4 then
        return "";
    end;

    local v5 = ItemData.Rarities[v4.Rarity];
    local v6 = v4.Name or "";

    if v5 then
        v6 = `<Color=#{v5.Color:ToHex()}>{v6}<Color=/>`;
    end;

    return v6;
end;

return {
    Title = "Guardian",

    Start = function() -- Line: 29, Name: Start
        -- upvalues: u2 (copy)
        return u2:HasTalkedToLabNPC("Enforcer"):expect() and "start" or "first_time";
    end,

    Nodes = {
        first_time = {
            Text = "Hey! What are you doing here?",
            Options = {
                {
                    Response = "Why? Who are you?",
                    Next = {
                        Text = "This area is off limits.",
                        Options = {
                            {
                                Response = "Why are you here?",
                                Next = {
                                    Text = "I just guard this place. Really though, you shouldn\'t be here.",
                                    Options = {
                                        {
                                            Response = "What is this place?",
                                            Next = {
                                                Mutable = true,
                                                Text = "That shouldn\'t concern you. Now, get going.",

                                                Transformer = function(p7, p8) -- Line: 60, Name: Transformer
                                                    -- upvalues: u1 (copy), ItemData (copy)
                                                    local v9 = u1:CheckRequirement("ItemCountCheck", "ITEM_908"):expect();
                                                    local v10;

                                                    if v9 then
                                                        v10 = v9 >= 1;
                                                    else
                                                        v10 = false;
                                                    end;

                                                    if v10 then
                                                        table.insert(p8.Options, 1, {
                                                            Response = "<i>(Show Camellite Fragment)</i> This of any interest to you?",
                                                            Next = "fragment"
                                                        });

                                                        return;
                                                    end;

                                                    local Text = p8.Text;
                                                    local v11 = ItemData.GetItemInfo("ITEM_908");
                                                    local v12;

                                                    if v11 then
                                                        local v13 = ItemData.Rarities[v11.Rarity];
                                                        v12 = v11.Name or "";

                                                        if v13 then
                                                            v12 = `<Color=#{v13.Color:ToHex()}>{v12}<Color=/>`;
                                                        end;
                                                    else
                                                        v12 = "";
                                                    end;

                                                    p8.Text = Text .. ` <TextTransparency=0.5>(HAVE {v12} IN INVENTORY)<TextTransparency=/>`;
                                                end,

                                                Options = { {
                                                        Response = "Fine.",
                                                        Next = nil
                                                    } }
                                            }
                                        }
                                    }
                                }
                            },
                            {
                                Response = "Okay, I\'m going.",
                                Next = nil
                            }
                        }
                    }
                },
                {
                    Response = "Uh, just walking by.",
                    Next = {
                        Text = "And stay away."
                    }
                }
            }
        },
        fragment = {
            Text = "Interesting... perhaps you may be useful after all. Alright. One moment.",
            Options = {
                {
                    Response = "...",
                    Next = {
                        Mutable = true,
                        Text = "Take this. Don\'t ask me anything else. You\'ll find answers inside.",
                        Options = {
                            {
                                Response = "Thanks, I guess?",
                                Next = nil,

                                Callback = function(p14, p15) -- Line: 111, Name: Callback
                                    -- upvalues: u2 (copy)
                                    if u2:GrantKeycard():expect() == "NoSpace" then
                                        p15.Next = {
                                            Text = "Can\'t store the keycard? Come back to me when you have some space.",
                                            Options = { {
                                                    Response = "Okay.",
                                                    Next = nil
                                                } }
                                        };
                                    end;

                                    u2:SetTalkedToLabNPC("Enforcer");
                                end
                            }
                        }
                    }
                }
            }
        },
        start = {
            Mutable = true,
            Text = "What do you want?",
            Options = {
                {
                    Response = "I lost my keycard.",

                    Callback = function(p16, p17) -- Line: 143, Name: Callback
                        -- upvalues: u2 (copy)
                        local v18 = u2:GrantKeycard():expect();
                        print(v18);

                        if v18 == "NoSpace" then
                            p17.Next = {
                                Text = "Can\'t store the keycard? Come back to me when you have some space.",
                                Options = { {
                                        Response = "Okay.",
                                        Next = nil
                                    } }
                            };

                            return;
                        end;

                        if v18 == "GotAlready" then
                            p17.Next = {
                                Text = "Don\'t lie to me.",
                                Options = { {
                                        Response = "Sorry.",
                                        Next = nil
                                    } }
                            };

                            return;
                        end;

                        if not v18 then
                            p17.Next = {
                                Text = "Try again later.",
                                Options = { {
                                        Response = "Okay.",
                                        Next = nil
                                    } }
                            };
                        end;
                    end,

                    Next = Dialogue.PLACEHOLDER
                },
                {
                    Response = "Nothing.",
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
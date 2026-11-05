  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local Core = require(ReplicatedStorage.ReplicatedRoot:WaitForChild("Core"));
local ItemData = require(ReplicatedStorage.ReplicatedModules.ItemData);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local u1 = Core.GetClientService("LabService");
Core.GetLegacyService("QuestLineService");
local u2 = Core.GetLegacyService("DialogueService");

local function GetItemRichText(p3) -- Line: 11
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

local function GetItemText(p7) -- Line: 23
    -- upvalues: ItemData (copy)
    local v8 = ItemData.GetItemInfo(p7);

    if not v8 then
        return "";
    end;

    local v9 = ItemData.Rarities[v8.Rarity];
    local v10 = v8.Name or "";

    if v9 then
        v10 = `<font color="#{v9.Color:ToHex()}">{v10}</font>`;
    end;

    return v10;
end;

local function ColorRichText(p11, p12) -- Line: 36
    return `<Color=#{p12:ToHex()}>{p11}<Color=/>`;
end;

local v14 = {
    Title = "Refining Overseer",

    Start = function() -- Line: 41, Name: Start
        -- upvalues: u1 (copy)
        local v13 = u1:HasTalkedToLabNPC("Overseer_B"):expect();

        return u1:GetClearance():expect() < 3 and "invalid" or (v13 and "start" or "first_time");
    end
};
local v22 = {
    first_time = {
        Text = "You’re cleared for this sector? Quite quick for a newcomer.",
        Options = {
            {
                Response = "I was told this is where special crafting is handled.",
                Next = {
                    Text = "That\'s right. This sector handles refinement - transforming unstable compounds into more functional assets, as well as creating specialized tools. But access here depends on what\'s been unlocked through analytics.",
                    Options = {
                        {
                            Response = "So I need to do research first?",
                            Next = {
                                Text = "Recipes become available only when verified data from Analytics supports stable synthesis.",
                                Options = {
                                    {
                                        Response = "What can I make here?",
                                        Next = {
                                            Text = "That depends on what you\'ve uncovered. Boosts, prototype gear, enhanced materials - everything here is precision-engineered from verified material blueprints.",
                                            Options = {
                                                {
                                                    Response = "Sounds useful.",
                                                    Next = {
                                                        Text = "Efficiency is everything. When you\'ve completed some research, just let me know and we\'ll see what can be arranged. By the way, if you ever happen to stumble upon Geodes, I can open them for some useful things.",
                                                        Options = {
                                                            {
                                                                Response = "Got it.",
                                                                Next = nil,

                                                                Callback = function(p15, p16) -- Line: 84, Name: Callback
                                                                    -- upvalues: u1 (copy), ReplicatedStorage (copy)
                                                                    u1:SetTalkedToLabNPC("Overseer_B");
                                                                    ReplicatedStorage.Remotes.ClientUIOutput:Fire("ShowInformationPrompt", "Refining");
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
        Text = "Hey.",
        Options = {
            {
                Response = "I want to access the refinery.",
                Next = Dialogue.PLACEHOLDER,

                Callback = function(p17, p18) -- Line: 116, Name: Callback
                    -- upvalues: ReplicatedStorage (copy)
                    ReplicatedStorage.Remotes.ClientUIOutput:Fire("ShowLabRefining");
                end
            },
            {
                Response = "I have geodes to exchange.",
                Next = Dialogue.PLACEHOLDER,

                Callback = function(p19, p20) -- Line: 123, Name: Callback
                    -- upvalues: u2 (copy)
                    local v21 = u2:CheckRequirement("ItemCountCheck", "ITEM_914"):expect();

                    if v21 and v21 > 0 then
                        p20.Next = "geodes";

                        return;
                    end;

                    p20.Next = {
                        Text = "Doesn\'t seem like you have any at the moment. You\'ll find them on the Fractured Island. Come to me if you wish to exchange geodes for some materials."
                    };
                end
            },
            {
                Response = "I want to see the information about this place again.",

                Callback = function() -- Line: 136, Name: Callback
                    -- upvalues: ReplicatedStorage (copy)
                    ReplicatedStorage.Remotes.ClientUIOutput:Fire("ShowInformationPrompt", "Refining");
                end,

                Next = Dialogue.PLACEHOLDER
            },
            {
                Response = "Nevermind.",
                Next = nil
            }
        }
    }
};
local v23 = {
    Text = `In exchange for a geode you will receive 2-3 random {`<Color=#{Color3.fromRGB(255, 150, 75):ToHex()}>Legendary<Color=/>`} <TextTransparency=0.5>(Chest Pool)<TextTransparency=/> items.`
};
local v24 = {};
local v25 = {};
local v26 = ItemData.GetItemInfo("ITEM_914");
local v27;

if v26 then
    local v28 = ItemData.Rarities[v26.Rarity];
    v27 = v26.Name or "";

    if v28 then
        v27 = `<font color="#{v28.Color:ToHex()}">{v27}</font>`;
    end;
else
    v27 = "";
end;

v25.Response = `<i>Exchange <b>{v27}</b></i>`;

function v25.Callback() -- Line: 153
    -- upvalues: u2 (copy)
    local v29 = u2:CheckRequirement("ExchangeGeode"):expect();
    print(v29);
end;

v25.Next = Dialogue.PLACEHOLDER;
v24[1] = v25;
v23.Options = v24;
v22.geodes = v23;
v22.invalid = {
    Text = "...",
    Options = { {
            Response = "...",
            Next = nil
        } }
};
v14.Nodes = v22;

return v14;
  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Dialogue = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local Core = require(ReplicatedStorage.ReplicatedRoot:WaitForChild("Core"));
local ItemData = require(ReplicatedStorage.ReplicatedModules.ItemData);
local u1 = Core.GetClientService("LabService");
local u2 = Core.GetLegacyService("DialogueService");
local u3 = Core.GetLegacyService("QuestLineService");

local function GetItemRichText(p4, p5) -- Line: 10
    -- upvalues: ItemData (copy)
    local v6 = ItemData.GetItemInfo(p4);

    if not v6 then
        return "";
    end;

    local v7 = ItemData.Rarities[v6.Rarity];
    local v8 = v6.Name or "";

    if v7 then
        v8 = `<Color=#{v7.Color:ToHex()}>{p5 and p5 .. " " or " "}{v8}<Color=/>`;
    end;

    return v8;
end;

local function GetItemText(p9) -- Line: 23
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

function GetColorRichText(p13, p14)
    return `<Color=#{p13:ToHex()}>{p14}<Color=/>`;
end;

local v16 = {
    Title = "Gateway Overseer",

    Start = function() -- Line: 44, Name: Start
        -- upvalues: u1 (copy)
        local v15 = u1:HasTalkedToLabNPC("Overseer_C"):expect();

        return u1:GetClearance():expect() < 4 and "invalid" or (v15 and "start" or "first_time");
    end
};
local v17 = {
    first_time = {
        Text = "I see you have been hard at work. Now that you have access to this sector, you are ready to go on expeditions to the Fractured Island.",
        Options = { {
                Response = "I assume the big machine is what gets me there?",
                Next = "first_time_2"
            }, {
                Response = "Got to go.",
                Next = nil
            } }
    }
};
local v18 = {
    Text = "Yes. The machine will create an access point that will directly transport you."
};
local v19 = {};
local v20 = {
    Response = "So, what do I do when I get there?"
};
local v21 = {
    Text = "Find samples, gather any information that may be useful to us. Just don\'t die."
};
local v22 = {};
local v23 = {
    Response = "Anything else I need to know?"
};
local v24 = {
    Text = "Yes. To activate the gateway, you must provide the required resources first. You can acquire these from Refining. When the bridge is activating, it\'s in your best interest to leave the chamber, unless you want to be hit by the energy pulse released by tearing through the very space that surrounds us."
};
local v25 = {};
local v26 = {
    Response = "Alright."
};
local v27 = {
    Text = "Another thing I should mention. There\'s a fairly strong level of background radiation on the Fractured Island. Strong enough to prove lethal over a certain period of time. You\'re outfitted with a tethering device that uses this radiation to charge itself, allowing you to return safely in time."
};
local v28 = {};
local v29 = {
    Response = "Well, that\'s good to know."
};
local v30 = {};
local v31 = ItemData.GetItemInfo("ITEM_913");
local v32;

if v31 then
    local v33 = ItemData.Rarities[v31.Rarity];
    v32 = v31.Name or "";

    if v33 then
        v32 = `<Color=#{v33.Color:ToHex()}> {v32}<Color=/>`;
    end;
else
    v32 = "";
end;

v30.Text = `Now then, I will leave you to prepare for your upcoming expeditions. You can return to me shall you have any questions or happen to run into anomalies. I will grant you access to the process required to make the necessary component for wormhole calibration: {v32}.`;
v30.Options = {
    {
        Response = "Thanks.",
        Next = nil,

        Callback = function(p34, p35) -- Line: 102, Name: Callback
            -- upvalues: u1 (copy), u2 (copy), ReplicatedStorage (copy)
            u1:SetTalkedToLabNPC("Overseer_C");
            local v36, v37 = u2:CheckRequirement("DialogueResearchUnlock", "CamelliteChannelling"):expect();
            print(v36, v37);
            ReplicatedStorage.Remotes.ClientUIOutput:Fire("ShowInformationPrompt", "Gateway");
        end
    }
};
v29.Next = v30;
v28[1] = v29;
v27.Options = v28;
v26.Next = v27;
v25[1] = v26;
v24.Options = v25;
v23.Next = v24;
v22[1] = v23;
v21.Options = v22;
v20.Next = v21;
v19[1], v19[2] = v20, {
    Response = "How does this work exactly?",
    Next = "explain",

    Callback = function(p38, p39) -- Line: 125, Name: Callback
        local v40 = p38:GetMetadata();
        local v41 = p38:GetCurrentNode();

        if not v40.OriginNode then
            v40.OriginNode = v41;
        end;
    end
};
v18.Options = v19;
v17.first_time_2 = v18;
v17.explain = {
    Text = "I was sure you would ask that. As you may have been told, the Fractured Island is surrounded by some kind of barrier, preventing any physical access. We aren\'t sure how it works, but we figured out a way to bypass it.",
    Options = {
        {
            Response = "How?",
            Next = {
                Mutable = true,
                Text = "The barrier, while indestructible, only affects the three spatial dimensions we\'re normally confined to. We can bypass it by bridging through a higher dimension. This material, Camellite, resonates a very specific energy signature - specific enough to pinpoint it in space. We use it to create a wormhole that <TextTransparency=0.5>(in 99% of cases)<TextTransparency=/> reaches through the barrier.",
                Options = {
                    {
                        Response = "I understand.",

                        Callback = function(p42, p43) -- Line: 148, Name: Callback
                            local v44 = p42:GetMetadata();

                            if v44.OriginNode then
                                p43.Next = v44.OriginNode;
                                v44.OriginNode = nil;
                            end;
                        end,

                        Next = Dialogue.PLACEHOLDER
                    },
                    {
                        Response = "I don\'t understand.",
                        Next = {
                            Text = "Imagine an entity on a drawing: if there\'s a wall drawn around it, there would be no way for it to escape. For you however, there exists an additional dimension, allowing you to simply jump over the drawn wall.",
                            Options = {
                                {
                                    Response = "I get it now.",

                                    Callback = function(p45, p46) -- Line: 164, Name: Callback
                                        local v47 = p45:GetMetadata();

                                        if v47.OriginNode then
                                            p46.Next = v47.OriginNode;
                                            v47.OriginNode = nil;
                                        end;
                                    end,

                                    Next = Dialogue.PLACEHOLDER
                                }
                            }
                        }
                    }
                }
            }
        }
    }
};
v17.start = {
    Mutable = true,
    Text = "What\'s up?",

    Transformer = function(p48, p49) -- Line: 184, Name: Transformer
        -- upvalues: u3 (copy)
        local v50 = { "The generator is standing by.", "You\'re cleared to speak. What is it?", "Are you planning on doing an expedition?" };
        p49.Text = v50[math.random(1, #v50)];

        if u3:GetCurrentStep("Space Crucible"):expect() == 2 then
            table.insert(p49.Options, 1, {
                Response = "I experienced something strange.",
                Next = "anomaly"
            });
        end;
    end,

    Options = {
        {
            Response = "I want to activate the Gateway.",
            Next = "request_generator"
        },
        {
            Response = "How does this machine work exactly?",
            Next = "explain",

            Callback = function(p51, p52) -- Line: 210, Name: Callback
                local v53 = p51:GetMetadata();

                if not v53.OriginNode then
                    v53.OriginNode = "start";
                end;
            end
        },
        {
            Response = "I want to see the information about this place again.",

            Callback = function() -- Line: 220, Name: Callback
                -- upvalues: ReplicatedStorage (copy)
                ReplicatedStorage.Remotes.ClientUIOutput:Fire("ShowInformationPrompt", "Gateway");
            end,

            Next = Dialogue.PLACEHOLDER
        },
        {
            Response = "Nevermind.",
            Next = nil
        }
    }
};
v17.anomaly = {
    Text = "Something strange, you say? Be more specific.",
    Options = {
        {
            Response = "<i>Explain the anomaly</i>",
            Next = {
                Text = "..Symbols? A shrine? I see. We were able to see structures when we launched our surveillance attempts, but our equipment could not handle the interference. It seems one of those structures happens to be that shrine you\'re speaking of, though.\nConsidering you interacted with the anomaly, I would recommend you go over to Analytics and run a cognitive scan. Try to investigate this further.",
                Options = {
                    {
                        Response = "Okay, I\'ll do that.",

                        Callback = function() -- Line: 242, Name: Callback
                            -- upvalues: u3 (copy), u2 (copy)
                            if u3:GetCurrentStep("Space Crucible"):expect() == 2 then
                                u2:CheckDialogue("Space Crucible"):expect();
                            end;
                        end
                    }
                }
            }
        }
    }
};
local v54 = {
    Mutable = true
};
local v55 = ItemData.GetItemInfo("ITEM_913");
local v56;

if v55 then
    local v57 = ItemData.Rarities[v55.Rarity];
    v56 = v55.Name or "";

    if v57 then
        v56 = `<Color=#{v57.Color:ToHex()}>{1 .. " " or " "}{v56}<Color=/>`;
    end;
else
    v56 = "";
end;

local v58 = ItemData.GetItemInfo("ITEM_909");
local v59;

if v58 then
    local v60 = ItemData.Rarities[v58.Rarity];
    v59 = v58.Name or "";

    if v60 then
        v59 = `<Color=#{v60.Color:ToHex()}>{1 .. " " or " "}{v59}<Color=/>`;
    end;
else
    v59 = "";
end;

v54.Text = `Sure. I'll need you to give me either {v56} OR {v59} for calibration. There's also a price of {GetColorRichText(Color3.fromRGB(255, 205, 88), "150K UCoins")} to cover energy expenses.`;

function v54.Transformer(p61, p62) -- Line: 259
    -- upvalues: ItemData (copy), u2 (copy), u1 (copy), Dialogue (copy)
    local v63 = {};
    local v64 = {};
    local v65 = ItemData.GetItemInfo("ITEM_913");
    local v66;

    if v65 then
        local v67 = ItemData.Rarities[v65.Rarity];
        v66 = v65.Name or "";

        if v67 then
            v66 = `<font color="#{v67.Color:ToHex()}">{v66}</font>`;
        end;
    else
        v66 = "";
    end;

    v64.Response = `I'll use <b>1 {v66}</b>.`;
    v64.ItemRequirement = {
        ITEM_913 = 1
    };
    v63.Manifold = v64;
    local v68 = {};
    local v69 = ItemData.GetItemInfo("ITEM_909");
    local v70;

    if v69 then
        local v71 = ItemData.Rarities[v69.Rarity];
        v70 = v69.Name or "";

        if v71 then
            v70 = `<font color="#{v71.Color:ToHex()}">{v70}</font>`;
        end;
    else
        v70 = "";
    end;

    v68.Response = `I'll use <b>1 {v70}</b>.`;
    v68.ItemRequirement = {
        ITEM_909 = 1
    };
    v63.Camellite = v68;

    for i, v in v63 do
        local v72 = true;

        for i2, v2 in v.ItemRequirement or {} do
            local v73 = u2:CheckRequirement("ItemCountCheck", i2):expect();

            if not v73 or v73 < v2 then
                v72 = false;
            end;
        end;

        if v72 then
            table.insert(p62.Options, 1, {
                Response = v.Response,

                Callback = function(p74, p75) -- Line: 289, Name: Callback
                    -- upvalues: u1 (ref), i (copy)
                    local v76 = u1:RequestWormhole(i):expect();

                    if typeof(v76) == "string" then
                        p75.Next = `request_fail_{v76}`;

                        return;
                    end;

                    if v76 == false then
                        p75.Next = "request_fail";

                        return;
                    end;

                    if v76 == true then
                        p75.Next = "request_success";
                    end;
                end,

                Next = Dialogue.PLACEHOLDER
            });
        end;
    end;
end;

v54.Options = { {
        Response = "Nevermind.",
        Next = nil
    } };
v17.request_generator = v54;
v17.request_success = {
    Text = "Very well. The Gateway will activate shortly. Good luck.",
    Options = { {
            Response = "Thanks.",
            Next = nil
        } }
};
v17.request_fail = {
    Text = "I can\'t help you right now, try again shortly.",
    Options = { {
            Response = "Okay.",
            Next = nil
        } }
};
v17.request_fail_Money = {
    Text = `You don't have enough {GetColorRichText(Color3.fromRGB(255, 205, 88), "UCoins")} at the moment. Come back when you have at least {GetColorRichText(Color3.fromRGB(255, 205, 88), "150K UCoins")}.`,
    Options = { {
            Response = "Okay.",
            Next = nil
        } }
};
v17.request_fail_TooLow = {
    Text = "Without the necessary resources, I cannot help you. Make sure you have them in your Inventory.",
    Options = { {
            Response = "Okay.",
            Next = nil
        } }
};
v17.request_fail_RankLow = {
    Text = "You shouldn\'t be here.",
    Options = { {
            Response = "...",
            Next = nil
        } }
};
v17.request_fail_Active = {
    Text = "The Gateway is currently activated. You can try to catch the wormhole or wait and ask me again.",
    Options = { {
            Response = "Okay.",
            Next = nil
        } }
};
v17.invalid = {
    Text = "You shouldn\'t be here.",
    Options = { {
            Response = "...",
            Next = nil
        } }
};
v16.Nodes = v17;

return v16;
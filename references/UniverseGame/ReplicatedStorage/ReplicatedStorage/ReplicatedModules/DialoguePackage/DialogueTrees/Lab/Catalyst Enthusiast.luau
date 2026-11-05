  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.Dialogue);
local u1 = require(ReplicatedStorage.ReplicatedRoot:WaitForChild("Core")).GetClientService("LabService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local u2 = require(PathShortcuts.KnitPath.Knit).GetService("DialogueService");
local ItemData = require(ReplicatedStorage.ReplicatedModules.ItemData);
local Name = script.Name;

local function GetItemText(p3) -- Line: 15
    -- upvalues: ItemData (copy)
    local v4 = ItemData.GetItemInfo(p3);

    if not v4 then
        return "";
    end;

    local v5 = ItemData.Rarities[v4.Rarity];
    local v6 = v4.Name or "";

    if v5 then
        v6 = `<font color="#{v5.Color:ToHex()}">{v6}</font>`;
    end;

    return v6;
end;

local function GetItemRichText(p7, p8) -- Line: 28
    -- upvalues: ItemData (copy)
    local v9 = ItemData.GetItemInfo(p7);

    if not v9 then
        return "";
    end;

    local v10 = ItemData.Rarities[v9.Rarity];
    local v11 = v9.Name or "";

    if v10 then
        v11 = `<Color=#{v10.Color:ToHex()}>{p8 and p8 .. " " or " "}{v11}<Color=/>`;
    end;

    return v11;
end;

local v14 = {
    Start = function() -- Line: 42, Name: Start
        -- upvalues: u2 (copy)
        local v12 = u2:CheckRequirement("ItemCountCheck", "ITEM_912"):expect();
        local v13;

        if typeof(v12) == "number" then
            v13 = v12 > 0;
        else
            v13 = false;
        end;

        return v13 and "HasCatalystStart" or "NoCatalystStart";
    end,

    Title = Name
};
local v15 = {};
local v16 = {
    Mutable = true,
    Title = Name
};
local v17 = ItemData.GetItemInfo("ITEM_912");
local v18;

if v17 then
    local v19 = ItemData.Rarities[v17.Rarity];
    v18 = v17.Name or "";

    if v19 then
        v18 = `<Color=#{v19.Color:ToHex()}> {v18}<Color=/>`;
    end;
else
    v18 = "";
end;

v16.Text = `Excellent! You have a {v18}. This will allow you to disrupt the wormhole generator and allow you to explore the unexplored area of space. Would you like to know more about how it works?`;
v16.Options = { {
        Response = "How does it disrupt the wormhole generator?",
        Next = "DisruptionExplanation"
    }, {
        Response = "How did you know I could make one?",
        Next = "ResearchBackground"
    }, {
        Response = "I understand how it works.",
        Next = nil
    } };
v15.HasCatalystStart = v16;
local v20 = {
    Title = Name
};
local v21 = ItemData.GetItemInfo("ITEM_912");
local v22;

if v21 then
    local v23 = ItemData.Rarities[v21.Rarity];
    v22 = v21.Name or "";

    if v23 then
        v22 = `<Color=#{v23.Color:ToHex()}> {v22}<Color=/>`;
    end;
else
    v22 = "";
end;

v20.Text = `The {v22} interferes with the wormhole generator's stabilization field. When introduced to the system, it creates controlled instability that redirects the wormhole to previously unreachable coordinates.`;
v20.Options = { {
        Response = "Ask something else.",
        Next = "HasCatalystStart"
    } };
v15.DisruptionExplanation = v20;
local v24 = {
    Title = Name
};
local v25 = ItemData.GetItemInfo("ITEM_912");
local v26;

if v25 then
    local v27 = ItemData.Rarities[v25.Rarity];
    v26 = v25.Name or "";

    if v27 then
        v26 = `<Color=#{v27.Color:ToHex()}> {v26}<Color=/>`;
    end;
else
    v26 = "";
end;

v24.Text = `I can see from your research data that you've unlocked Advanced Materials and Mining Laser research. Only those who've progressed this far can synthesize the {v26}.`;
v24.Options = { {
        Response = "Ask something else.",
        Next = "HasCatalystStart"
    } };
v15.ResearchBackground = v24;
local v28 = {
    Title = Name
};
local v29 = ItemData.GetItemInfo("ITEM_912");
local v30;

if v29 then
    local v31 = ItemData.Rarities[v29.Rarity];
    v30 = v29.Name or "";

    if v31 then
        v30 = `<Color=#{v31.Color:ToHex()}> {v30}<Color=/>`;
    end;
else
    v30 = "";
end;

v28.Text = `Greetings! I'm researching objects that cause distruptions for wormhole. I notice you don't have a {v30} yet. If my theory is correct this item should help you cause a distruption in wormhole generator.`;
v28.Options = { {
        Response = "How do I make this catalyst?",
        Next = "CraftingInstructions"
    }, {
        Response = "What research do I need?",
        Next = "ResearchRequirements"
    }, {
        Response = "Not interested right now.",
        Next = nil
    } };
v15.NoCatalystStart = v28;
local v48 = {
    Mutable = true,
    Title = Name,

    Transformer = function(p32, p33) -- Line: 116, Name: Transformer
        -- upvalues: u1 (copy), ItemData (copy)
        local v34 = u1:GetUnlockedResearch():expect();
        local v35;

        if v34 then
            v35 = v34.Mats1;
        else
            v35 = v34;
        end;

        if v34 then
            v34 = v34.Drill1;
        end;

        if not (v35 and v34) then
            local v36 = ItemData.GetItemInfo("ITEM_912");
            local v37;

            if v36 then
                local v38 = ItemData.Rarities[v36.Rarity];
                v37 = v36.Name or "";

                if v38 then
                    v37 = `<Color=#{v38.Color:ToHex()}> {v37}<Color=/>`;
                end;
            else
                v37 = "";
            end;

            p33.Text = `You need to unlock Advanced Materials and Mining Laser research before you can refine a {v37}. Come back once you've unlocked these researchs.`;
            p33.Options = { {
                    Response = "I\'ll work on unlocking those.",
                    Next = nil
                } };

            return p33;
        end;

        local v39 = ItemData.GetItemInfo("ITEM_912");
        local v40;

        if v39 then
            local v41 = ItemData.Rarities[v39.Rarity];
            v40 = v39.Name or "";

            if v41 then
                v40 = `<Color=#{v41.Color:ToHex()}> {v40}<Color=/>`;
            end;
        else
            v40 = "";
        end;

        local v42 = ItemData.GetItemInfo("ITEM_20");
        local v43;

        if v42 then
            local v44 = ItemData.Rarities[v42.Rarity];
            v43 = v42.Name or "";

            if v44 then
                v43 = `<Color=#{v44.Color:ToHex()}> {v43}<Color=/>`;
            end;
        else
            v43 = "";
        end;

        local v45 = ItemData.GetItemInfo("ITEM_910");
        local v46;

        if v45 then
            local v47 = ItemData.Rarities[v45.Rarity];
            v46 = v45.Name or "";

            if v47 then
                v46 = `<Color=#{v47.Color:ToHex()}> {v46}<Color=/>`;
            end;
        else
            v46 = "";
        end;

        p33.Text = `To craft a {v40}, you'll need to refine {v43} and {v46} together. The refining process combines their properties to create the catalyst.`;
        p33.Options = { {
                Response = "Got it, I\'ll gather those materials.",
                Next = "NoCatalystStart"
            } };

        return p33;
    end
};
local v49 = ItemData.GetItemInfo("ITEM_912");
local v50;

if v49 then
    local v51 = ItemData.Rarities[v49.Rarity];
    v50 = v49.Name or "";

    if v51 then
        v50 = `<Color=#{v51.Color:ToHex()}> {v50}<Color=/>`;
    end;
else
    v50 = "";
end;

local v52 = ItemData.GetItemInfo("ITEM_20");
local v53;

if v52 then
    local v54 = ItemData.Rarities[v52.Rarity];
    v53 = v52.Name or "";

    if v54 then
        v53 = `<Color=#{v54.Color:ToHex()}> {v53}<Color=/>`;
    end;
else
    v53 = "";
end;

local v55 = ItemData.GetItemInfo("ITEM_910");
local v56;

if v55 then
    local v57 = ItemData.Rarities[v55.Rarity];
    v56 = v55.Name or "";

    if v57 then
        v56 = `<Color=#{v57.Color:ToHex()}> {v56}<Color=/>`;
    end;
else
    v56 = "";
end;

v48.Text = `To craft a {v50}, you'll need to refine {v53} and {v56} together. The refining process combines their properties to create the catalyst.`;
v48.Options = { {
        Response = "What research do I need first?",
        Next = "ResearchRequirements"
    } };
v15.CraftingInstructions = v48;
local v58 = {
    Title = Name
};
local v59 = ItemData.GetItemInfo("ITEM_912");
local v60;

if v59 then
    local v61 = ItemData.Rarities[v59.Rarity];
    v60 = v59.Name or "";

    if v61 then
        v60 = `<Color=#{v61.Color:ToHex()}> {v60}<Color=/>`;
    end;
else
    v60 = "";
end;

v58.Text = `You'll need to unlock both the Advanced Materials research and the Mining Laser research before you can refine a {v60}. These researchs are essential for the synthesis process.`;
v58.Options = { {
        Response = "I see. I\'ll work on that research.",
        Next = nil
    } };
v15.ResearchRequirements = v58;
v14.Nodes = v15;

return v14;
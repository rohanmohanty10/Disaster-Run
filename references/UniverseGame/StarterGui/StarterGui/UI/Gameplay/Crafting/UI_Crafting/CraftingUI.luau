  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
local ItemData = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").ItemData);
local u1 = Knit.GetService("InventoryService");
require(PathShortcuts.ReplicatedModules.Classes.Stack);
require(PathShortcuts.KnitPath.Promise);
local u2 = Knit.GetService("CraftingService");
require(PathShortcuts.ReplicatedModules.Stands);
require(PathShortcuts.ReplicatedStorage.ReplicatedModules.PVEPackage.RosterInfo);
require(ReplicatedStorage.ReplicatedModules.AbilityNameToId);
local u3 = ItemData.GetCraftingRecipes();
ItemData.GetAbilityRecipes();
local LocalPlayer = Players.LocalPlayer;
local u4 = {
    UCoins = {
        Name = "UCoins",
        String = "<font color=\"#ffff00\">UCoins</font>",
        Color = "#ffff00"
    },
    UShards = {
        Name = "Currency",
        String = "<font color=\"#00aaff\"><s>u</s>S</font>"
    }
};
local u5 = {
    NoSpace = { "Crafting Failed", "Not enough inventory space for recipe output" },
    NoItem = { "Crafting Failed", "Insufficient crafting materials / materials not equipped in tool bar" },
    NoShard = { "Crafting Failed", "Insufficient ability shards" }
};
local u6 = {};
u6.__index = u6;

local function RNG(p7, p8) -- Line: 48
    return Random.new():NextNumber(p7, p8);
end;

function u6.new(p9, p10) -- Line: 52
    -- upvalues: u6 (copy), Trove (copy), u3 (copy), u1 (copy)
    local u11 = setmetatable({}, u6);
    u11.UI = p9;
    u11.UIEngine = p10;
    u11.Trove = Trove.new();
    u11.Assets = p9.Assets;
    u11.Cache = {
        Entries = {}
    };
    u11.Entry = u11.Assets.Entry;
    u11.RecipeEntry = u11.Assets.Recipe;
    u11.Recipes = p9.Recipes;
    u11.Search = p9.SearchBar;
    u11.Close = p9.Close;
    u11.SearchBar = u11.Search.Search;
    u11.Trove:Connect(u11.Close.MouseButton1Click, function() -- Line: 72
        -- upvalues: u11 (copy)
        u11.UI.Visible = false;
    end);
    u11.Trove:Connect(u11.SearchBar:GetPropertyChangedSignal("Text"), function() -- Line: 75
        -- upvalues: u11 (copy)
        u11:Filter();
    end);
    local u12 = 0;
    local u13 = false;

    local function RequestViewingUpdate(u14, u15) -- Line: 85
        -- upvalues: u12 (ref), u13 (ref), RequestViewingUpdate (copy), u3 (ref), u11 (copy)
        local u16 = (u12 or 0) + 1;
        u12 = u16;

        if u13 then
            return;
        end;

        u13 = true;
        task.delay(0.05, function() -- Line: 94
            -- upvalues: u13 (ref), u16 (copy), u12 (ref), RequestViewingUpdate (ref), u14 (copy), u15 (copy), u3 (ref), u11 (ref)
            u13 = false;

            if u16 ~= u12 then
                RequestViewingUpdate(u14);

                return;
            end;

            if u15 then
                for i, v in u3 do
                    for i2, v2 in v.Input do
                        if i2 == "Items" and v2[u15._ItemId] then
                            print(v);
                            u11:AddEntry(i);
                        end;
                    end;
                end;
            end;

            u11:AddEntries();
        end);
    end;

    u11.Trove:Connect(u1.ItemAdded, function(u17, u18) -- Line: 120
        -- upvalues: u12 (ref), u13 (ref), RequestViewingUpdate (copy), u3 (ref), u11 (copy)
        local u19 = (u12 or 0) + 1;
        u12 = u19;

        if u13 then
            return;
        end;

        u13 = true;
        task.delay(0.05, function() -- Line: 94
            -- upvalues: u13 (ref), u19 (copy), u12 (ref), RequestViewingUpdate (ref), u18 (copy), u17 (copy), u3 (ref), u11 (ref)
            u13 = false;

            if u19 ~= u12 then
                RequestViewingUpdate(u18);

                return;
            end;

            if u17 then
                for i, v in u3 do
                    for i2, v2 in v.Input do
                        if i2 == "Items" and v2[u17._ItemId] then
                            print(v);
                            u11:AddEntry(i);
                        end;
                    end;
                end;
            end;

            u11:AddEntries();
        end);
    end);
    u11.Trove:Connect(u1.ItemUpdated, function(u20, u21) -- Line: 124
        -- upvalues: u12 (ref), u13 (ref), RequestViewingUpdate (copy), u3 (ref), u11 (copy)
        local u22 = (u12 or 0) + 1;
        u12 = u22;

        if u13 then
            return;
        end;

        u13 = true;
        task.delay(0.05, function() -- Line: 94
            -- upvalues: u13 (ref), u22 (copy), u12 (ref), RequestViewingUpdate (ref), u21 (copy), u20 (copy), u3 (ref), u11 (ref)
            u13 = false;

            if u22 ~= u12 then
                RequestViewingUpdate(u21);

                return;
            end;

            if u20 then
                for i, v in u3 do
                    for i2, v2 in v.Input do
                        if i2 == "Items" and v2[u20._ItemId] then
                            print(v);
                            u11:AddEntry(i);
                        end;
                    end;
                end;
            end;

            u11:AddEntries();
        end);
    end);
    u11.Trove:Connect(u1.ItemRemoved, function(u23, u24) -- Line: 128
        -- upvalues: u12 (ref), u13 (ref), RequestViewingUpdate (copy), u3 (ref), u11 (copy)
        local u25 = (u12 or 0) + 1;
        u12 = u25;

        if u13 then
            return;
        end;

        u13 = true;
        task.delay(0.05, function() -- Line: 94
            -- upvalues: u13 (ref), u25 (copy), u12 (ref), RequestViewingUpdate (ref), u24 (copy), u23 (copy), u3 (ref), u11 (ref)
            u13 = false;

            if u25 ~= u12 then
                RequestViewingUpdate(u24);

                return;
            end;

            if u23 then
                for i, v in u3 do
                    for i2, v2 in v.Input do
                        if i2 == "Items" and v2[u23._ItemId] then
                            print(v);
                            u11:AddEntry(i);
                        end;
                    end;
                end;
            end;

            u11:AddEntries();
        end);
    end);

    return u11;
end;

function u6.AddEntry(u26, u27) -- Line: 135
    -- upvalues: u3 (copy), u4 (copy), ItemData (copy), LocalPlayer (copy), u1 (copy), Trove (copy)
    local v28 = u3[u27];

    if not (v28 and u26.Recipes) then
        return;
    end;

    local Input = v28.Input;
    local Output = v28.Output;
    local v29 = u26.Recipes:FindFirstChild(u27) or u26.RecipeEntry:Clone();
    v29.Name = u27;
    v29.Parent = u26.Recipes;
    local v30 = 0;
    local v31 = 0;
    local u32 = nil;

    for i, v in Input do
        v30 = v30 + 1;

        if i == "UCoins" then
            local v33 = u26:GetAmount(i, nil);
            local v34 = v <= v33;

            if v34 then
                v31 = v31 + 1;
            end;

            local v35 = `<font color="{v34 and "#82ff4c" or "#ff4040"}">{v33}</font> / {v}`;
            local String = u4[i].String;
            local v36 = v29.Input:FindFirstChild(i) or u26.Entry:Clone();
            v36.NameLabel.Text = String;
            v36.AmountLabel.Text = v35;
            v36.Name = i;
            v36.Visible = true;
            v36.Parent = v29.Input;
        elseif i == "Items" then
            local v37 = true;

            for i2, v2 in v do
                local v38 = 0;
                local v39 = ItemData.GetItemInfo(i2);

                if v39.Type == "Item" then
                    for _, child in LocalPlayer.Backpack:GetChildren() do
                        if child:IsA("Tool") and (child:GetAttribute("ItemId") == i2 and type(child:GetAttribute("UUID")) == "string") then
                            v38 = v38 + 1;
                        end;
                    end;
                end;

                if v39.Type == "Item" or (v39.Type == "Ability" or v39.Type == "Skin") then
                    u32 = true;
                    local v40 = u1:GetItemCount(v39.Type == "Ability" and "AbilityInventory" or (v39.Type == "Item" and "ItemInventory" or "SkinInventory"), i2, {
                        Unusual = false,
                        Trait = false,
                        Locked = false
                    }):expect();

                    if typeof(v40) == "number" then
                        v38 = v38 + v40;
                    end;
                end;

                local v41 = v2 <= v38;

                if not v41 then
                    v37 = false;
                end;

                local v42 = `<font color="{v41 and "#82ff4c" or "#ff4040"}">{v38}</font> / {v2}`;
                local v43;

                if u4[i2] then
                    v43 = u4[i2].String;
                else
                    v43 = u26.UIEngine:GetItemText(i2);
                end;

                local v44 = v29.Input:FindFirstChild("Input" .. i2) or u26.Entry:Clone();
                v44.NameLabel.Text = v43;
                v44.AmountLabel.Text = v42;
                v44.Name = "Input" .. i2;
                v44.Visible = true;
                v44.Parent = v29.Input;
            end;

            if v37 then
                v31 = v31 + 1;
            end;
        elseif i == "Shards" then
            local v45 = true;

            for i2, v2 in v do
                local v46 = u26.AbilityCrafts[i2];
                local v47 = v29.Input:FindFirstChild(i2 .. "_SHARDS") or u26.Entry:Clone();
                local v48 = not v46 and "???" or v46.Shards;
                local v49 = ItemData.GetRarityByName(not v46 and "Common" or v46.Rarity);
                local v50;

                if v46 then
                    v50 = v49.Color;
                else
                    v50 = Color3.new(0.2, 0.2, 0.2);
                end;

                local v51 = v50:ToHex();
                local v52 = ItemData.GetItemInfo(i2);
                local v53;

                if v46 == nil then
                    v53 = false;
                else
                    v53 = v2 <= v48;
                end;

                local v54 = v46 == nil and `#{Color3.new(0.2, 0.2, 0.2):ToHex()}` or (v53 and "#82ff4c" or "#ff4040");

                if not v53 then
                    v45 = false;
                end;

                v47.NameLabel.Text = `<font color="#{v51}">{v52.Name} Shards</font>`;
                v47.AmountLabel.Text = `<font color="{v54}">{v48}</font> / {v2}`;
                v47.Name = i2 .. "_SHARDS";
                v47.Visible = true;
                v47.Parent = v29.Input;
            end;

            if v45 then
                v31 = v31 + 1;
            end;
        end;
    end;

    if v30 == v31 then
        v29.ArrowImage.ImageColor3 = Color3.fromRGB(90, 255, 90);
        v29.BackgroundColor3 = Color3.fromRGB(90, 255, 90);
    else
        v29.ArrowImage.ImageColor3 = Color3.new(1, 1, 1);
        v29.BackgroundColor3 = Color3.new(0, 0, 0);
    end;

    for i, v in Output do
        if i == "UCoins" then
            local String = u4[i].String;
            local v55 = v29.Output:FindFirstChild(i) or u26.Entry:Clone();
            v55.NameLabel.Text = String;
            v55.AmountLabel.Text = v;
            v55.Name = i;
            v55.Visible = true;
            v55.Parent = v29.Output;
        elseif i == "Items" then
            for i2, v2 in v do
                local v56 = u26.UIEngine:GetItemText(i2);
                local v57 = v29.Output:FindFirstChild(i2) or u26.Entry:Clone();
                v57.NameLabel.Text = v56;
                v57.AmountLabel.Text = v2;
                v57.Name = i2;
                v57.Visible = true;
                v57.Parent = v29.Output;
            end;
        elseif i == "Shards" then
            for i2, v2 in v do
                local v58 = u26.AbilityCrafts[i2];
                local v59 = ItemData.GetRarityByName(not v58 and "Common" or v58.Rarity);
                local v60 = ItemData.GetItemInfo(i2);
                local v61;

                if v58 then
                    v61 = v59.Color;
                else
                    v61 = Color3.new(0.2, 0.2, 0.2);
                end;

                local v62 = v29.Input:FindFirstChild(i2 .. "_SHARDS") or u26.Entry:Clone();
                v62.NameLabel.Text = `<font color="#{v61:ToHex():upper()}">{v60.Name} Shards</font>`;
                v62.AmountLabel.Text = v2;
                v62.Name = i2 .. "_SHARDS";
                v62.Visible = true;
                v62.Parent = v29.Input;
            end;
        end;
    end;

    if not u26.Cache.Entries[u27] then
        local v63 = Trove.new();
        v63:Add(v29);
        v63:Connect(v29.MouseButton1Click, function() -- Line: 299
            -- upvalues: u26 (copy), u27 (copy), u32 (ref)
            u26:AttemptCraft(u27);

            if u32 then
                u26.UIEngine:PlaySound("xp_gain");
                u26.UIEngine:CreateMiddleNotification({
                    NumericalContent = 1,
                    NumericalSuffix = "INFO",
                    Verb = "",
                    Subject = "Abilities must have no traits to be added as crafting material"
                });
            end;
        end);
        v29.Visible = true;
        u26.Cache.Entries[u27] = {
            Trove = v63,
            Entry = v29
        };
    end;
end;

function u6.AddEntries(p64) -- Line: 321
    -- upvalues: u3 (copy)
    if not p64.UI.Visible then
        return;
    end;

    p64.AbilityCrafts = p64.UIEngine:CheckAbilityCrafts();

    for i, _ in u3 do
        p64:AddEntry(i);
    end;
end;

function u6.GetAmount(p65, p66, p67) -- Line: 331
    -- upvalues: u4 (copy), LocalPlayer (copy), u1 (copy)
    if u4[p66] then
        return LocalPlayer:FindFirstChild("Data"):FindFirstChild(u4[p66].Name).Value;
    end;

    return u1:GetItemCount(p67, p66):expect();
end;

function u6.AttemptCraft(u68, u69) -- Line: 344
    -- upvalues: u2 (copy), u5 (copy), u3 (copy)
    if not u2:CheckCraftable(u69):expect() then
        return;
    end;

    local v70 = u68.Cache.Entries[u69];

    if not v70 then
        return;
    end;

    local Entry = v70.Entry;
    Entry.BackgroundTransparency = 0.3;
    u68.UIEngine:PlaySound("Click");
    u68.UIEngine.NewPrompt({
        Title = "Craft Recipe",
        Text = "Are you sure you want to craft this recipe?",
        Delay = 0.75,
        Options = { "Yes", "No" },

        Callback = function(p71) -- Line: 364, Name: Callback
            -- upvalues: Entry (copy), u68 (copy), u2 (ref), u69 (copy), u5 (ref), u3 (ref)
            Entry.BackgroundTransparency = 0.8;

            if p71.Choice ~= 1 then
                return;
            end;

            u68.UIEngine:PlaySound("Click");
            local v72 = u2:Craft(u69):expect();

            if type(v72) == "string" then
                print(v72);
                local v73 = u5[v72];
                u68.UIEngine.NewPrompt({
                    Title = v73[1],
                    Text = v73[2]
                });

                return;
            end;

            local v74 = {};

            for i in u3[u69].Output.Items do
                table.insert(v74, i);
            end;

            u68:AddEntries();
            u68.UIEngine:PromptItems(v74);
        end
    });
end;

function u6.Filter(p75) -- Line: 398
    local Text = p75.SearchBar.Text;
    local Entries = p75.Cache.Entries;

    if Text:gsub(" ", "") == "" then
        for _, v in Entries do
            local Entry = v.Entry;
            local _ = Entry.Output;
            Entry.Visible = true;
        end;

        return;
    end;

    for _, v in Entries do
        local Entry = v.Entry;
        local Output = Entry.Output;
        Entry.Visible = false;

        for _, descendant in Output:GetDescendants() do
            if descendant:IsA("TextLabel") and (descendant.Name == "NameLabel" and string.find(string.lower(descendant.Text), string.lower(Text))) then
                Entry.Visible = true;
                break;
            end;
        end;
    end;
end;

function u6.Load(p76) -- Line: 430
    -- upvalues: u6 (copy)
    p76.UI.Visible = true;
    u6.AddEntries(p76);
end;

return u6;
  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
local ItemData = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").ItemData);
require(PathShortcuts.ReplicatedModules:WaitForChild("Stands"));
Knit.GetService("LevelService");
Knit.GetService("StatService");
local TraitHandler = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").PVEPackage.TraitHandler);
local u1 = Knit.GetService("TraitService");
local LocalPlayer = game.Players.LocalPlayer;
local u2 = {};
u2.__index = u2;
local u3 = nil;
local u4 = nil;
local u5 = nil;
Knit.OnStart():andThen(function() -- Line: 21
    -- upvalues: u1 (ref), Knit (copy), u3 (ref), u4 (ref), u5 (ref)
    u1 = Knit.GetService("TraitService");
    local v6 = u1:GetTraitsMetadata():expect();
    u3 = v6.RarityColors;
    u4 = v6.RarityIndices;
    u5 = v6.StatRanges;
end);

function u2.new(p7, p8) -- Line: 29
    -- upvalues: u2 (copy), Trove (copy)
    local v9 = setmetatable({}, u2);
    v9.UI = p7;
    v9.UIEngine = p8;
    v9.Trove = Trove.new();
    v9.Assets = p7.Assets;
    v9.Cache = {};
    v9.TraitSection = v9.UI.TraitSection;
    v9.TraitCard = v9.TraitSection.CurrentTrait;
    v9.InfoSection = v9.UI.InfoSection;
    v9.AbilityName = v9.InfoSection.AbilityName;
    v9.AbilityPrefix = v9.InfoSection.AbilityPrefix;
    v9.AbilityDescription = v9.InfoSection.AbilityDescription;

    return v9;
end;

function u2.FormatTraitCard(p10, p11, p12) -- Line: 51
    -- upvalues: TraitHandler (copy), LocalPlayer (copy), u3 (ref), u4 (ref)
    local v13 = p12 or {};
    local v14 = TraitHandler.GetTraitFromPlayer(LocalPlayer);

    if v13.Trait ~= v14.Trait or v13.Hexed ~= v14.Hexed then
        v13 = v14;
    end;

    if not v13.Trait then
        p11.Content.Title.Label.Text = "None";
        p11.Content.Title.Label.TextStrokeTransparency = 1;
        p11.Content.Title.Label.TextStrokeColor3 = Color3.new(0, 0, 0);
        local v15 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(175, 175, 255)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) });
        local v16 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.fromRGB(57, 57, 57)) });

        for _, descendant in p11:GetDescendants() do
            if descendant.Name == "Seperator" and descendant:IsA("Frame") then
                descendant.BackgroundColor3 = Color3.new(1, 1, 1);
            end;
        end;

        p11.Content.Rating.Text = "/";
        p11.Content.UIStroke.Color = Color3.new(1, 1, 1);
        p11.Content.UIGradient.Color = v15;
        p11.Content.Rating.UIGradient.Color = v16;
        p11.Content.ModifiersTitle.UIGradient.Color = v16;
        p11.Content.Description.Text = "";
        p11.Content.ModifiersTitle.Visible = false;
        p11.Content.Modifiers.Visible = false;

        return;
    end;

    local v17 = TraitHandler.GetTraitData(v13.Trait);
    p11.Content.Title.Label.TextStrokeTransparency = 1;
    local v18;

    if v13.Hexed then
        v18 = u3.Hexed;
    else
        v18 = u3[v17.Rarity];
    end;

    local v19;

    if v13.Hexed then
        v19 = `{v17.HexPrefix} {v13.Trait}`;
    else
        v19 = v13.Trait;
    end;

    p11.Content.Title.Label.Text = v19;

    if v13.Hexed then
        p11.Content.Title.Label.TextStrokeTransparency = 0;
        p11.Content.Title.Label.TextStrokeColor3 = v18;
    end;

    p11.Content.ModifiersTitle.Visible = false;
    p11.Content.Modifiers.Visible = false;
    p11.Content.Modifiers.Text = "";
    local v20 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(175, 175, 255)), ColorSequenceKeypoint.new(1, v18) });
    local v21 = ColorSequence.new({ ColorSequenceKeypoint.new(0, v18), ColorSequenceKeypoint.new(1, Color3.fromRGB(57, 57, 57)) });
    p11.Content.UIStroke.Color = v18;
    p11.Content.UIGradient.Color = v20;
    p11.Content.Rating.UIGradient.Color = v21;
    p11.Content.ModifiersTitle.UIGradient.Color = v21;

    for _, descendant in p11:GetDescendants() do
        if descendant.Name == "Seperator" and descendant:IsA("Frame") then
            descendant.BackgroundColor3 = v18;
        end;
    end;

    p11.Content.Rating.Text = string.rep("★", u4[v17.Rarity]);
    local v22;

    if v13.Hexed then
        v22 = v17.HexDescription;
    else
        v22 = v17.Description;
    end;

    p11.Content.Description.Text = v22;

    if v13.StatBonuses then
        p11.Content.ModifiersTitle.Visible = true;
        p11.Content.Modifiers.Visible = true;

        for i, v in v13.StatBonuses do
            local Modifiers = p11.Content.Modifiers;
            Modifiers.Text = Modifiers.Text .. `{i}: {v}<br />`;
        end;
    end;
end;

function u2.Load(p23, p24) -- Line: 128
    -- upvalues: ItemData (copy), u1 (ref)
    p23.AbilityId = p24;
    local v25 = ItemData.GetItemInfo((`ABILITY_{p24}`));
    local v26 = "Ability";

    if type(v25.Title) == "string" then
        v26 = v25.Title;
    elseif type(v25.Prefix) == "table" then
        v26 = v25.Prefix.Name;
    elseif type(v25.Prefix) == "string" then
        v26 = v25.Prefix;
    end;

    p23:SetInfo({
        AbilityName = v25.Name,
        AbilityPrefix = v26,
        AbilityPrefixColor = ItemData.Rarities[v25.Rarity].Color,
        AbilityDescription = v25.Description
    });
    local v27 = u1:GetCurrentTraitInfo():expect();
    p23:FormatTraitCard(p23.TraitCard, v27);
end;

function u2.SetInfo(p28, p29) -- Line: 154
    p28.AbilityName.Text = p29.AbilityName;
    p28.AbilityPrefix.Text = p29.AbilityPrefix;
    p28.AbilityPrefix.TextColor3 = p29.AbilityPrefixColor;
    p28.AbilityDescription.Text = p29.AbilityDescription;
end;

return u2;
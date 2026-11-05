  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
local ItemData = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").ItemData);
Knit.GetService("InventoryService");
require(PathShortcuts.ReplicatedModules.Classes.Stack);
require(PathShortcuts.KnitPath.Promise);
Knit:OnStart():await();
local TraitHandler = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").PVEPackage.TraitHandler);
local u1 = Knit.GetService("TraitService");
Knit.GetService("CraftingService");
local u2 = Knit.GetService("ShopService");
local AbilityNameToId = require(ReplicatedStorage.ReplicatedModules.AbilityNameToId);
local LocalPlayer = Players.LocalPlayer;
local u3 = nil;
local u4 = nil;
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = nil;
Knit.OnStart():andThen(function() -- Line: 29
    -- upvalues: u1 (ref), Knit (copy), u3 (ref), u4 (ref), u5 (ref), u6 (ref), u7 (ref), u8 (ref), u9 (ref)
    u1 = Knit.GetService("TraitService");
    local v10 = u1:GetTraitsMetadata():expect();
    u3 = v10.RarityColors;
    u4 = v10.RarityIndices;
    u5 = v10.StatRanges;
    u6 = v10.GoldenStar;
    u7 = v10.PerfectText;
    u8 = v10.BrokenHeart;
    u9 = v10.DepressingText;
end);
local u11 = {};
u11.__index = u11;

local function RNG(p12, p13) -- Line: 48
    return Random.new():NextNumber(p12, p13);
end;

function u11.new(p14, p15) -- Line: 52
    -- upvalues: u11 (copy), Trove (copy)
    local u16 = setmetatable({}, u11);
    u16.UI = p14;
    u16.UIEngine = p15;
    u16.Trove = Trove.new();
    u16.Assets = p14.Assets;
    u16.Cache = {};
    u16.Modifier = u16.Assets.Modifier;
    u16.InfoSection = u16.UI.InfoSection;
    u16.RerollSection = u16.UI.RerollSection;
    u16.BuySection = u16.UI.Buy;
    u16.Currencies = u16.UI.RerollSection.Currencies;
    u16.Modifiers = u16.RerollSection.Modifiers;
    u16.AbilityName = u16.InfoSection.AbilityName;
    u16.AbilityPrefix = u16.InfoSection.AbilityPrefix;
    u16.AbilityDescription = u16.InfoSection.AbilityDescription;
    u16.Close = p14.Close;
    u16.Trove:Connect(u16.Close.MouseButton1Click, function() -- Line: 78
        -- upvalues: u16 (copy)
        u16:CloseMenu();
    end);
    u16.Trove:Connect(u16.BuySection.Roll.MouseButton1Click, function() -- Line: 82
        -- upvalues: u16 (copy)
        u16:PromptPurchase();
    end);

    return u16;
end;

function u11.UpdateTraitDisplay(u17, p18) -- Line: 91
    -- upvalues: TraitHandler (copy), u3 (ref), u1 (ref), u4 (ref), u6 (ref), u8 (ref), AbilityNameToId (copy)
    if not p18 then
        u17.RerollSection.Title.Label.Text = "None";
        u17.RerollSection.Title.Label.TextStrokeTransparency = 1;
        u17.RerollSection.Title.Label.TextStrokeColor3 = Color3.new(0, 0, 0);
        u17.RerollSection.Title.Label.TextColor3 = Color3.new(1, 1, 1);
        local v19 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(175, 175, 255)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) });
        ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.fromRGB(57, 57, 57)) });
        u17.RerollSection.UIStroke.Color = Color3.new(1, 1, 1);
        u17.RerollSection.UIGradient.Color = v19;

        for _, child in u17.Modifiers:GetChildren() do
            if child:IsA("Frame") then
                child:Destroy();
            end;
        end;

        return;
    end;

    local v20 = TraitHandler.GetTraitData(p18.Trait);
    u17.RerollSection.Title.Label.TextStrokeTransparency = 1;
    local v21;

    if p18.Hexed then
        v21 = u3.Hexed;
    else
        v21 = u3[v20.Rarity];
    end;

    local v22;

    if p18.Hexed then
        v22 = `{v20.HexPrefix} {p18.Trait}`;
    else
        v22 = p18.Trait;
    end;

    u17.RerollSection.Title.Label.Text = v22;
    u17.RerollSection.Title.Label.TextStrokeColor3 = Color3.new(0, 0, 0);

    if p18.Hexed then
        u17.RerollSection.Title.Label.TextStrokeTransparency = 0;
        u17.RerollSection.Title.Label.TextStrokeColor3 = v21;
    end;

    local v23 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(175, 175, 255)), ColorSequenceKeypoint.new(1, v21) });
    ColorSequence.new({ ColorSequenceKeypoint.new(0, v21), ColorSequenceKeypoint.new(1, Color3.fromRGB(57, 57, 57)) });
    u17.RerollSection.Title.Label.TextColor3 = v21;
    u17.RerollSection.UIStroke.Color = v21;
    u17.RerollSection.UIGradient.Color = v23;

    for _, child in u17.Modifiers:GetChildren() do
        if child:IsA("Frame") then
            child:Destroy();
        end;
    end;

    if p18.StatBonuses then
        local v24 = u1:GetTraitsMetadata():expect();
        local StatRanges = v24.StatRanges;
        u3 = v24.RarityColors;
        u4 = v24.RarityIndices;
        local v25;

        if p18.Hexed then
            v25 = StatRanges.Hexed;
        else
            v25 = StatRanges[v20.Rarity];
        end;

        for i, v in p18.StatBonuses do
            local v26 = v25.Max <= v;
            local v27 = v <= v25.Min;
            local v28 = u17.Modifier:Clone();
            v28.Modifier.Text = `{i}:`;
            local v29;

            if v26 then
                v29 = " " .. u6;
            else
                v29 = not v27 and "" or " " .. u8;
            end;

            v28.Value.Text = v .. v29;
            v28.Range.Text = `Value Ranges: [{v25.Min}, {v25.Max}] (<font color="#{u17.UIEngine.UShardsTextColor:ToHex()}">{u17.UIEngine.CurrencyString}</font>) | [1, {v25.Max}] (<font color="#{u17.UIEngine.UPointsTextColor:ToHex()}">{u17.UIEngine.PremiumCurrencyString}</font>)`;
            v28.Visible = true;
            v28.Parent = u17.Modifiers;
            v28.Roll.MouseButton1Click:Connect(function() -- Line: 156
                -- upvalues: u17 (copy), i (copy), AbilityNameToId (ref)
                u17.UIEngine.NewPrompt({
                    Title = "Reroll Stats",
                    Delay = 0.5,
                    Text = `Reroll <b>{i}</b> stat for trait ({AbilityNameToId.GetAbilityName(u17.Cache.AbilityId)})`,
                    RichText = { 2 },
                    Options = { "Cancel", `<font color="#{u17.UIEngine.UPointsTextColor:ToHex()}">250 {u17.UIEngine.PremiumCurrencyString}</font>` },

                    Callback = function(p30) -- Line: 166, Name: Callback
                        -- upvalues: u17 (ref), i (ref)
                        u17.UIEngine:PlaySound("Click");

                        if p30.Choice == 1 then
                            return;
                        end;

                        u17:RerollStat(i);
                    end
                });
            end);
        end;
    end;
end;

function u11.SetInfo(p31, p32) -- Line: 177
    p31.AbilityName.Text = p32.AbilityName;
    p31.AbilityPrefix.Text = p32.AbilityPrefix;
    p31.AbilityPrefix.TextColor3 = p32.AbilityPrefixColor;
    p31.AbilityDescription.Text = p32.AbilityDescription;
end;

function u11.UpdateCurrencies(p33) -- Line: 184
    -- upvalues: u2 (copy)
    local v34 = u2:GetCurrencyType("UPoints"):expect();
    local v35 = u2:GetCurrencyType("UShards"):expect();
    local v36 = p33.UIEngine:AbbreviateNumber(v34);
    local v37 = p33.UIEngine:AbbreviateNumber(v35);
    p33.Currencies.UShards.Text = `<font color="#{p33.UIEngine.UShardsTextColor:ToHex()}">{v37} {p33.UIEngine.CurrencyString}</font>`;
    p33.Currencies.UPoints.Text = `<font color="#{p33.UIEngine.UPointsTextColor:ToHex()}">{v36} {p33.UIEngine.PremiumCurrencyString}</font>`;
end;

function u11.PromptPurchase(u38, p39) -- Line: 195
    -- upvalues: ItemData (copy), AbilityNameToId (copy)
    ItemData.GetItemInfo((`ABILITY_{u38.Cache.AbilityId}`));
    u38.UIEngine.NewPrompt({
        Title = "Reroll Stats",
        Delay = 0.5,
        Text = `Reroll <b>all</b> stats for trait ({AbilityNameToId.GetAbilityName(u38.Cache.AbilityId)})`,
        RichText = { 2, 3 },
        Options = { "Cancel", `<font color="#{u38.UIEngine.UShardsTextColor:ToHex()}">100k {u38.UIEngine.CurrencyString}</font>`, `<font color="#{u38.UIEngine.UPointsTextColor:ToHex()}">100 {u38.UIEngine.PremiumCurrencyString}</font>` },

        Callback = function(p40) -- Line: 208, Name: Callback
            -- upvalues: u38 (copy)
            u38.UIEngine:PlaySound("Click");

            if p40.Choice == 1 then
                return;
            end;

            u38:RerollStats(p40.Choice == 3);
        end
    });
end;

function u11.RerollStats(p41, p42) -- Line: 216
    -- upvalues: u1 (ref), LocalPlayer (copy)
    local v43, v44 = u1:RerollTraitStats(LocalPlayer.Data.Ability:GetAttribute("UUID"), p42):expect();
    local v45;

    if v44 == "UPoints" then
        v45 = `<font color="#{p41.UIEngine.UPointsTextColor:ToHex()}">{p41.UIEngine.PremiumCurrencyString}</font>`;
    else
        v45 = `<font color="#{p41.UIEngine.UShardsTextColor:ToHex()}">{p41.UIEngine.CurrencyString}</font>`;
    end;

    if type(v43) == "table" then
        p41:UpdateTraitDisplay(v43);

        return;
    end;

    if v43 == "NotEnough" then
        p41.UIEngine.NewPrompt({
            Title = "Stat Reroll Failed",
            Delay = 0.5,
            Text = `You do not have enough {v45} to continue rerolling.`
        });

        return;
    end;

    if v43 == "NoTrait" then
        p41.UIEngine.NewPrompt({
            Title = "Stat Reroll Failed",
            Text = "You have no trait, obtain a trait first",
            Delay = 0.5
        });

        return;
    end;

    if v43 == "AscensionFailed" then
        p41.UIEngine.NewPrompt({
            Title = "Stat Reroll Failed",
            Text = "You must be Ascension Rank 10 minimum to reroll on this ability",
            Delay = 0.5
        });
    end;
end;

function u11.RerollStat(p46, p47) -- Line: 245
    -- upvalues: u1 (ref), LocalPlayer (copy)
    local v48 = u1:RerollTraitStat(LocalPlayer.Data.Ability:GetAttribute("UUID"), p47):expect();
    local v49 = `<font color="#{p46.UIEngine.UPointsTextColor:ToHex()}">{p46.UIEngine.PremiumCurrencyString}</font>`;

    if type(v48) == "table" then
        p46:UpdateTraitDisplay(v48);

        return;
    end;

    if v48 == "NotEnough" then
        p46.UIEngine.NewPrompt({
            Title = "Stat Reroll Failed",
            Delay = 0.5,
            Text = `You do not have enough {v49} to continue rerolling.`
        });

        return;
    end;

    if v48 == "NoTrait" then
        p46.UIEngine.NewPrompt({
            Title = "Stat Reroll Failed",
            Text = "You have no trait, obtain a trait first",
            Delay = 0.5
        });
    end;
end;

function u11.CloseMenu(p50) -- Line: 267
    p50.UI.Visible = false;
end;

function u11.Update(u51) -- Line: 271
    -- upvalues: LocalPlayer (copy), ItemData (copy), u1 (ref)
    local Value = LocalPlayer.Data.Ability.Value;
    u51.Cache.AbilityId = Value;
    local v52 = ItemData.GetItemInfo((`ABILITY_{Value}`));
    local v53 = "Ability";

    if type(v52.Title) == "string" then
        v53 = v52.Title;
    elseif type(v52.Prefix) == "table" then
        v53 = v52.Prefix.Name;
    elseif type(v52.Prefix) == "string" then
        v53 = v52.Prefix;
    end;

    u51:SetInfo({
        AbilityName = v52.Name,
        AbilityPrefix = v53,
        AbilityPrefixColor = ItemData.Rarities[v52.Rarity].Color,
        AbilityDescription = v52.Description
    });
    task.defer(function() -- Line: 296
        -- upvalues: u1 (ref), u51 (copy)
        u51:UpdateTraitDisplay((u1:GetCurrentTraitInfo():expect()));
        u51:UpdateCurrencies();
    end);
end;

function u11.Load(p54) -- Line: 304
    p54:Update();
    p54.UI.Visible = true;
end;

return u11;
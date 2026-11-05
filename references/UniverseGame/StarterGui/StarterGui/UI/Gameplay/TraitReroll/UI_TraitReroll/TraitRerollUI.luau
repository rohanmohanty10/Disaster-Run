  

 

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
local v3 = u1:GetTraitsMetadata():expect();
local RarityColors = v3.RarityColors;
local RarityIndices = v3.RarityIndices;
local _ = v3.StatRanges;
local _ = v3.GoldenStar;
local _ = v3.PerfectText;
local _ = v3.BrokenHeart;
local _ = v3.DepressingText;
local u4 = {};
u4.__index = u4;

local function RNG(p5, p6) -- Line: 55
    return Random.new():NextNumber(p5, p6);
end;

function u4.new(p7, p8) -- Line: 59
    -- upvalues: u4 (copy), Trove (copy)
    local u9 = setmetatable({}, u4);
    u9.UI = p7;
    u9.UIEngine = p8;
    u9.Trove = Trove.new();
    u9.Assets = p7.Assets;
    u9.Cache = {};
    u9.InfoSection = u9.UI.InfoSection;
    u9.RerollSection = u9.UI.RerollSection;
    u9.BuySection = u9.UI.Buy;
    u9.Currencies = u9.UI.Currencies;
    u9.TraitRates = u9.UI.TraitRates;
    u9.CurrentTraitCard = u9.RerollSection.CurrentTrait;
    u9.RerolledTraitCard = u9.RerollSection.RolledTrait;
    u9.AbilityName = u9.InfoSection.AbilityName;
    u9.AbilityPrefix = u9.InfoSection.AbilityPrefix;
    u9.AbilityDescription = u9.InfoSection.AbilityDescription;
    u9.Close = p7.Close;
    u9.PoolAsset = u9.Assets.PoolAsset;
    u9.Selector = u9.UI.Selector;
    u9.Trove:Connect(u9.Close.MouseButton1Click, function() -- Line: 89
        -- upvalues: u9 (copy)
        u9:CloseMenu();
    end);
    u9.Trove:Connect(u9.TraitRates.Frame.Close.MouseButton1Click, function() -- Line: 93
        -- upvalues: u9 (copy)
        u9.TraitRates.Visible = false;
    end);
    u9.Trove:Connect(u9.BuySection.One.MouseButton1Click, function() -- Line: 97
        -- upvalues: u9 (copy)
        u9:PromptPurchase("TraitRerollCurrency", 1);
    end);
    u9.Trove:Connect(u9.BuySection.Ten.MouseButton1Click, function() -- Line: 101
        -- upvalues: u9 (copy)
        u9:PromptPurchase("TraitRerollCurrency", 10);
    end);
    u9.Trove:Connect(u9.BuySection.Roll.MouseButton1Click, function() -- Line: 105
        -- upvalues: u9 (copy)
        u9:PromptPurchase("Reroll");
    end);
    u9.Trove:Connect(u9.RerollSection.Accept.MouseButton1Click, function() -- Line: 109
        -- upvalues: u9 (copy)
        u9:AcceptTrait();
    end);
    u9.Trove:Connect(u9.RerollSection.LootPool.MouseButton1Click, function() -- Line: 113
        -- upvalues: u9 (copy)
        u9:DisplayTraitRates();
    end);
    u9.Trove:Connect(u9.RerollSection.ResultList.MouseButton1Click, function() -- Line: 117
        -- upvalues: u9 (copy)
        if u9.Cache.LastRerollResults then
            local v10 = u9:QuerySelector(u9.Cache.LastRerollResults) or u9.Cache.LastRerollResults[1];
            print(v10.Trait);
            u9:FormatTraitCard(u9.RerolledTraitCard, v10);
            u9.RerolledTraitCard.Content.Cover.Visible = false;
            u9.RerollSection.Accept.Visible = true;
        end;
    end);

    return u9;
end;

function u4.FormatTraitCard(p11, p12, p13) -- Line: 137
    -- upvalues: TraitHandler (copy), RarityColors (copy), RarityIndices (copy)
    if not p13 then
        p12.Content.Title.Label.Text = "None";
        p12.Content.Title.Label.TextStrokeTransparency = 1;
        p12.Content.Title.Label.TextStrokeColor3 = Color3.new(0, 0, 0);
        local v14 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(175, 175, 255)), ColorSequenceKeypoint.new(1, Color3.new(1, 1, 1)) });
        local v15 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)), ColorSequenceKeypoint.new(1, Color3.fromRGB(57, 57, 57)) });

        for _, descendant in p12:GetDescendants() do
            if descendant.Name == "Seperator" and descendant:IsA("Frame") then
                descendant.BackgroundColor3 = Color3.new(1, 1, 1);
            end;
        end;

        p12.Content.Rating.Text = "/";
        p12.Content.UIStroke.Color = Color3.new(1, 1, 1);
        p12.Content.UIGradient.Color = v14;
        p12.Content.Rating.UIGradient.Color = v15;
        p12.Content.ModifiersTitle.UIGradient.Color = v15;
        p12.Content.Description.Text = "";
        p12.Content.ModifiersTitle.Visible = false;
        p12.Content.Modifiers.Visible = false;

        return;
    end;

    local v16 = TraitHandler.GetTraitData(p13.Trait);
    p12.Content.Title.Label.TextStrokeTransparency = 1;
    local v17;

    if p13.Hexed then
        v17 = RarityColors.Hexed;
    else
        v17 = RarityColors[v16.Rarity];
    end;

    local v18;

    if p13.Hexed then
        v18 = `{v16.HexPrefix} {p13.Trait}`;
    else
        v18 = p13.Trait;
    end;

    p12.Content.Title.Label.Text = v18;

    if p13.Hexed then
        p12.Content.Title.Label.TextStrokeTransparency = 0;
        p12.Content.Title.Label.TextStrokeColor3 = v17;
    end;

    p12.Content.ModifiersTitle.Visible = false;
    p12.Content.Modifiers.Visible = false;
    p12.Content.Modifiers.Text = "";
    local v19 = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(175, 175, 255)), ColorSequenceKeypoint.new(1, v17) });
    local v20 = ColorSequence.new({ ColorSequenceKeypoint.new(0, v17), ColorSequenceKeypoint.new(1, Color3.fromRGB(57, 57, 57)) });
    p12.Content.UIStroke.Color = v17;
    p12.Content.UIGradient.Color = v19;
    p12.Content.Rating.UIGradient.Color = v20;
    p12.Content.ModifiersTitle.UIGradient.Color = v20;

    for _, descendant in p12:GetDescendants() do
        if descendant.Name == "Seperator" and descendant:IsA("Frame") then
            descendant.BackgroundColor3 = v17;
        end;
    end;

    p12.Content.Rating.Text = string.rep("★", RarityIndices[v16.Rarity]);
    local v21;

    if p13.Hexed then
        v21 = v16.HexDescription;
    else
        v21 = v16.Description;
    end;

    p12.Content.Description.Text = v21;

    if p13.StatBonuses then
        p12.Content.ModifiersTitle.Visible = true;
        p12.Content.Modifiers.Visible = true;

        for i, v in p13.StatBonuses do
            local Modifiers = p12.Content.Modifiers;
            Modifiers.Text = Modifiers.Text .. `{i}: {v}<br />`;
        end;
    end;
end;

function u4.SetInfo(p22, p23) -- Line: 206
    p22.AbilityName.Text = p23.AbilityName;
    p22.AbilityPrefix.Text = p23.AbilityPrefix;
    p22.AbilityPrefix.TextColor3 = p23.AbilityPrefixColor;
    p22.AbilityDescription.Text = p23.AbilityDescription;
end;

function u4.DisplayPrices(p24) -- Line: 213
    -- upvalues: ItemData (copy)
    ItemData.GetItemInfo((`ABILITY_{p24.Cache.AbilityId}`));
    p24.BuySection.One.Price.Text = `{tostring(200)} {p24.UIEngine.PremiumCurrencyString}`;
    p24.BuySection.Ten.Price.Text = `{tostring(2000)} {p24.UIEngine.PremiumCurrencyString}`;
end;

function u4.UpdateCurrencies(p25) -- Line: 220
    -- upvalues: u2 (copy)
    local v26 = u2:GetCurrencyType("UPoints"):expect();
    local v27 = p25.UIEngine:AbbreviateNumber(v26);
    p25.Currencies.PremiumCurrency.Text = `{v27} {p25.UIEngine.PremiumCurrencyString}`;
    p25.Currencies.Rerolls.Text = `{u2:GetCurrencyType("TraitRerolls"):expect()} Trait Rerolls`;
end;

function u4.UpdateTraitRates(u28) -- Line: 229
    -- upvalues: u1 (copy), ItemData (copy)
    local v29 = u1:GetTraitRates():expect();
    local WeightPool = v29.WeightPool;
    local TraitPool = v29.TraitPool;

    if #u28.TraitRates.Frame.List:GetChildren() > 1 then
        return;
    end;

    task.defer(function() -- Line: 236
        -- upvalues: WeightPool (copy), u28 (copy), ItemData (ref), TraitPool (copy)
        local v30 = 0;

        for _, v in WeightPool do
            v30 = v30 + v;
        end;

        for i, v in WeightPool do
            local v31 = u28.PoolAsset:Clone();
            v31.BackgroundTransparency = 1;
            local v32 = i or "";
            local v33 = ItemData.GetRarityByName(i);
            local v34, v35;

            if v33 then
                local v36, v37, v38;

                if v33 then
                    local v39 = math.floor(v33.Color.R * 255);
                    v36 = tostring(v39);
                    local v40 = math.round(v33.Color.G * 255);
                    v37 = tostring(v40);
                    local v41 = math.round(v33.Color.B * 255);
                    v38 = tostring(v41);
                else
                    v36 = "255";
                    v37 = "255";
                    v38 = "255";
                end;

                v34 = "<font color=\"rgb(" .. v36 .. "," .. v37 .. "," .. v38 .. ")\"><b>";
                v35 = "</b></font>";
                v32 = v34 .. v32 .. v35;
            else
                v34 = "";
                v35 = "";
            end;

            v31.LayoutOrder = v * -1;
            v31.Text = v32 .. ": ~" .. string.format("%.3f", v / v30 * 100) .. "% (Category)";
            v31.Parent = u28.TraitRates.Frame.List;
            v31.Visible = true;
            local v42 = v / #TraitPool[i] / v30 * 100;

            for _, v2 in TraitPool[i] do
                if v33 then
                    local v43, v44, v45;

                    if v33 then
                        local v46 = math.floor(v33.Color.R * 255);
                        v43 = tostring(v46);
                        local v47 = math.round(v33.Color.G * 255);
                        v44 = tostring(v47);
                        local v48 = math.round(v33.Color.B * 255);
                        v45 = tostring(v48);
                    else
                        v43 = "255";
                        v44 = "255";
                        v45 = "255";
                    end;

                    v34 = "<font color=\"rgb(" .. v43 .. "," .. v44 .. "," .. v45 .. ")\">";
                    v35 = "</font>";
                    v32 = v34 .. v32 .. v35;
                end;

                local v49 = u28.PoolAsset:Clone();
                v49.LayoutOrder = (v - 1) * -1;
                v49.Text = v34 .. v2 .. v35 .. "  -  " .. string.format("%.3f", v42) .. "%";
                v49.Parent = u28.TraitRates.Frame.List;
                v49.Visible = true;
                task.defer(function() -- Line: 341
                    -- upvalues: u28 (ref)
                    u28.TraitRates.Frame.List.CanvasSize = UDim2.fromOffset(0, u28.TraitRates.Frame.List.UIListLayout.AbsoluteContentSize.Y);
                end);
            end;
        end;
    end);
end;

function u4.DisplayTraitRates(p50) -- Line: 349
    p50.TraitRates.Visible = true;
end;

function u4.PromptPurchase(u51, p52, u53) -- Line: 353
    -- upvalues: ItemData (copy), u1 (copy), u2 (copy), AbilityNameToId (copy)
    ItemData.GetItemInfo((`ABILITY_{u51.Cache.AbilityId}`));

    if p52 == "TraitRerollCurrency" then
        u51.UIEngine.NewPrompt({
            Title = "Purchase Trait Reroll",
            Delay = 0.5,
            Text = `Do you really want to purchase <font color="rgb(216, 125, 255)">{u53 == 1 and "1 Trait Reroll" or "10 Trait Rerolls"}</font>`,
            RichText = { 2 },
            Options = { "Cancel", `<font color="rgb(255,200,100)">{tostring(200 * u53)} {u51.UIEngine.PremiumCurrencyString}</font>` },

            Callback = function(p54) -- Line: 366, Name: Callback
                -- upvalues: u51 (copy), u1 (ref), u53 (copy)
                u51.UIEngine:PlaySound("Click");

                if p54.Choice == 1 then
                    return;
                end;

                u1:BuyReroll(u53);
            end
        });

        return;
    end;

    if p52 == "Reroll" then
        local v55 = u2:GetPityInfo():expect();
        local v56 = u2:GetCurrencyType("TraitRerolls"):expect();
        local v57 = `<font color="#{Color3.new(0, 1, 0):ToHex()}">Current Pity: {v55.TraitRerollPity} / 100\nTotal Pities: {v55.TraitRerollTotalPity}\n</font>`;
        local NewPrompt = u51.UIEngine.NewPrompt;
        local v58 = {
            Title = "Reroll Trait",
            Delay = 0.5,
            Text = v57 .. `Reroll trait for {AbilityNameToId.GetAbilityName(u51.Cache.AbilityId)}\n<font color="#9a9a9a">(If you pick the 5 or 10 Rerolls option, you will be able to choose one of the traits listed for applying. This can also be changed after.)</font>`,
            RichText = { 2, 3, 4 }
        };
        local v59 = { "Cancel", `<font color="rgb(216, 125, 255)">{1} Reroll</font>` };
        local v60;

        if v56 >= 5 then
            v60 = `<font color="rgb(216, 125, 255)">{5} Rerolls</font>`;
        else
            v60 = nil;
        end;

        v59[3] = v60;
        local v61;

        if v56 >= 10 then
            v61 = `<font color="rgb(216, 125, 255)">{10} Rerolls</font>`;
        else
            v61 = nil;
        end;

        v59[4] = v61;
        v58.Options = v59;

        function v58.Callback(p62) -- Line: 390
            -- upvalues: u51 (copy)
            u51.UIEngine:PlaySound("Click");

            if p62.Choice == 1 then
                return;
            end;

            u51:RerollTrait("TraitRerolls", p62.Choice == 3 and 5 or (p62.Choice == 4 and 10 or nil));
        end;

        NewPrompt(v58);
    end;
end;

function u4.QuerySelector(u63, u64) -- Line: 402
    -- upvalues: ItemData (copy)
    local v65 = u63.Trove:Extend();
    local Selector = u63.Selector;
    v65:Add(function() -- Line: 406
        -- upvalues: Selector (copy)
        Selector.Label.Text = "Chosen: None";
        Selector.Visible = false;
    end);
    Selector.Visible = true;
    local AbilityId = u63.Cache.AbilityId;
    local u66 = nil;
    local u67 = nil;
    local u68 = nil;
    local u69 = nil;

    for i = 1, #u64 do
        local u70 = u64[i];
        local u71 = ItemData.GetRarityByName(u70.Rarity);
        local u72 = u63.Assets.SmallCard:Clone();
        u72.Parent = Selector.Holder.Items;
        u72.LayoutOrder = u71.Weight;
        u63:FormatTraitCard(u72, u70);
        u72.Visible = true;
        v65:Add(u72);
        v65:Connect(u72.MouseButton1Click, function() -- Line: 430
            -- upvalues: u67 (ref), i (copy), u68 (ref), u72 (copy), u66 (ref), u71 (copy), Selector (copy), u70 (copy)
            u67 = i;
            u68 = u72;
            u68.Content.BackgroundColor3 = Color3.fromRGB(96, 214, 70);

            if u66 ~= u68 then
                if u66 ~= nil then
                    u66.Content.BackgroundColor3 = Color3.fromRGB(50, 50, 50);
                end;

                u66 = u68;
            end;

            local v73 = u71.Color:ToHex();
            Selector.Label.Text = `Chosen: <font color="#{v73}">{u70.Trait}</font>`;
        end);
    end;

    v65:Connect(Selector.Confirm.MouseButton1Click, function() -- Line: 448
        -- upvalues: u67 (ref), u64 (copy), u63 (copy), u69 (ref)
        if not u67 then
            return;
        end;

        local v74 = u64[u67];

        if not v74 then
            warn("Couldn\'t choose index:", u67);

            return;
        end;

        u63.Cache.LastChosenIndex = u67;
        u69 = v74;
    end);

    repeat
        task.wait(0.1);
    until u69 or AbilityId ~= u63.Cache.AbilityId;

    v65:Destroy();

    return u69;
end;

function u4.RerollTrait(p75, p76, p77) -- Line: 467
    -- upvalues: u1 (copy), LocalPlayer (copy)
    local v78;

    if p76 == "Shards" then
        v78 = nil;
    else
        v78 = u1:RerollTrait(LocalPlayer.Data.Ability:GetAttribute("UUID"), p77):expect();
    end;

    if typeof(v78) ~= "table" then
        if v78 == "NotEnough" then
            p75.UIEngine.NewPrompt({
                Title = "Trait Reroll Failed",
                Text = "You do not have enough Trait Rerolls to continue rerolling. Please buy more.",
                Delay = 0.5
            });

            return;
        end;

        if v78 == "Policy" then
            p75.UIEngine.NewPrompt({
                Title = "Trait Reroll Failed",
                Text = "Due to legal restrictions in your region, you are unable to purchase trait rerolls.",
                Delay = 0.5
            });
        end;

        return;
    end;

    p75.RerollSection.ResultList.Visible = #v78 > 1;

    if #v78 <= 1 then
        p75:FormatTraitCard(p75.RerolledTraitCard, v78[1]);
        p75.RerolledTraitCard.Content.Cover.Visible = false;
        p75.RerollSection.Accept.Visible = true;

        return;
    end;

    p75.Cache.LastRerollResults = v78;
    local v79 = p75:QuerySelector(v78) or v78[1];
    print(v79);
    p75:FormatTraitCard(p75.RerolledTraitCard, v79);
    p75.RerolledTraitCard.Content.Cover.Visible = false;
    p75.RerollSection.Accept.Visible = true;
end;

function u4.AcceptTrait(u80) -- Line: 512
    -- upvalues: LocalPlayer (copy), u1 (copy)
    u80.UIEngine.NewPrompt({
        Title = "Accept Trait",
        Delay = 0.5,
        Text = `Are you sure you want to accept the rolled trait? <font color="#ff6c6c">This will overwrite your current trait ({LocalPlayer.Data.Ability:GetAttribute("Trait") or "None"}) and cannot be undone</font> `,
        Options = { "Cancel", "Yes" },

        Callback = function(p81) -- Line: 521, Name: Callback
            -- upvalues: u80 (copy), u1 (ref), LocalPlayer (ref)
            u80.UIEngine:PlaySound("Click");

            if p81.Choice == 1 then
                return;
            end;

            local v82 = u80.Cache.LastChosenIndex or 1;
            u80.Cache.LastChosenIndex = nil;
            u80.Cache.LastRerollResults = nil;
            u80.RerollSection.ResultList.Visible = false;

            if u1:PickRerollTrait(LocalPlayer.Data.Ability:GetAttribute("UUID"), v82):expect() == true then
                u80.RerolledTraitCard.Content.Cover.Visible = false;
                u80.RerollSection.Accept.Visible = true;
            end;
        end
    });
end;

function u4.GetCurrentAbilityShards(p83) -- Line: 542
    local AbilityId = p83.Cache.AbilityId;
    local v84 = p83.UIEngine:CheckAbilityCrafts();

    return (type(v84) ~= "table" or not v84["ABILITY_" .. AbilityId]) and 0 or v84["ABILITY_" .. AbilityId].Shards;
end;

function u4.CloseMenu(p85) -- Line: 552
    p85.UI.Visible = false;
end;

function u4.Update(u86) -- Line: 556
    -- upvalues: LocalPlayer (copy), ItemData (copy), u1 (copy)
    local Value = LocalPlayer.Data.Ability.Value;
    u86.Cache.AbilityId = Value;
    local v87 = ItemData.GetItemInfo((`ABILITY_{Value}`));
    local v88 = "Ability";

    if type(v87.Title) == "string" then
        v88 = v87.Title;
    elseif type(v87.Prefix) == "table" then
        v88 = v87.Prefix.Name;
    elseif type(v87.Prefix) == "string" then
        v88 = v87.Prefix;
    end;

    u86:SetInfo({
        AbilityName = v87.Name,
        AbilityPrefix = v88,
        AbilityPrefixColor = ItemData.Rarities[v87.Rarity].Color,
        AbilityDescription = v87.Description
    });
    task.defer(function() -- Line: 581
        -- upvalues: u1 (ref), u86 (copy), LocalPlayer (ref)
        local v89 = u1:GetCurrentTraitInfo():expect();
        u86:FormatTraitCard(u86.CurrentTraitCard, v89);
        u86:DisplayPrices();
        u86.RerolledTraitCard.Content.Cover.Visible = true;
        u86.RerollSection.Accept.Visible = false;
        u86:UpdateCurrencies();
        u86:UpdateTraitRates();
        local v90 = u1:GetRerolledTrait(LocalPlayer.Data.Ability:GetAttribute("UUID")):expect();

        if typeof(v90) ~= "table" then
            u86.RerollSection.ResultList.Visible = false;

            return;
        end;

        u86:FormatTraitCard(u86.RerolledTraitCard, v90[u86.Cache.LastChosenIndex or 1]);
        u86.RerolledTraitCard.Content.Cover.Visible = false;
        u86.RerollSection.Accept.Visible = true;

        if #v90 > 1 then
            u86.RerollSection.ResultList.Visible = true;

            return;
        end;

        u86.RerollSection.ResultList.Visible = false;
    end);
end;

function u4.Load(u91) -- Line: 610
    -- upvalues: LocalPlayer (copy)
    u91:Update();
    u91.UI.Visible = true;

    if not LocalPlayer:GetAttribute("CanBuyPaidRandomItems") then
        u91:CloseMenu();
        u91.UIEngine:Prompt("Policy Service", u91.UIEngine.PolicyError and "An error has occurred with Roblox services, you will not be able to reroll traits with currency." or "Due to legal restrictions in your region, you are unable to reroll traits with currency.", "ok", function(p92, p93, p94) -- Line: 620
            -- upvalues: u91 (copy)
            u91.UIEngine:PlaySound("Click");
        end);
    end;
end;

return u4;
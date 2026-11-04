  

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local MarketplaceService = game:GetService("MarketplaceService");
local CollectionService = game:GetService("CollectionService");
game:GetService("RunService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local LocalPlayer = game.Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local BattlepassEventData = require(ReplicatedStorage.Shared.Configs.BattlepassEventData);
local BattlepassEventUI = ReplicatedStorage.Assets.UI.BattlepassEventUI;
local FormatNumber = require(ReplicatedStorage.Shared.FormatNumber);
local Popup = require(ReplicatedStorage.Shared.Popup);
local v1 = Knit.CreateController({
    Name = "BattlepassEventController"
});

function v1.SetXpBar(p2, p3) -- Line: 23
    local Tiers = p2.BattlepassFrame.Tiers;
    local Content = Tiers.Content;
    local Progress = Tiers.Progress;
    local Fill = Progress.Fill;

    if p3.Tier <= 0 then
        Fill.Size = UDim2.fromScale(0, 1);

        return;
    end;

    local v4 = Content:FindFirstChild((tostring(p3.Tier)));

    if not v4 then
        local v5 = 0;

        for _, child in Content:GetChildren() do
            if child:IsA("Frame") and tonumber(child.Name) then
                local v6 = tonumber(child.Name);

                if v5 < v6 then
                    v5 = v6;
                end;
            end;
        end;

        v4 = Content:FindFirstChild((tostring(v5)));

        if not v4 then
            return;
        end;
    end;

    local v7 = (1 / 0);
    local v8 = 0;
    local v9 = nil;
    local v10 = nil;

    for _, child in Content:GetChildren() do
        if child:IsA("Frame") and tonumber(child.Name) then
            local v11 = tonumber(child.Name);

            if v11 < v7 then
                v9 = child;
                v7 = v11;
            end;

            if v8 < v11 then
                v10 = child;
                v8 = v11;
            end;
        end;
    end;

    if not (v9 and v10) then
        return;
    end;

    local function getCenterX(p12) -- Line: 63
        -- upvalues: Tiers (copy)
        return p12.AbsolutePosition.X - Tiers.AbsolutePosition.X + Tiers.CanvasPosition.X + p12.AbsoluteSize.X * 0.5;
    end;

    local v13 = v9.AbsolutePosition.X - Tiers.AbsolutePosition.X + Tiers.CanvasPosition.X + v9.AbsoluteSize.X * 0.5;
    local v14 = v4.AbsolutePosition.X - Tiers.AbsolutePosition.X + Tiers.CanvasPosition.X + v4.AbsoluteSize.X * 0.5;
    local math_max_ret = math.max(1, v10.AbsolutePosition.X - Tiers.AbsolutePosition.X + Tiers.CanvasPosition.X + v10.AbsoluteSize.X * 0.5 - v13);
    local v15 = math.clamp(v14 - v13, 0, math_max_ret) / math_max_ret;
    Progress.Position = UDim2.new(0, v13, Progress.Position.Y.Scale, Progress.Position.Y.Offset);
    Progress.Size = UDim2.new(0, math_max_ret, Progress.Size.Y.Scale, Progress.Size.Y.Offset);
    Fill.Size = UDim2.fromScale(v15, 1);
end;

function v1.LoadSection(u16, p17, u18) -- Line: 82
    -- upvalues: BattlepassEventData (copy)
    for _, child in u16.BattlepassFrame.Tiers.Content:GetChildren() do
        if child:IsA("Frame") and tonumber(child.Name) then
            child:Destroy();
        end;
    end;

    local v19 = BattlepassEventData.Sections[#BattlepassEventData.Sections < p17 and #BattlepassEventData.Sections or p17];
    local v20 = v19[1];
    local v21 = v19[2];
    local v22 = BattlepassEventData.SectionRewards[v21];
    u16.BattlepassFrame.SkipTiers.Label.Text = `Tier {v21}`;

    if v22 then
        u16.BattlepassFrame.SkipTiers.Vector.Image = v22.Image or (BattlepassEventData.Icons[v22.Category or "None"] or "");
        u16.BattlepassFrame.SkipTiers.ItemName.Text = v22.Reward or "";
        local v23 = u18.Claimed.Section and table.find(u18.Claimed.Section, v21);
        local v24 = v21 <= u18.Tier;

        if v23 then
            u16.BattlepassFrame.SkipTiers.bg.Claim.Visible = true;
            u16.BattlepassFrame.SkipTiers.bg.Claim.Label.Text = "CLAIMED";
            u16.BattlepassFrame.SkipTiers.bg.Skip.Visible = false;
        else
            u16.BattlepassFrame.SkipTiers.bg.Claim.Visible = v24;
            u16.BattlepassFrame.SkipTiers.bg.Claim.Label.Text = "Claim";
            u16.BattlepassFrame.SkipTiers.bg.Skip.Visible = not v24;
        end;

        u16.BattlepassFrame.SkipTiers.bg.Skip.Label.Text = u18.Tier == v21 - 1 and "Skip" or "Skip Tiers";
    end;

    for i = v20, v21 - 1 do
        u16:CreateBPTemplate(i, u18);
        local _ = i;
    end;

    task.delay(0.1, function() -- Line: 125
        -- upvalues: u16 (copy), u18 (copy)
        u16:SetXpBar(u18);
    end);
end;

function v1.GetDisplay(p25, p26) -- Line: 130
    -- upvalues: BattlepassEventData (copy)
    if p26.Amount then
        return string.gsub(BattlepassEventData.Display[p26.Reward or (p26.RewardType or p26.Category)] or "", "=", p26.Amount);
    end;

    return BattlepassEventData.Display[p26.Reward] or BattlepassEventData.Display[p26.Category] or (p26.Display or p26.Reward);
end;

function v1.SetUpTier(u27, p28, p29, u30, u31, u32) -- Line: 138
    -- upvalues: BattlepassEventData (copy), CollectionService (copy)
    if p29.VP then
        p28.Icon.Visible = false;

        if p28:FindFirstChild("VPIcon") then
            p28.VPIcon.Visible = true;
            CollectionService:AddTag(p28.VPIcon, (`{p29.Category}Viewport`));
            p28.VPIcon:SetAttribute(p29.Category, p29.Reward);
        end;
    else
        p28.Icon.Visible = true;

        if p28:FindFirstChild("VPIcon") then
            p28.VPIcon.Visible = false;
        end;

        p28.Icon.Image = p29.Image or (BattlepassEventData.Icons[p29.Category or "None"] or "");
    end;

    if p29.ImageScale and not p28:GetAttribute("Scaled") then
        p28:SetAttribute("Scaled", true);
        p28.Icon.Size = UDim2.fromScale(p28.Icon.Size.X.Scale * p29.ImageScale, p28.Icon.Size.Y.Scale * p29.ImageScale);
    end;

    p28.Label.Text = u27:GetDisplay(p29) or "";
    p28.Claim.Activated:Connect(function() -- Line: 159
        -- upvalues: u30 (copy), u32 (copy), u31 (copy), u27 (copy)
        if u30 == "Section" then
            if u31 <= u32.Tier then
                u27.BattlepassEventService:ClaimSectionReward(u31);

                return;
            end;

            u27.BattlepassEventService:SkipBP();

            return;
        end;

        if u30 == "Section" then
            if u31 <= u32.Tier then
                u27.BattlepassEventService:ClaimSectionReward(u31);

                return;
            end;

            u27.BattlepassEventService:SkipBP();

            return;
        end;

        if (not u32.Premium or u30 ~= "Premium") and u30 ~= "Free" then
            u27.BattlepassEventService:UnlockPremium();

            return;
        end;

        if u31 <= u32.Tier then
            u27.BattlepassEventService:ClaimBattlepass(u31, u30);

            return;
        end;

        u27.BattlepassEventService:SkipBP();
    end);

    if u32.Tier + 1 == u31 then
        if u32.Premium or (u30 ~= "Premium" or u30 == "Section") then
            p28.Locked.Visible = false;
        else
            p28.Locked.Visible = true;
        end;

        p28.Claim.Visible = true;
        p28.Claim.Label.Text = "Skip";

        return;
    end;

    if u31 > u32.Tier then
        p28.Locked.Visible = true;
        p28.Claim.Visible = false;

        return;
    end;

    if u32.Premium or u30 ~= "Premium" then
        p28.Locked.Visible = false;
    else
        p28.Locked.Visible = true;
    end;

    if not p29.Category then
        p28.Claim.Visible = false;
        p28.Claimed.Visible = true;

        return;
    end;

    if table.find(u32.Claimed[u30] or (u30 == "Section" and (u32.Claimed.Section or {}) or {}), u31) then
        p28.Claim.Visible = false;
        p28.Claimed.Visible = true;

        return;
    end;

    p28.Claim.Visible = true;
    p28.Claim.Label.Text = "Claim";
end;

function v1.CreateBPTemplate(p33, p34, p35) -- Line: 218
    -- upvalues: BattlepassEventData (copy)
    local v36 = p33.TierTemplate:Clone();
    v36.Name = tostring(p34);
    v36.Frame.Tier.Text = tostring(p34);
    v36.Visible = true;
    local v37 = BattlepassEventData.SectionRewards[p34];

    if v37 then
        p33:SetUpTier(v36.Free, v37, "Section", p34, p35);
        p33:SetUpTier(v36.Premium, v37, "Section", p34, p35);
    else
        p33:SetUpTier(v36.Free, BattlepassEventData.Free[p34], "Free", p34, p35);
        p33:SetUpTier(v36.Premium, BattlepassEventData.Premium[p34], "Premium", p34, p35);
    end;

    v36.LayoutOrder = p34;
    v36.Parent = p33.BattlepassFrame.Tiers.Content;
end;

function v1.OpenPurchaseFrame(p38, p39) -- Line: 240
    p38.Sections.Purchase.Visible = true;
    p38.SkipAmount = p38.SkipAmount or 1;
    p38:UpdatePurchasePreview(p39);
end;

function v1.UpdatePurchasePreview(p40, p41) -- Line: 249
    -- upvalues: BattlepassEventData (copy), MarketplaceService (copy)
    local Purchase = p40.Sections.Purchase;
    local ScrollingFrame = Purchase.ScrollingFrame;
    local v42 = p40.SkipAmount or 1;
    Purchase.add.total.number.Text = BattlepassEventData.Tiers - p41.Tier <= v42 and "MAX" or tostring(v42);

    for _, child in ScrollingFrame:GetChildren() do
        if child:IsA("ImageLabel") then
            child.Visible = false;
        end;
    end;

    local Free = ScrollingFrame:FindFirstChild("Free");

    if not Free then
        return;
    end;

    local v43 = {};
    local v44 = {};
    local v45 = {};

    for i = 1, v42 do
        local v46 = p41.Tier + i;

        if BattlepassEventData.Tiers < v46 then
            break;
        end;

        local v47 = {};
        local v48 = BattlepassEventData.SectionRewards and BattlepassEventData.SectionRewards[v46];

        if v48 then
            table.insert(v47, v48);
        else
            local v49 = BattlepassEventData.Free[v46];

            if v49 and v49.Category then
                table.insert(v47, v49);
            end;

            if p41.Premium then
                local v50 = BattlepassEventData.Premium[v46];

                if v50 and v50.Category then
                    table.insert(v47, v50);
                end;
            end;
        end;

        local _ = i;

        for _, v in v47 do
            if v.Amount and not v.Reward then
                local Category = v.Category;

                if v43[Category] then
                    local v51 = v43[Category];
                    v51.amount = v51.amount + v.Amount;
                else
                    v43[Category] = {
                        amount = v.Amount,
                        image = BattlepassEventData.Icons[v.Category or "None"] or "",
                        category = v.Category
                    };
                    table.insert(v44, Category);
                end;
            else
                local v52 = {
                    image = v.Image or (BattlepassEventData.Icons[v.Category or "None"] or ""),
                    label = v.Reward or v.Display or (p40:GetDisplay(v) or "")
                };
                table.insert(v45, v52);
            end;
        end;
    end;

    local v53 = {};

    for _, child in ScrollingFrame:GetChildren() do
        if child:IsA("ImageLabel") then
            table.insert(v53, child);
        end;
    end;

    while #v53 < #v44 + #v45 do
        local v54 = Free:Clone();
        v54.Parent = ScrollingFrame;
        table.insert(v53, v54);
    end;

    local v55 = 0;

    for _, v in v44 do
        v55 = v55 + 1;
        local v56 = v53[v55];
        v56.Visible = true;
        v56.Icon.Image = v43[v].image;
        local v57 = BattlepassEventData.Display[v43[v].category];

        if v57 then
            v56.Label.Text = string.gsub(v57, "=", (tostring(v43[v].amount)));
        else
            v56.Label.Text = `x{v43[v].amount}`;
        end;

        v56.Claimed.Visible = false;
        v56.Claim.Visible = false;
        v56.Locked.Visible = false;
    end;

    for _, v in v45 do
        v55 = v55 + 1;
        local v58 = v53[v55];
        v58.Visible = true;
        v58.Icon.Image = v.image;
        v58.Label.Text = v.label;
        v58.Claimed.Visible = false;
        v58.Claim.Visible = false;
        v58.Locked.Visible = false;
    end;

    local u59 = BattlepassEventData.TierSkipProducts[v42];

    if u59 then
        task.spawn(function() -- Line: 366
            -- upvalues: MarketplaceService (ref), u59 (copy), Purchase (copy)
            local success, result = pcall(function() -- Line: 367
                -- upvalues: MarketplaceService (ref), u59 (ref)
                return MarketplaceService:GetProductInfo(u59, Enum.InfoType.Product);
            end);

            if success and result then
                Purchase.Buy.Label.Text = `{result.PriceInRobux}`;

                return;
            end;

            Purchase.Buy.Label.Text = "...";
        end);
    end;
end;

function v1.SetUpPurchase(u60, u61) -- Line: 379
    -- upvalues: BattlepassEventData (copy), MarketplaceService (copy), LocalPlayer (copy)
    local Purchase = u60.Sections.Purchase;
    u60.SkipAmount = 1;
    Purchase.add.plus.Activated:Connect(function() -- Line: 383
        -- upvalues: BattlepassEventData (ref), u61 (copy), u60 (copy)
        if BattlepassEventData.Tiers - u61.Tier > u60.SkipAmount then
            local v62 = u60;
            v62.SkipAmount = v62.SkipAmount + 1;
            u60:UpdatePurchasePreview(u61);
        end;
    end);
    Purchase.add.minus.Activated:Connect(function() -- Line: 391
        -- upvalues: u60 (copy), u61 (copy)
        if u60.SkipAmount > 1 then
            local v63 = u60;
            v63.SkipAmount = v63.SkipAmount - 1;
            u60:UpdatePurchasePreview(u61);
        end;
    end);
    Purchase.Buy.Activated:Connect(function() -- Line: 398
        -- upvalues: BattlepassEventData (ref), u60 (copy), MarketplaceService (ref), LocalPlayer (ref)
        local v64 = BattlepassEventData.TierSkipProducts[u60.SkipAmount];

        if v64 then
            MarketplaceService:PromptProductPurchase(LocalPlayer, v64);
        end;
    end);
    Purchase.Return.Activated:Connect(function() -- Line: 405
        -- upvalues: Purchase (copy)
        Purchase.Visible = false;
    end);
end;

function v1.SetUpQuests(u65, u66) -- Line: 410
    -- upvalues: BattlepassEventData (copy), BattlepassEventUI (copy), MarketplaceService (copy), LocalPlayer (copy), FormatNumber (copy)
    local u67 = nil;

    local function setQuestsState(p68) -- Line: 423
        -- upvalues: u67 (ref), u65 (copy)
        if u67 == p68 then
            return;
        end;

        u67 = p68;

        for _, child in u65.QuestFrame.SubSection:GetChildren() do
            if child:IsA("ImageButton") then
                child.Image = "rbxassetid://96226915523125";
                child.HoverImage = "rbxassetid://120209039319275";
            end;
        end;

        u65.QuestFrame.Timer.Visible = true;
        u65.QuestFrame.SubSection[p68].Image = "rbxassetid://85335980801620";
        u65.QuestFrame.SubSection[p68].HoverImage = "rbxassetid://102434164347136";

        for _, child in u65.QuestFrame.List.Quests:GetChildren() do
            if child:IsA("Frame") then
                if child:GetAttribute("Type") == p68 then
                    child.Visible = true;
                else
                    child.Visible = false;
                end;
            end;
        end;
    end;

    local function createQuestTemplate(u69, p70, p71, p72) -- Line: 447
        -- upvalues: BattlepassEventData (ref), BattlepassEventUI (ref), u67 (ref), u65 (copy)
        local u73 = p71 or "Daily";

        if not p72 then
            if u73 == "Weekly" then
                p72 = BattlepassEventData.WeeklyQuests[u69];
            else
                p72 = BattlepassEventData.Quests[u69];
            end;
        end;

        if not p72 then
            return;
        end;

        local v74 = BattlepassEventUI.Quests[u73 == "Daily" and "Basic" or "Seasonal"]:Clone();
        v74:SetAttribute("Type", u73);
        v74:SetAttribute("IsPremium", p70.IsPremium or false);
        v74.Name = u69 .. u73;
        v74.QuestName.Text = string.gsub(p72.Display, "X", p70.Goal);

        if p70.IsPremium then
            v74.QuestName.Text = v74.QuestName.Text .. " (PREMIUM)";
        end;

        if p70.Claimed then
            v74.Progress.Label.Text = "CLAIMED!!!";
            v74.LayoutOrder = v74.LayoutOrder + 100;
            v74.Claimed.Visible = true;
        elseif p70.Progress < p70.Goal then
            v74.Progress.Label.Text = `{p70.Progress}/{p70.Goal}`;
        else
            v74.Progress.Label.Text = "CLICK TO CLAIM";
        end;

        if u73 == u67 then
            v74.Visible = true;
        else
            v74.Visible = false;
        end;

        v74.Progress.Fill.Size = UDim2.fromScale(p70.Progress / p70.Goal, 1);
        v74.Progress.Fill.Activated:Connect(function() -- Line: 481
            -- upvalues: u65 (ref), u69 (copy), u73 (copy)
            u65.BattlepassEventService:ClaimQuest(u69, u73 == "Daily" and "DailyQuests" or "WeeklyQuests");
        end);
        v74.Parent = u65.QuestFrame.List.Quests;
    end;

    u65.MainFrame.Currency.Buy.Activated:Connect(function() -- Line: 488
        -- upvalues: u65 (copy)
        u65.BattlepassUI.Enabled = false;
        u65.CurrencyUI.Enabled = true;
    end);
    u65.CurrencyUI.Frame.Return.Activated:Connect(function() -- Line: 493
        -- upvalues: u65 (copy)
        u65.BattlepassUI.Enabled = true;
        u65.CurrencyUI.Enabled = false;
    end);
    local Tokens = u66.AdditionalEventData[BattlepassEventData.DATA_NAME].Tokens;
    u65.MainFrame.Currency.Amount.Text = Tokens;
    u65.CurrencyUI.Frame.Currency.Amount.Text = Tokens;
    u65.BattlepassEventService.UpdateTokens:Connect(function(p75) -- Line: 502
        -- upvalues: u66 (copy), BattlepassEventData (ref), u65 (copy)
        u66.AdditionalEventData[BattlepassEventData.DATA_NAME].Tokens = p75;
        u65.MainFrame.Currency.Amount.Text = p75;
        u65.CurrencyUI.Frame.Currency.Amount.Text = p75;
    end);

    for _, child in u65.CurrencyUI.Frame.Options:GetChildren() do
        if child:IsA("ImageButton") then
            child.Label.Text = string.gsub(child.Label.Text, "Turkey", BattlepassEventData.TOKEN_DISPLAY_NAME);
            task.spawn(function() -- Line: 511
                -- upvalues: MarketplaceService (ref), child (copy)
                local success, result = pcall(function() -- Line: 512
                    -- upvalues: MarketplaceService (ref), child (ref)
                    return MarketplaceService:GetProductInfo(child:GetAttribute("PurchaseID"), Enum.InfoType.Product);
                end);

                if success and result then
                    child.Buy.Label.Text = `{result.PriceInRobux}` or "[???]";
                end;
            end);
            child.Activated:Connect(function() -- Line: 520
                -- upvalues: MarketplaceService (ref), LocalPlayer (ref), child (copy)
                MarketplaceService:PromptProductPurchase(LocalPlayer, child:GetAttribute("PurchaseID"));
            end);
            child.Buy.Activated:Connect(function() -- Line: 524
                -- upvalues: MarketplaceService (ref), LocalPlayer (ref), child (copy)
                MarketplaceService:PromptProductPurchase(LocalPlayer, child:GetAttribute("PurchaseID"));
            end);
        end;
    end;

    u65.BattlepassEventService.UpdateQuest:Connect(function(p76, p77) -- Line: 529
        -- upvalues: u66 (copy), BattlepassEventData (ref), u65 (copy)
        u66.AdditionalEventData[BattlepassEventData.DATA_NAME].DailyQuests.Quests[p76] = p77;
        local v78 = u65.QuestFrame.List.Quests:FindFirstChild(p76 .. "Daily");

        if not v78 then
            return;
        end;

        if p77.Claimed then
            local Battlepass = u66.AdditionalEventData[BattlepassEventData.DATA_NAME].Battlepass;
            Battlepass.TotalXp = Battlepass.TotalXp + BattlepassEventData.XpPerDailyQuest;
            u65:SetXpBar(u66.AdditionalEventData[BattlepassEventData.DATA_NAME].Battlepass);
            v78.Progress.Label.Text = "CLAIMED!!!";
            v78.Claimed.Visible = true;
            v78.LayoutOrder = v78.LayoutOrder + 100;
        elseif p77.Progress < p77.Goal then
            v78.Progress.Label.Text = `{p77.Progress}/{p77.Goal}`;
        else
            v78.Progress.Label.Text = "CLICK TO CLAIM";
        end;

        v78.Progress.Fill.Size = UDim2.fromScale(p77.Progress / p77.Goal, 1);
    end);
    u65.BattlepassEventService.UpdateWeeklyQuest:Connect(function(p79, p80) -- Line: 549
        -- upvalues: u66 (copy), BattlepassEventData (ref), u65 (copy)
        u66.AdditionalEventData[BattlepassEventData.DATA_NAME].WeeklyQuests.Quests[p79] = p80;
        local v81 = u65.QuestFrame.List.Quests:FindFirstChild(p79 .. "Weekly");

        if not v81 then
            return;
        end;

        if p80.Claimed then
            local Battlepass = u66.AdditionalEventData[BattlepassEventData.DATA_NAME].Battlepass;
            Battlepass.TotalXp = Battlepass.TotalXp + BattlepassEventData.XpPerWeeklyQuest;
            u65:SetXpBar(u66.AdditionalEventData[BattlepassEventData.DATA_NAME].Battlepass);
            v81.Progress.Label.Text = "CLAIMED!!!";
            v81.LayoutOrder = v81.LayoutOrder + 100;
            v81.Claimed.Visible = true;
        elseif p80.Progress < p80.Goal then
            v81.Progress.Label.Text = `{p80.Progress}/{p80.Goal}`;
        else
            v81.Progress.Label.Text = "CLICK TO CLAIM";
        end;

        v81.Progress.Fill.Size = UDim2.fromScale(p80.Progress / p80.Goal, 1);
    end);
    u65.BattlepassEventService.QuestsRefreshed:Connect(function(p82, p83, p84) -- Line: 569
        -- upvalues: u66 (copy), BattlepassEventData (ref), u65 (copy), createQuestTemplate (copy), setQuestsState (copy), u67 (ref)
        u66.AdditionalEventData[BattlepassEventData.DATA_NAME].DailyQuests.Timestamp = p83;
        u66.AdditionalEventData[BattlepassEventData.DATA_NAME].DailyQuests.Quests = p82;

        for _, child in u65.QuestFrame.List.Quests:GetChildren() do
            if child:GetAttribute("Type") == "Daily" then
                child:Destroy();
            end;
        end;

        for i, v in p82 do
            createQuestTemplate(i, v, "Daily");
        end;

        setQuestsState(u67);
    end);
    u65.BattlepassEventService.WeeklyQuestsRefreshed:Connect(function(p85) -- Line: 585
        -- upvalues: u66 (copy), BattlepassEventData (ref), u65 (copy), createQuestTemplate (copy), setQuestsState (copy), u67 (ref)
        u66.AdditionalEventData[BattlepassEventData.DATA_NAME].WeeklyQuests.Quests = p85;

        for _, child in u65.QuestFrame.List.Quests:GetChildren() do
            if child:GetAttribute("Type") == "Weekly" then
                child:Destroy();
            end;
        end;

        for i, v in p85 do
            createQuestTemplate(i, v, "Weekly", BattlepassEventData.WeeklyQuests[i]);
        end;

        setQuestsState(u67);
    end);
    u65.QuestFrame.ClaimAll.Activated:Connect(function() -- Line: 600
        -- upvalues: u65 (copy)
        u65.BattlepassEventService:ClaimAll();
    end);

    if u66.AdditionalEventData[BattlepassEventData.DATA_NAME].DailyQuests.Quests then
        for i, v in u66.AdditionalEventData[BattlepassEventData.DATA_NAME].DailyQuests.Quests do
            createQuestTemplate(i, v, "Daily");
        end;
    end;

    if u66.AdditionalEventData[BattlepassEventData.DATA_NAME].WeeklyQuests.Quests then
        for i, v in u66.AdditionalEventData[BattlepassEventData.DATA_NAME].WeeklyQuests.Quests do
            createQuestTemplate(i, v, "Weekly", BattlepassEventData.WeeklyQuests[i]);
        end;
    end;

    for _, child in u65.QuestFrame.SubSection:GetChildren() do
        if child:IsA("ImageButton") then
            child.Activated:Connect(function() -- Line: 618
                -- upvalues: setQuestsState (copy), child (copy)
                setQuestsState(child.Name);
            end);
        end;
    end;

    setQuestsState("Daily");
    task.spawn(function() -- Line: 624
        -- upvalues: u66 (copy), BattlepassEventData (ref), u67 (ref), u65 (copy), FormatNumber (ref)
        while task.wait(1) do
            if u66 then
                local v86 = BattlepassEventData.DailyRefreshTime - (DateTime.now().UnixTimestamp - u66.AdditionalEventData[BattlepassEventData.DATA_NAME].DailyQuests.Timestamp);
                local math_max_ret = math.max(0, v86);
                local v87 = BattlepassEventData.WeeklyRefreshTime - (DateTime.now().UnixTimestamp - (u66.AdditionalEventData[BattlepassEventData.DATA_NAME].WeeklyQuests.Timestamp or 0));
                local math_max_ret2 = math.max(0, v87);

                if u67 == "Weekly" then
                    math_max_ret = math_max_ret2;
                end;

                u65.QuestFrame.Timer.Text = `Refresh in: {FormatNumber.AdaptiveClockString(math_max_ret)}`;
                local Attribute = workspace:GetAttribute("BattlepassEndTime");

                if Attribute then
                    local v88 = Attribute - workspace:GetServerTimeNow();
                    local v89 = v88 < 0 and "ENDING SOON" or FormatNumber.AdaptiveClockString(v88);
                    u65.BPButton.Fade.Timer.Text = v89;
                else
                    u65.BPButton.Fade.Timer.Text = "LOADING";
                end;
            end;
        end;
    end);
end;

function v1.SetUpBP(u90, p91) -- Line: 642
    -- upvalues: BattlepassEventData (copy), MarketplaceService (copy), LocalPlayer (copy), Popup (copy)
    local Battlepass = p91.AdditionalEventData[BattlepassEventData.DATA_NAME].Battlepass;
    u90.BattlepassFrame.SkipTiers.bg.Claim.Activated:Connect(function() -- Line: 645
        -- upvalues: Battlepass (copy), BattlepassEventData (ref), u90 (copy)
        local CurrentSection = Battlepass.CurrentSection;

        if #BattlepassEventData.Sections < CurrentSection then
            return;
        end;

        u90.BattlepassEventService:ClaimSectionReward(BattlepassEventData.Sections[CurrentSection][2]);
    end);
    u90.BattlepassFrame.SkipTiers.bg.Skip.Activated:Connect(function() -- Line: 652
        -- upvalues: Battlepass (copy), BattlepassEventData (ref), MarketplaceService (ref), LocalPlayer (ref), u90 (copy)
        local CurrentSection = Battlepass.CurrentSection;

        if #BattlepassEventData.Sections < CurrentSection then
            return;
        end;

        if Battlepass.Tier == BattlepassEventData.Sections[CurrentSection][2] - 1 then
            local v92 = BattlepassEventData.TierSkipProducts[1];

            if v92 then
                MarketplaceService:PromptProductPurchase(LocalPlayer, v92);
            end;
        else
            u90:OpenPurchaseFrame(Battlepass);
        end;
    end);
    u90.BattlepassEventService.ClaimedBattlepass:Connect(function(p93, p94) -- Line: 666
        -- upvalues: Popup (ref), Battlepass (copy), u90 (copy)
        Popup.Popup(nil, (`Claimed tier {p93} of {p94} battle pass rewards!`));

        if p94 ~= "Section" then
            if not table.find(Battlepass.Claimed[p94], p93) then
                table.insert(Battlepass.Claimed[p94], p93);
            end;

            local v95 = u90.BattlepassFrame.Tiers.Content:FindFirstChild((tostring(p93)));

            if v95 then
                local v96 = v95[p94];
                v96.Claim.Visible = false;
                v96.Claimed.Visible = true;
            end;

            return;
        end;

        if not Battlepass.Claimed.Section then
            Battlepass.Claimed.Section = {};
        end;

        if not table.find(Battlepass.Claimed.Section, p93) then
            table.insert(Battlepass.Claimed.Section, p93);
        end;

        u90.BattlepassFrame.SkipTiers.bg.Claim.Visible = true;
        u90.BattlepassFrame.SkipTiers.bg.Claim.Label.Text = "CLAIMED";
        u90.BattlepassFrame.SkipTiers.bg.Skip.Visible = false;
    end);
    u90.BattlepassEventService.TierUp:Connect(function(p97, p98) -- Line: 694
        -- upvalues: Battlepass (copy), u90 (copy), BattlepassEventData (ref), Popup (ref)
        Battlepass.Tier = p97;
        Battlepass.TotalXp = p98;
        u90:SetXpBar(Battlepass);

        if u90.Sections.Purchase.Visible then
            if BattlepassEventData.Tiers <= p97 then
                u90.Sections.Purchase.Visible = false;
            else
                u90.SkipAmount = 1;
                u90:UpdatePurchasePreview(Battlepass);
            end;
        end;

        Popup.Popup(nil, (`Tiered up in battlepass to tier {p97}!`));
        u90.BattlepassFrame.SkipTiers.Label.Text = `Tiers {BattlepassEventData.Sections[Battlepass.CurrentSection][1]}-{BattlepassEventData.Sections[Battlepass.CurrentSection][2]}`;
        local v99 = u90.BattlepassFrame.Tiers.Content:FindFirstChild((tostring(p97)));

        if v99 then
            u90:SetUpTier(v99.Free, BattlepassEventData.Free[p97], "Free", p97, Battlepass);
            u90:SetUpTier(v99.Premium, BattlepassEventData.Premium[p97], "Premium", p97, Battlepass);
        end;

        local v100 = u90.BattlepassFrame.Tiers.Content:FindFirstChild((tostring(p97 + 1)));

        if v100 then
            u90:SetUpTier(v100.Free, BattlepassEventData.Free[p97 + 1], "Free", p97 + 1, Battlepass);
            u90:SetUpTier(v100.Premium, BattlepassEventData.Premium[p97 + 1], "Premium", p97 + 1, Battlepass);
        end;

        local CurrentSection = Battlepass.CurrentSection;

        if CurrentSection <= #BattlepassEventData.Sections then
            local v101 = BattlepassEventData.Sections[CurrentSection][2];

            if v101 <= p97 then
                local v102 = Battlepass.Claimed.Section and table.find(Battlepass.Claimed.Section, v101);
                u90.BattlepassFrame.SkipTiers.bg.Claim.Visible = not v102;
                u90.BattlepassFrame.SkipTiers.bg.Skip.Visible = false;

                return;
            end;

            if p97 == v101 - 1 then
                u90.BattlepassFrame.SkipTiers.bg.Skip.Label.Text = "Skip";
            end;
        end;
    end);
    u90.BattlepassEventService.PremiumUnlocked:Connect(function() -- Line: 742
        -- upvalues: Battlepass (copy), u90 (copy)
        Battlepass.Premium = true;
        u90:LoadSection(Battlepass.CurrentSection, Battlepass);
        u90.BattlepassFrame.Premiumbuy.premium.Buy.Label.Text = "BOUGHT";
        u90.BattlepassFrame.Premiumbuy["premium+"].Buy.Label.Text = "BOUGHT";
    end);
    u90.BattlepassEventService.SectionAdvanced:Connect(function(p103) -- Line: 749
        -- upvalues: Battlepass (copy), u90 (copy)
        Battlepass.CurrentSection = p103;
        u90:LoadSection(p103, Battlepass);
        u90.BattlepassFrame.Tiers.CanvasPosition = Vector2.new(0, 0);
    end);
    u90.BattlepassFrame.Premiumbuy.premium.Buy.Activated:Connect(function() -- Line: 755
        -- upvalues: Battlepass (copy), u90 (copy)
        if Battlepass.Premium then
            return;
        end;

        u90.BattlepassEventService:UnlockPremium();
    end);
    u90.BattlepassFrame.Premiumbuy["premium+"].Buy.Activated:Connect(function() -- Line: 760
        -- upvalues: Battlepass (copy), u90 (copy)
        if Battlepass.Premium then
            return;
        end;

        u90.BattlepassEventService:UnlockPremiumPlus();
    end);
    task.spawn(function() -- Line: 765
        -- upvalues: MarketplaceService (ref), BattlepassEventData (ref), Battlepass (copy), u90 (copy)
        local success, result = pcall(function() -- Line: 766
            -- upvalues: MarketplaceService (ref), BattlepassEventData (ref)
            return MarketplaceService:GetProductInfo(BattlepassEventData.PremiumId, Enum.InfoType.Product);
        end);

        if success and (result and not Battlepass.Premium) then
            u90.BattlepassFrame.Premiumbuy.premium.Buy.Label.Text = `{result.PriceInRobux}` or "[???]";
        elseif Battlepass.Premium then
            u90.BattlepassFrame.Premiumbuy.premium.Buy.Label.Text = "BOUGHT";
        end;

        local success2, result2 = pcall(function() -- Line: 775
            -- upvalues: MarketplaceService (ref), BattlepassEventData (ref)
            return MarketplaceService:GetProductInfo(BattlepassEventData.PremiumPlusId, Enum.InfoType.Product);
        end);

        if success2 and (result2 and not Battlepass.Premium) then
            u90.BattlepassFrame.Premiumbuy["premium+"].Buy.Label.Text = `{result2.PriceInRobux}` or "[???]";

            return;
        end;

        if Battlepass.Premium then
            u90.BattlepassFrame.Premiumbuy["premium+"].Buy.Label.Text = "BOUGHT";
        end;
    end);
    u90:LoadSection(Battlepass.CurrentSection, Battlepass);
    u90:SetUpPurchase(Battlepass);
end;

function v1.KnitStart(u104) -- Line: 789
    -- upvalues: BattlepassEventData (copy), PlayerGui (copy), Knit (copy), LocalPlayer (copy)
    if not BattlepassEventData.Enabled then
        return;
    end;

    u104.BattlepassUI = PlayerGui:WaitForChild("BattlepassEvent");
    u104.CurrencyUI = PlayerGui:WaitForChild("BattlepassBuyCurrency");
    u104.BPButton = PlayerGui:WaitForChild("HUD"):WaitForChild("BundleButtons"):WaitForChild("Battlepass");
    u104.MainFrame = u104.BattlepassUI:WaitForChild("Frame");
    u104.Sections = u104.MainFrame:WaitForChild("Sections");
    u104.QuestFrame = u104.Sections:WaitForChild("Quests");
    u104.BattlepassFrame = u104.Sections:WaitForChild("Pass");
    u104.CratesFrame = u104.Sections:WaitForChild("Crates");
    u104.TierTemplate = u104.BattlepassUI:WaitForChild("BattlepassTier");
    u104.BattlepassEventService = Knit.GetService("BattlepassEventService");
    u104.UIController = Knit.GetController("UIController");
    PlayerGui:WaitForChild("PickTeam"):GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 806
        -- upvalues: LocalPlayer (ref), u104 (copy)
        if LocalPlayer.PlayerGui.PickTeam.Enabled then
            u104.CurrencyUI.Enabled = false;
        end;
    end);
    u104.QuestFrame.SubSection.Basic.Name = "Daily";
    u104.QuestFrame.SubSection.Seasonal.Name = "Weekly";
    u104.MainFrame.Close.Activated:Connect(function() -- Line: 815
        -- upvalues: u104 (copy)
        u104.BattlepassUI.Enabled = false;
        u104.Sections.Purchase.Visible = false;
    end);
    u104.BPButton.Activated:Connect(function() -- Line: 820
        -- upvalues: u104 (copy)
        u104.BattlepassUI.Enabled = not u104.BattlepassUI.Enabled;
    end);
    task.spawn(function() -- Line: 825
        -- upvalues: u104 (copy)
        local BattlepassNPC = workspace:WaitForChild("GameObjects"):WaitForChild("LobbyNPCs"):WaitForChild("BattlepassNPC", 10);

        if BattlepassNPC then
            local HumanoidRootPart = BattlepassNPC:WaitForChild("HumanoidRootPart", 5);
            local v105 = HumanoidRootPart and HumanoidRootPart:WaitForChild("ProximityPrompt", 5);

            if v105 then
                v105.Triggered:Connect(function() -- Line: 833
                    -- upvalues: u104 (ref)
                    u104.BattlepassUI.Enabled = true;
                end);
            end;
        end;
    end);
    local Data = u104.BattlepassEventService:GetData();

    while Data == nil do
        Data = u104.BattlepassEventService:GetData();
        task.wait(0.25);
    end;

    u104:SetUpQuests(Data);
    u104:SetUpBP(Data);
    local u106 = {
        Pass = {},
        Crates = {},
        Quests = {}
    };
    local u107 = {
        Pass = {},
        Crates = {},
        Quests = {}
    };
    local u108 = nil;

    for _, child in u104.MainFrame.TopBtns:GetChildren() do
        if child:IsA("ImageButton") then
            u106[child.Name].Image = child.Image;
            u106[child.Name].HoverImage = child.HoverImage;
            u106[child.Name].ImageColor = Color3.new(1, 1, 1);
            u106[child.Name].StrokeColor = Color3.fromRGB(0, 0, 0);
            u106[child.Name].TextColor = Color3.new(1, 1, 1);
            u107[child.Name].Image = child.Image;
            u107[child.Name].HoverImage = child.HoverImage;
            u107[child.Name].ImageColor = Color3.new(0.443137, 0.443137, 0.443137);
            u107[child.Name].StrokeColor = Color3.fromRGB(0, 0, 0);
            u107[child.Name].TextColor = Color3.new(1, 1, 1);
        end;
    end;

    local function changeButton(p109) -- Line: 886
        -- upvalues: u108 (ref), u104 (copy), u106 (copy), u107 (copy)
        u108 = p109;

        for _, child in u104.MainFrame.TopBtns:GetChildren() do
            if child:IsA("ImageButton") then
                child.HoverImage = u106[child.Name].HoverImage;
                child.Image = u106[child.Name].Image;
                child.ImageColor3 = u106[child.Name].ImageColor;
                child.Label.TextColor3 = u106[child.Name].TextColor;
                child.Label.UIStroke.Color = u106[child.Name].StrokeColor;
            end;
        end;

        p109.HoverImage = u107[p109.Name].HoverImage;
        p109.Image = u107[p109.Name].Image;
        p109.ImageColor3 = u107[p109.Name].ImageColor;
        p109.Label.TextColor3 = u107[p109.Name].TextColor;
        p109.Label.UIStroke.Color = u107[p109.Name].StrokeColor;
    end;

    local function enableFrame(p110) -- Line: 878
        -- upvalues: u104 (copy)
        for _, child in u104.MainFrame.Sections:GetChildren() do
            if child:IsA("Frame") then
                child.Visible = false;
            end;
        end;

        p110.Visible = true;
    end;

    for _, child in u104.MainFrame.TopBtns:GetChildren() do
        if child:IsA("ImageButton") then
            child.Activated:Connect(function() -- Line: 907
                -- upvalues: u108 (ref), child (copy), changeButton (copy), enableFrame (copy), u104 (copy)
                if u108 == child then
                    return;
                end;

                changeButton(child);
                enableFrame(u104.MainFrame.Sections[child.Name]);
            end);
        end;
    end;

    changeButton(u104.MainFrame.TopBtns.Pass);
    enableFrame(u104.MainFrame.Sections.Pass);
end;

return v1;
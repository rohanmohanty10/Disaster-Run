  

 

return function(u1) -- Line: 1
    u1.Knit.GetService("ShopService");
    require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").ItemData);
    require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").Stands);
    local Monetization = game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("Monetization");
    u1.Knit.GetService("InventoryService");
    local u2 = u1.Knit.GetService("ShopService");
    require(u1.KnitPath.Trove);
    local MarketplaceService = game:GetService("MarketplaceService");
    local _ = game:GetService("Players").LocalPlayer;
    local SponsoredAssets = require(Monetization:WaitForChild("SponsoredAssets"));
    local u3 = u2:GetSponsoredAssets():expect();
    local u4 = SponsoredAssets.GetAssets();
    local Parent = script.Parent;
    local Assets = Parent.Assets;
    local BonusList = Parent.BonusList;
    local u5 = {};
    local ContainerSponsored = Assets:WaitForChild("ContainerSponsored");
    local u6 = {
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
    local u7 = {};

    local function FetchAssetData(u8) -- Line: 43
        -- upvalues: u7 (copy), MarketplaceService (copy), u4 (copy)
        local v9 = u7[u8];

        if v9 then
            return v9;
        end;

        local success, result = pcall(function() -- Line: 46
            -- upvalues: MarketplaceService (ref), u8 (copy)
            return MarketplaceService:GetProductInfo(u8);
        end);

        if not success then
            return false;
        end;

        if result.IsForSale ~= true or result.CanBeSoldInThisGame ~= true and not table.find(u4, u8) then
            return false;
        end;

        local v10 = {
            Price = result.PriceInRobux,
            Name = result.Name,
            CreatorName = result.Creator.Name,
            Image = `rbxthumb://type=Asset&id={u8}&w=420&h=420`,
            Remaining = result.Remaining or nil,
            Sales = result.Sales or nil
        };
        u7[u8] = v10;
        task.delay(120, function() -- Line: 62
            -- upvalues: u7 (ref), u8 (copy)
            u7[u8] = nil;
        end);

        return v10;
    end;

    local function DisplaySponsorPrompt(p11) -- Line: 69
        -- upvalues: FetchAssetData (copy), SponsoredAssets (copy), BonusList (copy), u6 (copy), u1 (copy), Assets (copy)
        local v12 = FetchAssetData(p11);

        if not v12 then
            return;
        end;

        local v13 = SponsoredAssets.GetBonusesForAsset(p11);
        local Benefits = BonusList.Benefits;
        local ContainerSponsored2 = BonusList.ContainerSponsored;
        ContainerSponsored2.ItemName.Text = v12.Name;
        ContainerSponsored2.CreatorName.Text = v12.CreatorName;
        ContainerSponsored2.Price.Cost.Text = v12.Price;
        ContainerSponsored2.Image.Image = v12.Image;
        ContainerSponsored2.Shadow.Image = v12.Image;

        if v12.Remaining == nil then
            ContainerSponsored2.Available.Count.Text = "∞ / ∞";
        else
            ContainerSponsored2.Available.Count.Text = `{tostring(v12.Remaining)} / {tostring(v12.Remaining + v12.Sales)}`;
        end;

        for _, child in Benefits:GetChildren() do
            if child:IsA("Frame") then
                child:Destroy();
            end;
        end;

        if v13 and v13.Items then
            for i, v in v13.Items do
                local v14;

                if u6[i] then
                    v14 = u6[i].String;
                else
                    v14 = u1:GetItemText(i);
                end;

                local v15 = Benefits:FindFirstChild(i) or Assets.Entry:Clone();
                v15.NameLabel.Text = v14;
                v15.AmountLabel.Text = v;
                v15.Name = i;
                v15.Visible = true;
                v15.Parent = Benefits;
            end;
        end;

        local v16;

        if v13 and v13.UPointsMultiplier then
            v16 = v12.Price * v13.UPointsMultiplier;
        else
            v16 = v12.Price * 2;
        end;

        local PremiumCurrencyString = u1.PremiumCurrencyString;
        local v17 = Benefits:FindFirstChild("UP") or Assets.Entry:Clone();
        v17.NameLabel.Text = `<font color="#ffc800">{PremiumCurrencyString}</font>`;

        if v13 and v13.UPointsFlat then
            v16 = v13.UPointsFlat;
        end;

        v17.AmountLabel.Text = v16;
        v17.Name = "UP";
        v17.Visible = true;
        v17.Parent = Benefits;
        BonusList:SetAttribute("AssetId", p11);
        BonusList.Visible = true;
    end;

    local function Display(p18) -- Line: 121
        -- upvalues: u5 (copy), FetchAssetData (copy), Parent (copy), ContainerSponsored (copy), DisplaySponsorPrompt (copy)
        for i, v in u5 do
            if not table.find(p18, i) then
                v:Destroy();
                u5[i] = nil;
            end;
        end;

        for _, v in p18 do
            local v19 = FetchAssetData(v);

            if v19 and not Parent.Items:FindFirstChild(v) then
                local v20 = ContainerSponsored:Clone();
                v20.ItemName.Text = v19.Name;
                v20.CreatorName.Text = v19.CreatorName;
                v20.Price.Cost.Text = v19.Price;
                v20.Image.Image = v19.Image;
                v20.Shadow.Image = v19.Image;
                v20.Parent = Parent.Items;
                v20.Visible = true;
                v20.Name = v;
                u5[v] = v20;
                v20.InputBegan:Connect(function(p21) -- Line: 146
                    -- upvalues: DisplaySponsorPrompt (ref), v (copy)
                    if p21.UserInputType == Enum.UserInputType.MouseButton1 or p21.UserInputType == Enum.UserInputType.Touch then
                        DisplaySponsorPrompt(v);
                    end;
                end);
            end;
        end;
    end;

    Display(u3);
    BonusList.Yes.InputBegan:Connect(function(p22) -- Line: 156
        -- upvalues: BonusList (copy), u2 (copy)
        if p22.UserInputType == Enum.UserInputType.MouseButton1 or p22.UserInputType == Enum.UserInputType.Touch then
            local v23 = BonusList:GetAttribute("AssetId");

            if not v23 then
                return;
            end;

            print(u2:PurchaseSponsoredItem(v23):expect());
            BonusList.Visible = false;
        end;
    end);
    BonusList.No.InputBegan:Connect(function(p24) -- Line: 165
        -- upvalues: BonusList (copy)
        if p24.UserInputType == Enum.UserInputType.MouseButton1 or p24.UserInputType == Enum.UserInputType.Touch then
            BonusList:SetAttribute("AssetId", nil);
            BonusList.Visible = false;
        end;
    end);
    u1.BindToClock("RefreshSponsored", 5, "PreRender", function() -- Line: 172
        -- upvalues: u3 (ref), u2 (copy), Display (copy)
        u3 = u2:GetSponsoredAssets():expect();
        Display(u3);
    end);
end;
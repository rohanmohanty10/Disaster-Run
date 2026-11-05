  

 

return function(u1) -- Line: 1
    local IsPublicTesting = require(game.ReplicatedStorage:WaitForChild("ReplicatedRoot").Core).Flags.IsPublicTesting;
    local LocalPlayer = game.Players.LocalPlayer;
    local MarketplaceService = game:GetService("MarketplaceService");
    local Parent = script.Parent;
    local PlayerList = Parent.Parent.PlayerList;
    local Assets = Parent.Assets;
    local ProductFrame = Assets.ProductFrame;
    local ProductInfo = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").ProductInfo);
    require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").ItemData);
    local u2 = u1.Knit.GetService("ShopService");
    local u3 = {
        {
            Name = "200uP",
            ProductName = "200uP",
            Text = `200 {u1.PremiumCurrencyString}`,
            Frame = Assets.UPointsFrame,
            Parent = script.Parent.A.Currency
        },
        {
            Name = "400uP",
            ProductName = "400uP",
            Text = `400 {u1.PremiumCurrencyString}`,
            Frame = Assets.UPointsFrame,
            Parent = script.Parent.A.Currency
        },
        {
            Name = "800uP",
            ProductName = "800uP",
            Text = `800 {u1.PremiumCurrencyString}`,
            Frame = Assets.UPointsFrame,
            Parent = script.Parent.A.Currency
        },
        {
            Name = "1600uP",
            ProductName = "1600uP",
            Text = `1600 (+ 160) {u1.PremiumCurrencyString}`,
            Frame = Assets.UPointsFrame,
            Parent = script.Parent.A.Currency
        },
        {
            Name = "3200uP",
            ProductName = "3200uP",
            Text = `3200 (+ 320) {u1.PremiumCurrencyString} <font color="#44FF00">+ 1 uF</font>`,
            Frame = Assets.UPointsFrame,
            Parent = script.Parent.A.Currency
        },
        {
            Name = "6400uP",
            ProductName = "6400uP",
            Text = `6400 (+ 640) {u1.PremiumCurrencyString} <font color="#44FF00">+ 2 uF</font>`,
            Frame = Assets.UPointsFrame,
            Parent = script.Parent.A.Currency
        },
        {
            Name = "1mUCoins",
            Text = "1m uCoins",
            ProductName = "1mUCoins",
            Frame = Assets.UCoinsFrame,
            Parent = script.Parent.B.Slots
        },
        {
            Name = "5mUCoins",
            Text = "5m uCoins",
            ProductName = "5mUCoins",
            Frame = Assets.UCoinsFrame,
            Parent = script.Parent.B.Slots
        },
        {
            Name = "10mUCoins",
            Text = "10m uCoins",
            ProductName = "10mUCoins",
            Frame = Assets.UCoinsFrame,
            Parent = script.Parent.B.Slots
        },
        {
            Name = "HakiColorReroll",
            Text = "Reroll Haki Color Item",
            ProductName = "HakiColorReroll",
            Parent = script.Parent.C.Other
        },
        {
            Name = "SkinSlot",
            Text = "+1 Skin Slot",
            ProductName = "SkinSlot",
            Parent = script.Parent.C.Other
        },
        {
            Name = "BankSlot",
            Text = "+1 Bank Slot",
            ProductName = "BankSlot",
            Parent = script.Parent.C.Other
        },
        {
            Name = "AbilitySlot",
            Text = "+1 Ability Slot",
            ProductName = "StandSlot",
            Parent = script.Parent.C.Other
        },
        {
            Name = "DoubleUCoins",
            Text = "2x UCoins (1 Hour)",
            ProductName = "DoubleUCoins",
            Parent = script.Parent.C.Other
        },
        {
            Name = "DoubleUShards",
            Text = "2x UShards (1 Hour)",
            ProductName = "DoubleUShards",
            Parent = script.Parent.C.Other
        },
        {
            Name = "DoubleXP",
            Text = "2x XP (1 Hour)",
            ProductName = "DoubleXP",
            Parent = script.Parent.C.Other
        },
        {
            Name = "DoubleTraitPity",
            Text = "2x Trait Pity (1 Hour)",
            ProductName = "DoubleTraitPity",
            Parent = script.Parent.C.Other
        }
    };
    local u4 = {};

    local function ClearPlayerList() -- Line: 147
        -- upvalues: u4 (copy)
        for _, v in u4 do
            v:Destroy();
        end;
    end;

    local function CreateContainer(u5, u6) -- Line: 153
        -- upvalues: Assets (copy), u4 (copy), u1 (copy), u2 (copy), MarketplaceService (copy), PlayerList (copy)
        local v7 = Assets.PlayerFrame:Clone();
        u4[u5.Name] = v7;
        v7.Username.Text = "@" .. u5.Name;
        v7.DisplayName.Text = u5.DisplayName;
        v7.Gift.MouseButton1Click:Connect(function() -- Line: 159
            -- upvalues: u1 (ref), u2 (ref), u5 (copy), MarketplaceService (ref), u6 (copy)
            u1:SetShopTab("Back");

            if u2:SetGiftUserId(u5.UserId):expect() then
                MarketplaceService:PromptProductPurchase(u1.Player, u6);

                return;
            end;

            u1.NewPrompt({
                Title = "Gift Failed",
                Text = "An error occurred when trying to gift product, please retry"
            });
        end);
        v7.Visible = true;
        v7.Parent = PlayerList;
    end;

    for i, v in ipairs(u3) do
        local u8 = (v.Frame or ProductFrame):Clone();
        u8.Title.Text = v.Text;
        u8.Name = v.Name;
        u8.LayoutOrder = v.LayoutOrder or (i or u8.LayoutOrder);
        u8.Visible = true;
        u8.Parent = v.Parent;
        local u9 = ProductInfo.Products[v.ProductName];

        if u9 then
            v.ProductId = u9;
            task.spawn(function() -- Line: 188
                -- upvalues: MarketplaceService (copy), u9 (copy), u8 (copy), IsPublicTesting (copy), u2 (copy), u1 (copy), v (copy), u4 (copy), LocalPlayer (copy), CreateContainer (copy)
                local u10 = nil;
                local v11 = 5;

                while not u10 do
                    pcall(function() -- Line: 192
                        -- upvalues: u10 (ref), MarketplaceService (ref), u9 (ref)
                        u10 = MarketplaceService:GetProductInfo(u9, Enum.InfoType.Product);
                    end);
                    v11 = v11 - 1;

                    if not u10 then
                        task.wait(1);
                    end;
                end;

                if not u10 then
                    u8:Destroy();

                    return;
                end;

                u8.Price.Text = `{u10.PriceInRobux} `;
                u8.Purchase.MouseButton1Down:Connect(function() -- Line: 203
                    -- upvalues: IsPublicTesting (ref), u2 (ref), u1 (ref), v (ref), MarketplaceService (ref), u9 (ref), u4 (ref), LocalPlayer (ref), CreateContainer (ref)
                    if IsPublicTesting then
                        return;
                    end;

                    u2:SetGiftUserId(nil);
                    u1.NewPrompt({
                        Text = "Select which purchase type",
                        RichTextTitle = true,
                        Delay = 1,
                        Title = v.Text,
                        Options = { "Purchase for Self", "Gift Product" },

                        Callback = function(p12) -- Line: 219, Name: Callback
                            -- upvalues: MarketplaceService (ref), u1 (ref), u9 (ref), u4 (ref), LocalPlayer (ref), CreateContainer (ref)
                            if p12.Choice == 1 then
                                MarketplaceService:PromptProductPurchase(u1.Player, u9);

                                return;
                            end;

                            if p12.Choice == 2 then
                                for _, v2 in u4 do
                                    v2:Destroy();
                                end;

                                for _, v2 in ipairs(game.Players:GetPlayers()) do
                                    if v2 ~= LocalPlayer then
                                        CreateContainer(v2, u9);
                                    end;
                                end;

                                u1:SetShopTab("PlayerList");
                            end;
                        end
                    });
                    u1:PlaySound("Click");
                end);
            end);
        else
            u8:Destroy();
        end;
    end;

    Parent.CanvasSize = UDim2.fromOffset(0, Parent.UIListLayout.AbsoluteContentSize.Y + 100);
    MarketplaceService.PromptProductPurchaseFinished:Connect(function(p13, p14, p15) -- Line: 241
        -- upvalues: LocalPlayer (copy), u2 (copy)
        if p13 ~= LocalPlayer.UserId then
            return;
        end;

        u2:SetGiftUserId(nil);
    end);
    local TextChatService = game:GetService("TextChatService");
    u2.Signal:Connect(function(p16, p17) -- Line: 248
        -- upvalues: u3 (copy), TextChatService (copy)
        if p16 == "ProductGifted" then
            local ProductId = p17.ProductId;
            local v18 = nil;

            for _, v in u3 do
                if v.ProductId == ProductId then
                    v18 = v;
                    break;
                end;
            end;

            if not v18 then
                return;
            end;

            local v19 = `@{p17.Gifter.Name} HAS GIFTED [{v18.Text}] TO @{p17.Receiver.Name}`;
            TextChatService.TextChannels.RBXGeneral:DisplaySystemMessage(v19);
        end;
    end);
end;
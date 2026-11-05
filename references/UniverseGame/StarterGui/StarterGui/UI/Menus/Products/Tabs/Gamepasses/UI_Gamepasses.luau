  

 

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
            Name = "Item Notifier",
            Text = "Item Notifier",
            ProductName = "Item Notifier",
            Parent = script.Parent.A.Slots
        },
        {
            Name = "Smart Assistant",
            Text = "Smart Assistant",
            ProductName = "Smart Assistant",
            Parent = script.Parent.A.Slots
        },
        {
            Name = "Emote Pack",
            Text = "Emote Pack 1",
            ProductName = "Emote Pack",
            Parent = script.Parent.B.Slots
        },
        {
            Name = "Emote Pack v2",
            Text = "Emote Pack 2",
            ProductName = "Emote Pack v2",
            Parent = script.Parent.B.Slots
        },
        {
            Name = "Emote Pack v3",
            Text = "Emote Pack 3",
            ProductName = "Emote Pack v3",
            Parent = script.Parent.B.Slots
        },
        {
            Name = "Emote Pack v4",
            Text = "Emote Pack 4",
            ProductName = "Emote Pack v4",
            Parent = script.Parent.B.Slots
        },
        {
            Name = "Emote Pack v5",
            Text = "Emote Pack 5",
            ProductName = "Emote Pack v5",
            Parent = script.Parent.B.Slots
        },
        {
            Name = "Emote Pack v6",
            Text = "JJK Emote Pack",
            ProductName = "Emote Pack v6",
            Parent = script.Parent.B.Slots
        },
        {
            Name = "Emote Pack v7",
            Text = "Community Emote Pack",
            ProductName = "Emote Pack v7",
            Parent = script.Parent.B.Slots
        },
        {
            Name = "Donation",
            Text = "Donation",
            ProductName = "Donation",
            Parent = script.Parent.C.Slots
        }
    };
    local u4 = {};

    local function ClearPlayerList() -- Line: 90
        -- upvalues: u4 (copy)
        for _, v in u4 do
            v:Destroy();
        end;
    end;

    local function CreateContainer(u5, u6, u7) -- Line: 96
        -- upvalues: Assets (copy), u4 (copy), u1 (copy), u2 (copy), MarketplaceService (copy), PlayerList (copy)
        local v8 = Assets.PlayerFrame:Clone();
        u4[u5.Name] = v8;
        v8.Username.Text = "@" .. u5.Name;
        v8.DisplayName.Text = u5.DisplayName;
        v8.Gift.MouseButton1Click:Connect(function() -- Line: 102
            -- upvalues: u1 (ref), u2 (ref), u5 (copy), u7 (copy), MarketplaceService (ref), u6 (copy)
            u1:SetShopTab("Back");

            if u2:OwnsGamepass(u5.UserId, u7):expect() then
                u1.NewPrompt({
                    Title = "Gift Failed",
                    Text = "User already owns gamepass"
                });

                return;
            end;

            if u2:SetGiftUserId(u5.UserId):expect() then
                MarketplaceService:PromptProductPurchase(u1.Player, u6);

                return;
            end;

            u1.NewPrompt({
                Title = "Gift Failed",
                Text = "An error occurred when trying to gift product, please retry"
            });
        end);
        v8.Visible = true;
        v8.Parent = PlayerList;
    end;

    for i, v in u3 do
        local u9 = (v.Frame or ProductFrame):Clone();
        u9.Title.Text = v.Text;
        u9.Name = v.Name;
        u9.LayoutOrder = v.LayoutOrder or (i or u9.LayoutOrder);
        u9.Visible = true;
        u9.Parent = v.Parent;
        local u10 = ProductInfo.Gamepasses[v.ProductName];
        local u11 = ProductInfo.Products[v.ProductName];

        if u10 then
            v.ProductId = u10;
            v.GiftProductId = u11;
            task.spawn(function() -- Line: 143
                -- upvalues: MarketplaceService (copy), u10 (copy), u9 (copy), IsPublicTesting (copy), u2 (copy), u1 (copy), v (copy), u4 (copy), LocalPlayer (copy), CreateContainer (copy), u11 (copy)
                local u12 = nil;
                local v13 = 5;

                while not u12 do
                    pcall(function() -- Line: 147
                        -- upvalues: u12 (ref), MarketplaceService (ref), u10 (ref)
                        u12 = MarketplaceService:GetProductInfo(u10, Enum.InfoType.GamePass);
                    end);
                    v13 = v13 - 1;

                    if not u12 then
                        task.wait(1);
                    end;
                end;

                if not u12 then
                    u9:Destroy();

                    return;
                end;

                u9.Price.Text = `{u12.PriceInRobux} R$`;
                u9.Purchase.MouseButton1Down:Connect(function() -- Line: 158
                    -- upvalues: IsPublicTesting (ref), u2 (ref), u1 (ref), v (ref), MarketplaceService (ref), u10 (ref), u4 (ref), LocalPlayer (ref), CreateContainer (ref), u11 (ref)
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

                        Callback = function(p14) -- Line: 174, Name: Callback
                            -- upvalues: MarketplaceService (ref), u1 (ref), u10 (ref), u4 (ref), LocalPlayer (ref), CreateContainer (ref), u11 (ref)
                            if p14.Choice == 1 then
                                MarketplaceService:PromptGamePassPurchase(u1.Player, u10);

                                return;
                            end;

                            if p14.Choice == 2 then
                                for _, v2 in u4 do
                                    v2:Destroy();
                                end;

                                for _, v2 in game.Players:GetPlayers() do
                                    if v2 ~= LocalPlayer then
                                        CreateContainer(v2, u11, u10);
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
            u9:Destroy();
        end;
    end;

    Parent.CanvasSize = UDim2.fromOffset(0, Parent.UIListLayout.AbsoluteContentSize.Y + 100);
    MarketplaceService.PromptProductPurchaseFinished:Connect(function(p15, p16, p17) -- Line: 203
        -- upvalues: LocalPlayer (copy), u2 (copy)
        if p15 ~= LocalPlayer.UserId then
            return;
        end;

        u2:SetGiftUserId(nil);
    end);
    local TextChatService = game:GetService("TextChatService");
    u2.Signal:Connect(function(p18, p19) -- Line: 210
        -- upvalues: u3 (copy), TextChatService (copy)
        if p18 == "ProductGifted" then
            local ProductId = p19.ProductId;
            local v20 = nil;

            for _, v in u3 do
                if v.GiftProductId == ProductId then
                    v20 = v;
                    break;
                end;
            end;

            if not v20 then
                return;
            end;

            local v21 = `@{p19.Gifter.Name} HAS GIFTED [{v20.Text}] TO @{p19.Receiver.Name}`;
            TextChatService.TextChannels.RBXGeneral:DisplaySystemMessage(v21);
        end;
    end);
end;
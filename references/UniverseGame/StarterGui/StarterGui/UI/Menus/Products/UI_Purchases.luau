  

 

return function(u1) -- Line: 1
    local MarketplaceService = game:GetService("MarketplaceService");
    local ProductInfo = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").ProductInfo);
    local ItemData = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").ItemData);

    for _, descendant in pairs(script.Parent:GetDescendants()) do
        if descendant:IsA("Frame") and descendant:FindFirstChild("Purchase") then
            if descendant:GetAttribute("Gamepass") then
                local v2 = descendant:GetAttribute("Gamepass");
                local u3 = ProductInfo.Gamepasses[v2];

                if u3 then
                    local v4 = MarketplaceService:GetProductInfo(u3, Enum.InfoType.GamePass);

                    if v4 and descendant:FindFirstChild("Price") then
                        descendant.Price.Text = tostring(v4.PriceInRobux) .. " R$";
                    end;

                    descendant.Purchase.MouseButton1Down:Connect(function() -- Line: 18
                        -- upvalues: MarketplaceService (copy), u1 (copy), u3 (copy)
                        MarketplaceService:PromptGamePassPurchase(u1.Player, u3);
                        u1:PlaySound("Click");
                    end);
                end;
            elseif descendant:GetAttribute("Item") then
                local v5 = ItemData.GetItemInfo(descendant:GetAttribute("Crate"));

                if v5 then
                    local v6;

                    if v5.Price == nil then
                        v6 = false;
                    else
                        v6 = v5.Price .. u1.CurrencyString;
                    end;

                    descendant.Price.Text = v6;
                    local v7;

                    if v5.PremiumPrice == nil then
                        v7 = false;
                    else
                        v7 = v5.PremiumPrice .. u1.PremiumCurrencyString;
                    end;

                    descendant.PremiumPrice.Text = v7;
                end;

                descendant.Purchase.MouseButton1Down:Connect(function() -- Line: 29
                    -- upvalues: u1 (copy), descendant (copy)
                    u1:PromptPurchase(descendant:GetAttribute("Item"));
                    u1:PlaySound("Click");
                end);
            end;
        end;
    end;

    local function GetStrikeThrough(p8) -- Line: 39
        return not p8 and "" or `<s>{p8}</s> `;
    end;

    local Parent = script.Parent;
    local Skin_Crate = Parent.Assets.Skin_Crate;

    for i, v in ItemData.GetCrates() do
        if v.Purchasable then
            local v9 = Skin_Crate:Clone();
            v9.Name = i;
            v9.Label.Text = v.Name;

            if v.UShards then
                v9.Prices.Price.Visible = true;
                local StrikeUShards = v.StrikeUShards;
                v9.Prices.Price.Text = `{not StrikeUShards and "" or `<s>{StrikeUShards}</s> `}{v.UShards} {u1.CurrencyString}`;

                if v.StrikeUShards then
                    v9.Prices.Price.Size = UDim2.fromScale(0.33, 1);
                end;
            else
                v9.Prices.Price.Visible = false;
            end;

            if v.UPoints then
                v9.Prices.PremiumPrice.Visible = true;
                local StrikeUPoints = v.StrikeUPoints;
                v9.Prices.PremiumPrice.Text = `{not StrikeUPoints and "" or `<s>{StrikeUPoints}</s> `}{v.UPoints} {u1.PremiumCurrencyString}`;

                if v.StrikeUPoints then
                    v9.Prices.PremiumPrice.Size = UDim2.fromScale(0.33, 1);
                end;
            else
                v9.Prices.PremiumPrice.Visible = false;
            end;

            if v.USummer26 then
                v9.Prices.EventPrice.Visible = true;
                local StrikeUEvents = v.StrikeUEvents;
                v9.Prices.EventPrice.Text = `{not StrikeUEvents and "" or `<s>{StrikeUEvents}</s> `}{v.USummer26} {u1.EventCurrencyString}`;

                if v.StrikeUEvents then
                    v9.Prices.EventPrice.Size = UDim2.fromScale(0.33, 1);
                end;
            else
                v9.Prices.EventPrice.Visible = false;
            end;

            v9.Purchase.MouseButton1Down:Connect(function() -- Line: 88
                -- upvalues: u1 (copy), i (copy)
                if u1.UI.Prompt.Visible then
                    return;
                end;

                u1:PlaySound("Click");
                u1:PromptCratePurchase(i);
            end);
            v9.Items.MouseButton1Down:Connect(function() -- Line: 94
                -- upvalues: u1 (copy), i (copy)
                if u1.UI.Prompt.Visible then
                    return;
                end;

                u1:PlaySound("Click");
                u1:PromptItemPool(i);
            end);
            v9.LayoutOrder = v.LayoutOrder or 0;
            v9.Visible = true;
            v9.Parent = Parent.Tabs.Crates.Crates.Skin;
        end;
    end;
end;
  

 

return function(u1) -- Line: 1
    local u2 = u1.Knit.GetService("ShopService");
    local ItemData = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").ItemData);
    local Stands = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").Stands);
    u1.Knit.GetService("InventoryService");
    local Trove = require(u1.KnitPath.Trove);
    local Parent = script.Parent;
    local Assets = Parent.Assets;
    local Items = Parent.Items;
    local u3 = {};

    local function DetermineType(p4) -- Line: 14
        -- upvalues: ItemData (copy)
        local v5 = ItemData.GetItemInfo(p4);

        if v5.Type then
            return v5.Type;
        end;

        if string.find(string.lower(p4), "ability") then
            return "Ability";
        end;
    end;

    local function GetRarityPrice(p6) -- Line: 23
        -- upvalues: ItemData (copy)
        local v7 = ItemData.Rarities[p6];

        if not v7 then
            return;
        end;

        local Name = v7.Name;
        local v8 = ItemData.Rates[`{Name}_Skin`];
        local v9 = ItemData.PremiumRates[`{Name}_Skin`];

        if v8 then
            return {
                Price = v8,
                PremiumPrice = v9
            };
        end;
    end;

    local function PromptPurchase(u10) -- Line: 38
        -- upvalues: u3 (copy), u1 (copy), u2 (copy)
        local v11 = u3[u10];

        if not v11 then
            return;
        end;

        local Price = v11.StockData.Price;
        u1.NewPrompt({
            Title = "Purchase limited item",
            Text = `Purchase {u1:GetItemText(u10, true)} for {tostring(Price)} <font color="#44ff00">{u1.uFragmentsString}</font>?`,
            Options = { "Cancel", "Confirm" },

            Callback = function(p12) -- Line: 50, Name: Callback
                -- upvalues: u2 (ref), u10 (copy), u1 (ref), Price (copy)
                if p12.Choice == 1 then
                    return true;
                end;

                local v13 = u2:BuyLimitedItem(u10):expect();

                if not v13 then
                    u1.NewPrompt({
                        Title = "Purchase successful",
                        Options = "ok",
                        Text = `You have successfully purchased {u1:GetItemText(u10, true)} for {tostring(Price)} <font color="#44ff00">{u1.uFragmentsString}</font>`
                    });

                    return;
                end;

                if v13 == "NoInventorySpace" then
                    u1.NewPrompt({
                        Title = "Purchase failed",
                        Text = "You do not have enough inventory space to purchase this item",
                        Options = "ok"
                    });

                    return;
                end;

                if v13 == "InvalidCurrencyAmount" then
                    u1.NewPrompt({
                        Title = "Purchase failed",
                        Options = "ok",
                        Text = `You do not have enough <font color="#44ff00">{u1.uFragmentsString}</font> to buy this item`
                    });

                    return;
                end;

                if v13 == "OnCooldown" then
                    u1.NewPrompt({
                        Title = "Purchase failed",
                        Text = "Limited item purchases on cooldown, try again shortly",
                        Options = "ok"
                    });

                    return;
                end;

                if v13 == "NoStock" then
                    u1.NewPrompt({
                        Title = "Purchase failed",
                        Text = "Limited item is out of stock",
                        Options = "ok"
                    });
                end;
            end
        });
    end;

    local function MakeItemFrame(u14, p15) -- Line: 91
        -- upvalues: ItemData (copy), u3 (copy), Assets (copy), u1 (copy), Trove (copy), PromptPurchase (copy), Stands (copy), Items (copy)
        local u16 = ItemData.GetItemInfo(u14);

        if not u16 then
            return;
        end;

        local u17;

        if u3[u14] then
            u17 = u3[u14].Container;
        elseif p15.Amount == (1 / 0) then
            u17 = Assets.ContainerNormal:Clone();
        else
            u17 = Assets.ContainerLimited:Clone();
        end;

        local v18 = ItemData.GetItemInfo(u14);
        local v19;

        if v18.Type then
            v19 = v18.Type;
        else
            v19 = string.find(string.lower(u14), "ability") and "Ability" or nil;
        end;

        u17.LayoutOrder = (p15.Amount ~= (1 / 0) and -100 or 0) + u1.GetInventorySort("Rarity (Highest)")(u14);
        local v20;

        if u3[u14] then
            v20 = u3[u14].Trove;
        else
            v20 = Trove.new();
        end;

        local v21 = (ItemData.GetRarityData(u16.Rarity) or {}).Color or Color3.new(1, 1, 1);

        if u3[u14] then
            if u3[u14] and (u3[u14].StockData.Amount or 0) < p15.Amount then
                u1:Notify(`<font color="#{Color3.new(1, 1, 0):ToHex()}">Limited Item Restocked</font>`, `<font color="#{v21:ToHex()}">{u16.Name}</font>`, 5);
                u1:PlaySound("ug_levelup");
            end;
        else
            task.defer(function() -- Line: 109
                -- upvalues: u1 (ref), u17 (copy), u16 (copy)
                u1:GenerateIcon(u17.ViewportFrame, u16);
            end);
            v20:Add(u17);
            v20:Add(u17.MouseButton1Down:Connect(function() -- Line: 114
                -- upvalues: u1 (ref), PromptPurchase (ref), u14 (copy)
                if u1.UI.Prompt.Visible then
                    return;
                end;

                u1:PlaySound("Click");
                PromptPurchase(u14);
            end));

            if (p15.Amount or 0) > 0 then
                u1:Notify(`<font color="#{Color3.new(1, 1, 0):ToHex()}">Limited Item Restocked</font>`, `<font color="#{v21:ToHex()}">{u16.Name}</font>`, 5);
                u1:PlaySound("ug_levelup");
            end;
        end;

        u3[u14] = {
            Container = u17,
            StockData = p15,
            Trove = v20
        };

        if v19 == "Ability" then
            local v22 = Stands[tonumber(string.match(u14, "%d+"))];
            u17.ItemName.Text = v22 or "NULL";
        else
            u17.ItemName.Text = u16.Name;
        end;

        if p15.Amount >= (1 / 0) or p15.InfStock then
            u17.Status.Text = "<b>Unlimited</b>";
        elseif p15.Amount > 0 then
            u17.Status.Text = `<b>{p15.Amount} / {p15.MaxAmount}</b> in stock`;
        else
            u17.Status.Text = "<b>Unavailable</b>";
        end;

        u17.Price.LimitedCurrency.Visible = true;
        u17.Price.LimitedCurrency.Text = tostring(p15.Price) .. " " .. u1.uFragmentsString;
        local v23 = ItemData.Rarities[u16.Rarity];

        if v23 then
            u17.ItemName.TextColor3 = v23.Color;
        else
            u17.ItemName.TextColor3 = Color3.fromRGB(255, 255, 255);
        end;

        u17.Parent = Items;
        u17.Visible = true;
    end;

    local function Update() -- Line: 166
        -- upvalues: u2 (copy), u3 (copy), MakeItemFrame (copy)
        local v24 = u2:GetLimitedShop():expect() or {};

        for i, v in u3 do
            if not v24[i] and v.Trove then
                v.Trove:Destroy();
                u3[i] = nil;
            end;
        end;

        for i, v in v24 do
            MakeItemFrame(i, v);
        end;
    end;

    pcall(Update);
    u1.BindToClock("RefreshLimiteds", 5, "PreRender", Update);
end;
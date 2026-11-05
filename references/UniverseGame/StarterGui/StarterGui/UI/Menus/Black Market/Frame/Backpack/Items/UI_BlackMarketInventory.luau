  

 

return function(u1) -- Line: 1
    local ItemData = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").ItemData);
    local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
    local Promise = require(PathShortcuts.KnitPath.Promise);
    local Trove = require(PathShortcuts.KnitPath.Trove);
    local Signal = require(PathShortcuts.KnitPath.Signal);
    local Knit = u1.Knit;
    Knit.GetService("InventoryService");
    local u2 = Knit.GetService("ShopService");
    local Parent = script.Parent.Parent;
    local u3 = Signal.new();
    local u4 = {};

    local function CreateContainer(p5, p6) -- Line: 17
        -- upvalues: u1 (copy)
        local v7 = u1.CreateInventorySlot(p6);
        v7.LayoutOrder = u1.GetInventorySort("BlackMarket")(p5);
        v7.Parent = script.Parent;

        return v7;
    end;

    local function AddSlot(u8, p9, p10, u11) -- Line: 24
        -- upvalues: ItemData (copy), u4 (copy), Trove (copy), u1 (copy), u3 (copy)
        local u12 = ItemData.GetItemInfo(u8);

        if u12 and not u4[p10] then
            local v13 = Trove.new();
            local u14 = u1.CreateInventorySlot(u12);
            u14.LayoutOrder = u1.GetInventorySort("BlackMarket")(u8);
            u14.Parent = script.Parent;
            v13:Add(u14);
            v13:Connect(u14.Button.MouseButton1Down, function() -- Line: 44
                -- upvalues: u1 (ref), u12 (copy), u8 (copy), u14 (copy), u11 (copy), u3 (ref)
                u1:PlaySound("Click");
                u1.InventorySignals.ItemSelected:Fire({
                    ItemCount = 1,
                    BlackMarket = true,
                    ItemInfo = u12,
                    ItemId = u8,
                    ActualGui = u14,
                    Purity = u11,
                    TransferAllSignal = u3
                });
            end);
            u4[p10] = {
                Container = u14,
                Trove = v13,
                ItemId = u8,
                ItemInfo = u12,
                Purity = u11
            };
        end;
    end;

    local Button = Parent.BlackMarketItemExchangePanel.Sell.Button;
    Button.MouseButton1Click:Connect(function() -- Line: 76
        -- upvalues: u1 (copy), Button (copy), u4 (copy), u2 (copy)
        u1.InventorySignals.ItemSelected:Fire({
            BlackMarket = true
        });
        Button:SetAttribute("ItemCount", 0);
        Button:SetAttribute("ItemsCumulativePrice", 0);
        Button.Text = "SELL 0 ITEMS";
        local v15 = {};

        for i, v in u4 do
            if v.Container:GetAttribute("InEscrow") then
                local _ = v.ItemId;
                table.insert(v15, i);
            end;
        end;

        if #v15 == 0 then
            return;
        end;

        u2.Signal:Fire("BlackMarketBulkSellItems", v15);
    end);
    local u16 = false;
    Parent.Tabs.AddAll.MouseButton1Click:Connect(function() -- Line: 106
        -- upvalues: u16 (ref), Button (copy), u4 (copy), Parent (copy), u1 (copy)
        u16 = not u16;

        if not u16 then
            u1.InventorySignals.ItemSelected:Fire({
                BlackMarket = true
            });
            Button:SetAttribute("ItemCount", 0);
            Button:SetAttribute("ItemsCumulativePrice", 0);
            Button.Text = "SELL 0 ITEMS";

            for _, v in u4 do
                if v.Container:GetAttribute("InEscrow") then
                    v.Container:SetAttribute("InEscrow", nil);
                    v.Container.Parent = Parent.Items;
                end;
            end;

            return;
        end;

        local v17 = Button:GetAttribute("ItemCount") or 0;
        local v18 = Button:GetAttribute("ItemsCumulativePrice") or 0;

        for _, v in u4 do
            if not v.Container:GetAttribute("InEscrow") then
                v17 = v17 + 1;
                local ItemInfo = v.ItemInfo;
                local Purity = v.Purity;
                local BlackMarketBasePrice = ItemInfo.BlackMarketBasePrice;
                local BlackMarketMaxPrice = ItemInfo.BlackMarketMaxPrice;

                if BlackMarketBasePrice and BlackMarketMaxPrice then
                    local v19 = BlackMarketBasePrice + (BlackMarketMaxPrice - BlackMarketBasePrice) * (Purity / 100);

                    if BlackMarketMaxPrice >= v19 then
                        BlackMarketMaxPrice = v19;
                    end;

                    v18 = v18 + math.ceil(BlackMarketMaxPrice);
                    v.Container:SetAttribute("InEscrow", true);
                    v.Container.Parent = Parent.BlackMarketItemExchangePanel.Escrow.Items;
                end;
            end;
        end;

        Button:SetAttribute("ItemCount", v17);
        Button:SetAttribute("ItemsCumulativePrice", v18);
        Button.Text = `SELL {v17} ITEMS ({u1:AbbreviateNumber(v18)} {u1.CurrencyString or "<s>u</s>S"})`;
    end);
    local u20 = {};

    for i, v in ItemData.GetItems() do
        if v.BlackMarketSellable then
            local BlackMarketMaxPrice = v.BlackMarketMaxPrice;

            if BlackMarketMaxPrice and v.BlackMarketBasePrice then
                u20[i] = BlackMarketMaxPrice;
            end;
        end;
    end;

    function u1.ShowBlackMarketItems() -- Line: 187
        -- upvalues: u4 (copy), u16 (ref), Button (copy), u20 (copy), Promise (copy), AddSlot (copy)
        for _, v in u4 do
            v.Trove:Destroy();
        end;

        table.clear(u4);
        u16 = false;
        Button:SetAttribute("ItemCount", 0);
        Button:SetAttribute("ItemsCumulativePrice", 0);
        Button.Text = "SELL 0 ITEMS";
        local v21 = 0;

        for _, child in game.Players.LocalPlayer:WaitForChild("Backpack"):GetChildren() do
            if child:IsA("Tool") and (child:GetAttribute("ItemId") and type(child:GetAttribute("UUID")) == "string") then
                v21 = v21 + 1;
                local v22 = child:GetAttribute("ItemId");
                local v23 = child:GetAttribute("Purity") or 0;
                local v24 = u20[v22];

                if v24 then
                    Promise.try(AddSlot, v22, v24, child:GetAttribute("UUID"), v23):catch(warn);
                end;
            end;
        end;
    end;

    u1.ShowBlackMarketItems();
end;
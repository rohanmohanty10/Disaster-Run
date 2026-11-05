  

 

return function(u1) -- Line: 1
    u1.Data:WaitForChild("Inventory");
    local _ = script.Parent.Parent.Parent.Assets.Container;
    local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
    local Promise = require(PathShortcuts.KnitPath.Promise);
    local Trove = require(PathShortcuts.KnitPath.Trove);
    local ItemData = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").ItemData);
    local Stands = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").Stands);
    require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").Skins);
    require(PathShortcuts.ReplicatedModules:WaitForChild("PVEPackage"):WaitForChild("TraitHandler"));
    u1.Knit.GetService("InventoryService");
    local u2 = u1.Knit.GetService("TradeService");
    local u3 = "Skins";
    local u4 = {};

    local function ResolveName(p5) -- Line: 17
        -- upvalues: Stands (copy)
        local v6 = "";

        if p5.Skin then
            local v7 = Stands[tonumber(p5.LinkedAbilityId)];

            if v7 then
                v6 = v6 .. v7;
            end;
        end;

        return v6 .. p5.Name, v6;
    end;

    local u8 = {};
    local u16 = {
        ["A - Z"] = function(p9) -- Line: 30
            -- upvalues: ItemData (copy)
            local v10 = ItemData.GetItemInfo(p9);

            return not v10.Name and 100 or string.byte(v10.Name:upper());
        end,

        ["Z - A"] = function(p11) -- Line: 34
            -- upvalues: ItemData (copy)
            local v12 = ItemData.GetItemInfo(p11);

            return not v12.Name and -100 or string.byte(v12.Name:upper()) * -1;
        end,

        ["Rarity (Highest)"] = function(p13) -- Line: 38
            -- upvalues: ItemData (copy)
            return (ItemData.GetItemInfo(p13).Rarity or 0) * -1;
        end,

        ["Rarity (Lowest)"] = function(p14) -- Line: 42
            -- upvalues: ItemData (copy)
            return ItemData.GetItemInfo(p14).Rarity or 0;
        end,

        Quantity = function(p15) -- Line: 46
            -- upvalues: u4 (copy)
            return (u4[p15] or 0) * -1;
        end
    };
    local u17 = "Rarity (Highest)";
    local u18 = 4;
    local u19 = { "A - Z", "Z - A", "Quantity", "Rarity (Highest)", "Rarity (Lowest)" };

    local function GetSort(p20, p21) -- Line: 55
        -- upvalues: u17 (ref), u16 (copy)
        local v22 = u16[p21 or u17];

        if v22 then
            return v22(p20);
        end;
    end;

    local function AddSlot(p23) -- Line: 66
        -- upvalues: ItemData (copy), u8 (copy), u1 (copy), u4 (copy), Trove (copy), u17 (ref), u16 (copy), u2 (copy)
        local u24 = ItemData.GetItemInfo(p23._ItemId);
        local _UUID = p23._UUID;
        local _ItemId = p23._ItemId;

        if u8[_UUID] then
            return;
        end;

        if u1.TradingSlots and u1.TradingSlots[_UUID] then
            return;
        end;

        if u4[_ItemId] then
            local v25 = u4;
            v25[_ItemId] = v25[_ItemId] + 1;
        else
            u4[_ItemId] = 1;
        end;

        local v26 = Trove.new();
        local u27 = v26:Add(u1.CreateInventorySlot(u24, {
            TraitInfo = p23._TraitInfo,
            UnusualInfo = p23._UnusualInfo,
            SerialNumber = p23._SerialNumber
        }));
        local v28 = u16[nil or u17];
        local v29;

        if v28 then
            v29 = v28(_ItemId);
        else
            v29 = nil;
        end;

        u27.LayoutOrder = v29;

        local function UpdateAmount() -- Line: 83
            -- upvalues: u24 (copy), u27 (copy)
            if u24.Type == "Ability" then
                u27.Button.Amount.Text = "";

                return;
            end;

            u27.Button.Amount.Text = "";
        end;

        if u24.Type == "Ability" then
            u27.Button.Amount.Text = "";
        else
            u27.Button.Amount.Text = "";
        end;

        v26:Connect(u27.Button.MouseButton1Down, function() -- Line: 94
            -- upvalues: u2 (ref), _UUID (copy)
            u2.AddTradeItem:Fire({
                UUID = _UUID
            });
        end);

        if u1.CanTooltipInventorySlot(p23) or u24.LinkedAbilityId then
            u1.ConstructTooltipSlot(u27, {
                ItemId = _ItemId,
                TraitInfo = p23._TraitInfo,
                UnusualInfo = p23._UnusualInfo,
                SerialNumber = p23._SerialNumber,
                Purity = p23._Purity,
                Premium = p23._Premium,
                PremiumCrate = p23._PremiumCrate,
                LinkedAbilityId = u24.LinkedAbilityId
            }, v26);
        end;

        u27.Parent = script.Parent.Items;
        u8[_UUID] = {
            Container = u27,
            Trove = v26,
            ItemId = _ItemId
        };
    end;

    local function Search(p30) -- Line: 124
        -- upvalues: u8 (copy), ItemData (copy)
        if p30 and p30 ~= "" then
            for _, v in pairs(u8) do
                local v31 = ItemData.GetItemInfo(v.ItemId);

                if v31 and v31.Name then
                    if string.find(v31.Name:lower(), p30:lower()) then
                        v.Container.Visible = true;
                    else
                        v.Container.Visible = false;
                    end;
                end;
            end;

            return;
        end;

        for _, v in pairs(u8) do
            v.Container.Visible = true;
        end;
    end;

    local Buttons = script.Parent.Buttons;
    local Order = Buttons.Order;
    local Search2 = Buttons.Search;
    Order.Text = u17;
    Order.MouseButton1Down:Connect(function() -- Line: 148
        -- upvalues: u1 (copy), u18 (ref), u19 (copy), u17 (ref), Order (copy), u8 (copy), u16 (copy)
        u1:PlaySound("Click");
        u18 = u18 + 1;

        if u18 > #u19 then
            u18 = 1;
        end;

        u17 = u19[u18];
        Order.Text = u17;

        for _, v in pairs(u8) do
            if v.Container then
                local Container = v.Container;
                local ItemId = v.ItemId;
                local v32 = u16[nil or u17];
                local v33;

                if v32 then
                    v33 = v32(ItemId);
                else
                    v33 = nil;
                end;

                Container.LayoutOrder = v33;
            end;
        end;
    end);
    Search2.TextBox.FocusLost:Connect(function() -- Line: 163
        -- upvalues: Search (copy), Search2 (copy)
        Search(Search2.TextBox.Text);
    end);
    local u34 = "Skin";

    function u1.SetTradeInventory(p35, p36) -- Line: 169
        -- upvalues: u8 (copy), u4 (copy), u3 (ref), u34 (ref), u1 (copy), ItemData (copy), AddSlot (copy), Promise (copy)
        local v37 = {
            Skins = "Skin",
            Stands = "Ability",
            Items = "Item",
            Mounts = "Mount",
            KillEffects = "KillEffect"
        };
        local v38 = {
            Skins = "SkinInventory",
            Stands = "AbilityInventory",
            Items = "ItemInventory",
            Mounts = "MountInventory",
            KillEffects = "KillEffectInventory"
        };

        for _, v in pairs(u8) do
            v.Trove:Destroy();
        end;

        table.clear(u8);
        table.clear(u4);

        if p35 ~= "TradeComplete" then
            u3 = p35 or u3;
            u34 = v37[p35] or "Skin";
            local v39 = v38[p35];
            local v40 = u1.LoadInventory(v39) or {};
            print(v40);

            for _, v in pairs(v40) do
                if not v._Locked and v._Tradeable then
                    local v41 = ItemData.GetItemInfo(v._ItemId);

                    if v41.Type == u34 and (u1.CanTradePaidItems or v41.Type ~= "Skin") then
                        AddSlot(v);
                    end;
                end;
            end;

            if not p36 then
                Promise.try(u1.ShowInventoryCapacity, v39):catch(warn);
            end;
        end;

        local Items = script.Parent.Items;
        Items.CanvasSize = UDim2.fromOffset(0, Items.UIGridLayout.AbsoluteContentSize.Y);
    end;

    function u1.RefreshTradeInventory(p42) -- Line: 216
        -- upvalues: u34 (ref), u3 (ref), u1 (copy), u8 (copy), ItemData (copy), AddSlot (copy)
        u34 = ({
            Skins = "Skin",
            Stands = "Ability",
            Items = "Item",
            Mounts = "Mount",
            KillEffects = "KillEffect"
        })[u3] or "Skin";
        local v43 = u1.LoadInventory(({
            Skins = "SkinInventory",
            Stands = "AbilityInventory",
            Items = "ItemInventory",
            Mounts = "MountInventory",
            KillEffects = "KillEffectInventory"
        })[u3]) or {};

        for i, v in pairs(v43) do
            if not v._Locked and (v._Tradeable and not (u8[i] or p42[i])) then
                local v44 = ItemData.GetItemInfo(v._ItemId);

                if v44.Type == u34 and (u1.CanTradePaidItems or v44.Type ~= "Skin") then
                    AddSlot(v);
                end;
            end;
        end;

        local Items = script.Parent.Items;
        Items.CanvasSize = UDim2.fromOffset(0, Items.UIGridLayout.AbsoluteContentSize.Y);
    end;

    u2.AddTradeItem:Connect(function(p45) -- Line: 248
        -- upvalues: u8 (copy), u4 (copy)
        local UUID = p45.UUID;
        local ItemId = p45.ItemId;

        if u8[UUID] then
            u8[UUID].Trove:Destroy();
            u8[UUID] = nil;
        end;

        if not u4[ItemId] then
            return;
        end;

        local v46 = u4;
        v46[ItemId] = v46[ItemId] - 1;

        if u4[ItemId] <= 0 then
            u4[ItemId] = nil;
        end;
    end);
end;
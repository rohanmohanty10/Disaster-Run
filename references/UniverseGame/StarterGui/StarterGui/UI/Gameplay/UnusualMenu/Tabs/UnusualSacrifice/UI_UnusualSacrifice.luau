  

 

return function(u1) -- Line: 1
    local PathShortcuts = u1.PathShortcuts;
    local u2 = u1.Knit.GetService("InventoryService");
    local u3 = u1.Knit.GetService("ShopService");
    local Parent = script.Parent;
    local ItemData = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").ItemData);
    local UnusualBlacklist = require(PathShortcuts.ReplicatedModules.PVEPackage.UnusualBlacklist);
    local Trove = require(PathShortcuts.KnitPath.Trove);
    local MainFrame = Parent.MainFrame;
    local Skins = MainFrame.Skins;
    local ToSacrifice = MainFrame.ToSacrifice;
    local Amount = MainFrame.Amount;
    local u4 = {};
    local u5 = {};
    local u6 = nil;
    local u7 = 0;
    local u8 = {};

    local function IsValidInputHue(p9) -- Line: 26
        local v10;

        if type(p9) == "number" and (p9 == p9 and (p9 ~= (1 / 0) and (p9 ~= (-1 / 0) and p9 >= 0))) then
            v10 = p9 <= 72;
        else
            v10 = false;
        end;

        return v10;
    end;

    local function UpdateAmount() -- Line: 31
        -- upvalues: u7 (ref), Amount (copy)
        Amount.Text = `<font color="{u7 == 5 and "#8fff7b" or "#ff7e7e"}">{u7}</font> / {5}`;
    end;

    local function GetSort(p11) -- Line: 36
        -- upvalues: u1 (copy)
        local v12 = u1.GetInventorySort("Rarity (Highest)");

        if v12 then
            return v12(p11);
        end;
    end;

    local function CreateContainer(p13, p14) -- Line: 43
        -- upvalues: u1 (copy), Skins (copy)
        local _ItemId = p13._ItemId;
        local v15 = u1.CreateInventorySlot(p14, {
            TraitInfo = p13._TraitInfo,
            UnusualInfo = p13._UnusualInfo,
            SerialNumber = p13._SerialNumber
        });
        local v16 = u1.GetInventorySort("Rarity (Highest)");
        local v17;

        if v16 then
            v17 = v16(_ItemId);
        else
            v17 = nil;
        end;

        v15.LayoutOrder = v17 or 0;
        v15.Parent = Skins;

        return v15;
    end;

    local function AddSlot(p18) -- Line: 55
        -- upvalues: ItemData (copy), UnusualBlacklist (copy), u4 (copy), u5 (copy), Trove (copy), CreateContainer (copy), u1 (copy), Skins (copy), u7 (ref), u6 (ref), u8 (copy), ToSacrifice (copy), Amount (copy)
        local _UUID = p18._UUID;
        local _ItemId = p18._ItemId;
        local v19 = ItemData.GetItemInfo(_ItemId);

        if UnusualBlacklist.IsBlacklisted(_ItemId) then
            return;
        end;

        if not v19 then
            return;
        end;

        if not (p18._Premium and p18._UnusualInfo) then
            return;
        end;

        if p18._Locked then
            return;
        end;

        local UnusualHueId = p18._UnusualInfo.UnusualHueId;
        local v20;

        if type(UnusualHueId) == "number" and (UnusualHueId == UnusualHueId and (UnusualHueId ~= (1 / 0) and (UnusualHueId ~= (-1 / 0) and UnusualHueId >= 0))) then
            v20 = UnusualHueId <= 72;
        else
            v20 = false;
        end;

        if not v20 then
            return;
        end;

        if u4[_UUID] or u5[_UUID] then
            return;
        end;

        local v21 = Trove.new();
        local u22 = CreateContainer(p18, v19);
        v21:Add(u22);
        u22.LayoutOrder = tonumber(string.match(_ItemId, "%d+"));
        v21:Connect(u22.Button.MouseButton1Down, function() -- Line: 78
            -- upvalues: u1 (ref), u22 (copy), Skins (ref), u7 (ref), u6 (ref), _ItemId (copy), u8 (ref), UnusualHueId (copy), u5 (ref), _UUID (copy), u4 (ref), ToSacrifice (ref), Amount (ref)
            if u1.UI.Prompt.Visible then
                return;
            end;

            u1:PlaySound("Click");

            if u22.Parent == Skins then
                if u7 >= 5 then
                    u1.NewPrompt({
                        Title = "Limit Reached",
                        Delay = 0.5,
                        Text = `You must sacrifice exactly {5} - no more`
                    });

                    return;
                end;

                if u6 and _ItemId ~= u6 then
                    u1.NewPrompt({
                        Title = "Mismatched Skin",
                        Text = "All skins must be the same skin",
                        Delay = 0.5
                    });

                    return;
                end;

                if u8[UnusualHueId] then
                    u1.NewPrompt({
                        Title = "Duplicate Hue",
                        Text = "Each skin must be a distinct pattern",
                        Delay = 0.5
                    });

                    return;
                end;

                u6 = _ItemId;
                u8[UnusualHueId] = true;
                u7 = u7 + 1;
                u5[_UUID] = u4[_UUID];
                u4[_UUID] = nil;
                u22.Parent = ToSacrifice;
            else
                u8[UnusualHueId] = nil;
                u7 = u7 - 1;
                u4[_UUID] = u5[_UUID];
                u5[_UUID] = nil;
                u22.Parent = Skins;

                if u7 == 0 then
                    u6 = nil;
                end;
            end;

            Amount.Text = `<font color="{u7 == 5 and "#8fff7b" or "#ff7e7e"}">{u7}</font> / {5}`;
        end);

        if u1.CanTooltipInventorySlot(p18) then
            u1.ConstructTooltipSlot(u22, {
                ItemId = _ItemId,
                TraitInfo = p18._TraitInfo,
                UnusualInfo = p18._UnusualInfo,
                SerialNumber = p18._SerialNumber,
                Purity = p18._Purity,
                Premium = p18._Premium
            }, v21);
        end;

        u4[_UUID] = {
            Container = u22,
            Trove = v21,
            ItemObject = p18,
            ItemInfo = v19,
            RarityInfo = ItemData.Rarities[v19._Rarity]
        };
    end;

    local function Reset() -- Line: 141
        -- upvalues: u4 (copy), u5 (copy), u8 (copy), u6 (ref), u7 (ref)
        for _, v in u4 do
            v.Trove:Destroy();
        end;

        table.clear(u4);

        for _, v in u5 do
            v.Trove:Destroy();
        end;

        table.clear(u5);
        table.clear(u8);
        u6 = nil;
        u7 = 0;
    end;

    local function Update() -- Line: 155
        -- upvalues: Parent (copy), Reset (copy), u2 (copy), AddSlot (copy), u7 (ref), Amount (copy)
        if not Parent.Visible then
            Reset();

            return;
        end;

        local v23 = u2:GetItems("SkinInventory"):expect();

        if not v23 then
            return;
        end;

        for _, v in v23 do
            task.spawn(AddSlot, v);
        end;

        Amount.Text = `<font color="{u7 == 5 and "#8fff7b" or "#ff7e7e"}">{u7}</font> / {5}`;
    end;

    Parent:GetPropertyChangedSignal("Visible"):Connect(Update);
    task.delay(2, Update);

    local function HandleResponse(p24) -- Line: 174
        -- upvalues: u1 (copy)
        if p24 == "OnCooldown" then
            u1.NewPrompt({
                Title = "On Cooldown",
                Text = "Sacrificing on cooldown, please retry later"
            });

            return;
        end;

        if p24 == "NotEnoughSkins" then
            u1.NewPrompt({
                Title = "Insufficient Skins",
                Text = `You must sacrifice exactly {5} distinct hues of the same skin`
            });

            return;
        end;

        if p24 == "NotSameSkin" then
            u1.NewPrompt({
                Title = "Mismatched Skins",
                Text = "All sacrificed skins must be the same skin"
            });

            return;
        end;

        if p24 == "DuplicateHue" then
            u1.NewPrompt({
                Title = "Duplicate Hue",
                Text = "Each skin must be a distinct hue"
            });

            return;
        end;

        if p24 == "InvalidItem" then
            u1.NewPrompt({
                Title = "Data Error",
                Text = "Error occured, please retry"
            });

            return;
        end;

        u1.NewPrompt({
            Title = "Data Error",
            Text = "Error occured, please retry"
        });
    end;

    MainFrame.Sacrifice.MouseButton1Click:Connect(function() -- Line: 190
        -- upvalues: u1 (copy), u7 (ref), u5 (copy), u3 (copy), HandleResponse (copy), u8 (copy), u6 (ref), Amount (copy)
        if u1.UI.Prompt.Visible then
            return;
        end;

        if u7 == 5 then
            u1.NewPrompt({
                Title = "Sacrifice Unusuals",
                Delay = 0.5,
                Text = `Sacrifice these {5} unusuals for a <font color="#ffffff">White</font> unusual?`,
                Options = { "Yes", "No" },

                Callback = function(p25) -- Line: 206, Name: Callback
                    -- upvalues: u5 (ref), u3 (ref), HandleResponse (ref), u8 (ref), u6 (ref), u7 (ref), Amount (ref), u1 (ref)
                    if p25.Choice ~= 1 then
                        return;
                    end;

                    local v26 = {};

                    for i, v in u5 do
                        if v.ItemObject._Premium and v.ItemObject._UnusualInfo then
                            table.insert(v26, i);
                        end;
                    end;

                    local v27 = u3:SacrificeUnusualSkins(v26):expect();

                    if typeof(v27) == "string" or not v27 then
                        HandleResponse(v27);

                        return;
                    end;

                    for _, v in u5 do
                        v.Trove:Destroy();
                    end;

                    table.clear(u5);
                    table.clear(u8);
                    u6 = nil;
                    u7 = 0;
                    Amount.Text = `<font color="{u7 == 5 and "#8fff7b" or "#ff7e7e"}">{u7}</font> / {5}`;
                    local v28 = `{(v27.UnusualInfo and v27.UnusualInfo.UnusualHueId) == (1 / 0) and "<font color=\"#ffffff\">White</font>" or "<font color=\"#1a1a1a\">Black</font>"} <font color="#AA55FF">Unusual</font> ` .. u1:GetItemText(v27.ItemId, true) .. "\n";
                    u1.NewPrompt({
                        Title = "You received the following Item",
                        Text = v28
                    });
                end
            });

            return;
        end;

        u1.NewPrompt({
            Title = "Insufficient Skins",
            Text = `You must sacrifice exactly {5} distinct hues of the same skin`
        });
    end);
end;
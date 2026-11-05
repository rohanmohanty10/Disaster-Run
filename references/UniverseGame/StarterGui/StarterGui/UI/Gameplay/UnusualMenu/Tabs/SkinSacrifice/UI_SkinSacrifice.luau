  

 

return function(u1) -- Line: 1
    local PathShortcuts = u1.PathShortcuts;
    local u2 = u1.Knit.GetService("InventoryService");
    local u3 = u1.Knit.GetService("ShopService");
    local Parent = script.Parent;
    local ItemData = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").ItemData);
    local UnusualBlacklist = require(PathShortcuts.ReplicatedModules.PVEPackage.UnusualBlacklist);
    local Trove = require(PathShortcuts.KnitPath.Trove);
    local u4 = u1.Util.Tooltip.GetFromParent(u1.UI:FindFirstChild("Screen"));
    local MainFrame = Parent.MainFrame;
    local Skins = MainFrame.Skins;
    local ToSacrifice = MainFrame.ToSacrifice;
    local Amount = MainFrame.Amount;
    local u5 = {};
    local u6 = {};
    local u7 = 0;
    local v8 = Trove.new();
    local u9 = false;

    local function GetRarityColor(p10) -- Line: 26
        -- upvalues: ItemData (copy)
        local u11 = Color3.fromRGB(255, 255, 255);
        local u12 = ItemData.GetItemInfo(p10);
        pcall(function() -- Line: 30
            -- upvalues: ItemData (ref), u12 (copy), u11 (ref)
            local v13 = ItemData.GetRarityData(u12.Rarity);

            if v13 and v13.Color then
                u11 = v13.Color;
            end;
        end);

        return u11;
    end;

    local function FormatOddsEntry(p14) -- Line: 40
        -- upvalues: ItemData (copy)
        local ItemId = p14.ItemId;
        local u15 = Color3.fromRGB(255, 255, 255);
        local u16 = ItemData.GetItemInfo(ItemId);
        pcall(function() -- Line: 30
            -- upvalues: ItemData (ref), u16 (copy), u15 (ref)
            local v17 = ItemData.GetRarityData(u16.Rarity);

            if v17 and v17.Color then
                u15 = v17.Color;
            end;
        end);
        local v18 = u15;
        local v19 = math.floor(v18.R * 255);
        local v20 = math.floor(v18.G * 255);
        local v21 = math.floor(v18.B * 255);

        return string.format("<font color=\"rgb(%d,%d,%d)\">%s (%.2f%%)</font>", v19, v20, v21, p14.Name, p14.Chance);
    end;

    local function UpdateSacrificeOdds() -- Line: 50
        -- upvalues: u9 (ref), u6 (copy), u4 (copy), u3 (copy), FormatOddsEntry (copy)
        if not u9 then
            return;
        end;

        local v22 = {};

        for i, _ in u6 do
            table.insert(v22, i);
        end;

        if #v22 == 0 then
            u4:SetTitle("Sacrifice Odds");
            u4:SetText("No skins selected");

            return;
        end;

        local v23 = u3:GetSkinSacrificeOdds(v22):expect();

        if not u9 then
            return;
        end;

        if typeof(v23) ~= "table" then
            return;
        end;

        table.sort(v23, function(p24, p25) -- Line: 68
            return p24.Chance > p25.Chance;
        end);
        local v26 = {};

        for _, v in v23 do
            table.insert(v26, FormatOddsEntry(v));
        end;

        local v27 = table.concat(v26, "\n");
        u4:SetTitle("Sacrifice Odds");
        u4:SetText(v27);
    end;

    v8:Connect(MainFrame.Sacrifice.MouseEnter, function() -- Line: 80
        -- upvalues: u9 (ref), UpdateSacrificeOdds (copy), u4 (copy)
        u9 = true;
        task.spawn(UpdateSacrificeOdds);
        u4:Show();
    end);
    v8:Connect(MainFrame.Sacrifice.MouseLeave, function() -- Line: 86
        -- upvalues: u9 (ref), u4 (copy)
        u9 = false;
        u4:Hide();
    end);

    local function GetSort(p28, p29) -- Line: 91
        -- upvalues: u1 (copy)
        local v30 = u1.GetInventorySort("Rarity (Highest)");

        if v30 then
            return v30(p28);
        end;
    end;

    local function CreateContainer(p31, p32) -- Line: 98
        -- upvalues: u1 (copy), Skins (copy)
        local _ItemId = p31._ItemId;
        local v33 = u1.CreateInventorySlot(p32, {
            TraitInfo = p31._TraitInfo,
            UnusualInfo = p31._UnusualInfo,
            SerialNumber = p31._SerialNumber
        });
        local v34 = u1.GetInventorySort("Rarity (Highest)");
        local v35;

        if v34 then
            v35 = v34(_ItemId);
        else
            v35 = nil;
        end;

        v33.LayoutOrder = v35 or 0;
        v33.Parent = Skins;

        return v33;
    end;

    local function AddSlot(p36) -- Line: 110
        -- upvalues: ItemData (copy), UnusualBlacklist (copy), u5 (copy), Trove (copy), CreateContainer (copy), u1 (copy), Skins (copy), u7 (ref), u6 (copy), ToSacrifice (copy), Amount (copy)
        local _UUID = p36._UUID;
        local _ItemId = p36._ItemId;
        local v37 = ItemData.GetItemInfo(_ItemId);
        local v38 = ItemData.GetRarity(v37);

        if UnusualBlacklist.IsBlacklisted(_ItemId) then
            return;
        end;

        if not p36._Premium or p36._UnusualInfo then
            return;
        end;

        if p36._Locked then
            return;
        end;

        local u39 = v37.PremiumPoints or v38.PremiumPoints;

        if not u39 then
            return;
        end;

        if not v37 then
            return;
        end;

        if u5[_UUID] then
            return;
        end;

        local v40 = Trove.new();
        local u41 = CreateContainer(p36, v37);
        v40:Add(u41);
        u41.LayoutOrder = tonumber(string.match(_ItemId, "%d+"));
        v40:Connect(u41.Button.MouseButton1Down, function() -- Line: 138
            -- upvalues: u1 (ref), u41 (copy), Skins (ref), u7 (ref), u6 (ref), _UUID (copy), u5 (ref), _UUID (copy), u39 (copy), ToSacrifice (ref), Amount (ref)
            if u1.UI.Prompt.Visible then
                return;
            end;

            u1:PlaySound("Click");
            local v42 = u41.Parent == Skins;

            if v42 and u7 < 100 then
                u6[_UUID] = u5[_UUID];
                u5[_UUID] = nil;
                u7 = u7 + u39;
                u41.Parent = ToSacrifice;
            elseif not v42 then
                u5[_UUID] = u6[_UUID];
                u6[_UUID] = nil;
                u41.Parent = Skins;
                u7 = u7 - u39;
            end;

            Amount.Text = `<font color="{u7 < 100 and "#ff7e7e" or "#8fff7b"}">{math.floor(u7)}</font> / {100}`;

            if u7 >= 100 and u41.Parent == Skins then
                u1.NewPrompt({
                    Title = "Max Sacrifice",
                    Text = "Premium Points capped",
                    Delay = 0.5
                });
            end;
        end);

        if u1.CanTooltipInventorySlot(p36) then
            u1.ConstructTooltipSlot(u41, {
                ItemId = _ItemId,
                TraitInfo = p36._TraitInfo,
                UnusualInfo = p36._UnusualInfo,
                SerialNumber = p36._SerialNumber,
                Purity = p36._Purity
            }, v40);
        end;

        u5[_UUID] = {
            Container = u41,
            Trove = v40,
            ItemObject = p36,
            ItemInfo = v37,
            RarityInfo = ItemData.Rarities[v37._Rarity]
        };
    end;

    local function Update() -- Line: 189
        -- upvalues: Parent (copy), u7 (ref), u5 (copy), u6 (copy), u2 (copy), AddSlot (copy), Amount (copy)
        if Parent.Visible then
            local v43 = u2:GetItems("SkinInventory"):expect();

            if not v43 then
                return;
            end;

            for _, v in v43 do
                task.spawn(AddSlot, v);
            end;

            Amount.Text = `<font color="{u7 < 100 and "#ff7e7e" or "#8fff7b"}">{math.floor(u7)}</font> / {100}`;

            return;
        end;

        u7 = 0;

        for _, v in u5 do
            v.Trove:Destroy();
        end;

        table.clear(u5);

        for _, v in u6 do
            v.Trove:Destroy();
        end;

        table.clear(u6);
    end;

    Parent:GetPropertyChangedSignal("Visible"):Connect(Update);
    task.delay(2, function() -- Line: 218
        -- upvalues: Update (copy)
        Update();
    end);

    local function HandleResponse(p44) -- Line: 222
        -- upvalues: u1 (copy)
        if p44 == "OnCooldown" then
            u1.NewPrompt({
                Title = "On Cooldown",
                Text = "Skin Sacrificing on Cooldown, please retry later"
            });

            return;
        end;

        if p44 == "InvalidItem" then
            u1.NewPrompt({
                Title = "Data Error",
                Text = "Error occured, please retry"
            });

            return;
        end;

        if p44 == "NotEnoughSkins" then
            u1.NewPrompt({
                Title = "Insufficient Skins",
                Text = "You must sacrifice at least 30 premium skins"
            });

            return;
        end;

        if p44 == "CrateNotFound" then
            u1.NewPrompt({
                Title = "Data Error",
                Text = "Crate data not found / incorrect"
            });

            return;
        end;

        u1.NewPrompt({
            Title = "Data Error",
            Text = "Error occured, please retry"
        });
    end;

    MainFrame.Sacrifice.MouseButton1Click:Connect(function() -- Line: 251
        -- upvalues: u1 (copy), u7 (ref), u6 (copy), u3 (copy), HandleResponse (copy), Amount (copy)
        if u1.UI.Prompt.Visible then
            return;
        end;

        if u7 < 100 then
            u1.NewPrompt({
                Title = "Insufficient Skins",
                Text = "You must sacrifice at least 30 premium skins"
            });
        end;

        u1.NewPrompt({
            Title = "Sacrifice Skins",
            Text = "Are you sure you want to Sacrifice these skins?",
            Delay = 0.5,
            Options = { "Yes", "No" },

            Callback = function(p45) -- Line: 266, Name: Callback
                -- upvalues: u6 (ref), u3 (ref), HandleResponse (ref), u7 (ref), Amount (ref), u1 (ref)
                if p45.Choice ~= 1 then
                    return;
                end;

                local v46 = {};

                for i, v in u6 do
                    if v.ItemObject._Premium then
                        table.insert(v46, i);
                    end;
                end;

                local v47 = u3:SacrificePremiumSkins(v46):expect();

                if typeof(v47) == "string" or not v47 then
                    HandleResponse(v47);

                    return;
                end;

                u7 = 0;
                Amount.Text = `<font color="{u7 < 100 and "#ff7e7e" or "#8fff7b"}">{u7}</font> / {100}`;

                for _, v in u6 do
                    v.Trove:Destroy();
                end;

                table.clear(u6);
                local v48 = "";

                if v47.UnusualInfo then
                    v48 = v48 .. "<font color=\"#AA55FF\">Unusual</font> ";
                end;

                local v49 = "" .. v48 .. u1:GetItemText(v47.ItemId, true) .. "\n";
                u1.NewPrompt({
                    Title = "You received the following Item",
                    Text = v49
                });
            end
        });
    end);
end;
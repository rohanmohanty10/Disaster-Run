  

 

return function(u1) -- Line: 1
    local PathShortcuts = u1.PathShortcuts;
    u1.Knit.GetService("InventoryService");
    local u2 = u1.Knit.GetService("ShopService");
    local Parent = script.Parent;
    local ItemData = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules").ItemData);
    local Fusion = require(game:GetService("ReplicatedStorage").ClientLibrary.Fusion);
    local Stands = require(game:GetService("ReplicatedStorage").ReplicatedModules.Stands);
    local CharmsHandler = require(PathShortcuts.ReplicatedModules:WaitForChild("PVEPackage"):WaitForChild("CharmsHandler"));
    local UnusualBlacklist = require(PathShortcuts.ReplicatedModules.PVEPackage.UnusualBlacklist);
    local Trove = require(PathShortcuts.KnitPath.Trove);
    local Holder = Parent.Holder;
    local RerollSection = Holder.RerollSection;
    local Skins = Holder.Skins;
    local u3 = {};
    local u4 = Fusion.Value(nil);

    local function GetSort(p5, p6) -- Line: 24
        -- upvalues: u1 (copy)
        local v7 = u1.GetInventorySort("Rarity (Highest)");

        if v7 then
            return v7(p5);
        end;
    end;

    local function CreateContainer(p8, p9) -- Line: 31
        -- upvalues: u1 (copy), Skins (copy)
        local _ItemId = p8._ItemId;
        local v10 = u1.CreateInventorySlot(p9, {
            TraitInfo = p8._TraitInfo,
            UnusualInfo = p8._UnusualInfo,
            SerialNumber = p8._SerialNumber
        });
        local v11 = u1.GetInventorySort("Rarity (Highest)");
        local v12;

        if v11 then
            v12 = v11(_ItemId);
        else
            v12 = nil;
        end;

        v10.LayoutOrder = v12 or 0;
        v10.Size = UDim2.fromOffset(80, 80);
        v10.Button.Size = UDim2.new(1, -40, 1, -40);
        v10.Parent = Skins;

        return v10;
    end;

    local function GetItemInfo(p13) -- Line: 45
        -- upvalues: ItemData (copy), Stands (copy)
        local v14 = {};

        if p13._UnusualInfo then
            v14.Pattern = p13._UnusualInfo.UnusualHueId;
            v14.Charm = p13._UnusualInfo.UnusualCharmId;
        end;

        v14.Rarity = ItemData.GetRarityData(p13._Rarity);
        v14.Ability = Stands[p13._AbilityId or nil];
        v14.Name = p13._DisplayName;
        v14.Id = p13._ItemId;
        v14.UUID = p13._UUID;

        return v14;
    end;

    local function AddSlot(u15) -- Line: 72
        -- upvalues: ItemData (copy), UnusualBlacklist (copy), u3 (copy), Trove (copy), CreateContainer (copy), Fusion (copy), u1 (copy), u4 (copy), GetItemInfo (copy)
        local _UUID = u15._UUID;
        local _ItemId = u15._ItemId;
        local v16 = ItemData.GetItemInfo(_ItemId);
        ItemData.GetRarity(v16);

        if UnusualBlacklist.IsBlacklisted(_ItemId) then
            return;
        end;

        if not (u15._Premium and u15._UnusualInfo) then
            return;
        end;

        if not v16 then
            return;
        end;

        if u3[_UUID] then
            return;
        end;

        local v17 = Trove.new();
        local v18 = CreateContainer(u15, v16);
        v17:Add(v18);
        local u19 = Fusion.Value(v18.Button.Size);
        Fusion.Hydrate(v18.Button)({
            Size = Fusion.Spring(u19, 32, 0.8),

            [Fusion.OnEvent("MouseButton1Down")] = function() -- Line: 107
                -- upvalues: u1 (ref), u4 (ref), GetItemInfo (ref), u15 (copy)
                if u1.UI.Prompt.Visible then
                    return;
                end;

                u1:PlaySound("Click");
                u4:set((GetItemInfo(u15)));
            end,

            [Fusion.OnEvent("MouseEnter")] = function() -- Line: 114
                -- upvalues: u19 (copy)
                u19:set(UDim2.new(1, -5, 1, -5));
            end,

            [Fusion.OnEvent("MouseLeave")] = function() -- Line: 117
                -- upvalues: u19 (copy)
                u19:set(UDim2.new(1, -12, 1, -12));
            end
        });
        u19:set(UDim2.new(1, -12, 1, -12));

        if u1.CanTooltipInventorySlot(u15) then
            u1.ConstructTooltipSlot(v18, {
                ItemId = _ItemId,
                TraitInfo = u15._TraitInfo,
                UnusualInfo = u15._UnusualInfo,
                SerialNumber = u15._SerialNumber,
                Purity = u15._Purity,
                Premium = u15._Premium
            }, v17);
        end;

        u3[_UUID] = {
            Container = v18,
            Trove = v17,
            ItemObject = u15,
            ItemInfo = v16,
            RarityInfo = ItemData.Rarities[v16._Rarity]
        };
    end;

    Parent:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 147
        -- upvalues: Parent (copy), u4 (copy), u3 (copy), u1 (copy), AddSlot (copy)
        if Parent.Visible then
            local v20 = u1.LoadInventory("SkinInventory");

            if not v20 then
                return;
            end;

            for _, v in v20 do
                task.spawn(AddSlot, v);
            end;

            return;
        end;

        u4:set(nil);

        for _, v in u3 do
            v.Trove:Destroy();
        end;

        table.clear(u3);
    end);

    local function HandleResponse(p21) -- Line: 175
        -- upvalues: u1 (copy)
        if p21 == "OnCooldown" then
            u1.NewPrompt({
                Title = "On Cooldown",
                Text = "Reroll on cooldown, please retry later"
            });

            return;
        end;

        if p21 == "NotEnough" then
            u1.NewPrompt({
                Title = "Purchase Failed",
                Text = `Not enough <font color="#44ff00">{u1.uFragmentsString}</font>`
            });

            return;
        end;

        u1.NewPrompt({
            Title = "Data Error",
            Text = "Error occured, please retry"
        });
    end;

    local function UpdateItem(u22) -- Line: 194
        -- upvalues: u4 (copy), u1 (copy), GetItemInfo (copy), u3 (copy), AddSlot (copy)
        local v23 = u4:get();

        if v23 and v23.UUID == u22 then
            task.defer(function() -- Line: 197
                -- upvalues: u1 (ref), u22 (copy), u4 (ref), GetItemInfo (ref), u3 (ref), AddSlot (ref)
                local v24 = u1.Inventory.SkinInventory and u1.Inventory.SkinInventory[u22];
                u4:set((GetItemInfo(v24)));

                if u3[u22] then
                    u3[u22].Trove:Destroy();
                    u3[u22] = nil;
                    AddSlot(v24);
                end;
            end);
        end;
    end;

    local function UpdateCurrency() -- Line: 224
        -- upvalues: u1 (copy), u2 (copy), RerollSection (copy)
        local v25 = `<font color="#44ff00">{u1:AbbreviateNumber(u2:GetCurrencyType("UFragments"):expect())} {u1.uFragmentsString}</font>`;
        RerollSection.Currency.Text = v25;
    end;

    u1.CurrencyUpdated:Connect(function(p26) -- Line: 231
        -- upvalues: u1 (copy), u2 (copy), RerollSection (copy)
        if p26 ~= "Changed" then
            return;
        end;

        local v27 = `<font color="#44ff00">{u1:AbbreviateNumber(u2:GetCurrencyType("UFragments"):expect())} {u1.uFragmentsString}</font>`;
        RerollSection.Currency.Text = v27;
    end);
    local v28 = `<font color="#44ff00">{u1:AbbreviateNumber(u2:GetCurrencyType("UFragments"):expect())} {u1.uFragmentsString}</font>`;
    RerollSection.Currency.Text = v28;
    Fusion.Hydrate(RerollSection.SelectedName)({
        Text = Fusion.Computed(function() -- Line: 240
            -- upvalues: u4 (copy)
            local v29 = u4:get();

            return not v29 and "None" or v29.Name;
        end),
        TextColor3 = Fusion.Spring(Fusion.Computed(function() -- Line: 246
            -- upvalues: u4 (copy)
            local v30 = u4:get();

            if v30 then
                return v30.Rarity.Color;
            end;

            return Color3.new(1, 1, 1);
        end), 10, 0.6)
    });
    Fusion.Hydrate(RerollSection.SelectedInfo)({
        Text = Fusion.Computed(function() -- Line: 255
            -- upvalues: u4 (copy)
            local v31 = u4:get();

            return not v31 and "- • -" or `{v31.Ability} • {v31.Rarity.Name}`;
        end)
    });
    Fusion.Hydrate(RerollSection.Pattern.Value)({
        Text = Fusion.Computed(function() -- Line: 264
            -- upvalues: u4 (copy)
            local v32 = u4:get();

            return not v32 and "-" or v32.Pattern;
        end)
    });
    Fusion.Hydrate(RerollSection.Charm.Value)({
        Text = Fusion.Computed(function() -- Line: 273
            -- upvalues: u4 (copy), CharmsHandler (copy)
            local v33 = u4:get();

            if not v33 then
                return "-";
            end;

            local Charm = v33.Charm;
            local v34;

            if tostring(Charm) == "nan" then
                v34 = false;
            else
                v34 = CharmsHandler.GetCharmInfo(Charm);
            end;

            if v34 then
                Charm = v34.DisplayName;

                if not Charm then
                    return v34.Charm;
                end;
            end;

            return Charm;
        end)
    });
    Fusion.Hydrate(RerollSection.Pattern.Preview)({
        BackgroundColor3 = Fusion.Spring(Fusion.Computed(function() -- Line: 286
            -- upvalues: u4 (copy)
            local v35 = u4:get();

            if not v35 then
                return Color3.new(1, 1, 1);
            end;

            local Pattern = v35.Pattern;

            if Pattern == (1 / 0) then
                return Color3.new(1, 1, 1);
            end;

            if type(Pattern) == "number" and Pattern ~= Pattern then
                return Color3.new();
            end;

            return Color3.fromHSV(Pattern * 5 / 360, 1, 1);
        end), 10, 0.6)
    });

    local function Reroll(u36, p37) -- Line: 210
        -- upvalues: u2 (copy), HandleResponse (copy), u4 (copy), u1 (copy), GetItemInfo (copy), u3 (copy), AddSlot (copy)
        if not (u36 and p37) then
            return;
        end;

        local v38 = u2:RerollUnusualType(u36, p37):expect();

        if not v38 or typeof(v38) == "string" then
            HandleResponse(v38);

            return;
        end;

        task.wait();
        local v39 = u4:get();

        if v39 and v39.UUID == u36 then
            task.defer(function() -- Line: 197
                -- upvalues: u1 (ref), u36 (copy), u4 (ref), GetItemInfo (ref), u3 (ref), AddSlot (ref)
                local v40 = u1.Inventory.SkinInventory and u1.Inventory.SkinInventory[u36];
                u4:set((GetItemInfo(v40)));

                if u3[u36] then
                    u3[u36].Trove:Destroy();
                    u3[u36] = nil;
                    AddSlot(v40);
                end;
            end);
        end;
    end;

    for _, v in { RerollSection.Pattern.Roll, RerollSection.Charm.Roll } do
        local Name = v.Parent.Name;
        local u41 = Name == "Charm" and 1 or 2;
        v.MouseButton1Click:Connect(function() -- Line: 304
            -- upvalues: u1 (copy), u4 (copy), Name (copy), u41 (copy), Reroll (copy)
            u1:PlaySound("Click");
            local u42 = u4:get();

            if not u42 then
                return;
            end;

            u1.NewPrompt({
                Title = "Unusual Reroll",
                Delay = 0.5,
                Text = `Are you sure you want to reroll the <font color="#ffce3c">{Name}</font> of your <font color="#AA55FF">Unusual</font> {u1:GetItemText(u42.Id)} for {tostring(u41)} <font color="#44ff00">{u1.uFragmentsString}</font>?`,
                RichText = { 2 },
                Options = { "Cancel", `{tostring(u41)} <font color="#44ff00">{u1.uFragmentsString}</font>` },

                Callback = function(p43) -- Line: 317, Name: Callback
                    -- upvalues: u1 (ref), Reroll (ref), u42 (copy), Name (ref)
                    u1:PlaySound("Click");

                    if p43.Choice ~= 2 then
                        return;
                    end;

                    Reroll(u42.UUID, Name);
                end
            });
        end);
    end;
end;
  

 

return function(u1) -- Line: 1
    local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
    require(PathShortcuts.KnitPath.Promise);
    local Signal = require(PathShortcuts.KnitPath.Signal);
    require(PathShortcuts.KnitPath.Trove);
    local ItemData = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules"):WaitForChild("ItemData"));
    local TraitHandler = require(PathShortcuts.ReplicatedModules:WaitForChild("PVEPackage"):WaitForChild("TraitHandler"));
    local CharmsHandler = require(PathShortcuts.ReplicatedModules:WaitForChild("PVEPackage"):WaitForChild("CharmsHandler"));
    local ItemFrames = require(PathShortcuts.ReplicatedModules:WaitForChild("ItemFrames"));
    local InventorySlot = script.InventorySlot;
    local v2 = u1.Knit.GetService("TraitService");
    local TooltipHydrators = require(script.TooltipHydrators);
    local u3 = nil;
    u1.InventorySignals = {
        ItemSelected = Signal.new()
    };
    local u15 = {
        ["A - Z"] = function(p4) -- Line: 24
            -- upvalues: ItemData (copy)
            local v5 = ItemData.GetItemInfo(p4);

            return not v5.Name and 100 or string.byte(v5.Name:upper());
        end,

        ["Z - A"] = function(p6) -- Line: 28
            -- upvalues: ItemData (copy)
            local v7 = ItemData.GetItemInfo(p6);

            return not v7.Name and -100 or string.byte(v7.Name:upper()) * -1;
        end,

        ["Rarity (Highest)"] = function(p8) -- Line: 32
            -- upvalues: ItemData (copy)
            local v9 = ItemData.GetItemInfo(p8);
            local v10 = ItemData.GetRarityData(v9.Rarity);

            return (v10 and v10.LayoutOrder or v9.Rarity or 0) * -10;
        end,

        ["Rarity (Lowest)"] = function(p11) -- Line: 38
            -- upvalues: ItemData (copy)
            local v12 = ItemData.GetItemInfo(p11);
            local v13 = ItemData.GetRarityData(v12.Rarity);

            return (v13 and v13.LayoutOrder or v12.Rarity or 0) * 10;
        end,

        BlackMarket = function(p14) -- Line: 44
            -- upvalues: ItemData (copy)
            return (ItemData.GetItemInfo(p14).BlackMarketMaxPrice or 0) * -1;
        end
    };

    function u1.GetInventorySort(p16) -- Line: 51
        -- upvalues: u15 (copy)
        return u15[p16];
    end;

    function u1.CreateInventorySlot(p17, p18) -- Line: 55
        -- upvalues: InventorySlot (copy), TraitHandler (copy), u3 (ref), ItemData (copy), ItemFrames (copy), u1 (copy)
        local v19 = p18 or {};
        local v20 = InventorySlot:Clone();
        v20.Name = p17.ItemId;
        local v21 = "";

        if v19.UnusualInfo then
            v21 = v21 .. (v19.UnusualInfo.Chroma and "<font color=\"#FF0000\">C</font><font color=\"#CCFF00\">H</font><font color=\"#00FF66\">R</font><font color=\"#0066FF\">O</font><font color=\"#CC00FF\">M</font><font color=\"#FF0000\">A</font>" or "<font color=\"#AA55FF\">Unusual</font>");
        end;

        if v19.TraitInfo then
            if #v21 > 0 then
                v21 = v21 .. " ";
            end;

            local v22 = TraitHandler.GetTraitData(v19.TraitInfo.Trait);
            local v23 = u3[v19.TraitInfo.Hexed and "Hexed" or v22.Rarity];

            if v19.TraitInfo.StatBonuses then
                local v24 = 0;

                for _, v in v19.TraitInfo.StatBonuses do
                    v24 = v24 + (v23.Max <= v and 1 or (v <= v23.Min and -1 or 0));
                end;

                v21 = v21 .. (v24 >= 4 and "<font color=\"#FFB000\">Perfect</font> " or (v24 <= -4 and "<font color=\"#FF0000\">Depressing</font> " or ""));
            end;

            if v19.TraitInfo.Hexed and v22.HexPrefix then
                v21 = v21 .. `{v22.HexPrefix} `;
            end;

            v21 = v21 .. v19.TraitInfo.Trait;
        end;

        v20.Button.Label.Text = "";
        v20.Button.Label.RichText = false;

        if #v21 > 0 then
            local Label = v20.Button.Label;
            Label.Text = Label.Text .. v21 .. " ";
            v20.Button.Label.RichText = true;
        end;

        local Label = v20.Button.Label;
        Label.Text = Label.Text .. (p17.Name or "");
        local v25 = ItemData.Rarities[p17.Rarity];

        if v25 then
            v20.Button.UIStroke.UIGradient.Enabled = false;
            v20.Button.UIStroke.RarityGradient.Enabled = true;
            v20.Button.UIStroke.Color = v25.Color or Color3.new(1, 1, 1);
        else
            v20.Button.UIStroke.UIGradient.Enabled = true;
            v20.Button.UIStroke.RarityGradient.Enabled = false;
            v20.Button.UIStroke.Color = Color3.new(1, 1, 1);
        end;

        v20.Button.Amount.Text = "";
        v20.Button.Label.Visible = true;
        v20.Visible = true;

        if ItemFrames[p17.ItemId] and not v20:GetAttribute("FrameConnection") then
            v20:SetAttribute("FrameConnection", true);
            task.defer(ItemFrames[p17.ItemId], unpack({ u1, v20 }));
        end;

        return v20;
    end;

    local u26 = nil;

    function u1.ConstructTooltipSlot(p27, u28, p29) -- Line: 127
        -- upvalues: u1 (copy), ItemData (copy), TraitHandler (copy), u3 (ref), CharmsHandler (copy), TooltipHydrators (copy), u26 (ref)
        local MainToolTipScreen = u1.MainToolTipScreen;
        local u30 = ItemData.GetItemInfo(u28.ItemId);
        local u31 = "";

        if u28.SerialNumber then
            local SerialNumber = u28.SerialNumber;

            if type(SerialNumber) == "number" then
                u31 = u31 .. `#{SerialNumber}`;
            end;
        end;

        if u28.TraitInfo then
            if #u31 > 0 then
                u31 = u31 .. "\n";
            end;

            local v32 = TraitHandler.GetTraitData(u28.TraitInfo.Trait);
            local Rarity = v32.Rarity;
            local v33 = "";

            if u28.TraitInfo.Hexed and v32.HexPrefix then
                v33 = v33 .. `{v32.HexPrefix} `;
            end;

            local v34 = v33 .. u28.TraitInfo.Trait;
            u31 = u31 .. `Trait: <font color="#{ItemData.GetRarityByName(Rarity).Color:ToHex()}">{v34}</font>`;

            if u28.TraitInfo.StatBonuses then
                local v35 = u3[u28.TraitInfo.Hexed and "Hexed" or Rarity];
                local v36 = {
                    Attack = Color3.fromRGB(255, 97, 97),
                    Defense = Color3.fromRGB(255, 180, 115),
                    Health = Color3.fromRGB(100, 220, 100),
                    Special = Color3.fromRGB(116, 211, 255)
                };
                local v37 = 0;
                local v38 = "";

                for i, v in u28.TraitInfo.StatBonuses do
                    local v39 = v35.Max <= v;
                    local v40 = v <= v35.Min;
                    v37 = v37 + (v39 and 1 or (v40 and -1 or 0));
                    v38 = v38 .. `\n\t<font color="#{v36[i]:ToHex()}">{(v39 and "<font color=\"#FFB000\">★</font> " or (v40 and "<font color=\"#FF0000\">💔</font> " or "")) .. i}: {v .. (v39 and " <font color=\"#FFB000\">★</font>" or (v40 and " <font color=\"#FF0000\">💔</font>" or ""))}</font>`;
                end;

                u31 = (u31 .. "\nStat Bonuses:") .. (v37 >= 4 and "\n<font color=\"#FFB000\">Perfect</font> " or (v37 <= -4 and "\n<font color=\"#FF0000\">Depressing</font> " or "")) .. v38;
            end;
        end;

        if u28.UnusualInfo then
            if #u31 > 0 then
                u31 = u31 .. "\n";
            end;

            local UnusualHueId = u28.UnusualInfo.UnusualHueId;
            local UnusualCharmId = u28.UnusualInfo.UnusualCharmId;
            local Chroma = u28.UnusualInfo.Chroma;
            local v41;

            if tostring(UnusualCharmId) == "nan" then
                v41 = false;
            else
                v41 = CharmsHandler.GetCharmInfo(UnusualCharmId);
            end;

            local v42;

            if v41 then
                v42 = v41.DisplayName or v41.Charm;
            else
                v42 = UnusualCharmId;
            end;

            local v43 = nil;
            local v44 = nil;
            local v45 = tostring(UnusualCharmId) == "nan" and "" or (`\n<font color="#4B96FF">Charm: {v42}</font>` or "");

            if UnusualHueId == 0 then
                v44 = "#FFFFFF";
            elseif UnusualHueId >= 9000000000 then
                v43 = "<font color=\"#fff\"><stroke color=\"#fff\" tr=\"0.5\">White</stroke> Pattern</font> (<font color=\"#fff\">■■■</font>)" .. v45;
            elseif UnusualHueId == UnusualHueId then
                local v46 = Color3.fromHSV(UnusualHueId * 5 / 360, 1, 1);

                local function RgbToHex(p47) -- Line: 207
                    return string.format("#%02X%02X%02X", math.floor(p47.R * 255 + 0.5), math.floor(p47.G * 255 + 0.5), (math.floor(p47.B * 255 + 0.5)));
                end;

                v44 = string.format("#%02X%02X%02X", math.floor(v46.R * 255 + 0.5), math.floor(v46.G * 255 + 0.5), (math.floor(v46.B * 255 + 0.5)));
            else
                v43 = "<stroke color=\"#888\" tr=\"0.5\"><font color=\"#000\">Black Pattern</font></stroke> (<font color=\"#000\">■■■</font>)" .. v45;
            end;

            if v43 then
                u31 = u31 .. v43;
            else
                u31 = u31 .. (Chroma and "<font color=\"#FF0000\">C</font><font color=\"#CCFF00\">H</font><font color=\"#00FF66\">R</font><font color=\"#0066FF\">O</font><font color=\"#CC00FF\">M</font><font color=\"#FF0000\">A</font>" or `<font color="#AA55FF">Pattern {UnusualHueId}</font> ({string.format("<font color=\"%s\">■■■</font>", v44, UnusualHueId)})`) .. v45;
            end;
        end;

        if u28.Purity then
            local v48 = {
                [25] = Color3.fromRGB(255, 90, 90),
                [50] = Color3.fromRGB(255, 194, 12),
                [75] = Color3.fromRGB(88, 255, 144),
                [100] = Color3.fromRGB(255, 51, 218)
            };
            local Purity = u28.Purity;
            local v49 = Color3.new(1, 1, 1);

            if Purity > 0 and Purity <= 25 then
                v49 = v48[25];
            elseif Purity > 25 and Purity <= 50 then
                v49 = v48[50];
            elseif Purity > 50 and Purity <= 75 then
                v49 = v48[75];
            elseif Purity > 75 then
                v49 = v48[100];
            end;

            u31 = u31 .. `<font color="#{v49:ToHex()}">Purity: {Purity}%</font>`;
        end;

        if u28.Premium then
            u31 = u31 .. `<br /><font color="#{Color3.fromRGB(255, 255, 0):ToHex()}">Premium</font>`;
        end;

        if u28.LinkedAbilityId then
            local v50 = `ABILITY_{u28.LinkedAbilityId}`;

            if #u31 > 0 then
                u31 = u31 .. "\n";
            end;

            local v51 = ItemData.GetItemInfo(v50) or {};
            u31 = u31 .. `Ability: {v51.DisplayName or v51.Name}`;
        end;

        if u28.ItemId and TooltipHydrators[u28.ItemId] then
            u31 = u31 .. TooltipHydrators[u28.ItemId](u28);
        end;

        p29:Connect(p27.MouseEnter, function() -- Line: 270
            -- upvalues: u26 (ref), u28 (copy), ItemData (ref), u30 (copy), MainToolTipScreen (copy), u31 (ref)
            u26 = u28;
            MainToolTipScreen:SetTitle((`<font color="#{ItemData.GetRarity(u30).Color:ToHex()}">{u30.Name}</font>`));
            MainToolTipScreen:SetText(u31);
            MainToolTipScreen:Show();
        end);
        p29:Connect(p27.MouseLeave, function() -- Line: 279
            -- upvalues: u26 (ref), u28 (copy), MainToolTipScreen (copy)
            if u26 ~= u28 then
                return;
            end;

            MainToolTipScreen:Hide();
        end);
        p29:Connect(p27.Destroying, function() -- Line: 283
            -- upvalues: u26 (ref), u28 (copy), MainToolTipScreen (copy)
            if u26 ~= u28 then
                return;
            end;

            MainToolTipScreen:Hide();
        end);
    end;

    function u1.CanTooltipTradeSlot(p52) -- Line: 290
        return p52.TraitInfo or (p52.UnusualInfo or p52.SerialNumber or (p52.Purity or p52.Premium));
    end;

    function u1.CanTooltipInventorySlot(p53) -- Line: 294
        -- upvalues: TooltipHydrators (copy)
        return p53._TraitInfo or p53._UnusualInfo or (p53._SerialNumber or p53._Purity or (p53._Premium or TooltipHydrators[p53._ItemId]));
    end;

    u3 = v2:GetTraitsMetadata():expect().StatRanges;
end;
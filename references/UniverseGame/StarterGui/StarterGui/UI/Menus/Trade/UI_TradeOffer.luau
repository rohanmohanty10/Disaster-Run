  

 

return function(u1) -- Line: 1
    local _ = u1.Xtal;
    local _ = script.Parent.Assets.Container;
    local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
    local Promise = require(PathShortcuts.KnitPath.Promise);
    local Trove = require(PathShortcuts.KnitPath.Trove);
    local ItemData = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").ItemData);
    local TraitHandler = require(PathShortcuts.ReplicatedModules:WaitForChild("PVEPackage"):WaitForChild("TraitHandler"));
    local u2 = u1.Knit.GetService("TradeService");
    local u3 = Trove.new();
    local u4 = false;
    local u5 = false;
    local Parent = script.Parent;
    local Parent2 = Parent.Parent;
    local Self = script.Parent.Self;
    local Target = script.Parent.Target;
    local Window = script.Parent.Window;
    local Window2 = Self.Window;
    local Window3 = Target.Window;
    local Items = Self.Items;
    local Items2 = Target.Items;
    local u6 = {};
    local u7 = {};
    u1.TradingSlots = u6;

    local function AddSlot(p8, p9, p10) -- Line: 36
        -- upvalues: ItemData (copy), u3 (copy), u1 (copy), u2 (copy)
        local ItemId = p8.ItemId;
        local v11 = ItemData.GetItemInfo(ItemId);
        local UUID = p8.UUID;

        if p9[UUID] then
            return;
        end;

        local v12 = u3.new();
        local v13 = v12:Add(u1.CreateInventorySlot(v11, {
            TraitInfo = p8.TraitInfo,
            UnusualInfo = p8.UnusualInfo,
            SerialNumber = ItemId.SerialNumber
        }));
        v13.LayoutOrder = (v11.Rarity or 0) * -1;
        v12:Connect(v13.Button.MouseButton1Down, function() -- Line: 53
            -- upvalues: u2 (ref), UUID (copy)
            u2.RemoveTradeItem:Fire({
                UUID = UUID
            });
        end);

        if u1.CanTooltipTradeSlot(p8) or v11.LinkedAbilityId then
            u1.ConstructTooltipSlot(v13, {
                ItemId = ItemId,
                TraitInfo = p8.TraitInfo,
                UnusualInfo = p8.UnusualInfo,
                SerialNumber = p8.SerialNumber,
                Purity = p8.Purity,
                Premium = p8.Premium,
                PremiumCrate = p8.PremiumCrate,
                LinkedAbilityId = v11.LinkedAbilityId
            }, v12);
        end;

        v13.Visible = true;
        v13.Parent = p10;
        p9[UUID] = {
            Count = 1,
            Container = v13,
            Trove = v12,
            ItemId = ItemId
        };
    end;

    local u14 = nil;
    local Confirm = script.Parent.Buttons.Confirm;
    Confirm.BackgroundTransparency = 0.4;
    Confirm.TextLabel.Text = "<font color=\"#FF0000\">Complete Trade</font>";
    Confirm.MouseButton1Click:Connect(function() -- Line: 92
        -- upvalues: u14 (ref), u4 (ref), u5 (ref), u2 (copy), Confirm (copy)
        if u14 then
            return;
        end;

        if u4 and u5 then
            u2.CompleteTrade:Fire();
            Confirm.BackgroundTransparency = 0.7;
            Confirm.TextLabel.Text = "<font color=\"#00FF00\">Complete Trade</font>";
            u14 = true;
        end;
    end);
    local Ready = Self.Ready;

    local function SetReadyButton(p15, p16) -- Line: 104
        -- upvalues: u4 (ref), u5 (ref), Confirm (copy)
        if p16 then
            p15.Unready.Visible = false;
            p15.Ready.Visible = true;
            p15.TextLabel.Text = "Ready to trade";
        else
            p15.Ready.Visible = false;
            p15.Unready.Visible = true;
            p15.TextLabel.Text = "Not ready to trade";
        end;

        if u4 and u5 then
            Confirm.TextLabel.TextTransparency = 0;

            return;
        end;

        Confirm.TextLabel.TextTransparency = 0.5;
    end;

    Ready.MouseButton1Click:Connect(function() -- Line: 123
        -- upvalues: u4 (ref), u2 (copy)
        u4 = not u4;

        if u4 then
            u2.ReadyTrade:Fire();

            return;
        end;

        u2.UnreadyTrade:Fire();
    end);
    local Items3 = Self.Items;
    local UIGridLayout = Items3.UIGridLayout;
    local Items4 = Target.Items;
    local UIGridLayout2 = Items4.UIGridLayout;
    local Ready2 = Target.Ready;

    local function ItemAdded(p17, p18, p19) -- Line: 140
        -- upvalues: AddSlot (copy), u6 (copy), u4 (ref), Ready (copy), u5 (ref), Confirm (copy)
        AddSlot(p17, p18, p19);

        if p18 == u6 then
            u4 = false;
            local v20 = Ready;

            if u4 then
                v20.Unready.Visible = false;
                v20.Ready.Visible = true;
                v20.TextLabel.Text = "Ready to trade";
            else
                v20.Ready.Visible = false;
                v20.Unready.Visible = true;
                v20.TextLabel.Text = "Not ready to trade";
            end;

            if u4 and u5 then
                Confirm.TextLabel.TextTransparency = 0;

                return;
            end;

            Confirm.TextLabel.TextTransparency = 0.5;
        end;
    end;

    local function ItemRemoved(p21, p22) -- Line: 148
        -- upvalues: u6 (copy), u4 (ref), Ready (copy), u5 (ref), Confirm (copy)
        p21[p22].Trove:Destroy();
        p21[p22] = nil;

        if p21 == u6 then
            u4 = false;
            local v23 = Ready;

            if u4 then
                v23.Unready.Visible = false;
                v23.Ready.Visible = true;
                v23.TextLabel.Text = "Ready to trade";
            else
                v23.Ready.Visible = false;
                v23.Unready.Visible = true;
                v23.TextLabel.Text = "Not ready to trade";
            end;

            if u4 and u5 then
                Confirm.TextLabel.TextTransparency = 0;

                return;
            end;

            Confirm.TextLabel.TextTransparency = 0.5;
        end;
    end;

    local function CleanUp() -- Line: 157
        -- upvalues: u6 (copy), u7 (copy), u4 (ref), u5 (ref), Ready (copy), Confirm (copy), Ready2 (copy), u1 (copy), Window2 (copy), Window3 (copy), Window (copy), u14 (ref)
        for i, v in pairs(u6) do
            v.Trove:Destroy();
            u6[i] = nil;
        end;

        for i, v in pairs(u7) do
            v.Trove:Destroy();
            u7[i] = nil;
        end;

        u4 = false;
        u5 = false;
        local v24 = Ready;
        v24.Ready.Visible = false;
        v24.Unready.Visible = true;
        v24.TextLabel.Text = "Not ready to trade";

        if u4 and u5 then
            Confirm.TextLabel.TextTransparency = 0;
        else
            Confirm.TextLabel.TextTransparency = 0.5;
        end;

        local v25 = Ready2;
        v25.Ready.Visible = false;
        v25.Unready.Visible = true;
        v25.TextLabel.Text = "Not ready to trade";

        if u4 and u5 then
            Confirm.TextLabel.TextTransparency = 0;
        else
            Confirm.TextLabel.TextTransparency = 0.5;
        end;

        u1:SetMenu(nil);
        Window2.Text = "Your Offer";
        Window3.Text = "Username\'s Offer";
        Window.Text = "Trading with Username";
        Confirm.BackgroundTransparency = 0.4;
        Confirm.TextLabel.Text = "<font color=\"#FF0000\">Complete Trade</font>";
        u14 = false;
    end;

    local function UpdateTradeUI() -- Line: 179
        -- upvalues: Items3 (copy), UIGridLayout (copy), Items4 (copy), UIGridLayout2 (copy)
        Items3.CanvasSize = UDim2.fromOffset(0, UIGridLayout.AbsoluteContentSize.Y + 100);
        Items4.CanvasSize = UDim2.fromOffset(0, UIGridLayout2.AbsoluteContentSize.Y + 100);
    end;

    local u26 = nil;
    Parent.Cancel.MouseButton1Click:Connect(function() -- Line: 188
        -- upvalues: u1 (copy), u26 (ref), CleanUp (copy), u2 (copy)
        u1:PlaySound("Click");

        if not u26 then
            u2.CancelTrade:Fire();

            return;
        end;

        pcall(CleanUp);
        u26 = false;
    end);
    u2.NotifyTrade:Connect(function(u27) -- Line: 198
        -- upvalues: u1 (copy), u2 (copy)
        u1:Notify("Trade Request", string.format("%s\n@%s", u27.DisplayName, u27.Name), 3, { "Accept", "Decline" }, function(p28, p29, p30) -- Line: 203
            -- upvalues: u2 (ref), u27 (copy)
            if p29 == 1 then
                u2.StartTrade:Fire(u27);
            end;
        end);
    end);
    u2.StartTrade:Connect(function(p31) -- Line: 210
        -- upvalues: CleanUp (copy), u1 (copy), u3 (copy), Parent2 (copy), Parent (copy), Window3 (copy), Window (copy), Promise (copy)
        game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true);
        pcall(CleanUp);
        u1:SetMenu("Trade");
        u3:Connect(Parent2:GetPropertyChangedSignal("Visible"), function() -- Line: 214
            -- upvalues: u1 (ref)
            u1:SetMenu("Trade");
        end);
        u3:Connect(Parent:GetPropertyChangedSignal("Visible"), function() -- Line: 217
            -- upvalues: u1 (ref)
            u1:SetMenu("Trade");
        end);
        u3:Add(CleanUp);
        u1.SetTradeInventory("Skins", true);
        Window3.Text = string.format("%s\'s Offer", p31.DisplayName);
        Window.Text = `Trading with {p31.DisplayName}`;

        for _, v in ipairs({ "SkinInventory", "ItemInventory", "AbilityInventory" }) do
            Promise.try(u1.ShowInventoryCapacity, v, false, 5):catch(warn);
        end;
    end);
    u2.ReadyTrade:Connect(function(p32) -- Line: 235
        -- upvalues: u4 (ref), Ready (copy), u5 (ref), Confirm (copy), Ready2 (copy)
        if p32 then
            u4 = true;
            local v33 = Ready;
            v33.Unready.Visible = false;
            v33.Ready.Visible = true;
            v33.TextLabel.Text = "Ready to trade";

            if u4 and u5 then
                Confirm.TextLabel.TextTransparency = 0;

                return;
            end;

            Confirm.TextLabel.TextTransparency = 0.5;

            return;
        end;

        u5 = true;
        local v34 = Ready2;
        v34.Unready.Visible = false;
        v34.Ready.Visible = true;
        v34.TextLabel.Text = "Ready to trade";

        if u4 and u5 then
            Confirm.TextLabel.TextTransparency = 0;

            return;
        end;

        Confirm.TextLabel.TextTransparency = 0.5;
    end);
    u2.UnreadyTrade:Connect(function(p35) -- Line: 245
        -- upvalues: u4 (ref), Ready (copy), u5 (ref), Confirm (copy), Ready2 (copy)
        if p35 then
            u4 = false;
            local v36 = Ready;
            v36.Ready.Visible = false;
            v36.Unready.Visible = true;
            v36.TextLabel.Text = "Not ready to trade";

            if u4 and u5 then
                Confirm.TextLabel.TextTransparency = 0;

                return;
            end;

            Confirm.TextLabel.TextTransparency = 0.5;

            return;
        end;

        u5 = false;
        local v37 = Ready2;
        v37.Ready.Visible = false;
        v37.Unready.Visible = true;
        v37.TextLabel.Text = "Not ready to trade";

        if u4 and u5 then
            Confirm.TextLabel.TextTransparency = 0;

            return;
        end;

        Confirm.TextLabel.TextTransparency = 0.5;
    end);
    u2.UpdateTradeUI:Connect(function(p38, ...) -- Line: 255
        -- upvalues: Confirm (copy), u6 (copy), u7 (copy), AddSlot (copy), Items (copy), Items2 (copy), Items3 (copy), UIGridLayout (copy), Items4 (copy), UIGridLayout2 (copy), u4 (ref), Ready (copy), u5 (ref), u1 (copy)
        game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Chat, true);
        local v39 = { ... };

        if p38 == "UpdateCountdown" then
            Confirm.TextLabel.Text = "<font color=\"#00FF00\">" .. tostring(v39[1]) .. "</font>";

            return;
        end;

        if p38 ~= "RefreshItems" then
            local v40 = v39[1];
            local UUID = v40.UUID;

            if p38 == "SelfItemAdded" then
                local v41 = u6;
                AddSlot(v40, v41, Items);

                if v41 == u6 then
                    u4 = false;
                    local v42 = Ready;

                    if u4 then
                        v42.Unready.Visible = false;
                        v42.Ready.Visible = true;
                        v42.TextLabel.Text = "Ready to trade";
                    else
                        v42.Ready.Visible = false;
                        v42.Unready.Visible = true;
                        v42.TextLabel.Text = "Not ready to trade";
                    end;

                    if u4 and u5 then
                        Confirm.TextLabel.TextTransparency = 0;
                    else
                        Confirm.TextLabel.TextTransparency = 0.5;
                    end;
                end;
            elseif p38 == "TargetItemAdded" then
                local v43 = u7;
                AddSlot(v40, v43, Items2);

                if v43 == u6 then
                    u4 = false;
                    local v44 = Ready;

                    if u4 then
                        v44.Unready.Visible = false;
                        v44.Ready.Visible = true;
                        v44.TextLabel.Text = "Ready to trade";
                    else
                        v44.Ready.Visible = false;
                        v44.Unready.Visible = true;
                        v44.TextLabel.Text = "Not ready to trade";
                    end;

                    if u4 and u5 then
                        Confirm.TextLabel.TextTransparency = 0;
                    else
                        Confirm.TextLabel.TextTransparency = 0.5;
                    end;
                end;
            elseif p38 == "SelfItemRemoved" then
                local v45 = u6;
                v45[UUID].Trove:Destroy();
                v45[UUID] = nil;

                if v45 == u6 then
                    u4 = false;
                    local v46 = Ready;

                    if u4 then
                        v46.Unready.Visible = false;
                        v46.Ready.Visible = true;
                        v46.TextLabel.Text = "Ready to trade";
                    else
                        v46.Ready.Visible = false;
                        v46.Unready.Visible = true;
                        v46.TextLabel.Text = "Not ready to trade";
                    end;

                    if u4 and u5 then
                        Confirm.TextLabel.TextTransparency = 0;
                    else
                        Confirm.TextLabel.TextTransparency = 0.5;
                    end;
                end;

                u1.RefreshTradeInventory(u6);
            elseif p38 == "TargetItemRemoved" then
                local v47 = u7;
                v47[UUID].Trove:Destroy();
                v47[UUID] = nil;

                if v47 == u6 then
                    u4 = false;
                    local v48 = Ready;

                    if u4 then
                        v48.Unready.Visible = false;
                        v48.Ready.Visible = true;
                        v48.TextLabel.Text = "Ready to trade";
                    else
                        v48.Ready.Visible = false;
                        v48.Unready.Visible = true;
                        v48.TextLabel.Text = "Not ready to trade";
                    end;

                    if u4 and u5 then
                        Confirm.TextLabel.TextTransparency = 0;
                    else
                        Confirm.TextLabel.TextTransparency = 0.5;
                    end;
                end;
            end;

            Items3.CanvasSize = UDim2.fromOffset(0, UIGridLayout.AbsoluteContentSize.Y + 100);
            Items4.CanvasSize = UDim2.fromOffset(0, UIGridLayout2.AbsoluteContentSize.Y + 100);

            return;
        end;

        local v49 = v39[1];

        for i, v in pairs(u6) do
            v.Trove:Destroy();
            u6[i] = nil;
        end;

        for i, v in pairs(u7) do
            v.Trove:Destroy();
            u7[i] = nil;
        end;

        for _, v in ipairs(v49.Self) do
            AddSlot(v, u6, Items);
        end;

        for _, v in ipairs(v49.Target) do
            AddSlot(v, u7, Items2);
        end;

        Items3.CanvasSize = UDim2.fromOffset(0, UIGridLayout.AbsoluteContentSize.Y + 100);
        Items4.CanvasSize = UDim2.fromOffset(0, UIGridLayout2.AbsoluteContentSize.Y + 100);
    end);
    u2.TradeFailed:Connect(function(p50) -- Line: 302
        -- upvalues: u3 (copy), u1 (copy)
        u3:Clean();

        if p50 and p50.Description then
            u1:Prompt("TRADE FAILED", p50.Description);

            return;
        end;

        u1:Prompt(
            "TRADE FAILED",
            "The trade failed to complete. This could be due to the other player disconnecting."
        );
    end);
    u2.CompleteTrade:Connect(function(p51) -- Line: 311
        -- upvalues: u3 (copy), TraitHandler (copy), u1 (copy)
        u3:Clean();

        if type(p51) ~= "table" then
            return;
        end;

        local v52 = "";

        for _, v in pairs(p51) do
            local v53 = "";

            if v._TraitInfo then
                local v54 = TraitHandler.GetTraitData(v._TraitInfo.Trait);

                if v._TraitInfo.Hexed and v54.HexPrefix then
                    v53 = v53 .. `{v54.HexPrefix} `;
                end;

                v53 = v53 .. v._TraitInfo.Trait;
            end;

            v52 = v52 .. `{v53} {u1:GetItemText(v._ItemId, true)}\n`;
        end;

        u1:Prompt("You received the following Items", v52);
    end);
    u2.ViewTradeLog:Connect(function(p55) -- Line: 331
        -- upvalues: CleanUp (copy), u26 (ref), Window2 (copy), Window3 (copy), ItemData (copy), u6 (copy), Items (copy), AddSlot (copy), u4 (ref), Ready (copy), u5 (ref), Confirm (copy), u7 (copy), Items2 (copy), u1 (copy)
        if not p55 then
            return;
        end;

        pcall(CleanUp);
        u26 = true;
        local TradeDetails = p55.TradeDetails;
        local v56 = os.date("%c", p55.TradeDate);
        local v57 = 1;

        for i, v in pairs(TradeDetails) do
            local u58 = "Unknown";
            pcall(function() -- Line: 346
                -- upvalues: u58 (ref), i (copy)
                u58 = game.Players:GetNameFromUserIdAsync(i);
            end);

            if v57 == 1 then
                Window2.Text = `{u58} Offer`;
            else
                Window3.Text = `{u58} Offer`;
            end;

            for i2, v2 in ipairs(v) do
                if type(v2) == "string" then
                    local v2 = ItemData.GetItemInfo(v2);
                    v2.UUID = i2;
                end;

                if v57 == 1 then
                    local v59 = u6;
                    AddSlot(v2, v59, Items);

                    if v59 == u6 then
                        u4 = false;
                        local v60 = Ready;

                        if u4 then
                            v60.Unready.Visible = false;
                            v60.Ready.Visible = true;
                            v60.TextLabel.Text = "Ready to trade";
                        else
                            v60.Ready.Visible = false;
                            v60.Unready.Visible = true;
                            v60.TextLabel.Text = "Not ready to trade";
                        end;

                        if u4 and u5 then
                            Confirm.TextLabel.TextTransparency = 0;
                        else
                            Confirm.TextLabel.TextTransparency = 0.5;
                        end;
                    end;
                else
                    local v61 = u7;
                    AddSlot(v2, v61, Items2);

                    if v61 == u6 then
                        u4 = false;
                        local v62 = Ready;

                        if u4 then
                            v62.Unready.Visible = false;
                            v62.Ready.Visible = true;
                            v62.TextLabel.Text = "Ready to trade";
                        else
                            v62.Ready.Visible = false;
                            v62.Unready.Visible = true;
                            v62.TextLabel.Text = "Not ready to trade";
                        end;

                        if u4 and u5 then
                            Confirm.TextLabel.TextTransparency = 0;
                        else
                            Confirm.TextLabel.TextTransparency = 0.5;
                        end;
                    end;
                end;
            end;

            v57 = v57 + 1;
        end;

        Confirm.BackgroundTransparency = 0.7;
        Confirm.TextLabel.TextTransparency = 0;
        Confirm.TextLabel.Text = `<font color="#00FF00">{v56}</font>`;
        u1:SetMenu("Trade");
    end);
end;
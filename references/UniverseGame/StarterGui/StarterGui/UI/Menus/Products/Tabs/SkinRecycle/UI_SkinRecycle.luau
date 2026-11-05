  

 

return function(u1) -- Line: 1
    local PathShortcuts = u1.PathShortcuts;
    local u2 = u1.Knit.GetService("InventoryService");
    local u3 = u1.Knit.GetService("ShopService");
    local MarketplaceService = game:GetService("MarketplaceService");
    local UserInputService = game:GetService("UserInputService");
    local Parent = script.Parent;
    local LocalPlayer = game.Players.LocalPlayer;
    local ItemData = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").ItemData);
    local Trove = require(PathShortcuts.KnitPath.Trove);
    local Frame = Parent.Skins:WaitForChild("Frame");
    local Frame2 = Parent.ToRecycle:WaitForChild("Frame");
    local ForgeInfo = Parent.ForgeInfo;
    local PointAmount = ForgeInfo:WaitForChild("Points"):WaitForChild("PointAmount");
    local Fill = ForgeInfo:WaitForChild("Points"):WaitForChild("Bar"):WaitForChild("Fill");

    if UserInputService.KeyboardEnabled then
        Frame:WaitForChild("UIGridLayout").CellSize = UDim2.fromOffset(80, 80);
        Frame2:WaitForChild("UIGridLayout").CellSize = UDim2.fromOffset(80, 80);
    elseif UserInputService.TouchEnabled then
        Frame:WaitForChild("UIGridLayout").CellSize = UDim2.fromOffset(60, 60);
        Frame2:WaitForChild("UIGridLayout").CellSize = UDim2.fromOffset(60, 60);
    end;

    local success, result = pcall(function() -- Line: 31
        -- upvalues: MarketplaceService (copy), LocalPlayer (copy), u3 (copy)
        return MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, 939773206) or u3:OwnsGamepass(LocalPlayer.UserId, 939773206):expect();
    end);
    local u4 = success and result and true or nil;

    if u4 then
        ForgeInfo:WaitForChild("UnusualFee").Text = `Fee: <font color="#{u1.UCoinsTextColor:ToHex()}">FREE</font>`;
    else
        ForgeInfo:WaitForChild("UnusualFee").Text = `Fee: <font color="#{u1.UCoinsTextColor:ToHex()}">{u1:AbbreviateNumber(1000000)} {u1.UCoinsString}</font>`;
    end;

    local u5 = {};
    local u6 = {};
    local u7 = 0;
    local u8 = nil;
    local u9 = 0;
    local Recycle = Parent:WaitForChild("Recycle");
    local Position = Parent.Recycle.Position;

    local function ShakeButton() -- Line: 57
        -- upvalues: Recycle (copy), Position (copy)
        local v10 = 0;

        while v10 < 1 do
            Recycle.Position = Position + UDim2.fromScale(math.sin(v10 * 30) * 0.0175 * (1 - v10), 0);
            v10 = v10 + task.wait() * 3;
        end;

        Recycle.Position = Position;
    end;

    local function GetSort(p11, p12) -- Line: 68
        -- upvalues: u1 (copy)
        local v13 = u1.GetInventorySort("Rarity (Highest)");

        if v13 then
            return v13(p11);
        end;
    end;

    local function CreateContainer(p14, p15) -- Line: 75
        -- upvalues: u1 (copy), Frame (copy)
        local _ItemId = p14._ItemId;
        local v16 = u1.CreateInventorySlot(p15, {
            TraitInfo = p14._TraitInfo,
            UnusualInfo = p14._UnusualInfo,
            SerialNumber = p14._SerialNumber
        });
        local v17 = u1.GetInventorySort("Rarity (Highest)");
        local v18;

        if v17 then
            v18 = v17(_ItemId);
        else
            v18 = nil;
        end;

        v16.LayoutOrder = v18 or 0;
        v16.Parent = Frame;

        return v16;
    end;

    local function UpdatePoints() -- Line: 87
        -- upvalues: u3 (copy), u6 (copy), PointAmount (copy), Fill (copy)
        local v19 = u3:GetCurrencyType("RecyclePoints"):expect();

        for _, v in u6 do
            v19 = v19 + v.Points;
        end;

        PointAmount.Text = `{v19} / {1000}`;
        Fill.Size = UDim2.fromScale(math.clamp(v19 / 1000, 0, 1), 1);
    end;

    local function AddSlot(p20) -- Line: 98
        -- upvalues: ItemData (copy), u5 (copy), Trove (copy), CreateContainer (copy), u1 (copy), u8 (ref), Frame (copy), u7 (ref), u6 (copy), Frame2 (copy), ShakeButton (ref), u9 (ref), UpdatePoints (copy)
        if p20._UnusualInfo or (p20._Premium or p20._Tradeable ~= true) then
            return;
        end;

        if p20._Locked then
            return;
        end;

        local _UUID = p20._UUID;
        local _ItemId = p20._ItemId;
        local v21 = ItemData.GetItemInfo(_ItemId);

        if not v21 or v21.Tradeable == false then
            return;
        end;

        local v22 = ItemData.GetRarity(v21);
        local PremiumPoints = v22.PremiumPoints;

        if not PremiumPoints then
            return;
        end;

        if u5[_UUID] then
            return;
        end;

        local v23 = Trove.new();
        local u24 = CreateContainer(p20, v21);
        v23:Add(u24);
        v23:Connect(u24.Button.MouseButton1Down, function() -- Line: 121
            -- upvalues: u1 (ref), u8 (ref), u24 (copy), Frame (ref), u7 (ref), u6 (ref), _UUID (copy), u5 (ref), _UUID (copy), Frame2 (ref), ShakeButton (ref), u9 (ref), UpdatePoints (ref)
            if u1.UI.Prompt.Visible or (u8 or u1.Player:GetAttribute("RecycleCooldown")) then
                return;
            end;

            u1:PlaySound("Click");
            local v25 = u24.Parent == Frame;

            if v25 and u7 < 25 then
                u6[_UUID] = u5[_UUID];
                u5[_UUID] = nil;
                u7 = u7 + 1;
                u24.Parent = Frame2;
            elseif not v25 then
                u5[_UUID] = u6[_UUID];
                u6[_UUID] = nil;
                u24.Parent = Frame;

                if u7 > 0 then
                    u7 = u7 - 1;
                end;
            end;

            if u7 >= 25 and u24.Parent == Frame then
                task.spawn(ShakeButton);
                u9 = u9 + 1;

                if u9 >= 3 then
                    u1.NewPrompt({
                        Title = "Max Recycle",
                        Text = "You can only recycle 25 skins at a time, recycling skins will give you points for forging unusuals",
                        Delay = 2
                    });
                end;

                task.delay(3, function() -- Line: 152
                    -- upvalues: u9 (ref)
                    u9 = u9 - 1;
                end);
            end;

            UpdatePoints();
        end);

        if u1.CanTooltipInventorySlot(p20) then
            u1.ConstructTooltipSlot(u24, {
                ItemId = _ItemId,
                TraitInfo = p20._TraitInfo,
                UnusualInfo = p20._UnusualInfo,
                SerialNumber = p20._SerialNumber,
                Purity = p20._Purity
            }, v23);
        end;

        u5[_UUID] = {
            Container = u24,
            Trove = v23,
            ItemObject = p20,
            ItemInfo = v21,
            RarityInfo = v22,
            Points = PremiumPoints
        };
    end;

    Parent:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 178
        -- upvalues: Parent (copy), u7 (ref), u5 (copy), u6 (copy), UpdatePoints (copy), u2 (copy), AddSlot (copy)
        if Parent.Visible then
            task.spawn(UpdatePoints);
            local v26 = u2:GetItems("SkinInventory"):expect();

            if not v26 then
                return;
            end;

            for _, v in v26 do
                task.spawn(AddSlot, v);
            end;

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
    end);

    local function HandleResponse(p27, p28) -- Line: 204
        -- upvalues: u1 (copy)
        if p27 == "OnCooldown" then
            u1.NewPrompt({
                Title = "On Cooldown",
                Text = "Skin Recycling / Unusual Forging on Cooldown, please retry later"
            });

            return;
        end;

        if p27 == "OnProfileCooldown" then
            local function FormatTime(p29) -- Line: 211
                return string.format("%02i hours, %02i minutes, %02i seconds", p29 / 3600, p29 / 60 % 60, p29 % 60);
            end;

            local NewPrompt = u1.NewPrompt;
            local v30 = {
                Title = "On Cooldown"
            };
            local v31 = p28 - os.time();
            v30.Text = `Unusual Forging on Cooldown, retry within {string.format("%02i hours, %02i minutes, %02i seconds", v31 / 3600, v31 / 60 % 60, v31 % 60)}`;
            NewPrompt(v30);

            return;
        end;

        if p27 == "UCoinsLow" then
            u1.NewPrompt({
                Title = "UCoins Low",
                Text = "Not enough UCoins to forge unusual"
            });

            return;
        end;

        if p27 == "PointsLow" then
            u1.NewPrompt({
                Title = "Points Low",
                Text = "Not enough Points to forge unusual"
            });

            return;
        end;

        if p27 == "AccountAgeLow" then
            u1.NewPrompt({
                Title = "Account Age Low",
                Text = "Your account must be 30 days or older to use this feature (Can be bypassed with smart assistant gamepass)"
            });

            return;
        end;

        if p27 == "InvalidItem" then
            u1.NewPrompt({
                Title = "Data Error",
                Text = "Error occured, please retry"
            });

            return;
        end;

        if p27 == "InventoryCapped" then
            u1.NewPrompt({
                Title = "Inventory Full",
                Text = "Skin Inventory is full"
            });

            return;
        end;

        u1.NewPrompt({
            Title = "Data Error",
            Text = "Error occured, please retry"
        });
    end;

    Parent.Recycle.MouseButton1Click:Connect(function() -- Line: 251
        -- upvalues: u1 (copy), u6 (copy), u8 (ref), u3 (copy), HandleResponse (copy), UpdatePoints (copy), u7 (ref)
        if u1.UI.Prompt.Visible then
            return;
        end;

        u1.NewPrompt({
            Title = "Recycle Skins",
            Text = "Are you sure you want to recycle these skins?",
            Delay = 0.5,
            Options = { "Yes", "No" },

            Callback = function(p32) -- Line: 262, Name: Callback
                -- upvalues: u6 (ref), u8 (ref), u3 (ref), HandleResponse (ref), u1 (ref), UpdatePoints (ref), u7 (ref)
                if p32.Choice ~= 1 then
                    return;
                end;

                local v33 = {};

                for i, v in u6 do
                    local _ = v.ItemInfo;

                    if v.RarityInfo.PremiumPoints then
                        table.insert(v33, i);
                    end;
                end;

                if #v33 <= 0 then
                    return;
                end;

                u8 = true;
                local v34 = u3:RecycleSkins(v33):expect();
                u8 = false;

                if type(v34) ~= "number" then
                    HandleResponse(v34);

                    return;
                end;

                u1.NewPrompt({
                    Title = "Skins Recycled",
                    Text = `You have received <font color="#{u1.UShardsTextColor:ToHex()}">{v34} Points</font>`
                });
                task.spawn(UpdatePoints);
                u7 = 0;

                for _, v in u6 do
                    v.Trove:Destroy();
                end;

                table.clear(u6);
            end
        });
    end);
    Parent.ForgeUnusual.MouseButton1Click:Connect(function() -- Line: 299
        -- upvalues: u1 (copy), u3 (copy), u4 (ref), HandleResponse (copy), UpdatePoints (copy)
        if u1.UI.Prompt.Visible then
            return;
        end;

        u1.NewPrompt({
            Title = "Forge Unusual",
            Text = "Are you sure you want to forge an unusual? Will consume 1000 Points",
            Delay = 0.5,
            Options = { "Yes", "No" },

            Callback = function(p35) -- Line: 310, Name: Callback
                -- upvalues: u3 (ref), u4 (ref), u1 (ref), HandleResponse (ref), UpdatePoints (ref)
                if p35.Choice ~= 1 then
                    return;
                end;

                if u3:GetCurrencyType("RecyclePoints"):expect() < 1000 and not u4 then
                    u1.NewPrompt({
                        Title = "UCoins Low",
                        Text = "Not enough UCoins to forge unusual"
                    });

                    return;
                end;

                local v36, v37 = u3:ForgeUnusual():expect();

                if type(v36) == "string" or not v36 then
                    HandleResponse(v36, v37);

                    return;
                end;

                local v38 = "";

                if v36.UnusualInfo then
                    v38 = v38 .. "<font color=\"#AA55FF\">Unusual</font> ";
                end;

                local v39 = "" .. v38 .. u1:GetItemText(v36.ItemId, true) .. "\n";
                u1.NewPrompt({
                    Title = "Unusual Forged",
                    Text = v39
                });
                task.spawn(UpdatePoints);
            end
        });
    end);
    task.delay(2, UpdatePoints);
end;
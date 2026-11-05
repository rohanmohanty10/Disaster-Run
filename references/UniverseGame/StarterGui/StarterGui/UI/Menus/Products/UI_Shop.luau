  

 

return function(u1) -- Line: 1
    u1.Data:WaitForChild("PremiumCurrency");

    repeat
        task.wait(0.1);
    until u1.GenerateIcon;

    local Trove = require(u1.KnitPath.Trove);
    local _ = u1.Xtal;
    local ItemData = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").ItemData);
    local Stands = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").Stands);
    local Remotes = game.ReplicatedStorage:WaitForChild("Remotes");
    local u2 = u1.Knit.GetService("ShopService");
    local u3 = u1.Knit.GetService("InventoryService");
    local TextChatService = game:GetService("TextChatService");
    local ParticleHandler = require(game:GetService("ReplicatedStorage").ReplicatedModules.ReplicatedLibrary.ParticleHandler);
    u1.LastShopTab = nil;

    function u1.SetShopTab(p4, p5) -- Line: 18
        if p5 == "Back" and p4.LastShopTab then
            p5 = p4.LastShopTab;
        end;

        for _, child in pairs(script.Parent.Tabs:GetChildren()) do
            if child:IsA("ScrollingFrame") or child:IsA("Frame") then
                if child.Visible and child.Name ~= p5 then
                    p4.LastShopTab = child.Name;
                end;

                child.Visible = child.Name == p5;
            end;
        end;
    end;

    u1.ViewingItemId = nil;

    function u1.ViewItem(p6, p7, p8) -- Line: 33
        -- upvalues: ItemData (copy), Stands (copy), u3 (copy)
        local v9 = ItemData.GetItemInfo(p7);

        if v9 then
            local u10 = p8 or script.Parent.Tabs.View;
            u10.Label.Text = v9.Name;
            local v11 = "";
            local v12 = ItemData.Rarities[v9.Rarity];

            if v12 or v9.Type then
                local v13 = "";
                local v14, v15, v16;

                if v12 then
                    v13 = v13 .. v12.Name .. " ";
                    local v17 = math.floor(v12.Color.R * 255);
                    v14 = tostring(v17);
                    local v18 = math.round(v12.Color.G * 255);
                    v15 = tostring(v18);
                    local v19 = math.round(v12.Color.B * 255);
                    v16 = tostring(v19);
                else
                    v14 = "255";
                    v15 = "255";
                    v16 = "255";
                end;

                if v9.Type then
                    v13 = v13 .. v9.Type;
                end;

                local v20 = v11 .. "<font size=\"28\"><font color=\"rgb(" .. v14 .. "," .. v15 .. "," .. v16 .. ")\">" .. v13 .. "</font> ";

                if v9.Skin then
                    local v21 = Stands[tonumber(v9.LinkedAbilityId)];

                    if v21 then
                        v20 = v20 .. "(" .. v21 .. ")";
                    end;
                end;

                v11 = v20 .. "</font><br />";
            end;

            if v9.Price then
                v11 = v11 .. "<font size=\"28\"><font color=\"rgb(75,170,255)\">" .. tostring(v9.Price) .. " " .. p6.CurrencyString .. "</font></font>";
            end;

            if v9.PremiumPrice then
                local v22 = "<font size=\"28\"><font color=\"rgb(255,200,100)\">" .. tostring(v9.PremiumPrice) .. " " .. p6.PremiumCurrencyString .. "</font></font>";

                if v9.Price then
                    v11 = v11 .. "<font size=\"28\">  /  </font>";
                end;

                v11 = v11 .. v22 .. "<br />";
            elseif not v9.EventPrice then
                v11 = v11 .. "<br />";
            end;

            if v9.EventPrice then
                v11 = v11 .. ("<font size=\"28\"><font color=\"rgb(255,0,0)\">" .. tostring(v9.EventPrice) .. " " .. p6.EventCurrencyString .. "</font></font>") .. "<br />";
            end;

            local _, v23 = u3:GetItemCount("SkinInventory", p7):expect();

            if typeof(v23) == "number" and v23 > 0 then
                if v23 == 1 then
                    v11 = v11 .. "<font size=\"28\"><font color=\"rgb(255,255,255)\">You own this item.</font></font><br />";
                else
                    v11 = v11 .. "<font size=\"28\"><font color=\"rgb(255,255,255)\">You own " .. tostring(v23) .. " of this item.</font></font><br />";
                end;
            end;

            if v9.Description and v9.Description ~= "" then
                v11 = v11 .. "\"" .. v9.Description .. "\"";
            end;

            u10.Description.Label.Text = v11;
            u10.Description.Label.AutomaticSize = Enum.AutomaticSize.None;
            p6:GenerateIcon(u10.Display.ViewportFrame, v9);
            p6:SetShopTab("View");
            task.defer(function() -- Line: 103
                -- upvalues: u10 (copy)
                u10.Description.Label.AutomaticSize = Enum.AutomaticSize.Y;
            end);
            p6.ViewingItemId = p7;
        end;
    end;

    function u1.PromptPurchase(u24, u25) -- Line: 111
        -- upvalues: ItemData (copy), Remotes (copy)
        local u26 = ItemData.GetItemInfo(u25);

        if u26 and (u26.Price or (u26.PremiumPrice or u26.EventPrice)) then
            local u33 = {
                Success = function(p27, p28) -- Line: 116
                    -- upvalues: u24 (copy), u26 (copy)
                    local v29 = u24.PremiumCurrencyString == p28;
                    local v30 = tostring(p27) .. " " .. p28;
                    local v31;

                    if v29 then
                        v31 = "<font color=\"rgb(255,200,100)\">" .. v30 .. "</font>";
                    else
                        v31 = "<font color=\"rgb(75,170,255)\">" .. v30 .. "</font>";
                    end;

                    u24:Prompt("Purchase successful!", "You have successfully purchased \"" .. u26.Name .. "\" for " .. v31, "ok");
                end,

                Duplicate = function() -- Line: 122
                    -- upvalues: u24 (copy)
                    u24:Prompt("Purchase failed", "You already own this item.", "ok");
                end,

                CapacityFull = function() -- Line: 125
                    -- upvalues: u24 (copy)
                    u24:Prompt("Purchase failed", "Your inventory is full", "ok");
                end,

                Error = function(p32) -- Line: 128
                    -- upvalues: u24 (copy)
                    u24:Prompt("Purchase failed", "Error: " .. tostring(p32), "ok");
                end
            };

            local function Prompt() -- Line: 133
                -- upvalues: u24 (copy), u26 (copy), Remotes (ref), u25 (copy), u33 (copy)
                if u24.Data.Currency.Value >= u26.Price then
                    u24:Prompt("Confirm Purchase", "Are you sure you want to purchase \"" .. u26.Name .. "\" for " .. "<font color=\"rgb(75,170,255)\">" .. tostring(u26.Price) .. " " .. u24.CurrencyString .. "</font>?", "purchase", function(p34, p35, p36) -- Line: 139
                        -- upvalues: u24 (ref), Remotes (ref), u25 (ref), u33 (ref), u26 (ref)
                        u24:PlaySound("Click");

                        if p35 == 1 then
                            return true;
                        end;

                        if p35 == 2 then
                            local v37 = Remotes.PurchaseItem:InvokeServer(u25, false);

                            if u33[v37] then
                                task.defer(u33[v37], u26.Price, u24.CurrencyString);
                            else
                                task.defer(u33.Error, v37);
                            end;
                        end;

                        return true;
                    end);

                    return;
                end;

                u24:Prompt("Not enough Universal Shards", "You do not have enough " .. "<font color=\"rgb(75,170,255)\">" .. u24.CurrencyString .. "</font> to purchase this item.", "ok", function(p38, p39, p40) -- Line: 159
                    -- upvalues: u24 (ref)
                    u24:PlaySound("Click");
                end);
            end;

            local function PromptPremium() -- Line: 166
                -- upvalues: u24 (copy), u26 (copy), Remotes (ref), u25 (copy), u33 (copy)
                if u24.Data.PremiumCurrency.Value >= u26.PremiumPrice then
                    u24:Prompt("Confirm Purchase", "Are you sure you want to purchase \"" .. u26.Name .. "\" for " .. "<font color=\"rgb(255,200,100)\">" .. tostring(u26.PremiumPrice) .. " " .. u24.PremiumCurrencyString .. "</font>?", "purchase", function(p41, p42, p43) -- Line: 172
                        -- upvalues: u24 (ref), Remotes (ref), u25 (ref), u33 (ref), u26 (ref)
                        u24:PlaySound("Click");

                        if p42 == 1 then
                            return true;
                        end;

                        if p42 == 2 then
                            local v44 = Remotes.PurchaseItem:InvokeServer(u25, true);

                            if u33[v44] then
                                task.defer(u33[v44], u26.PremiumPrice, u24.PremiumCurrencyString);
                            else
                                task.defer(u33.Error, v44);
                            end;
                        end;

                        return true;
                    end);

                    return;
                end;

                u24:Prompt("Not enough Universal Points", "You do not have enough " .. "<font color=\"rgb(255,200,100)\">" .. u24.PremiumCurrencyString .. "</font> to purchase this item, would you like to buy more?", "choose", function(p45, p46, p47) -- Line: 192
                    -- upvalues: u24 (ref)
                    u24:PlaySound("Click");

                    if p46 == 2 then
                        u24:SetShopTab("Products");
                    end;
                end);
            end;

            local function PromptEvent() -- Line: 202
                -- upvalues: u24 (copy), u26 (copy), Remotes (ref), u25 (copy)
                if u24.Data.EventCurrency.Value >= u26.EventPrice then
                    u24:Prompt("Confirm Purchase", "Are you sure you want to purchase \"" .. u26.Name .. "\" for " .. "<font color=\"rgb(255,0,0)\">" .. tostring(u26.EventPrice) .. " " .. u24.EventCurrencyString .. "</font>?", "purchase", function(p48, p49, p50) -- Line: 208
                        -- upvalues: u24 (ref), Remotes (ref), u25 (ref), u26 (ref)
                        u24:PlaySound("Click");

                        if p49 == 1 then
                            return true;
                        end;

                        if p49 == 2 then
                            local u51 = Remotes.PurchaseItem:InvokeServer(u25, "Event");

                            if u51 == "Success" then
                                task.defer(function() -- Line: 215
                                    -- upvalues: u24 (ref), u26 (ref)
                                    u24:Prompt("Purchase successful!", "You have successfully purchased \"" .. u26.Name .. "\" for " .. "<font color=\"rgb(255,0,0)\">" .. tostring(u26.EventPrice) .. " " .. u24.EventCurrencyString .. "</font>", "ok");
                                end);
                            elseif u51 == "Duplicate" then
                                task.defer(function() -- Line: 219
                                    -- upvalues: u24 (ref)
                                    u24:Prompt("Purchase failed", "You already own this item.", "ok");
                                end);
                            else
                                task.defer(function() -- Line: 223
                                    -- upvalues: u24 (ref), u51 (copy)
                                    u24:Prompt("Purchase failed", "Error: " .. tostring(u51), "ok");
                                end);
                            end;
                        end;

                        return true;
                    end);

                    return;
                end;

                u24:Prompt("Not enough Universal Points", "You do not have enough " .. "<font color=\"rgb(255,0,0)\">" .. u24.EventCurrencyString .. "</font> to purchase this item.", "ok", function(p52, p53, p54) -- Line: 236
                    -- upvalues: u24 (ref)
                    u24:PlaySound("Click");
                end);
            end;

            local v55 = u26.Price and u26.Purchasable;
            local v56 = u26.PremiumPrice and u26.PremiumPurchasable;
            local v57 = u26.EventPrice and u26.EventPurchasable;

            if v55 and v56 then
                u24:Prompt("Choose Currency", "Choose a currency to buy \"" .. u26.Name .. "\" with", { "Cancel", "<font color=\"rgb(75,170,255)\">" .. tostring(u26.Price) .. " " .. u24.CurrencyString .. "</font>", "<font color=\"rgb(255,200,100)\">" .. tostring(u26.PremiumPrice) .. " " .. u24.PremiumCurrencyString .. "</font>" }, function(p58, p59, p60) -- Line: 256
                    -- upvalues: u24 (copy), Prompt (copy), PromptPremium (copy)
                    u24:PlaySound("Click");

                    if p59 == 2 then
                        task.defer(Prompt);

                        return;
                    end;

                    if p59 == 3 then
                        task.defer(PromptPremium);
                    end;
                end);

                return;
            end;

            if v55 and not (v56 or v57) then
                Prompt();

                return;
            end;

            if not v55 and (v56 and not v57) then
                PromptPremium();

                return;
            end;

            if not v55 and (not v56 and v57) then
                PromptEvent();

                return;
            end;

            if not v56 and (v55 and v57) then
                u24:Prompt("Choose Currency", "Choose a currency to buy \"" .. u26.Name .. "\" with", { "Cancel", "<font color=\"rgb(75,170,255)\">" .. tostring(u26.Price) .. " " .. u24.CurrencyString .. "</font>", "<font color=\"rgb(255,0,0)\">" .. tostring(u26.EventPrice) .. " " .. u24.EventCurrencyString .. "</font>" }, function(p61, p62, p63) -- Line: 280
                    -- upvalues: u24 (copy), Prompt (copy), PromptEvent (copy)
                    u24:PlaySound("Click");

                    if p62 == 2 then
                        task.defer(Prompt);

                        return;
                    end;

                    if p62 == 3 then
                        task.defer(PromptEvent);
                    end;
                end);

                return;
            end;

            if not v55 and (v56 and v57) then
                u24:Prompt("Choose Currency", "Choose a currency to buy \"" .. u26.Name .. "\" with", { "Cancel", "<font color=\"rgb(255,0,0)\">" .. tostring(u26.EventPrice) .. " " .. u24.EventCurrencyString .. "</font>", "<font color=\"rgb(255,200,100)\">" .. tostring(u26.PremiumPrice) .. " " .. u24.PremiumCurrencyString .. "</font>" }, function(p64, p65, p66) -- Line: 298
                    -- upvalues: u24 (copy), PromptEvent (copy), PromptPremium (copy)
                    u24:PlaySound("Click");

                    if p65 == 2 then
                        task.defer(PromptEvent);

                        return;
                    end;

                    if p65 == 3 then
                        task.defer(PromptPremium);
                    end;
                end);
            end;
        end;
    end;

    u1.OpeningCrate = false;

    function u1.OpenCrateAnim(u67, p68) -- Line: 312
        -- upvalues: Trove (copy)
        local u69 = Trove.new();
        u67.OpeningCrate = true;
        u67.UI.Enabled = false;
        u67:SetMenu(nil);
        u67:Lock(true);
        local u70 = game.ReplicatedStorage:WaitForChild("Client Assets").UX.ChestArea:Clone();
        u70.Parent = game.Workspace.Effects;
        u69:Add(u70);
        local CurrentCamera = game.Workspace.CurrentCamera;
        local Chest = u70.Rigs.Chest;
        local HumanoidCameraRig = u70.Rigs.HumanoidCameraRig;
        local v71 = Chest.Humanoid:LoadAnimation(Chest.Animation);
        local v72 = HumanoidCameraRig.Humanoid:LoadAnimation(HumanoidCameraRig.Animation);
        local v73 = os.clock() + 0.25;

        repeat
            task.wait();
        until v71.Length ~= 0 and v72.Length ~= 0 or v73 < os.clock();

        u67:PromptNewItem(p68);
        local u74 = true;
        v71:Play(0, 1, 1);
        v72:Play(0, 1, 1);
        u67:PlaySound("Chest");
        CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        task.spawn(function() -- Line: 348
            -- upvalues: u74 (ref), u70 (copy), HumanoidCameraRig (copy), CurrentCamera (copy)
            while u74 and (u70 and HumanoidCameraRig) do
                CurrentCamera.CFrame = HumanoidCameraRig.Torso.CFrame;
                task.wait();
            end;

            CurrentCamera.CameraType = Enum.CameraType.Custom;
        end);
        task.delay(1.8, function() -- Line: 356
            -- upvalues: u70 (copy), u69 (copy), Chest (copy)
            for _, descendant in pairs(u70.Building:GetDescendants()) do
                if descendant:IsA("PointLight") or descendant:IsA("SpotLight") then
                    local v75 = game:GetService("TweenService"):Create(descendant, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        Brightness = 0
                    });
                    v75:Play();
                    u69:Add(v75);
                end;
            end;

            local v76 = game:GetService("TweenService"):Create(Chest.BASE.Aura.PointLight, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Brightness = 4
            });
            v76:Play();
            u69:Add(v76);
            Chest.BASE.Aura.Shine.Enabled = true;
            Chest.BASE.Glow.Shine.Enabled = true;
        end);
        task.wait(2.4);
        local ScreenGui = Instance.new("ScreenGui");
        ScreenGui.DisplayOrder = 2;
        ScreenGui.IgnoreGuiInset = true;
        ScreenGui.Parent = game.Players.LocalPlayer.PlayerGui;
        local Frame = Instance.new("Frame");
        Frame.Size = UDim2.new(1, 0, 1, 0);
        Frame.BackgroundTransparency = 1;
        Frame.BackgroundColor3 = Color3.new(1, 1, 1);
        Frame.Parent = ScreenGui;
        u69:Add(ScreenGui);
        local v77 = game:GetService("TweenService"):Create(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            BackgroundTransparency = 0
        });
        v77:Play();
        u69:Add(v77);
        task.wait(0.75);
        u74 = false;
        local v78 = game:GetService("TweenService"):Create(Frame, TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        });
        v78:Play();
        u69:Add(v78);
        u67.UI.Enabled = true;
        u67:SetMenu("Products");
        u67:Lock(false);
        task.delay(0.4, function() -- Line: 406
            -- upvalues: u69 (copy), u67 (copy)
            u69:Destroy();
            u67.OpeningCrate = false;
        end);
    end;

    function u1.OpenBriefcaseAnim(u79, p80) -- Line: 412
        -- upvalues: ItemData (copy), Trove (copy), ParticleHandler (copy)
        local v81 = ItemData.GetRarityInfoByValue(p80);
        local u82 = Trove.new();
        u79.OpeningCrate = true;
        u79.UI.Enabled = false;
        u79:SetMenu(nil);
        u79:Lock(true);
        local u83 = game.ReplicatedStorage:WaitForChild("Client Assets").UX.GachaArea:Clone();
        u83.Parent = game.Workspace.Effects;
        u82:Add(u83);
        local CurrentCamera = game.Workspace.CurrentCamera;
        local CaseRig = u83.CaseRig;
        local CameraRig = u83.CameraRig;
        local u84 = CaseRig.AnimationController.Animator:LoadAnimation(CaseRig.Animation);
        local u85 = CameraRig.AnimationController.Animator:LoadAnimation(CameraRig.Animation);
        local v86 = os.clock() + 0.25;

        repeat
            task.wait();
        until u85.Length ~= 0 and u85.Length ~= 0 or v86 < os.clock();

        local u87 = true;
        u84:Play();
        u85:Play();
        local u88 = 0;
        local u89 = v81.Name ~= "Mythic" and (v81.Name == "Legendary" and 180 or (v81.Name == "Epic" and 110 or 45)) or nil;
        local u90 = {};
        task.spawn(function() -- Line: 458
            -- upvalues: u89 (copy), u88 (ref), u84 (copy), u85 (copy)
            if not u89 then
                return;
            end;

            while u88 < u89 do
                u88 = u84.TimePosition * 60;
                task.wait();
            end;

            u84.TimePosition = 4.5;
            u85.TimePosition = 4.5;
        end);
        CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        local Stars = CaseRig:FindFirstChild("Stars", true);
        local Emit = CaseRig:FindFirstChild("Emit", true);
        local u91 = ParticleHandler.GenerateEmitInfo(Emit);

        local function EmitRarity(p92) -- Line: 475
            -- upvalues: Stars (copy), Emit (copy), ParticleHandler (ref), u91 (copy)
            Stars.Color = p92;

            for _, child in Emit:GetChildren() do
                ParticleHandler.ChangeProperties(child, {
                    Color = p92
                });
            end;

            ParticleHandler.Emit(Emit, u91);
        end;

        task.spawn(function() -- Line: 485
            -- upvalues: CurrentCamera (copy), CameraRig (copy), u87 (ref), u83 (copy), u84 (copy), u89 (copy), u90 (copy), EmitRarity (copy), ItemData (ref), u79 (copy)
            CurrentCamera.CFrame = CameraRig.camera.CFrame;

            while u87 and (u83 and CameraRig) do
                CurrentCamera.CFrame = CurrentCamera.CFrame:Lerp(CameraRig.camera.CFrame, 0.5);
                local v93 = u84.TimePosition * 60;

                if v93 >= 326 then
                    CurrentCamera.FieldOfView = 40;
                elseif v93 >= 319 then
                    CurrentCamera.FieldOfView = 50;
                elseif v93 >= 315 then
                    CurrentCamera.FieldOfView = 80;
                elseif v93 >= 251 then
                    CurrentCamera.FieldOfView = 50;
                elseif v93 >= 231 then
                    CurrentCamera.FieldOfView = 70;
                elseif v93 >= 210 then
                    CurrentCamera.FieldOfView = 50;
                elseif v93 >= 137 then
                    CurrentCamera.FieldOfView = 20;
                elseif v93 >= 68 then
                    CurrentCamera.FieldOfView = 30;
                else
                    CurrentCamera.FieldOfView = 50;
                end;

                if u89 and u89 < v93 then
                    v93 = u89;
                end;

                if v93 >= 195 and not u90.Mythic then
                    u90.Mythic = true;
                    EmitRarity(ColorSequence.new(ItemData.GetRarityByName("Mythic").Color));
                    u79:PlaySound("ug_gacha_mythic");
                elseif v93 >= 125 and not u90.Legendary then
                    u90.Legendary = true;
                    EmitRarity(ColorSequence.new(ItemData.GetRarityByName("Legendary").Color));
                    u79:PlaySound("ug_gacha_legendary");
                elseif v93 >= 60 and not u90.Epic then
                    u90.Epic = true;
                    EmitRarity(ColorSequence.new(ItemData.GetRarityByName("Epic").Color));
                    u79:PlaySound("ug_gacha_rare");
                elseif not u90.Common then
                    u90.Common = true;
                    EmitRarity(ColorSequence.new(ItemData.GetRarityByName("Common").Color));
                    u79:PlaySound("ug_gacha_common");
                end;

                task.wait();
            end;

            CurrentCamera.CameraType = Enum.CameraType.Custom;
            CurrentCamera.FieldOfView = game.Players.LocalPlayer.Settings.FieldOfView.Value or 70;
        end);

        repeat
            task.wait();
        until u84.TimePosition * 60 >= 300;

        local ScreenGui = Instance.new("ScreenGui");
        ScreenGui.DisplayOrder = 2;
        ScreenGui.IgnoreGuiInset = true;
        ScreenGui.Parent = game.Players.LocalPlayer.PlayerGui;
        local Frame = Instance.new("Frame");
        Frame.Size = UDim2.new(1, 0, 1, 0);
        Frame.BackgroundTransparency = 1;
        Frame.BackgroundColor3 = Color3.new(1, 1, 1);
        Frame.Parent = ScreenGui;
        u82:Add(ScreenGui);
        local v94 = game:GetService("TweenService"):Create(Frame, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            BackgroundTransparency = 0
        });
        v94:Play();
        u82:Add(v94);
        task.wait(0.75);
        u87 = false;
        local v95 = game:GetService("TweenService"):Create(Frame, TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
            BackgroundTransparency = 1
        });
        v95:Play();
        u82:Add(v95);
        u79.UI.Enabled = true;
        u79:Lock(false);
        task.delay(0.4, function() -- Line: 573
            -- upvalues: u82 (copy), u79 (copy)
            u82:Destroy();
            u79.OpeningCrate = false;
        end);
    end;

    u1.PromptItemId = nil;

    function u1.PromptNewItem(p96, p97) -- Line: 580
        -- upvalues: ItemData (copy)
        local v98 = ItemData.GetItemInfo(p97);

        if v98 then
            local NewItemPrompt = p96.UI.NewItemPrompt;
            NewItemPrompt.Visible = true;
            local v99 = v98.Name or "";
            local v100 = ItemData.Rarities[v98.Rarity];

            if v100 then
                local v101, v102, v103;

                if v100 then
                    local v104 = math.floor(v100.Color.R * 255);
                    v101 = tostring(v104);
                    local v105 = math.round(v100.Color.G * 255);
                    v102 = tostring(v105);
                    local v106 = math.round(v100.Color.B * 255);
                    v103 = tostring(v106);
                else
                    v101 = "255";
                    v102 = "255";
                    v103 = "255";
                end;

                v99 = "<font color=\"rgb(" .. v101 .. "," .. v102 .. "," .. v103 .. ")\">" .. v99 .. "</font> ";
            end;

            NewItemPrompt.Frame.ItemName.Text = v99;
            p96:GenerateIcon(NewItemPrompt.Frame.ViewportFrame, v98);
            p96.PromptItemId = p97;
        end;
    end;

    u1.UI.NewItemPrompt.Frame.Close.MouseButton1Down:Connect(function() -- Line: 606
        -- upvalues: u1 (copy)
        u1:PlaySound("Click");
        u1.UI.NewItemPrompt.Visible = false;
    end);
    u1.UI.NewItemPrompt.Frame.View.MouseButton1Down:Connect(function() -- Line: 610
        -- upvalues: u1 (copy)
        u1:PlaySound("Click");
        u1.UI.NewItemPrompt.Visible = false;
        u1:ViewItem(u1.PromptItemId, u1.UI.Menus.Inventory.Tabs.View);
        u1:SetMenu("Inventory");
        u1:SetInventoryTab("View");
    end);

    function u1.PromptCratePurchase(u107, u108) -- Line: 620
        -- upvalues: ItemData (copy), u2 (copy)
        local u109 = ItemData.Crates[u108];

        if not (u109 and u109.Purchasable) then
            return;
        end;

        local function u133(u110) -- Line: 624
            -- upvalues: u107 (copy), u109 (copy), u108 (copy), u2 (ref)
            local v111 = u110 == "UPoints";
            local v112 = u110 == "USummer26";
            local v113;

            if v111 then
                v113 = u107.Data.PremiumCurrency.Value;
            elseif v112 then
                v113 = u107.Data.EventCurrency.Value;
            else
                v113 = u107.Data.Currency.Value;
            end;

            local u114;

            if v111 then
                u114 = u109.UPoints;
            elseif v112 then
                u114 = u109.USummer26;
            else
                u114 = u109.UShards;
            end;

            local u115;

            if v111 then
                u115 = u107.PremiumCurrencyString;
            elseif v112 then
                u115 = u107.EventCurrencyString;
            else
                u115 = u107.CurrencyString;
            end;

            local u116;

            if v111 then
                u116 = u107.UPointsTextColor;
            elseif v112 then
                u116 = u107.UEventsTextColor;
            else
                u116 = u107.UShardsTextColor;
            end;

            local u117 = `<font color='#{u116:ToHex()}'>{u115}</font>`;

            if v113 < u114 then
                u107.NewPrompt({
                    Options = "ok",
                    Title = "Not enough " .. u110,
                    Text = "You do not have enough " .. u117 .. " to purchase this item",

                    Callback = function() -- Line: 651, Name: Callback
                        -- upvalues: u107 (ref)
                        u107:PlaySound("Click");
                    end
                });

                return;
            end;

            local function HandleResponse(p118, p119) -- Line: 658
                -- upvalues: u107 (ref), u108 (ref), u117 (copy)
                if p118 == "Success" then
                    if type(p119.Value) == "table" and #p119.Value > 1 then
                        local v120 = "";

                        for _, v in p119.Value do
                            local v121 = "";

                            if v.UnusualInfo then
                                v121 = v121 .. "<font color=\"#AA55FF\">Unusual</font> ";
                            end;

                            v120 = v120 .. v121 .. u107:GetItemText(v.ItemId, true) .. "\n";
                        end;

                        u107.NewPrompt({
                            Title = "You received the following Items",
                            Text = v120
                        });

                        return;
                    end;

                    if not u108:lower():find("killeffect") then
                        task.defer(u107.OpenCrateAnim, u107, p119.Value[1].ItemId);

                        return;
                    end;

                    local v122 = "";

                    for _, v in p119.Value do
                        v122 = v122 .. "" .. u107:GetItemText(v.ItemId, true) .. "\n";
                    end;

                    u107.NewPrompt({
                        Title = "You received the following Items",
                        Text = v122
                    });

                    return;
                end;

                if p118 == "AboveMaxMulti" then
                    local v123 = u108:lower():find("killeffect") and "Kill Effects" or "Skins";
                    u107.NewPrompt({
                        Title = "Purchase Failed",
                        Options = "ok",
                        Text = `Your skin inventory does not have enough space to hold all [{p119.Value}] {v123}`
                    });

                    return;
                end;

                if p118 == "NotEnough" then
                    u107.NewPrompt({
                        Title = "Purchase Failed",
                        Options = "ok",
                        Text = "You do not have enough " .. u117 .. " to purchase this",

                        Callback = function() -- Line: 705, Name: Callback
                            -- upvalues: u107 (ref)
                            u107:PlaySound("Click");
                        end
                    });

                    return;
                end;

                if p118 == "OnCooldown" then
                    u107.NewPrompt({
                        Title = "Purchase Failed",
                        Text = "Skin rolling currently on cooldown",
                        Options = "ok",

                        Callback = function() -- Line: 714, Name: Callback
                            -- upvalues: u107 (ref)
                            u107:PlaySound("Click");
                        end
                    });

                    return;
                end;

                if p118 ~= "Capped" then
                    if p118 == "Policy" then
                        u107.NewPrompt({
                            Title = "Purchase Failed",
                            Text = "Due to legal restrictions in your region, you are unable to purchase crates.",
                            Options = "ok",

                            Callback = function() -- Line: 735, Name: Callback
                                -- upvalues: u107 (ref)
                                u107:PlaySound("Click");
                            end
                        });

                        return;
                    end;

                    u107.NewPrompt({
                        Title = "Purchase Failed",
                        Options = "ok",
                        Text = "Error: " .. tostring(p118)
                    });

                    return;
                end;

                local v124 = os.time() / 86400;
                local v125 = math.floor(v124) + 1;
                u107.NewPrompt({
                    Title = "Purchase Failed",
                    Options = "ok",
                    Text = `You have hit the daily cap for skin rolling, resets in [{u107.toHMS(v125 * 86400 - os.time())}]`,

                    Callback = function() -- Line: 726, Name: Callback
                        -- upvalues: u107 (ref)
                        u107:PlaySound("Click");
                    end
                });
            end;

            u107.NewPrompt({
                Title = "Pull Amount",
                Text = "How many pulls?",
                Options = { "1x pull", "10x pulls" },

                Callback = function(p126) -- Line: 755, Name: Callback
                    -- upvalues: u114 (copy), u115 (copy), u116 (copy), u107 (ref), u109 (ref), u108 (ref), u2 (ref), u110 (copy), HandleResponse (copy)
                    local u127 = p126.Choice == 2 and 10 or 1;
                    local v128 = `{u114 * u127} {u115}`;
                    local v129 = `<font color='#{u116:ToHex()}'>{v128}</font>`;
                    u107.NewPrompt({
                        Title = "Confirm Purchase",
                        Delay = 0.5,
                        Options = "purchase",
                        Text = `Are you sure you want to purchase {u109.Name} for {v129}?`,

                        Callback = function(p130) -- Line: 765, Name: Callback
                            -- upvalues: u107 (ref), u108 (ref), u2 (ref), u110 (ref), u127 (ref), HandleResponse (ref)
                            u107:PlaySound("Click");

                            if p130.Choice ~= 2 then
                                return;
                            end;

                            local v131, v132;

                            if u108:lower():find("killeffect") then
                                v131, v132 = u2:BuyKillEffectCrate(u108, u110, u127):expect();
                            else
                                v131, v132 = u2:BuySkinCrate(u108, u110, u127):expect();
                            end;

                            HandleResponse(v131, {
                                Value = v132,
                                Amount = u127
                            });
                        end
                    });
                end
            });
        end;

        local v134 = {
            UShards = `<font color='#{u107.UShardsTextColor:ToHex()}'>{u109.UShards} {u107.CurrencyString}</font>`,
            UPoints = `<font color='#{u107.UPointsTextColor:ToHex()}'>{u109.UPoints} {u107.PremiumCurrencyString}</font>`,
            PoolPoints = `<font color='#{u107.UEventsTextColor:ToHex()}'>{u109.PoolPoints} {u107.EventCurrencyString}</font>`,
            UHalloween = `<font color='#{u107.UEventsTextColor:ToHex()}'>{u109.UHalloween} {u107.EventCurrencyString}</font>`,
            USummer26 = `<font color='#{u107.UEventsTextColor:ToHex()}'>{u109.USummer26} {u107.EventCurrencyString}</font>`
        };
        local u135 = {};
        local v137 = {
            Title = "Choose Currency",
            Text = `Choose a currency to buy {u109.Name} with`,
            RichText = {},
            Options = { "Cancel" },

            Callback = function(p136) -- Line: 803, Name: Callback
                -- upvalues: u107 (copy), u135 (copy), u133 (copy)
                u107:PlaySound("Click");

                if p136.Choice == 1 then
                    return;
                end;

                task.defer(u133, u135[p136.Choice]);
            end
        };

        for i, v in v134 do
            if u109[i] then
                table.insert(v137.Options, v);
                table.insert(v137.RichText, #v137.Options);
                u135[#v137.Options] = i;
            end;
        end;

        if #v137.Options < 3 then
            if u109.UPoints then
                u133("UPoints");

                return;
            end;

            if u109.UShards then
                u133("UShards");
            end;

            return;
        end;

        if u108 == "Skin_Crate" then
            local v138 = u2:GetPityInfo():expect();
            local v139 = Color3.fromRGB(255, 85, 0);
            local v140 = Color3.fromRGB(0, 255, 127);

            for _, v in pairs(ItemData.Rarities) do
                if v.Name == "Mythic" then
                    v139 = v.Color;
                    break;
                end;
            end;

            local v141 = `<font color="#{v139:ToHex()}">Expected Drop: Mythic</font>\n`;
            v137.Text = `<font color="#{v140:ToHex()}">{`Current Pity: {v138.SkinCrate}`}</font>\n{v141}` .. v137.Text;
        end;

        u107.NewPrompt(v137);
    end;

    script.Parent.Tabs.View.Purchase.MouseButton1Down:Connect(function() -- Line: 848
        -- upvalues: u1 (copy)
        u1:PlaySound("Click");
        u1:PromptPurchase(u1.ViewingItemId);
    end);
    script.Parent.Tabs.View.Back.MouseButton1Down:Connect(function() -- Line: 853
        -- upvalues: u1 (copy)
        u1:PlaySound("Click");
        u1:SetShopTab("Back");
    end);
    local u142 = nil;

    function u1.PromptItemPool(p143, p144) -- Line: 859
        -- upvalues: ItemData (copy), u2 (copy), u142 (ref), Trove (copy)
        local v145 = ItemData.Crates[p144];

        if not v145 then
            return;
        end;

        local u146 = u2:RequestCratePool(p144):expect() or {};

        if u142 then
            u142:Destroy();
            u142 = nil;
        end;

        u142 = Trove.new();
        local ItemPoolPrompt = p143.UI.ItemPoolPrompt;

        for _, child in pairs(ItemPoolPrompt.Frame.List:GetChildren()) do
            if child:IsA("TextLabel") then
                child:Destroy();
            end;
        end;

        ItemPoolPrompt.Visible = true;
        ItemPoolPrompt.Frame.Label.Text = `Viewing items for: {tostring(v145.Name)} (Odds may be rounded)`;
        local u147 = 0;

        for _, v in u146 do
            u147 = u147 + v;
        end;

        task.defer(function() -- Line: 905
            -- upvalues: u146 (copy), ItemData (ref), u147 (ref), ItemPoolPrompt (copy), u142 (ref)
            local v148 = {};
            local u149 = {};

            for i, v in u146 do
                local v150 = ItemData.GetItemInfo(i);

                if v150 then
                    local v151 = ItemData.Rarities[v150.Rarity];
                    local v152 = v / u147 * 100;
                    local v153 = script.Label:Clone();
                    local v154 = v150.Name or "";
                    local v155, v156;

                    if v151 then
                        v155 = `<font color="#{v151.Color:ToHex()}">`;
                        v156 = "</font>";
                        v154 = v155 .. v154 .. v156;
                    else
                        v155 = "";
                        v156 = "";
                    end;

                    if not v148[v151.Name] then
                        v148[v151.Name] = true;
                        local v157 = script.Label:Clone();
                        v157.BackgroundTransparency = 1;
                        v157.Text = `{v155}{v151.Name}{v156}: ?`;
                        local v158 = 0;

                        for i2, v2 in u146 do
                            if ItemData.GetItemInfo(i2).Rarity == v150.Rarity then
                                v158 = v158 + v2;
                            end;
                        end;

                        local v159 = v158 / u147 * 100;

                        if v151.Name == "Universal" then
                            v157.Text = `{v155}{v151.Name}{v156}: ~{string.format("%.4f", v159)}% (Category)`;
                        else
                            v157.Text = `{v155}{v151.Name}{v156}: ~{string.format("%.3f", v159)}% (Category)`;
                        end;

                        v157.LayoutOrder = (v + 10) * -1;

                        if v151.Name == "Mythic" then
                            local v160 = {
                                Rarity = true,
                                Object = v157,
                                Name = v151.Name,
                                Chance = string.format("%.3f", v159)
                            };
                            table.insert(u149, v160);
                        end;

                        v157.Parent = ItemPoolPrompt.Frame.List;
                    end;

                    if v153 then
                        if v151.Name == "Universal" then
                            v153.Text = `{v154}  -  ~{string.format("%.4f", v152)}%`;
                        else
                            v153.Text = `{v154}  -  ~{string.format("%.3f", v152)}%`;
                        end;

                        v153.LayoutOrder = v * -1;
                        v153.Parent = ItemPoolPrompt.Frame.List;

                        if v151.Name == "Mythic" then
                            local v161 = {
                                Object = v153,
                                Name = v150.Name,
                                Chance = string.format("%.3f", v152)
                            };
                            table.insert(u149, v161);
                        end;
                    end;
                end;
            end;

            local u162 = nil;
            task.defer(function() -- Line: 989
                -- upvalues: u149 (copy), u162 (ref)
                for _, v in ipairs(u149) do
                    local Object = v.Object;
                    local v163;

                    if v.Rarity then
                        v163 = `{v.Name}: ~{v.Chance}%`;
                    else
                        v163 = `{v.Name}  -  ~{v.Chance}%`;
                    end;

                    Object.Text = v163;
                end;

                while not u162 do
                    local v164 = DateTime.now().UnixTimestampMillis / 1000 % 5 / 5;
                    local v165 = Color3.fromHSV(v164, 1, 1);

                    for _, v in ipairs(u149) do
                        v.Object.TextColor3 = v165;
                    end;

                    task.wait();
                end;
            end);
            u142:Add(function() -- Line: 1002
                -- upvalues: u162 (ref)
                u162 = true;
            end);
        end);
    end;

    function u1.NotifyNewItem(p166, p167, p168, p169) -- Line: 1009
        -- upvalues: ItemData (copy)
        local v170 = ItemData.GetItemInfo(p167);
        local v171 = p166:GetItemText(p167);

        if v170 and #v171 > 0 then
            p166:Notify(p168 or "Obtained new " .. (v170.Type or "item"), v171, p169 or 3);
        end;
    end;

    function u1.NotifyFailedItem(p172, p173, p174, p175) -- Line: 1017
        -- upvalues: ItemData (copy)
        local v176 = ItemData.GetItemInfo(p173);
        local v177 = p172:GetItemText(p173);

        if v176 and #v177 > 0 then
            p172:Notify(`{v176.Type or "item"} OBTAINMENT FAILED`, `{v177}\nReason: {p174}`, p175 or 3);
        end;
    end;

    u1.UI.ItemPoolPrompt.Frame.Close.MouseButton1Down:Connect(function() -- Line: 1025
        -- upvalues: u1 (copy), u142 (ref)
        u1:PlaySound("Click");

        if u142 then
            u142:Destroy();
            u142 = nil;
        end;

        u1.UI.ItemPoolPrompt.Visible = false;
    end);

    local function UpdateCurrency() -- Line: 1126
        -- upvalues: u1 (copy), u2 (copy)
        local v178 = u1:AbbreviateNumber(u2:GetCurrencyType("UShards"):expect());
        local v179 = u1:AbbreviateNumber(u2:GetCurrencyType("UPoints"):expect());
        local v180 = u1:AbbreviateNumber(u2:GetCurrencyType("UFragments"):expect());
        local v181 = u1:AbbreviateNumber(u2:GetCurrencyType("UCoins"):expect());
        local v182 = `{v178} ` .. u1.CurrencyString;
        local v183 = `{v179} ` .. u1.PremiumCurrencyString;
        local v184 = `{v180} ` .. u1.uFragmentsString;
        ("%* uCoins"):format(v181);
        script.Parent.Buttons.Currency.Text = v182;
        script.Parent.Buttons.PremiumCurrency.Text = v183;
        script.Parent.Buttons.uFragments.Text = v184;
    end;

    pcall(UpdateCurrency);
    u1.CurrencyUpdated:Connect(function(p185) -- Line: 1145
        -- upvalues: UpdateCurrency (copy)
        if p185 ~= "Changed" then
            return;
        end;

        UpdateCurrency();
    end);
    u2.Signal:Connect(function(p186, p187) -- Line: 1152
        -- upvalues: u1 (copy), ItemData (copy), TextChatService (copy)
        if p186 == "GlobalAnnouncement" then
            if game.Players.LocalPlayer:WaitForChild("Settings").GlobalAnnouncementsHidden.Value then
                return;
            end;

            local v188 = "";

            if p187.Type == "UnusualRolled" then
                local SerialNumber = p187.SerialNumber;
                v188 = `<font color="#00FFFF">@{p187.Name} HAS ROLLED</font> {p187.Variant == "White" and "<font color=\"#FFFFFF\">White</font> <font color=\"#AA55FF\">Unusual</font>" or (p187.Variant == "Black" and "<font color=\"#1A1A1A\">Black</font> <font color=\"#AA55FF\">Unusual</font>" or "<font color=\"#AA55FF\">Unusual</font>")} {u1:GetItemText(p187.ItemId)}`;

                if type(SerialNumber) == "number" then
                    v188 = v188 .. ` <font color="#{Color3.new(1, 1, 1):ToHex()}">#{SerialNumber}</font>`;
                end;
            elseif p187.Type == "MythicAbilityRolled" then
                local AbilityName = p187.AbilityName;
                v188 = `<font color="#00FFFF">@{p187.Name} HAS ROLLED</font> <font color="#{ItemData.GetRarityByName("Mythic").Color:ToHex()}">{AbilityName} Shards</font>`;
            end;

            if #v188 <= 0 then
                return;
            end;

            TextChatService.TextChannels.GlobalAnnouncements:DisplaySystemMessage(v188);
        end;
    end);
end;
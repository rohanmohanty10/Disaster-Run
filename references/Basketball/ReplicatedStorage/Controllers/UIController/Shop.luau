 
 

game:GetService("AdService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local MarketplaceService = game:GetService("MarketplaceService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local LocalPlayer = Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local u2 = u1:FindFirstChildOfClass("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.Trove);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local ShopSettings = require(ReplicatedStorage.Shared.Tables.ShopSettings);
local Customization = require(ReplicatedStorage.Shared.Tables.Customization);
local Rarities = require(ReplicatedStorage.Shared.Tables.Rarities);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local v3 = Knit.CreateController({
    Name = "Shop"
});
local u4 = nil;
local u5 = nil;
local u6 = 0;
local u7 = tick();

function v3.Packs(u8) -- Line: 31
    -- upvalues: LocalPlayer (copy), ShopSettings (copy), u4 (ref), MarketplaceService (copy), Effects (copy), u7 (ref), u6 (ref), u5 (ref), SfxManager (copy), Customization (copy), Rarities (copy), Knit (copy), TweenService (copy)
    for _, child in LocalPlayer.PlayerGui.Shop.BG.Content.Packs:GetChildren() do
        if ShopSettings.Packs[child.Name] then
            local Price = ShopSettings.Packs[child.Name].Price;
            child.Purchase.Txt.Text = `${Price}`;
            child.Purchase.MouseButton1Click:Connect(function() -- Line: 40
                -- upvalues: u4 (ref), Price (copy), MarketplaceService (ref), LocalPlayer (ref), Effects (ref), u7 (ref), u6 (ref), u5 (ref), child (copy)
                if u4.Player.Money < Price then
                    if u4.Policy then
                        return;
                    end;

                    MarketplaceService:PromptProductPurchase(LocalPlayer, 2838788938);
                    Effects:Popup("Not enough money!");

                    return;
                end;

                if u7 > tick() then
                    return;
                end;

                u7 = tick() + 1;
                u6 = Price;
                u5.Pack:Fire(child.Name);
            end);
            child.Info.MouseButton1Click:Connect(function() -- Line: 50
                -- upvalues: LocalPlayer (ref), child (copy)
                LocalPlayer.PlayerGui.Shop.BG.PackItems.Visible = true;

                for _, child2 in LocalPlayer.PlayerGui.Shop.BG.PackItems:GetChildren() do
                    if child2:IsA("ScrollingFrame") then
                        child2.Visible = false;
                    end;
                end;

                LocalPlayer.PlayerGui.Shop.BG.PackItems[child.Name].Visible = true;
            end);
        end;
    end;

    LocalPlayer.PlayerGui.Shop.BG.PackItems.Exit.MouseButton1Click:Connect(function() -- Line: 63
        -- upvalues: LocalPlayer (ref)
        LocalPlayer.PlayerGui.Shop.BG.PackItems.Visible = false;

        for _, child in LocalPlayer.PlayerGui.Shop.BG.PackItems:GetChildren() do
            if child:IsA("ScrollingFrame") then
                child.Visible = false;
            end;
        end;
    end);
    u5.Pack:Connect(function(p9, p10, p11) -- Line: 73
        -- upvalues: u7 (ref), SfxManager (ref), LocalPlayer (ref), Customization (ref), Rarities (ref), u8 (copy), Knit (ref), TweenService (ref), Effects (ref), u6 (ref)
        u7 = tick() + 10;
        SfxManager:playSound({
            Sound = "PackOpening",
            Parent = workspace
        });
        local Enabled = LocalPlayer.PlayerGui.Shop.Enabled;
        LocalPlayer.PlayerGui.Shop.Enabled = false;
        LocalPlayer.PlayerGui.HUD.Enabled = false;
        LocalPlayer.PlayerGui.InGame.Enabled = false;
        local v12 = script[`{p11}Pack`]:Clone();
        v12.Parent = LocalPlayer.PlayerGui.Misc.Pack.WorldModel;
        v12.AnimationController.Animator:LoadAnimation(script.Pack):Play();
        task.wait(2);
        local v13 = script.Card:Clone();
        v13.Parent = LocalPlayer.PlayerGui.Misc;
        local Rarity = Customization[p11][p9].Rarity;
        v13.BG.Inside.ItemName.Text = p9;
        v13.BG.Inside.Rarity.Text = Rarity;
        v13.BG.Inside.Rarity.TextColor3 = Rarities.Colors[Rarity];

        if u8.GoalIcons[p9] and p11 == "GoalEffects" then
            v13.BG.Inside.Icon.Visible = true;
            v13.BG.Inside.Icon.Image = u8.GoalIcons[p9];
        elseif u8.Cards[p9] and p11 == "Cards" then
            v13.BG.Inside.Icon.Visible = true;
            v13.BG.Inside.Icon.Image = u8.Cards[p9];
        end;

        if p11 == "Emotes" then
            local Controller = Knit.GetController("EmotesController");
            Controller:CreatePreview(p9, v13.BG.Inside.Emote, Controller.CharacterRig);
        end;

        task.wait(0.5);
        TweenService:Create(v12.Plane, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            CFrame = CFrame.new(0, -8, -8.5)
        }):Play();

        if p10 then
            Effects:Popup((`Duplicate! Received {u6 / 2} back`));
        else
            Effects:Popup(`Received {p9}!`, 1.5, Rarities.Colors[Rarity]);
        end;

        task.wait(3);
        v12:Destroy();
        v13:Destroy();
        LocalPlayer.PlayerGui.Shop.Enabled = Enabled;

        if LocalPlayer.Team == game.Teams.Visitor then
            LocalPlayer.PlayerGui.HUD.Enabled = not Enabled;
            LocalPlayer.PlayerGui.InGame.Enabled = false;
        else
            LocalPlayer.PlayerGui.HUD.Enabled = false;
            LocalPlayer.PlayerGui.InGame.Enabled = not Enabled;
        end;

        u7 = tick();
    end);
end;

function v3.RobuxPurchase(p14) -- Line: 139
    -- upvalues: LocalPlayer (copy), ShopSettings (copy), MarketplaceService (copy), u4 (ref), Effects (copy), Knit (copy)
    local PlayerGui = LocalPlayer.PlayerGui;
    local u15 = tick();

    for _, descendant in PlayerGui:GetDescendants() do
        if descendant:IsA("ImageButton") and descendant.Name == "Robux" then
            local u16 = descendant;
            local u17 = nil;

            for _, v in ShopSettings.AllProducts do
                for i, v2 in v do
                    if i == u16.Parent.Name then
                        u17 = v2.ID;
                        break;
                    end;
                end;
            end;

            task.spawn(function() -- Line: 153
                -- upvalues: u17 (ref), MarketplaceService (ref), u16 (copy)
                if u17 == nil then
                    return;
                end;

                local u18 = nil;

                while true do
                    pcall(function() -- Line: 158
                        -- upvalues: u18 (ref), MarketplaceService (ref), u17 (ref)
                        u18 = MarketplaceService:GetProductInfo(u17, Enum.InfoType.Product);
                    end);

                    if u18 == nil then
                        task.wait(1);
                    end;

                    if u18 ~= nil then
                        u16.Txt.Text = `{u18.PriceInRobux}`;

                        return;
                    end;
                end;
            end);
            u16.MouseButton1Click:Connect(function() -- Line: 169
                -- upvalues: u15 (ref), u4 (ref), Effects (ref), u17 (ref), MarketplaceService (ref), LocalPlayer (ref)
                if u15 > tick() then
                    return;
                end;

                if u4.Policy then
                    Effects:Popup("This purchase is not available for your region.");

                    return;
                end;

                u15 = tick() + 0.5;

                if u17 == nil then
                    return;
                end;

                MarketplaceService:PromptProductPurchase(LocalPlayer, u17);
            end);
        end;
    end;

    local u19 = {
        AwakeningOutfits = 3238744179,
        SkipSpins = 3238744507,
        VIP = 3238743960
    };
    local u20 = {
        AwakeningOutfits = 1090339361,
        SkipSpins = 1070782960,
        VIP = 1070764799,
        RelicsBoombox = 109444884683755
    };

    for _, child in LocalPlayer.PlayerGui.Shop.BG.Content.Gamepasses:GetChildren() do
        if child:IsA("ImageLabel") then
            local Gift = child:FindFirstChild("Gift");

            if Gift then
                Gift.MouseButton1Click:Connect(function() -- Line: 203
                    -- upvalues: Knit (ref), u19 (copy), child (copy)
                    Knit.GetController("GiftingController").PromptGiftPlayer(u19[child.Name]);
                end);
            end;

            child.Buy.MouseButton1Click:Connect(function() -- Line: 209
                -- upvalues: child (copy), MarketplaceService (ref), LocalPlayer (ref), u20 (copy)
                if child.Name == "RelicsBoombox" then
                    MarketplaceService:PromptPurchase(LocalPlayer, u20[child.Name]);

                    return;
                end;

                MarketplaceService:PromptGamePassPurchase(LocalPlayer, u20[child.Name]);
            end);
            task.spawn(function() -- Line: 217
                -- upvalues: child (copy), MarketplaceService (ref), u20 (copy)
                local u21 = nil;

                while true do
                    pcall(function() -- Line: 221
                        -- upvalues: child (ref), u21 (ref), MarketplaceService (ref), u20 (ref)
                        if child.Name == "RelicsBoombox" then
                            u21 = MarketplaceService:GetProductInfo(u20[child.Name], Enum.InfoType.Asset);

                            return;
                        end;

                        u21 = MarketplaceService:GetProductInfo(u20[child.Name], Enum.InfoType.GamePass);
                    end);

                    if u21 == nil then
                        task.wait(1);
                    end;

                    if u21 ~= nil then
                        child.Buy.Txt.Text = `{u21.PriceInRobux}`;

                        return;
                    end;
                end;
            end);
        end;
    end;
end;

function v3.PackItems(p22) -- Line: 238
    -- upvalues: Rarities (copy), Knit (copy), ReplicatedStorage (copy), LocalPlayer (copy), Customization (copy)
    local v23 = {};
    local v24 = {
        Rare = 5,
        Epic = 4,
        Legendary = 3,
        Mythic = 2,
        Limited = 1
    };

    for _, v in Rarities.PackOdds do
        table.insert(v23, v[1]);
    end;

    local Controller = Knit.GetController("EmotesController");
    local EmoteAnimations = ReplicatedStorage.Assets.EmoteAnimations;
    local GoalEffects = ReplicatedStorage.Assets.GoalEffects;
    local Cards = ReplicatedStorage.Assets.Cards;
    local PackItems = LocalPlayer.PlayerGui.Shop.BG.PackItems;
    local v25 = {};
    local v26 = {};
    local v27 = {};

    for _, child in EmoteAnimations:GetChildren() do
        if Customization.Emotes[child.Name] then
            local Rarity = Customization.Emotes[child.name].Rarity;

            if table.find(v23, Rarity) then
                if not v25[Rarity] then
                    v25[Rarity] = {};
                end;

                table.insert(v25[Rarity], child.Name);
            end;
        end;
    end;

    for _, child in GoalEffects:GetChildren() do
        if Customization.GoalEffects[child.Name] then
            local Rarity = Customization.GoalEffects[child.name].Rarity;

            if table.find(v23, Rarity) then
                if not v26[Rarity] then
                    v26[Rarity] = {};
                end;

                table.insert(v26[Rarity], child.Name);
            end;
        end;
    end;

    for _, child in Cards:GetChildren() do
        if Customization.Cards[child.Name] then
            local Rarity = Customization.Cards[child.name].Rarity;

            if table.find(v23, Rarity) then
                if not v27[Rarity] then
                    v27[Rarity] = {};
                end;

                table.insert(v27[Rarity], child.Name);
            end;
        end;
    end;

    for _, child in EmoteAnimations:GetChildren() do
        if Customization.Emotes[child.Name] and table.find(v23, Customization.Emotes[child.Name].Rarity) then
            local Name = child.Name;
            local Rarity = Customization.Emotes[Name].Rarity;
            local v28 = math.round(Rarities.PackOdds[Rarity == "Rare" and 1 or (Rarity == "Epic" and 2 or (Rarity == "Legendary" and 3 or false))][2] * 10000 / #v25[Rarity]) / 10000;
            local v29 = script.EmoteItem:Clone();
            v29.ItemName.Text = `{Name} - {v28}%`;
            v29.LayoutOrder = v24[Rarity];
            v29.UIGradient.Color = ColorSequence.new(Rarities.Colors[Rarity]);
            v29.Parent = PackItems.Emotes;
            Controller:CreatePreview(child.Name, v29:WaitForChild("ViewportFrame"), Controller.CharacterRig);
        end;
    end;

    for _, child in GoalEffects:GetChildren() do
        if Customization.GoalEffects[child.Name] and table.find(v23, Customization.GoalEffects[child.Name].Rarity) then
            local Name = child.Name;
            local Rarity = Customization.GoalEffects[Name].Rarity;
            local v30 = math.round(Rarities.PackOdds[Rarity == "Rare" and 1 or (Rarity == "Epic" and 2 or (Rarity == "Legendary" and 3 or false))][2] * 10000 / #v26[Rarity]) / 10000;
            local GoalIcons = p22.GoalIcons;
            local v31 = script.GoalEffectsItem:Clone();
            v31.ItemName.Text = `{Name} - {v30}%`;
            v31.LayoutOrder = v24[Rarity];
            v31.UIGradient.Color = ColorSequence.new(Rarities.Colors[Rarity]);

            if GoalIcons[child.Name] then
                v31.Icon.Visible = true;
                v31.Icon.Image = GoalIcons[child.Name];
                v31.ItemName.Size = UDim2.fromScale(0.8, 0.25);
                v31.ItemName.Position = UDim2.fromScale(0.5, 0.77);
            end;

            v31.Parent = PackItems.GoalEffects;
        end;
    end;

    for _, child in Cards:GetChildren() do
        if Customization.Cards[child.Name] and table.find(v23, Customization.Cards[child.Name].Rarity) then
            local Name = child.Name;
            local Rarity = Customization.Cards[Name].Rarity;
            local v32 = math.round(Rarities.PackOdds[Rarity == "Rare" and 1 or (Rarity == "Epic" and 2 or (Rarity == "Legendary" and 3 or false))][2] * 10000 / #v27[Rarity]) / 10000;
            local _ = p22.GoalIcons;
            local v33 = script.GoalEffectsItem:Clone();
            v33.ItemName.Text = `{Name} - {v32}%`;
            v33.LayoutOrder = v24[Rarity];
            v33.UIGradient.Color = ColorSequence.new(Rarities.Colors[Rarity]);
            v33.Icon.Visible = true;
            v33.Icon.Image = child.DesignHolder.Design.Image;
            v33.ItemName.Size = UDim2.fromScale(0.8, 0.25);
            v33.ItemName.Position = UDim2.fromScale(0.5, 0.77);
            v33.Parent = PackItems.Cards;
        end;
    end;

    PackItems.Exit.MouseButton1Click:Connect(function() -- Line: 363
        -- upvalues: PackItems (copy)
        PackItems.Visible = false;
    end);
end;

function v3.PackItemsLobby(p34) -- Line: 368
    -- upvalues: Rarities (copy), Knit (copy), ReplicatedStorage (copy), Customization (copy), LocalPlayer (copy)
    local v35 = {};
    local v36 = {
        Rare = 5,
        Epic = 4,
        Legendary = 3,
        Mythic = 2,
        Limited = 1
    };

    for _, v in Rarities.PackOdds do
        table.insert(v35, v[1]);
    end;

    Knit.GetController("EmotesController");
    local EmoteAnimations = ReplicatedStorage.Assets.EmoteAnimations;
    local GoalEffects = ReplicatedStorage.Assets.GoalEffects;
    local Cards = ReplicatedStorage.Assets.Cards;

    for _, child in workspace.Lobby.Packs:GetChildren() do
        if child:IsA("Model") then
            local Name = child.Name;
            local PackItemsUI = child:FindFirstChild("PackItemsUI", true);

            if PackItemsUI then
                if Name == "Emotes" then
                    local v37 = {};

                    for _, child2 in EmoteAnimations:GetChildren() do
                        if Customization.Emotes[child2.Name] then
                            local Rarity = Customization.Emotes[child2.name].Rarity;

                            if table.find(v35, Rarity) then
                                if not v37[Rarity] then
                                    v37[Rarity] = {};
                                end;

                                table.insert(v37[Rarity], child2.Name);
                            end;
                        end;
                    end;

                    for _, child2 in EmoteAnimations:GetChildren() do
                        if Customization.Emotes[child2.Name] and table.find(v35, Customization.Emotes[child2.Name].Rarity) then
                            local Name2 = child2.Name;
                            local Rarity = Customization.Emotes[Name2].Rarity;
                            local v38 = math.round(Rarities.PackOdds[Rarity == "Rare" and 1 or (Rarity == "Epic" and 2 or (Rarity == "Legendary" and 3 or false))][2] * 10000 / #v37[Rarity]) / 10000;
                            local v39 = script.EmoteItem:Clone();
                            v39.ItemName.Text = `{Name2} - {v38}%`;
                            v39.LayoutOrder = v36[Rarity];
                            v39.UIGradient.Color = ColorSequence.new(Rarities.Colors[Rarity]);
                            v39.Parent = PackItemsUI.PackItems.List;
                        end;
                    end;
                elseif Name == "GoalEffects" then
                    local v40 = {};

                    for _, child2 in GoalEffects:GetChildren() do
                        if Customization.GoalEffects[child2.Name] then
                            local Rarity = Customization.GoalEffects[child2.name].Rarity;

                            if table.find(v35, Rarity) then
                                if not v40[Rarity] then
                                    v40[Rarity] = {};
                                end;

                                table.insert(v40[Rarity], child2.Name);
                            end;
                        end;
                    end;

                    for _, child2 in GoalEffects:GetChildren() do
                        if Customization.GoalEffects[child2.Name] and table.find(v35, Customization.GoalEffects[child2.Name].Rarity) then
                            local Name2 = child2.Name;
                            local Rarity = Customization.GoalEffects[Name2].Rarity;
                            local v41 = math.round(Rarities.PackOdds[Rarity == "Rare" and 1 or (Rarity == "Epic" and 2 or (Rarity == "Legendary" and 3 or false))][2] * 10000 / #v40[Rarity]) / 10000;
                            local GoalIcons = p34.GoalIcons;
                            local v42 = script.GoalEffectsItem:Clone();
                            v42.ItemName.Text = `{Name2} - {v41}%`;
                            v42.LayoutOrder = v36[Rarity];
                            v42.UIGradient.Color = ColorSequence.new(Rarities.Colors[Rarity]);

                            if GoalIcons[Name2] then
                                v42.Icon.Visible = true;
                                v42.Icon.Image = GoalIcons[Name2];
                                v42.ItemName.Size = UDim2.fromScale(0.8, 0.25);
                                v42.ItemName.Position = UDim2.fromScale(0.5, 0.77);
                            end;

                            v42.Parent = PackItemsUI.PackItems.List;
                        end;
                    end;
                elseif Name == "PlayerCard" then
                    local v43 = {};

                    for _, child2 in Cards:GetChildren() do
                        if Customization.Cards[child2.Name] then
                            local Rarity = Customization.Cards[child2.name].Rarity;

                            if table.find(v35, Rarity) then
                                if not v43[Rarity] then
                                    v43[Rarity] = {};
                                end;

                                table.insert(v43[Rarity], child2.Name);
                            end;
                        end;
                    end;

                    for _, child2 in Cards:GetChildren() do
                        if Customization.Cards[child2.Name] and table.find(v35, Customization.Cards[child2.Name].Rarity) then
                            local Name2 = child2.Name;
                            local Rarity = Customization.Cards[Name2].Rarity;
                            local v44 = math.round(Rarities.PackOdds[Rarity == "Rare" and 1 or (Rarity == "Epic" and 2 or (Rarity == "Legendary" and 3 or false))][2] * 10000 / #v43[Rarity]) / 10000;
                            local _ = p34.GoalIcons;
                            local v45 = script.GoalEffectsItem:Clone();
                            v45.ItemName.Text = `{Name2} - {v44}%`;
                            v45.LayoutOrder = v36[Rarity];
                            v45.UIGradient.Color = ColorSequence.new(Rarities.Colors[Rarity]);
                            v45.Icon.Visible = true;
                            v45.Icon.Image = child2.DesignHolder.Design.Image;
                            v45.ItemName.Size = UDim2.fromScale(0.8, 0.25);
                            v45.ItemName.Position = UDim2.fromScale(0.5, 0.77);
                            v45.Parent = PackItemsUI.PackItems.List;
                        end;
                    end;
                end;

                local Parent = PackItemsUI.Parent;
                PackItemsUI.Parent = LocalPlayer.PlayerGui;
                PackItemsUI.Adornee = Parent;
            end;
        end;
    end;
end;

function v3.KnitStart(u46) -- Line: 513
    -- upvalues: Knit (copy), u5 (ref), u4 (ref), LocalPlayer (copy), ShopSettings (copy), MarketplaceService (copy), Effects (copy), u7 (ref), u6 (ref), Essentials (copy), RunService (copy)
    local Controller = Knit.GetController("PromptController");
    u5 = Knit.GetService("PacksService");
    u4 = Knit.GetController("Network");
    u46:Packs();
    u46:RobuxPurchase();
    u46:PackItemsLobby();
    LocalPlayer.PlayerGui.Shop:GetPropertyChangedSignal("Enabled"):Once(function() -- Line: 523
        -- upvalues: u46 (copy)
        u46:PackItems();
    end);
    local Emotes = workspace:WaitForChild("Lobby"):WaitForChild("Packs"):WaitForChild("Emotes");
    local GoalEffects = workspace:WaitForChild("Lobby"):WaitForChild("Packs"):WaitForChild("GoalEffects");
    local PlayerCard = workspace.Lobby.Packs:WaitForChild("PlayerCard");

    local function promptPurchase(p47) -- Line: 531
        -- upvalues: u4 (ref), ShopSettings (ref), MarketplaceService (ref), LocalPlayer (ref), Effects (ref), u7 (ref), u6 (ref), u5 (ref)
        if u4.Player.Money < ShopSettings.Packs[p47].Price then
            if u4.Policy then
                return;
            end;

            MarketplaceService:PromptProductPurchase(LocalPlayer, 2838788938);
            Effects:Popup("Not enough money!");

            return;
        end;

        if u7 > tick() then
            return;
        end;

        u7 = tick() + 1;
        u6 = ShopSettings.Packs[p47].Price;
        u5.Pack:Fire(p47);
    end;

    Controller.SpawnPurchasePrompt(Emotes, "Emote Pack", nil, nil, nil, `${Essentials:formatNumberWithCommas(ShopSettings.Packs.Emotes.Price)}`, function() -- Line: 541
        -- upvalues: promptPurchase (copy)
        promptPurchase("Emotes");
    end);
    Controller.SpawnPurchasePrompt(GoalEffects, "Goal Effects Pack", nil, nil, nil, `${Essentials:formatNumberWithCommas(ShopSettings.Packs.GoalEffects.Price)}`, function() -- Line: 545
        -- upvalues: promptPurchase (copy)
        promptPurchase("GoalEffects");
    end);
    Controller.SpawnPurchasePrompt(PlayerCard, "Player Card Pack", nil, nil, nil, `${Essentials:formatNumberWithCommas(ShopSettings.Packs.Cards.Price)}`, function() -- Line: 549
        -- upvalues: promptPurchase (copy)
        promptPurchase("Cards");
    end);
    task.spawn(function() -- Line: 553
        -- upvalues: LocalPlayer (ref)
        while task.wait(3) do
            local Packs = LocalPlayer.PlayerGui.Shop.BG.Content.Packs;
            Packs.Emotes.Desc.Normal.Visible = not Packs.Emotes.Desc.Normal.Visible;
            Packs.Emotes.Desc.Lucky.Visible = not Packs.Emotes.Desc.Lucky.Visible;
            Packs.GoalEffects.Desc.Normal.Visible = not Packs.GoalEffects.Desc.Normal.Visible;
            Packs.GoalEffects.Desc.Lucky.Visible = not Packs.GoalEffects.Desc.Lucky.Visible;
        end;
    end);

    for _, v in { Emotes, GoalEffects, PlayerCard } do
        local Pivot = v:GetPivot();
        RunService.PreRender:Connect(function(p48: number) -- Line: 568
            -- upvalues: LocalPlayer (ref), Pivot (copy), v (copy)
            if LocalPlayer.Team ~= game.Teams.Visitor then
                return;
            end;

            local v49 = time() * 2 + Pivot.X;
            local v50 = Pivot * CFrame.fromEulerAnglesYXZ(0, -0.15707963267948966 + math.cos(v49) * 3.141592653589793 * 0.02, math.sin(v49) * 3.141592653589793 * 0.1);
            local v51 = math.sin(v49) * 0.5;
            v:PivotTo(v50 + Vector3.new(0, v51, 0));
        end);
    end;
end;

function v3.KnitInit(p52) -- Line: 586
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), HumanoidRootPart (ref), ReplicatedStorage (copy)
    LocalPlayer.CharacterAdded:Connect(function(p53) -- Line: 587
        -- upvalues: u1 (ref), u2 (ref), HumanoidRootPart (ref)
        u1 = p53;
        u2 = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
    end);
    p52.GoalIcons = {
        SLASH = "rbxassetid://81538975788835",
        HellFire = "rbxassetid://136501720884459",
        ["Lightning Storm"] = "rbxassetid://78526830648854",
        ["Cell Explosion"] = "rbxassetid://136501720884459",
        ["Emperor\'s Aura"] = "rbxassetid://136501720884459",
        ["BASKETBALL GOD\'S GOAL"] = "rbxassetid://136501720884459",
        Rocket = "rbxassetid://85598323604242",
        Wet = "rbxassetid://86019777320928",
        Meteor = "rbxassetid://92360371631965",
        Timestop = "rbxassetid://136501720884459",
        Cyber = "rbxassetid://136501720884459",
        Symbiote = "rbxassetid://136501720884459",
        Haki = "rbxassetid://136501720884459",
        IDOL = "rbxassetid://136501720884459",
        Current = "rbxassetid://136501720884459",
        Fireworks = "rbxassetid://136501720884459",
        Garbage = "rbxassetid://136501720884459",
        Skulls = "rbxassetid://136501720884459",
        Beast = "rbxassetid://136501720884459",
        ["Sunburst Slam"] = "rbxassetid://136501720884459",
        Nature = "rbxassetid://133179059807634",
        Lightning = "rbxassetid://102913331138948",
        Default = "rbxassetid://93183707314402",
        ["Always In"] = "rbxassetid://72630678553467",
        Wind = "rbxassetid://112184094077462",
        Glitch = "rbxassetid://85610466731048",
        Dark = "rbxassetid://131145737718139",
        Ice = "rbxassetid://128765223058185",
        ["Sand Explosion"] = "rbxassetid://137867418755441",
        Venom = "rbxassetid://94519848280273",
        ["SLIME!"] = "rbxassetid://82076008981902",
        Smoke = "rbxassetid://98620024767344",
        Butterfly = "rbxassetid://131367850447651",
        Water = "rbxassetid://86019777320928",
        Music = "rbxassetid://102003556421705",
        Atomic = "rbxassetid://80144555374345",
        Boom = "rbxassetid://137257672794436",
        ["Energy Beam"] = "rbxassetid://120181282882320",
        Constellation = "rbxassetid://134797901544216",
        Jackpot = "rbxassetid://104060164677085",
        Rulebook = "rbxassetid://115983679490249",
        Lowrider = "rbxassetid://83464278513480",
        ["Rubber Duck"] = "rbxassetid://137945129343082",
        HAHA = "rbxassetid://87958109139187",
        ["Flying Knife"] = "rbxassetid://109802553460870",
        ["Wazzup!"] = "rbxassetid://80938350337033",
        Chainsaw = "rbxassetid://107611578878149",
        ["Floating Pumpkins"] = "rbxassetid://106127572295834",
        ["Candle Explosion"] = "rbxassetid://104125835187154",
        Butterflies = "rbxassetid://89463650208505",
        ["Shark Fins"] = "rbxassetid://75813370520655",
        ["UFO Goal"] = "rbxassetid://98613001697143",
        ["Cyber Tentacles"] = "rbxassetid://111597222542107",
        ["Dino Roar"] = "rbxassetid://99390647052686",
        Concert = "rbxassetid://93894518249066",
        ["Music Notes"] = "rbxassetid://89627431037143",
        Throne = "rbxassetid://83696219272574",
        Trophy = "rbxassetid://73078413262343",
        ["Dragon Summon"] = "rbxassetid://106900891052746",
        ["Eclipse Goal"] = "rbxassetid://130254235195690",
        ["77"] = "rbxassetid://83824620985266",
        ["Buzzer Beater"] = "rbxassetid://126037164413227",
        ["Card Explosion"] = "rbxassetid://107084206908654",
        ["Different Dimension"] = "rbxassetid://72179782087504",
        ["67"] = "rbxassetid://81374209109835",
        ["Laser Beam"] = "rbxassetid://88245137658617",
        Error = "rbxassetid://79866915268025",
        Nuke = "rbxassetid://126000100058902",
        L = "rbxassetid://124125910086727",
        ["Super Slam"] = "rbxassetid://91568343218453",
        ["Fighter Jets"] = "rbxassetid://135753618652909",
        ["Whale Dance"] = "rbxassetid://107046240997946",
        ["Whale Drop"] = "rbxassetid://129764369609496",
        ["Anvil Drop"] = "rbxassetid://111029958904905",
        ["Piano Drop"] = "rbxassetid://78657053435207",
        ["Playing Piano"] = "rbxassetid://80379180396955",
        ["Playing Guitar"] = "rbxassetid://133990231388406",
        ["Playing Violin"] = "rbxassetid://71762339299280",
        ["Disco Ball"] = "rbxassetid://72599465755359",
        ["Spray Paint"] = "rbxassetid://71596172505337",
        ["Floating Eye"] = "rbxassetid://134851765985427",
        ["Slow Dancer"] = "rbxassetid://114740654724520",
        ["Valentine\'s Aura"] = "rbxassetid://102802297127046",
        ["Hee Hee"] = "rbxassetid://125985311043356",
        ["Pop Legend"] = "rbxassetid://71552526016823",
        ["Skeleton Arm"] = "rbxassetid://92150593229193",
        ["Bat Swarm"] = "rbxassetid://134851322990855",
        ["Ghost Tornado"] = "rbxassetid://119653128208983"
    };
    p52.ShotIcons = {
        Water = "rbxassetid://87147981294110",
        Fire = "rbxassetid://126417690193880",
        Joker = "rbxassetid://111294226671164",
        Lightning = "rbxassetid://85834148045713",
        ["Blue Glitch"] = "rbxassetid://90851086305032",
        Strongest = "rbxassetid://79986082822129",
        Chrollo = "rbxassetid://128577962805238",
        Dragon = "rbxassetid://105651372279669",
        Green = "rbxassetid://70656459650924",
        ["Pink Glitch"] = "rbxassetid://97893578207581",
        Music = "rbxassetid://86671588928950"
    };
    p52.Cards = {
        Basic = "",
        Basketball = "",
        ["Blue Graffiti"] = "",
        ["Cool Guy"] = "",
        ["Dead Lightning"] = "",
        Graffiti = "",
        ["Green Design"] = "",
        ["Green Graffiti"] = "",
        Lion = "",
        ["Orange Paint"] = "",
        ["Purple Design"] = "",
        Samurai = ""
    };

    for _, child in ReplicatedStorage.Assets.Cards:GetChildren() do
        p52.Cards[child.Name] = child.DesignHolder.Design.Image;
    end;
end;

return v3;
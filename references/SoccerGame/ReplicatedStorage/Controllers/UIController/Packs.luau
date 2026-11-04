  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local ContentProvider = game:GetService("ContentProvider");
local Debris = game:GetService("Debris");
local MarketplaceService = game:GetService("MarketplaceService");
local TweenService = game:GetService("TweenService");
local CollectionService = game:GetService("CollectionService");
local LocalPlayer = Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local u2 = u1:FindFirstChildOfClass("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local _ = HumanoidRootPart:WaitForChild("RootJoint").C0;
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
local Trove = require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local KaiserRarities = require(ReplicatedStorage.Shared.KaiserRarities);
local ItemRarities = require(ReplicatedStorage.Shared.ItemRarities);
local ItemRobuxRarities = require(ReplicatedStorage.Shared.ItemRobuxRarities);
local Icons = require(ReplicatedStorage.Shared.Configs.Icons);
local PacksConfig = require(ReplicatedStorage.Shared.Configs.PacksConfig);
local PackOddsCalculator = require(ReplicatedStorage.Shared.PackOddsCalculator);
local ItemDisplayNames = require(ReplicatedStorage.Shared.Configs.ItemDisplayNames);
local MVPCutscenes = require(ReplicatedStorage.Shared.MVPCutscenes);
require(ReplicatedStorage.Shared.Emotes.Emotes);
local v3 = Knit.CreateController({
    Name = "Packs"
});
local u4 = tick();

function v3.LobbyPacks(u5) -- Line: 41
    -- upvalues: ReplicatedStorage (copy), UserInputService (copy), LocalPlayer (copy), u4 (ref), Popup (copy), PacksConfig (copy), MarketplaceService (copy), Knit (copy)
    ReplicatedStorage.Assets.Misc.LobbyVFX.Parent = workspace;
    task.spawn(function() -- Line: 44
        -- upvalues: UserInputService (ref)
        if UserInputService.TouchEnabled then
            local Descendants = workspace.LobbyVFX:GetDescendants();

            for _, v in pairs(Descendants) do
                if v:IsA("ParticleEmitter") then
                    v:Destroy();
                end;
            end;

            table.clear(Descendants);
        end;
    end);
    local u6 = {};

    for _, child in workspace.Cards:GetChildren() do
        local Card = child:FindFirstChild("Card");
        local v7 = Card and Card:FindFirstChild("AnimationController");

        if v7 then
            v7 = v7:FindFirstChild("Animator");
        end;

        if v7 then
            u6[child.Name] = v7:LoadAnimation(ReplicatedStorage.Assets.ReplicatedAnims.HoverCard);
        end;
    end;

    for _, child in pairs(workspace.Cards:GetChildren()) do
        local u8 = 1;
        u5.BaseTrove:Connect(child.Card.Proximity.Normal.Triggered, function(p9) -- Line: 73
            -- upvalues: LocalPlayer (ref), u4 (ref), u5 (copy), Popup (ref), PacksConfig (ref), child (copy), MarketplaceService (ref), Knit (ref)
            if p9 ~= LocalPlayer then
                return;
            end;

            if u4 > tick() then
                return;
            end;

            if u5.Opening or LocalPlayer:GetAttribute("PackBusy") then
                return;
            end;

            if LocalPlayer.Team ~= game.Teams.Visitor then
                Popup.Popup(LocalPlayer, "YOU CAN\'T OPEN PACKS DURING A MATCH");

                return;
            end;

            u4 = tick() + 0.15;
            local v10 = PacksConfig[child.Name];

            if v10 then
                local v11 = LocalPlayer.PacksStorage:FindFirstChild(child.Name) and LocalPlayer.PacksStorage[child.Name].Value > 0;

                if LocalPlayer.ProfileStats.Money.Value < v10.Cost and not v11 then
                    MarketplaceService:PromptProductPurchase(LocalPlayer, v10.RobuxProductId or Knit.GetController("GemSkinController"):MapProductId(2660228654));

                    return;
                end;
            end;

            u5.Opening = true;
            LocalPlayer:SetAttribute("PackBusy", true);
            u5.PackService.Pack:Fire(child.Name);
        end);
        u5.BaseTrove:Connect(child.Card.Proximity.Normal.PromptShown, function() -- Line: 99
            -- upvalues: u8 (ref), u6 (copy), child (copy)
            u8 = u8 + 1;
            local u12 = u8;
            u6[child.Name]:Play();
            u6[child.Name]:AdjustSpeed(1);
            task.delay(0.35, function() -- Line: 105
                -- upvalues: u8 (ref), u12 (copy), u6 (ref), child (ref)
                if u8 == u12 then
                    u6[child.Name]:AdjustSpeed(0);
                end;
            end);
        end);
        u5.BaseTrove:Connect(child.Card.Proximity.Normal.PromptHidden, function() -- Line: 112
            -- upvalues: u8 (ref), u6 (copy), child (copy)
            u8 = u8 + 1;
            u6[child.Name]:AdjustSpeed(-1);
        end);
        u5.BaseTrove:Connect(child.Card.Proximity.Robux.Triggered, function(p13) -- Line: 117
            -- upvalues: LocalPlayer (ref), u4 (ref), u5 (copy), Popup (ref), MarketplaceService (ref), child (copy)
            if p13 ~= LocalPlayer then
                return;
            end;

            if u4 > tick() then
                return;
            end;

            if u5.Opening or LocalPlayer:GetAttribute("PackBusy") then
                return;
            end;

            if LocalPlayer.Team ~= game.Teams.Visitor then
                Popup.Popup(LocalPlayer, "YOU CAN\'T OPEN PACKS DURING A MATCH");

                return;
            end;

            u4 = tick() + 0.15;
            MarketplaceService:PromptProductPurchase(LocalPlayer, child.Card.Proximity.Robux:GetAttribute("ID"));
        end);
    end;
end;

function v3.Refresh(p14) -- Line: 139
    -- upvalues: LocalPlayer (copy), PacksConfig (copy)
    local function fmt(p15) -- Line: 140
        return string.format("%s", p15):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
    end;

    local Shop = LocalPlayer.PlayerGui:WaitForChild("Shop");

    for _, child in pairs(Shop:WaitForChild("BG"):WaitForChild("ShopUI"):WaitForChild("Inside"):WaitForChild("Packs"):GetChildren()) do
        if child:IsA("Frame") then
            local v16 = PacksConfig[child.Name];

            if v16 then
                local v17 = LocalPlayer.PacksStorage:FindFirstChild(child.Name);
                local v18 = v17 and v17.Value or 0;

                if v18 > 0 then
                    child.PriceButton.TextLabel.Text = `Open ({v18})`;
                    child.PriceButton.Icon.Visible = false;
                    child.PriceButton.TextLabel.Position = UDim2.fromScale(0.5, 0.52);
                    child.PriceButton.TextLabel.Size = UDim2.fromScale(0.6, 0.5);
                else
                    child.PriceButton.TextLabel.Text = string.format("%s", v16.Cost):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
                    child.PriceButton.Icon.Visible = true;
                    child.PriceButton.TextLabel.Position = UDim2.fromScale(0.6, 0.52);
                    child.PriceButton.TextLabel.Size = UDim2.fromScale(0.35, 0.5);
                end;
            end;
        end;
    end;

    for _, child in workspace.Cards:GetChildren() do
        local v19 = PacksConfig[child.Name];

        if v19 then
            local v20 = child:FindFirstChild("Card") and child.Card:FindFirstChild("Proximity");

            if v20 then
                v20 = v20:FindFirstChild("Normal");
            end;

            if v20 then
                local v21 = LocalPlayer.PacksStorage:FindFirstChild(child.Name);
                local v22 = v21 and v21.Value or 0;

                if v22 > 0 then
                    v20.ActionText = `Free ({v22})`;
                else
                    v20.ActionText = "$" .. string.format("%s", v19.Cost):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
                end;
            end;
        end;
    end;
end;

function v3.PreviewMVP(p23, p24, p25) -- Line: 179
    -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy), Players (copy)
    local Character = LocalPlayer.Character;
    local v26;

    if Character then
        v26 = Character:FindFirstChild("Humanoid");
    else
        v26 = Character;
    end;

    local MVPCutscenes2 = ReplicatedStorage.Effects:FindFirstChild("MVPCutscenes");

    if MVPCutscenes2 then
        MVPCutscenes2 = MVPCutscenes2:FindFirstChild(p24);
    end;

    if not (Character and (Character:FindFirstChild("HumanoidRootPart") and (v26 and MVPCutscenes2))) then
        return;
    end;

    if v26.Health <= 0 or Character:GetAttribute("CutsceneChar") then
        return;
    end;

    local success, result = pcall(require, MVPCutscenes2);

    if not success or type(result) ~= "function" then
        return;
    end;

    local function createActor(p27) -- Line: 196
        -- upvalues: Character (copy), ReplicatedStorage (ref), Players (ref)
        local Archivable = Character.Archivable;
        Character.Archivable = true;
        local v28 = Character:Clone();
        Character.Archivable = Archivable;
        local u29 = typeof(p27) == "string" and (p27:match("^%s*(.-)%s*$") or "") or "";
        local u30 = v28:FindFirstChildOfClass("Humanoid");

        if u29 ~= "" and u30 then
            v28.Parent = ReplicatedStorage;
            local success2, result2 = pcall(function() -- Line: 208
                -- upvalues: Players (ref), u29 (ref)
                return Players:GetHumanoidDescriptionFromUserId((Players:GetUserIdFromNameAsync(u29)));
            end);

            if success2 then
                local success3, result3 = pcall(function() -- Line: 214
                    -- upvalues: u30 (copy), result2 (copy)
                    u30:ApplyDescription(result2);
                end);

                if success3 then
                    v28.Name = u29;
                else
                    warn("[MVPPreview] Could not apply @" .. u29 .. "\'s avatar: " .. tostring(result3));
                end;
            else
                warn("[MVPPreview] Could not find @" .. u29 .. ": " .. tostring(result2));
            end;

            v28.Parent = nil;
        end;

        return v28;
    end;

    local v31 = typeof(p25) == "table" and p25 and p25 or {};
    local v32 = createActor(v31.MainUsername);
    local v33 = {};
    local v34 = typeof(v31.TeammateUsernames) == "table" and (v31.TeammateUsernames or {}) or {};
    v33[1] = createActor(v34[1]);
    v33[2] = createActor(v34[2]);
    v33[3] = createActor(v34[3]);
    v33[4] = createActor(v34[4]);
    local BallSpawn = workspace:FindFirstChild("BallSpawn");

    if BallSpawn then
        v32:PivotTo(BallSpawn.CFrame * CFrame.new(0, 2, 0));
    end;

    LocalPlayer:SetAttribute("MVPPreviewActive", true);
    local success2, result2 = pcall(result, {
        Char = v32,
        Teammates = v33
    });

    if not success2 then
        warn("[MVPPreview] " .. tostring(result2));
    end;

    LocalPlayer:SetAttribute("MVPPreviewActive", nil);
    v32:Destroy();

    for _, v in ipairs(v33) do
        v:Destroy();
    end;
end;

function v3.KnitStart(u35) -- Line: 256
    -- upvalues: ContentProvider (copy), ReplicatedStorage (copy), LocalPlayer (copy), Knit (copy), Popup (copy), TweenService (copy), Debris (copy), MVPCutscenes (copy), ItemDisplayNames (copy), Icons (copy), VfxManager (copy), RunService (copy), KaiserRarities (copy), UserInputService (copy), u4 (ref), PacksConfig (copy), MarketplaceService (copy), CollectionService (copy), PackOddsCalculator (copy), ItemRarities (copy), ItemRobuxRarities (copy)
    task.spawn(function() -- Line: 257
        -- upvalues: ContentProvider (ref), ReplicatedStorage (ref), LocalPlayer (ref)
        ContentProvider:PreloadAsync({ ReplicatedStorage.Assets.ReplicatedAnims.OpenCard });

        for _, child in LocalPlayer.PlayerGui.ImpactFrames:GetChildren() do
            ContentProvider:PreloadAsync({ child });
        end;
    end);
    u35.Opening = false;
    u35.PackService = Knit.GetService("PacksService");
    u35.Customization = Knit.GetController("Customization");
    u35.BaseTrove:Connect(u35.PackService.Opened, function(u36, p37, p38, p39) -- Line: 270
        -- upvalues: LocalPlayer (ref), u35 (copy), Popup (ref), TweenService (ref), ReplicatedStorage (ref), Debris (ref), MVPCutscenes (ref), ItemDisplayNames (ref), Icons (ref), VfxManager (ref), RunService (ref)
        LocalPlayer:SetAttribute("PackBusy", true);
        u35.Opening = true;
        Popup.Blackframe(LocalPlayer);
        task.wait(0.5);
        local Enabled = LocalPlayer.PlayerGui.DailyRewards.Enabled;
        local Enabled2 = LocalPlayer.PlayerGui.Shop.Enabled;
        local v40 = TweenService:Create(game.Lighting.Blur, TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = 22
        });
        v40:Play();
        LocalPlayer.PlayerGui.Pack.Enabled = true;
        LocalPlayer.PlayerGui.Pack.Pack.Visible = true;
        LocalPlayer.PlayerGui.DailyRewards.Enabled = false;
        LocalPlayer.PlayerGui.HUD.Enabled = false;
        LocalPlayer.PlayerGui.Shop.Enabled = false;
        LocalPlayer.PlayerGui.InGameUI.Enabled = false;

        if Enabled then
            task.spawn(function() -- Line: 294
                -- upvalues: LocalPlayer (ref)
                for i = 1, 50 do
                    LocalPlayer.PlayerGui.HUD.Enabled = false;
                    task.wait(0.01);
                    local _ = i;
                end;
            end);
        end;

        local u41;

        if string.find(p37, "LTM") then
            local string_gsub_ret = string.gsub(p37, "LTM", "");
            u41 = ReplicatedStorage.Assets.Misc[string_gsub_ret .. "Card"]:Clone();
        else
            u41 = ReplicatedStorage.Assets.Misc[p37 .. "Card"]:Clone();
        end;

        u41.Parent = LocalPlayer.PlayerGui.Pack.Pack.Inside;
        local u42 = u41.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.ReplicatedAnims.OpenCard);
        u42:Play();
        u42:AdjustSpeed(1.5);
        task.wait(3.6);
        u42:AdjustSpeed(1);
        task.delay(1, function() -- Line: 319
            -- upvalues: TweenService (ref), u41 (ref), Debris (ref)
            local v43 = TweenService:Create(u41.RootPart, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                CFrame = u41.RootPart.CFrame + Vector3.new(0, -3, 0)
            });
            v43:Play();
            Debris:AddItem(v43, 1);
        end);
        v40:Destroy();
        local u44;

        if p37 == "MVP" or p37 == "LTMMVP" then
            u44 = ReplicatedStorage.Assets.UI[p38]:Clone();
            u44.ZIndex = -1;
            local v45 = MVPCutscenes[u36] and MVPCutscenes[u36].Display;

            if not v45 then
                if ItemDisplayNames then
                    v45 = ItemDisplayNames[u36] or u36;
                else
                    v45 = u36;
                end;
            end;

            u44.Item.Text = v45;
            local v46 = Icons.MVPCutscenes and Icons.MVPCutscenes[u36];

            if v46 and v46 ~= "" then
                local Icon = u44:FindFirstChild("Icon");

                if Icon and Icon:IsA("ImageLabel") then
                    Icon.Image = v46;
                    Icon.Visible = true;
                end;
            end;

            u44.Parent = LocalPlayer.PlayerGui.Pack;
            u44.Position = UDim2.new(0.5, 0, 0.8, 0);
            u44.Size = UDim2.new(0.01, 0, 0.01, 0);
        elseif p37 == "Emotes" or p37 == "LTMEmotes" then
            u44 = ReplicatedStorage.Assets.UI[p38]:Clone();
            u44.ZIndex = -1;
            u44.Item.Text = u36;
            u44.Parent = LocalPlayer.PlayerGui.Pack;
            u44.Position = UDim2.new(0.5, 0, 0.8, 0);
            u44.Size = UDim2.new(0.01, 0, 0.01, 0);
            local u47 = ReplicatedStorage.Assets.UI.ITEM:Clone();
            u47.Parent = u44;
            u47.Size = UDim2.new(0.8, 0, 0.8, 0);
            task.spawn(function() -- Line: 361
                -- upvalues: u47 (copy), ReplicatedStorage (ref), u36 (copy)
                u47.WorldModel.Rig.Humanoid:ApplyDescription(ReplicatedStorage:WaitForChild("PlrRig"));
                local v48 = u47.WorldModel.Rig.Humanoid:LoadAnimation(ReplicatedStorage.Assets.Emotes[u36]);
                v48:Play();
                v48.Looped = true;
                v48:Destroy();
            end);
        elseif p37 == "GoalEffects" or p37 == "LTMGoalEffects" then
            u44 = ReplicatedStorage.Assets.UI[p38]:Clone();
            u44.ZIndex = -1;
            u44.Item.Text = u36;
            u44.Parent = LocalPlayer.PlayerGui.Pack;
            u44.Position = UDim2.new(0.5, 0, 0.8, 0);
            u44.Size = UDim2.new(0.01, 0, 0.01, 0);
            task.delay(1, function() -- Line: 378
                -- upvalues: ReplicatedStorage (ref), u36 (copy), VfxManager (ref), Debris (ref)
                if ReplicatedStorage.Effects.GoalEffects:FindFirstChild(u36) then
                    return;
                end;

                local v49 = ReplicatedStorage.Assets.GoalEffects[u36]:Clone();
                v49.Anchored = true;
                v49.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, -10);
                v49.Size = Vector3.new(0.5, 0.5, 0.5);
                v49.Parent = workspace;
                VfxManager.Emit(v49);
                Debris:AddItem(v49, 5);
            end);
        else
            u44 = ReplicatedStorage.Assets.Customization.Cards[u36]:Clone();

            if ReplicatedStorage.Assets.Customization.Cards[u36]:GetAttribute("Rainbow") then
                local u50 = nil;
                u50 = RunService.RenderStepped:Connect(function() -- Line: 395
                    -- upvalues: u44 (ref), u50 (ref)
                    if not u44 then
                        u50:Disconnect();

                        return;
                    end;

                    local v51 = tick() % 10 / 10;
                    u44.ImageColor3 = Color3.fromHSV(v51, 0.8, 1);
                end);
            end;

            u44.ZIndex = -1;
            u44.Parent = LocalPlayer.PlayerGui.Pack;
            u44.Position = UDim2.new(0.5, 0, 0.8, 0);
            u44.Size = UDim2.new(0.01, 0, 0.01, 0);
        end;

        if p37 == "Cards" or p37 == "LTMCards" then
            local v52 = TweenService:Create(u44, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.5, 0, 0.5, 0)
            });
            v52:Play();
            local v53 = TweenService:Create(u44, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Size = ReplicatedStorage.Assets.Customization.Cards[u36].Size
            });
            v53:Play();
            Debris:AddItem(v52, 1);
            Debris:AddItem(v53, 1);
        else
            local v54 = TweenService:Create(u44, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Position = UDim2.new(0.5, 0, 0.5, 0)
            });
            v54:Play();
            local v55 = TweenService:Create(u44, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Size = UDim2.new(0.2, 0, 0.3, 0)
            });
            v55:Play();
            Debris:AddItem(v54, 1);
            Debris:AddItem(v55, 1);
        end;

        task.delay(2, function() -- Line: 441
            -- upvalues: u42 (copy)
            u42:AdjustSpeed(0);
        end);
        local string_gsub_ret = string.gsub(p37, "LTM", "");
        local v56;

        if p39 == nil then
            v56 = string_gsub_ret == "MVP";
        else
            v56 = false;
        end;

        if p39 == nil then
            LocalPlayer.PlayerGui.HUD.Buttons.Customization.Button.New.Visible = true;

            if u35.Customization.NewItems[string_gsub_ret] == nil then
                u35.Customization.NewItems[string_gsub_ret] = {};
                u35.Customization.NewItems[string_gsub_ret][u36] = true;
            end;

            local v57 = MVPCutscenes[u36] and MVPCutscenes[u36].Display;

            if not v57 then
                if ItemDisplayNames then
                    v57 = ItemDisplayNames[u36] or u36;
                else
                    v57 = u36;
                end;
            end;

            Popup.Popup(LocalPlayer, "ACQUIRED " .. tostring(v57));
            task.wait(3);
        else
            Popup.Popup(LocalPlayer, p39);
            task.wait(2);
        end;

        Popup.Blackframe(LocalPlayer);
        task.wait(0.5);
        u35.Opening = false;

        if u44 then
            u44:Destroy();
        end;

        if LocalPlayer.Team == game.Teams.Visitor then
            LocalPlayer.PlayerGui.HUD.Enabled = true;
            LocalPlayer.PlayerGui.Shop.Enabled = Enabled2;
        else
            LocalPlayer.PlayerGui.InGameUI.Enabled = true;
        end;

        if Enabled2 == false then
            game.Lighting.Blur.Size = 0;
        end;

        LocalPlayer.PlayerGui.Pack.Pack.Visible = false;
        LocalPlayer.PlayerGui.Pack.Enabled = false;
        u41:Destroy();
        LocalPlayer.PlayerGui.DailyRewards.Enabled = Enabled;

        if v56 then
            u35:PreviewMVP(u36);
        end;

        LocalPlayer:SetAttribute("PackBusy", nil);
    end);
    u35.BaseTrove:Connect(u35.PackService.KaiserOpened, function(p58, p59) -- Line: 496
        -- upvalues: LocalPlayer (ref), u35 (copy), Popup (ref), TweenService (ref), ReplicatedStorage (ref), Debris (ref), KaiserRarities (ref), UserInputService (ref)
        LocalPlayer:SetAttribute("PackBusy", true);
        u35.Opening = true;
        Popup.Blackframe(LocalPlayer);
        task.wait(0.5);
        local Enabled = LocalPlayer.PlayerGui.DailyRewards.Enabled;
        local Enabled2 = LocalPlayer.PlayerGui.Shop.Enabled;
        local v60 = TweenService:Create(game.Lighting.Blur, TweenInfo.new(0.7, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = 22
        });
        v60:Play();
        LocalPlayer.PlayerGui.Pack.Enabled = true;
        LocalPlayer.PlayerGui.Pack.Pack.Visible = true;
        LocalPlayer.PlayerGui.DailyRewards.Enabled = false;
        LocalPlayer.PlayerGui.HUD.Enabled = false;
        LocalPlayer.PlayerGui.Shop.Enabled = false;
        LocalPlayer.PlayerGui.InGameUI.Enabled = false;

        if Enabled then
            task.spawn(function() -- Line: 520
                -- upvalues: LocalPlayer (ref)
                for i = 1, 50 do
                    LocalPlayer.PlayerGui.HUD.Enabled = false;
                    task.wait(0.01);
                    local _ = i;
                end;
            end);
        end;

        local u61;

        if string.find(p59, "LTM") then
            local string_gsub_ret = string.gsub(p59, "LTM", "");
            u61 = ReplicatedStorage.Assets.Misc[string_gsub_ret .. "Card"]:Clone();
        else
            u61 = ReplicatedStorage.Assets.Misc[p59 .. "Card"]:Clone();
        end;

        u61.Parent = LocalPlayer.PlayerGui.Pack.Pack.Inside;
        local EasterUI = LocalPlayer.PlayerGui.EasterUI;
        local Enabled3 = EasterUI.Enabled;
        EasterUI.Enabled = false;
        local u62 = u61.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.ReplicatedAnims.OpenCard);
        u62:Play();
        u62:AdjustSpeed(1.5);
        task.wait(3.6);
        u62:AdjustSpeed(1);
        task.delay(1, function() -- Line: 547
            -- upvalues: TweenService (ref), u61 (ref), Debris (ref)
            local v63 = TweenService:Create(u61.RootPart, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                CFrame = u61.RootPart.CFrame + Vector3.new(0, -3, 0)
            });
            v63:Play();
            Debris:AddItem(v63, 1);
        end);
        v60:Destroy();
        local v64 = {};

        for _, v in p58 do
            local v65 = KaiserRarities[v];
            local Type = v65.Type;
            local Name = v65.Name;
            local u66 = ReplicatedStorage.Assets.UI[v65.Rarity]:Clone();
            u66.Visible = false;
            task.delay(0.3, function() -- Line: 566
                -- upvalues: u66 (copy)
                u66.Visible = true;
            end);
            u66.ZIndex = -1;
            u66.Item.Text = Name;
            u66.Item.AnchorPoint = Vector2.new(0.5, 0.5);
            u66.Item.Position = UDim2.fromScale(0.5, 0.5);
            u66.Parent = LocalPlayer.PlayerGui.Pack.Frame;
            table.insert(v64, u66);
            LocalPlayer.PlayerGui.HUD.Buttons.Customization.Button.New.Visible = true;

            if not (Type ~= "Cosmetics" and Type ~= "GoalEffects" or u35.Customization.InventoryData[Type][Name]) then
                if u35.Customization.NewItems[p59] == nil then
                    u35.Customization.NewItems[p59] = {};
                    u35.Customization.NewItems[p59][Name] = true;
                else
                    u35.Customization.NewItems[p59][Name] = true;
                end;

                Popup.Popup(LocalPlayer, "ACQUIRED " .. tostring(Name));
            end;
        end;

        task.delay(2, function() -- Line: 609
            -- upvalues: u62 (copy)
            u62:AdjustSpeed(0);
        end);
        Popup.Blackframe(LocalPlayer);
        local u67 = false;
        UserInputService.InputBegan:Connect(function(p68, p69) -- Line: 617
            -- upvalues: u67 (ref)
            if p68.UserInputType == Enum.UserInputType.Touch or (p68.UserInputType == Enum.UserInputType.MouseButton1 or p68.UserInputType == Enum.UserInputType.Gamepad1) then
                u67 = true;
            end;
        end);

        while not u67 do
            task.wait();
        end;

        task.wait(0.5);
        u35.Opening = false;

        for _, v in v64 do
            v:Destroy();
        end;

        if LocalPlayer.Team == game.Teams.Visitor then
            LocalPlayer.PlayerGui.HUD.Enabled = true;
            LocalPlayer.PlayerGui.Shop.Enabled = Enabled2;
        else
            LocalPlayer.PlayerGui.InGameUI.Enabled = true;
        end;

        if Enabled2 == false then
            game.Lighting.Blur.Size = 0;
        end;

        LocalPlayer.PlayerGui.Pack.Pack.Visible = false;
        LocalPlayer.PlayerGui.Pack.Enabled = false;
        EasterUI.Enabled = Enabled3;
        LocalPlayer.PlayerGui.DailyRewards.Enabled = Enabled;
        LocalPlayer:SetAttribute("PackBusy", nil);
    end);
    local Shop = LocalPlayer.PlayerGui:WaitForChild("Shop");

    for _, child in pairs(Shop:WaitForChild("BG"):WaitForChild("ShopUI"):WaitForChild("Inside"):WaitForChild("Packs"):GetChildren()) do
        if child:IsA("Frame") ~= false then
            u35.BaseTrove:Connect(child.PriceButton.MouseButton1Click, function() -- Line: 653
                -- upvalues: u4 (ref), u35 (copy), LocalPlayer (ref), Popup (ref), PacksConfig (ref), child (copy), MarketplaceService (ref), Knit (ref)
                if u4 > tick() then
                    return;
                end;

                if u35.Opening or LocalPlayer:GetAttribute("PackBusy") then
                    return;
                end;

                if LocalPlayer.Team ~= game.Teams.Visitor then
                    Popup.Popup(LocalPlayer, "YOU CAN\'T OPEN PACKS DURING A MATCH");

                    return;
                end;

                u4 = tick() + 0.15;
                local v70 = PacksConfig[child.Name];

                if not v70 then
                    return;
                end;

                local v71 = LocalPlayer.PacksStorage:FindFirstChild(child.Name);

                if v71 then
                    v71 = v71.Value > 0;
                end;

                if LocalPlayer.ProfileStats.Money.Value < v70.Cost and not v71 then
                    MarketplaceService:PromptProductPurchase(LocalPlayer, v70.RobuxProductId or Knit.GetController("GemSkinController"):MapProductId(2660228654));

                    return;
                end;

                u35.Opening = true;
                LocalPlayer:SetAttribute("PackBusy", true);
                u35.PackService.Pack:Fire(child.Name);
            end);
        end;
    end;

    local PacksStorage = LocalPlayer.PacksStorage;
    PacksStorage.ChildAdded:Connect(function(p72) -- Line: 678
        -- upvalues: u35 (copy)
        if not p72:IsA("IntValue") then
            return;
        end;

        u35:Refresh();
        p72:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 681
            -- upvalues: u35 (ref)
            u35:Refresh();
        end);
    end);
    u35:Refresh();

    for _, child in PacksStorage:GetChildren() do
        child:GetPropertyChangedSignal("Value"):Connect(function() -- Line: 687
            -- upvalues: u35 (copy)
            u35:Refresh();
        end);
    end;

    u35:LobbyPacks();
    local PackBBUI = ReplicatedStorage.Assets.UI.PackBBUI;
    local v73 = {};
    local u74 = {};

    for _, child in pairs(ReplicatedStorage.Shared.Inventory:GetChildren()) do
        v73[child.Name] = require(child);
    end;

    local u75 = { "Rare", "Epic", "Legendary" };
    local v76 = {
        GoalEffects = {
            Item = "Galactic",
            Rarity = "Legendary"
        },
        Emotes = {
            Item = "Planetary Orbit",
            Rarity = "Legendary"
        },
        Cards = {
            Item = "Purple Galaxy",
            Rarity = "Legendary"
        },
        MVP = {
            Item = "BarouMVPCutscene",
            Rarity = "Limited"
        }
    };

    for _, v in CollectionService:GetTagged("CardPack") do
        local u77 = {};
        local Attribute = v:GetAttribute("Pack");
        local v78 = PacksConfig[Attribute];
        local v79;

        if v78 then
            v79 = v;

            for _, v2 in PackOddsCalculator.BuildPool(v78) do
                if table.find(u75, v2.Rarity) and (not v76[Attribute] or v76[Attribute].Item ~= v2.Name) then
                    if not u77[v2.Rarity] then
                        u77[v2.Rarity] = {};
                    end;

                    table.insert(u77[v2.Rarity], v2.Name);
                end;
            end;

            for _, v2 in u77 do
                table.sort(v2);
            end;
        else
            v79 = v;
        end;

        local u80 = PackBBUI:Clone();
        u80.Enabled = false;
        u80.Frame.Title.Text = v79:GetAttribute("DisplayName");
        u80.Adornee = v79.PrimaryPart;
        u80.Frame.RobuxChance.Text = "Robux Chance";
        u80.Frame.RobuxChance.TextScaled = true;

        if not u80.Frame.YenChance:FindFirstChild("ChanceLabel") then
            local TextLabel = Instance.new("TextLabel");
            TextLabel.Name = "ChanceLabel";
            TextLabel.Size = UDim2.new(1, 0, 1, 0);
            TextLabel.BackgroundTransparency = 1;
            TextLabel.Text = "Cash Chance";
            TextLabel.TextScaled = true;
            TextLabel.FontFace = u80.Frame.RobuxChance.FontFace;
            TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
            TextLabel.ZIndex = u80.Frame.YenChance.ZIndex + 1;
            local v81 = u80.Frame.RobuxChance:FindFirstChildOfClass("UIStroke");

            if v81 then
                v81:Clone().Parent = TextLabel;
            end;

            TextLabel.Parent = u80.Frame.YenChance;
        end;

        u80.Parent = LocalPlayer.PlayerGui;
        table.insert(u74, u80);
        local Normal = v79.Proximity.Normal;
        u35.BaseTrove:Connect(Normal.PromptShown, function() -- Line: 759
            -- upvalues: u74 (copy), u80 (copy)
            for _, v2 in u74 do
                v2.Enabled = false;
            end;

            u80.Enabled = true;
        end);
        u35.BaseTrove:Connect(Normal.PromptHidden, function() -- Line: 765
            -- upvalues: u80 (copy)
            u80.Enabled = false;
        end);
        local v82 = PacksConfig[Attribute];
        local u83 = {};

        if v82 and v82.Includes then
            local u84 = v82.InventoryKey or Attribute;
            local v85 = v73[u84];
            local v86 = v82.DefaultRarity or "Rare";
            local v87 = {};
            local v88 = 0;

            for i, v2 in v82.Includes do
                local v89, v90;

                if type(i) == "number" then
                    v89 = v2;
                    v90 = 1;
                else
                    v90 = type(v2) == "number" and v2 and v2 or 1;
                    v89 = i;
                end;

                local v91;

                if v85 then
                    v91 = v85[v89] or v86;
                else
                    v91 = v86;
                end;

                table.insert(v87, {
                    Name = v89,
                    Weight = v90,
                    Rarity = v91
                });
                v88 = v88 + v90;
            end;

            table.sort(v87, function(p92, p93) -- Line: 794
                return p92.Weight > p93.Weight;
            end);
            local Small = u80.Frame:FindFirstChild("Small");
            local Item = u80.Frame:FindFirstChild("Item");
            local v94 = nil;

            if Small then
                for _, child in Small:GetChildren() do
                    if child:IsA("ImageButton") or child:IsA("ImageLabel") then
                        if v94 then
                            child.Visible = false;
                        else
                            v94 = child;
                        end;
                    end;
                end;
            end;

            local function applyRarityVisual(p95, p96) -- Line: 817
                -- upvalues: ItemRarities (ref)
                local v97 = ItemRarities[p96] and ItemRarities[p96].Color or Color3.new(1, 1, 1);
                local Rarity = p95:FindFirstChild("Rarity");

                if Rarity and Rarity:IsA("TextLabel") then
                    Rarity.TextColor3 = v97;
                end;

                local Chance = p95:FindFirstChild("Chance");

                if Chance and Chance:IsA("TextLabel") then
                    Chance.TextColor3 = v97;
                end;
            end;

            local function populateSlot(p98, p99, p100) -- Line: 830
                -- upvalues: applyRarityVisual (copy), MVPCutscenes (ref), ItemDisplayNames (ref), Icons (ref), u84 (copy)
                p98.Visible = true;
                applyRarityVisual(p98, p99.Rarity);

                if p98:FindFirstChild("Chance") then
                    p98.Chance.Text = p100;
                end;

                local v101 = MVPCutscenes[p99.Name] and MVPCutscenes[p99.Name].Display or (ItemDisplayNames and ItemDisplayNames[p99.Name] or p99.Name);
                local v102 = p98:FindFirstChild("ItemName") or p98:FindFirstChild("Name");

                if v102 and v102:IsA("TextLabel") then
                    v102.Text = v101;
                else
                    local Rarity = p98:FindFirstChild("Rarity");

                    if Rarity and Rarity:IsA("TextLabel") then
                        Rarity.Text = v101;
                    end;
                end;

                local v103 = Icons[u84] and (Icons[u84][p99.Name] or "") or "";
                local Vector = p98:FindFirstChild("Vector");
                local ViewportFrame = p98:FindFirstChild("ViewportFrame");

                if v103 == "" then
                    if Vector and Vector:IsA("ImageLabel") then
                        Vector.Image = "";
                    end;
                else
                    if Vector and Vector:IsA("ImageLabel") then
                        Vector.Image = v103;
                        Vector.Visible = true;
                    end;

                    if ViewportFrame then
                        ViewportFrame.Visible = false;
                    end;
                end;

                local Limited = p98:FindFirstChild("Limited");

                if Limited and Limited:IsA("TextLabel") then
                    Limited.Visible = p99.Rarity == "Limited";
                end;
            end;

            local function fmtPct(p104) -- Line: 876
                local v105 = string.format("%.2f", p104):gsub("%.?0+$", "");

                return (v105 == "" and "0" or v105) .. "%";
            end;

            local v106 = {};
            local v107 = {};

            for _, v2 in v87 do
                if not v106[v2.Weight] then
                    v106[v2.Weight] = {};
                    table.insert(v107, v2.Weight);
                end;

                table.insert(v106[v2.Weight], v2);
            end;

            table.sort(v107, function(p108, p109) -- Line: 893
                return p109 < p108;
            end);
            local v110 = #v107;
            local u111 = {};
            local v112 = 0;

            for i, v2 in v107 do
                local v113 = v106[v2];
                local v114 = string.format("%.2f", v2 / v88 * 100):gsub("%.?0+$", "");
                local v115 = (v114 == "" and "0" or v114) .. "%";
                local v116 = i == v110;
                local v117 = {
                    entries = v113,
                    pctText = v115,
                    slots = {}
                };

                for i2 = 1, i == 1 and (math.min(#v113, 3) or 1) or 1 do
                    local v118 = nil;

                    if v116 and (i2 == 1 and Item) then
                        v118 = Item;
                    elseif Small and v94 then
                        v112 = v112 + 1;

                        if v112 == 1 then
                            v118 = v94;
                        else
                            v118 = v94:Clone();
                            v118.Name = "Slot" .. tostring(v112);
                            v118.LayoutOrder = v112;
                            v118.Parent = Small;
                        end;
                    end;

                    local v119;

                    if v118 then
                        populateSlot(v118, v113[(i2 - 1) % #v113 + 1], v115);
                        table.insert(u83, v118);
                        table.insert(v117.slots, {
                            slot = v118,
                            offset = i2 - 1
                        });
                        v119 = i2;
                    else
                        v119 = i2;
                    end;
                end;

                if #v117.slots > 0 then
                    table.insert(u111, v117);
                end;
            end;

            task.spawn(function() -- Line: 944
                -- upvalues: u111 (copy), populateSlot (copy)
                local v120 = 0;

                while true do
                    task.wait(3);
                    v120 = v120 + 1;

                    for _, v2 in u111 do
                        if #v2.entries > 1 then
                            local v121 = v2;

                            for _, v4 in v2.slots do
                                populateSlot(v4.slot, v121.entries[(v120 + v4.offset) % #v121.entries + 1], v121.pctText);
                            end;
                        end;
                    end;
                end;
            end);
        else
            local v122 = {};
            local Small = u80.Frame:FindFirstChild("Small");

            if Small then
                for _, child in Small:GetChildren() do
                    if child:IsA("ImageButton") or child:IsA("ImageLabel") then
                        v122[child.Name] = v122[child.Name] or {};
                        table.insert(v122[child.Name], child);
                    end;
                end;
            end;

            local Item = u80.Frame:FindFirstChild("Item");
            local u123 = v76[Attribute];

            local function _(p124) -- Line: 972
                local v125 = string.format("%.2f", p124):gsub("%.?0+$", "");
                local v126 = p124 > 0 and (v125 == "0" or v125 == "") and "0.01" or v125;

                return (v126 == "" and "0" or v126) .. "%";
            end;

            local function setSlotIcon(p127, p128) -- Line: 979
                -- upvalues: Attribute (copy), CollectionService (ref), ReplicatedStorage (ref), Icons (ref)
                local Vector = p127:FindFirstChild("Vector");
                local ViewportFrame = p127:FindFirstChild("ViewportFrame");

                if Attribute == "Emotes" then
                    if Vector then
                        Vector.Visible = false;
                    end;

                    if ViewportFrame then
                        ViewportFrame.Visible = true;
                        ViewportFrame.BackgroundTransparency = 1;
                        CollectionService:AddTag(ViewportFrame, "EmoteViewport");
                        ViewportFrame:SetAttribute("Emote", p128);
                    end;
                elseif Attribute == "Cards" then
                    local v129 = ReplicatedStorage.Assets.Customization.Cards:FindFirstChild(p128);

                    if Vector then
                        Vector.Visible = true;
                        Vector.Image = v129 and v129.Image or "";
                    end;

                    if ViewportFrame then
                        ViewportFrame.Visible = false;
                    end;
                else
                    local v130 = Icons[Attribute];

                    if Vector then
                        Vector.Visible = true;
                        Vector.Image = v130 and v130[p128] or "";
                    end;

                    if ViewportFrame then
                        ViewportFrame.Visible = false;
                    end;
                end;
            end;

            local function setSlotItem(p131, p132) -- Line: 1007
                -- upvalues: MVPCutscenes (ref), ItemDisplayNames (ref), setSlotIcon (copy)
                local Rarity = p131:FindFirstChild("Rarity");

                if Rarity and Rarity:IsA("TextLabel") then
                    local v133 = MVPCutscenes[p132] and MVPCutscenes[p132].Display;

                    if not v133 then
                        if ItemDisplayNames then
                            v133 = ItemDisplayNames[p132] or p132;
                        else
                            v133 = p132;
                        end;
                    end;

                    Rarity.Text = v133;
                end;

                setSlotIcon(p131, p132);
            end;

            local u134 = {};

            for _, v2 in u75 do
                local v135 = u77[v2];
                local v136 = v122[v2];

                if v135 and (#v135 > 0 and (v136 and #v136 > 0)) then
                    table.insert(u134, {
                        Rarity = v2,
                        Items = v135,
                        Slots = v136
                    });
                elseif v136 then
                    for _, v4 in v136 do
                        v4.Visible = false;
                    end;
                end;
            end;

            local function applyOdds(p137, p138) -- Line: 1026
                -- upvalues: PackOddsCalculator (ref), Attribute (copy), u134 (copy), Item (copy), u123 (copy)
                local v139 = PackOddsCalculator.ForPack(Attribute, p138);
                local v140 = v139 and (v139.PerItem or {}) or {};
                local v141 = {};
                local v142 = {};

                for _, v2 in v139 and v139.Pool or {} do
                    if v2.Rarity then
                        v141[v2.Rarity] = (v141[v2.Rarity] or 0) + 1;
                        v142[v2.Rarity] = (v142[v2.Rarity] or 0) + (v140[v2.Name] or 0);
                    end;
                end;

                for _, v2 in u134 do
                    local v143 = v141[v2.Rarity] or 0;
                    local v144 = v143 > 0 and ((v142[v2.Rarity] or 0) / v143 * 100 or 0) or 0;
                    local v145 = string.format("%.2f", v144):gsub("%.?0+$", "");
                    local v146 = v144 > 0 and (v145 == "0" or v145 == "") and "0.01" or v145;
                    local v147 = (v146 == "" and "0" or v146) .. "%";
                    local v148 = v2;

                    for _, v4 in v2.Slots do
                        v4.Visible = v144 > 0;
                        local Chance = v4:FindFirstChild("Chance");

                        if Chance then
                            Chance.Text = v147;
                        end;

                        local Rarity = v4:FindFirstChild("Rarity");

                        if Rarity and p137[v148.Rarity] then
                            Rarity.TextColor3 = p137[v148.Rarity].Color;
                        end;
                    end;
                end;

                local v149 = Item and (u123 and Item:FindFirstChild("Chance"));

                if v149 then
                    local v150 = (v140[u123.Item] or 0) * 100;
                    local v151 = string.format("%.2f", v150):gsub("%.?0+$", "");
                    local v152 = v150 > 0 and (v151 == "0" or v151 == "") and "0.01" or v151;
                    v149.Text = (v152 == "" and "0" or v152) .. "%";
                end;
            end;

            if Item and u123 then
                local Item2 = u123.Item;
                local Rarity = Item:FindFirstChild("Rarity");

                if Rarity and Rarity:IsA("TextLabel") then
                    local v153 = MVPCutscenes[Item2] and MVPCutscenes[Item2].Display;

                    if not v153 then
                        if ItemDisplayNames then
                            v153 = ItemDisplayNames[Item2] or Item2;
                        else
                            v153 = Item2;
                        end;
                    end;

                    Rarity.Text = v153;
                end;

                setSlotIcon(Item, Item2);
                local Limited = Item:FindFirstChild("Limited");

                if Limited then
                    Limited.Visible = u123.Rarity == "Limited";
                end;
            end;

            for _, v2 in u134 do
                local v154 = v2;

                for i, v4 in v2.Slots do
                    v4.Visible = true;
                    local v155 = v154.Items[(i - 1) % #v154.Items + 1];
                    local Rarity = v4:FindFirstChild("Rarity");

                    if Rarity and Rarity:IsA("TextLabel") then
                        local v156 = MVPCutscenes[v155] and MVPCutscenes[v155].Display;

                        if not v156 then
                            if ItemDisplayNames then
                                v156 = ItemDisplayNames[v155] or v155;
                            else
                                v156 = v155;
                            end;
                        end;

                        Rarity.Text = v156;
                    end;

                    setSlotIcon(v4, v155);
                end;
            end;

            applyOdds(ItemRarities, false);
            u80.Frame.RobuxChance.Activated:Connect(function() -- Line: 1071
                -- upvalues: applyOdds (copy), ItemRobuxRarities (ref)
                applyOdds(ItemRobuxRarities, true);
            end);
            u80.Frame.YenChance.Activated:Connect(function() -- Line: 1074
                -- upvalues: applyOdds (copy), ItemRarities (ref)
                applyOdds(ItemRarities, false);
            end);
            task.spawn(function() -- Line: 1078
                -- upvalues: u134 (copy), MVPCutscenes (ref), ItemDisplayNames (ref), setSlotIcon (copy)
                local v157 = 0;

                while true do
                    task.wait(3);
                    v157 = v157 + 1;

                    for _, v2 in u134 do
                        if #v2.Items > 1 then
                            local v158 = v2;

                            for i, v4 in v2.Slots do
                                local v159 = v158.Items[(v157 + i - 1) % #v158.Items + 1];
                                local Rarity = v4:FindFirstChild("Rarity");

                                if Rarity and Rarity:IsA("TextLabel") then
                                    local v160 = MVPCutscenes[v159] and MVPCutscenes[v159].Display;

                                    if not v160 then
                                        if ItemDisplayNames then
                                            v160 = ItemDisplayNames[v159] or v159;
                                        else
                                            v160 = v159;
                                        end;
                                    end;

                                    Rarity.Text = v160;
                                end;

                                setSlotIcon(v4, v159);
                            end;
                        end;
                    end;
                end;
            end);
        end;

        local u161 = {};

        for _, v2 in u75 do
            u161[v2] = 1;
        end;

        task.spawn(function() -- Line: 1099
            -- upvalues: Attribute (copy), u75 (copy), u77 (copy), u83 (copy), u161 (copy), ReplicatedStorage (ref), CollectionService (ref), Icons (ref)
            while true do
                if Attribute == "Cards" then
                    for _, v2 in u75 do
                        local v162 = u77[v2];
                        local v163 = u83[v2];

                        if v162 and (#v162 > 0 and (v163 and #v163 > 0)) then
                            local v164 = v2;

                            for i, v4 in v163 do
                                local v165 = v162[(u161[v164] + i - 2) % #v162 + 1];
                                local v166 = ReplicatedStorage.Assets.Customization.Cards:FindFirstChild(v165);

                                if v166 then
                                    v4.Vector.Visible = true;
                                    v4.ViewportFrame.Visible = false;
                                    v4.Vector.Image = v166.Image;
                                    v4.Rarity.Text = v165;
                                end;
                            end;

                            u161[v164] = u161[v164] % #v162 + 1;
                        end;
                    end;
                elseif Attribute == "Emotes" then
                    for _, v2 in u75 do
                        local v167 = u77[v2];
                        local v168 = u83[v2];

                        if v167 and (#v167 > 0 and (v168 and #v168 > 0)) then
                            local v169 = v2;

                            for i, v4 in v168 do
                                local v170 = v167[(u161[v169] + i - 2) % #v167 + 1];
                                v4.Vector.Visible = false;
                                v4.ViewportFrame.Visible = true;
                                v4.ViewportFrame.BackgroundTransparency = 1;
                                CollectionService:AddTag(v4.ViewportFrame, "EmoteViewport");
                                v4.ViewportFrame:SetAttribute("Emote", v170);
                                v4.Rarity.Text = v170;
                            end;

                            u161[v169] = u161[v169] % #v167 + 1;
                        end;
                    end;
                elseif Attribute == "GoalEffects" then
                    for _, v2 in u75 do
                        local v171 = u77[v2];
                        local v172 = u83[v2];

                        if v171 and (#v171 > 0 and (v172 and #v172 > 0)) then
                            local v173 = v2;

                            for i, v4 in v172 do
                                local v174 = v171[(u161[v173] + i - 2) % #v171 + 1];
                                v4.Vector.Visible = true;
                                v4.ViewportFrame.Visible = false;
                                v4.ViewportFrame.BackgroundTransparency = 1;
                                v4.Vector.Image = Icons.GoalEffects[v174] or "";
                                v4.Rarity.Text = v174;
                            end;

                            u161[v173] = u161[v173] % #v171 + 1;
                        end;
                    end;
                end;

                task.wait(3);
            end;
        end);
    end;
end;

function v3.KnitInit(u175) -- Line: 1185
    -- upvalues: Trove (copy), Knit (copy), LocalPlayer (copy), u1 (ref), u2 (ref), HumanoidRootPart (ref)
    u175.BaseTrove = Trove.new();
    u175.ShopController = Knit.GetController("Shop");
    u175.UIController = Knit.GetController("UIController");
    u175.BaseTrove:Connect(LocalPlayer.CharacterAdded, function(p176) -- Line: 1191
        -- upvalues: u1 (ref), u2 (ref), HumanoidRootPart (ref)
        u1 = p176;
        u2 = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
    end);
    u175.BaseTrove:Connect(game.Players.PlayerRemoving, function(p177) -- Line: 1197
        -- upvalues: LocalPlayer (ref), u1 (ref), HumanoidRootPart (ref), u2 (ref), u175 (copy)
        if p177 == LocalPlayer then
            u1 = nil;
            HumanoidRootPart = nil;
            u2 = nil;
            u175.BaseTrove:Destroy();
        end;
    end);
end;

return v3;
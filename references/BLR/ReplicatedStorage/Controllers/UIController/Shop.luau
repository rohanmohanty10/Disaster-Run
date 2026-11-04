  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
game:GetService("TweenService");
game:GetService("Debris");
local MarketplaceService = game:GetService("MarketplaceService");
local LocalPlayer = Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local u2 = u1:FindFirstChildOfClass("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local _ = HumanoidRootPart:WaitForChild("RootJoint").C0;
local u3 = nil;
require(ReplicatedStorage.Shared.VfxManager);
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
local Trove = require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Signal = require(ReplicatedStorage.Packages.Signal);
local Gamepasses = require(ReplicatedStorage.Shared.Configs.Gamepasses);
local MVPCutscenes = require(ReplicatedStorage.Shared.MVPCutscenes);
local ItemDisplayNames = require(ReplicatedStorage.Shared.Configs.ItemDisplayNames);
local Icons = require(ReplicatedStorage.Shared.Configs.Icons);
local PackOddsCalculator = require(ReplicatedStorage.Shared.PackOddsCalculator);
local u4 = {};
local u5 = Signal.new();
local u6 = Knit.CreateController({
    Name = "Shop"
});
local u7 = {
    Common = 5,
    Uncommon = 4,
    Rare = 3,
    Epic = 2,
    Legendary = 1,
    Limited = 0
};

function u6.HasGamepass(p8, p9) -- Line: 50
    -- upvalues: u4 (ref)
    return u4[p9];
end;

function u6.PromptGamepass(p10, p11) -- Line: 54
    -- upvalues: Gamepasses (copy), MarketplaceService (copy), LocalPlayer (copy)
    local v12 = Gamepasses[p11];

    if not v12 or typeof(v12.ID) ~= "number" then
        return false;
    end;

    MarketplaceService:PromptGamePassPurchase(LocalPlayer, v12.ID);

    return true;
end;

function u6.GetGamepasses(p13) -- Line: 64
    -- upvalues: u4 (ref)
    return u4;
end;

function u6.ObserveGamepasses(p14, p15) -- Line: 68
    -- upvalues: u4 (ref), u5 (copy)
    p15(u4);

    return u5:Connect(p15);
end;

function u6.ItemsInside(p16, p17) -- Line: 73
    -- upvalues: ReplicatedStorage (copy), PackOddsCalculator (copy), LocalPlayer (copy), MVPCutscenes (copy), ItemDisplayNames (copy), Icons (copy), u7 (copy), RunService (copy)
    local v18 = require(ReplicatedStorage.Shared.Configs.PacksConfig)[p17];

    if not v18 then
        return;
    end;

    local u19 = PackOddsCalculator.BuildPool(v18);

    if #u19 == 0 then
        return;
    end;

    local v20 = PackOddsCalculator.ItemDistribution(u19, false);
    local v21 = PackOddsCalculator.ItemDistribution(u19, true);
    local ItemsInside = LocalPlayer.PlayerGui.Shop.BG.ItemsInside;
    ItemsInside.Visible = true;

    for _, child in pairs(ItemsInside.Items:GetChildren()) do
        if child:IsA("ImageButton") then
            child:Destroy();
        end;
    end;

    local OddsSummary = ItemsInside:FindFirstChild("OddsSummary");

    if not OddsSummary then
        OddsSummary = Instance.new("TextLabel");
        OddsSummary.Name = "OddsSummary";
        OddsSummary.BackgroundTransparency = 1;
        OddsSummary.AnchorPoint = Vector2.new(0.5, 1);
        OddsSummary.Position = UDim2.fromScale(0.5, 1);
        OddsSummary.Size = UDim2.fromScale(0.95, 0.12);
        OddsSummary.Font = Enum.Font.GothamMedium;
        OddsSummary.TextScaled = true;
        OddsSummary.TextWrapped = true;
        OddsSummary.TextColor3 = Color3.fromRGB(255, 255, 255);
        OddsSummary.ZIndex = 5;
        local UIStroke = Instance.new("UIStroke");
        UIStroke.Thickness = 2;
        UIStroke.Color = Color3.fromRGB(0, 0, 0);
        UIStroke.Parent = OddsSummary;
        OddsSummary.Parent = ItemsInside;
    end;

    local function displayNameOf(p22) -- Line: 113
        -- upvalues: MVPCutscenes (ref), ItemDisplayNames (ref)
        local v23 = MVPCutscenes[p22] and MVPCutscenes[p22].Display;

        if v23 then
            p22 = v23;
        elseif ItemDisplayNames then
            p22 = ItemDisplayNames[p22] or p22;
        end;

        return p22;
    end;

    local function iconFor(p24, p25) -- Line: 119
        -- upvalues: Icons (ref)
        local v26 = Icons and Icons[p24];

        if v26 then
            v26 = v26[p25];
        end;

        if type(v26) == "string" and v26 ~= "" then
            return v26;
        end;

        return nil;
    end;

    local function pct(p27) -- Line: 128
        return string.format("%.2f%%", math.floor(p27 * 10000 + 0.5) / 100);
    end;

    local function rarityAggregate(p28) -- Line: 132
        -- upvalues: u19 (copy)
        local v29 = {};

        for _, v in u19 do
            local v30 = p28[v.Name];

            if v30 and v30 > 0 then
                v29[v.Rarity or "?"] = (v29[v.Rarity or "?"] or 0) + v30;
            end;
        end;

        local v31 = {};

        for _, v in { "Rare", "Epic", "Legendary" } do
            if v29[v] then
                local v32 = v .. " " .. string.format("%.2f%%", math.floor(v29[v] * 10000 + 0.5) / 100);
                table.insert(v31, v32);
            end;
        end;

        for i, v in v29 do
            if i ~= "Rare" and (i ~= "Epic" and i ~= "Legendary") then
                local v33 = tostring(i) .. " " .. string.format("%.2f%%", math.floor(v * 10000 + 0.5) / 100);
                table.insert(v31, v33);
            end;
        end;

        return table.concat(v31, ", ");
    end;

    local v34 = "Cash open: " .. rarityAggregate(v20);
    local v35 = "Robux open: " .. rarityAggregate(v21);

    if rarityAggregate(v20) == rarityAggregate(v21) then
        OddsSummary.Text = "Odds: " .. rarityAggregate(v20) .. "\nOdds are rounded to 2 decimal places and may not total exactly 100%.";
    else
        OddsSummary.Text = v34 .. "  |  " .. v35 .. "\nOdds are rounded to 2 decimal places and may not total exactly 100%.";
    end;

    local v36 = {};

    for _, v in u19 do
        local v37 = v20[v.Name] or 0;
        local v38 = v21[v.Name] or 0;

        if v37 > 0 or v38 > 0 then
            table.insert(v36, {
                Entry = v,
                Cash = v37,
                Robux = v38
            });
        end;
    end;

    table.sort(v36, function(p39, p40) -- Line: 170
        return p39.Cash > p40.Cash;
    end);

    for _, v in v36 do
        local Entry = v.Entry;
        local Rarity = Entry.Rarity;
        local v41 = ReplicatedStorage.Assets.UI:FindFirstChild(Rarity or "");

        if v41 then
            local u42 = v41:Clone();
            u42.Parent = ItemsInside.Items;
            u42.Name = u7[Rarity] or "5";
            local v43;

            if p17 == "MVP" then
                v43 = Entry.Name;
                local v44 = MVPCutscenes[v43] and MVPCutscenes[v43].Display;

                if v44 then
                    v43 = v44;
                elseif ItemDisplayNames then
                    v43 = ItemDisplayNames[v43] or v43;
                end;

                if not v43 then
                    v43 = Entry.Name;
                end;
            else
                v43 = Entry.Name;
            end;

            if v.Cash > 0 and (v.Robux > 0 and string.format("%.2f%%", math.floor(v.Cash * 10000 + 0.5) / 100) ~= string.format("%.2f%%", math.floor(v.Robux * 10000 + 0.5) / 100)) then
                u42.Item.Text = ("%s - %s (Robux: %s)"):format(v43, string.format("%.2f%%", math.floor(v.Cash * 10000 + 0.5) / 100), pct(v.Robux));
            elseif v.Cash > 0 and v.Robux > 0 then
                u42.Item.Text = ("%s - %s"):format(v43, pct(v.Cash));
            elseif v.Cash > 0 then
                u42.Item.Text = ("%s - %s (Cash open only)"):format(v43, pct(v.Cash));
            else
                u42.Item.Text = ("%s - Robux only: %s"):format(v43, pct(v.Robux));
            end;

            if p17 == "MVP" then
                local Icon = u42.Icon;
                local Name = Entry.Name;
                local v45 = Icons and Icons[v18.InventoryKey];

                if v45 then
                    v45 = v45[Name];
                end;

                if type(v45) ~= "string" or v45 == "" then
                    v45 = nil;
                end;

                Icon.Image = v45 or "";
            elseif p17 == "Cards" then
                local v46 = ReplicatedStorage.Assets.Customization.Cards:FindFirstChild(Entry.Name);

                if v46 then
                    u42.Icon.Image = v46.Image;

                    if v46:GetAttribute("Rainbow") then
                        local u47 = nil;
                        u47 = RunService.RenderStepped:Connect(function() -- Line: 199
                            -- upvalues: u42 (copy), u47 (ref)
                            if not (u42 and u42:FindFirstChild("Icon")) then
                                u47:Disconnect();

                                return;
                            end;

                            local v48 = tick() % 10 / 10;
                            local Color3_fromHSV_ret = Color3.fromHSV(v48, 0.8, 1);
                            u42.Icon.ImageColor3 = Color3_fromHSV_ret;
                        end);
                    end;
                end;
            elseif p17 == "Emotes" then
                task.spawn(function() -- Line: 211
                    -- upvalues: ReplicatedStorage (ref), u42 (copy), Entry (copy)
                    local v49 = ReplicatedStorage.Assets.UI.ITEM:Clone();
                    v49.Parent = u42;
                    v49.WorldModel.Rig.Humanoid:ApplyDescription(ReplicatedStorage:WaitForChild("PlrRig"));
                    local v50 = ReplicatedStorage.Assets.Emotes:WaitForChild(Entry.Name, 10);

                    if not v50 then
                        return;
                    end;

                    local v51 = v49.WorldModel.Rig.Humanoid:LoadAnimation(v50);
                    v51:Play();
                    v51:Destroy();
                end);
                u42.ITEM.Visible = true;
            end;
        end;
    end;
end;

function u6.Cycle(p52, u53) -- Line: 226
    task.spawn(function() -- Line: 227
        -- upvalues: u53 (copy)
        local Packs = u53.BG.ShopUI.Inside.Packs;
        local v54 = "Normal";

        while wait(3) do
            local v55 = v54 == "Normal";
            v54 = v55 and "Robux" or "Normal";

            for _, child in Packs:GetChildren() do
                if child:IsA("Frame") then
                    local RobuxFrame = child:FindFirstChild("RobuxFrame");
                    local NormalFrame = child:FindFirstChild("NormalFrame");

                    if RobuxFrame then
                        RobuxFrame.Visible = v55;
                    end;

                    if NormalFrame then
                        NormalFrame.Visible = not v55;
                    end;
                end;
            end;
        end;
    end);
end;

function u6.CycleEmotes(p56) -- Line: 245
    -- upvalues: ReplicatedStorage (copy)
    task.spawn(function() -- Line: 246
        -- upvalues: ReplicatedStorage (ref)
        local v57 = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Anime"):Clone();
        local v58 = ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Toxic"):Clone();
        v57.Parent = script;
        v58.Parent = script;
        local v59 = 0;

        for _, child in pairs(script.Anime:GetChildren()) do
            child.Rig.Humanoid:ApplyDescription(ReplicatedStorage:WaitForChild("PlrRig"));
        end;

        for _, child in pairs(script.Toxic:GetChildren()) do
            child.Rig.Humanoid:ApplyDescription(ReplicatedStorage:WaitForChild("PlrRig"));
        end;

        local v60 = nil;
        local v61 = nil;

        while true do
            local v62 = v59 + 1;
            v59 = v62 > 4 and 1 or v62;

            if v60 then
                v60:Destroy();
            end;

            if v61 then
                v61:Destroy();
            end;

            v60 = script.Anime[tostring(v59)]:Clone();
            v60.Parent = workspace.Debris;
            v60.Rig.Humanoid:LoadAnimation(ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Emotes"):WaitForChild(v60:GetAttribute("Emote"))):Play();
            v61 = script.Toxic[tostring(v59)]:Clone();
            v61.Parent = workspace.Debris;
            v61.Rig.Humanoid:LoadAnimation(ReplicatedStorage:WaitForChild("Assets"):WaitForChild("Emotes"):WaitForChild(v61:GetAttribute("Emote"))):Play();
            task.wait(5);
        end;
    end);
end;

function u6.Scroll(p63: table, p64: string) -- Line: 290
    -- upvalues: LocalPlayer (copy)
    print("Scrolling: ", p64);
    local Inside = LocalPlayer.PlayerGui:WaitForChild("Shop").BG.ShopUI.Inside;
    local v65 = Inside:FindFirstChild(p64);

    if v65 then
        Inside.CanvasPosition = Vector2.new(v65:GetAttribute("Pos"), 0);

        if p64 == "Passes" then
            Inside.CanvasPosition = Vector2.new(99999, 0);
            Inside.CanvasPosition = Inside.CanvasPosition / 2;
            local Rewards = Inside:FindFirstChild("Rewards");

            if Rewards and Rewards.Visible == true then
                Inside.CanvasPosition = Vector2.new(99999, 0);
                Inside.CanvasPosition = Inside.CanvasPosition / 3;
            end;
        end;
    end;
end;

function u6.KnitStart(u66) -- Line: 317
    -- upvalues: Knit (copy), ReplicatedStorage (copy), Gamepasses (copy), LocalPlayer (copy), PackOddsCalculator (copy), u1 (ref), u3 (ref), u4 (ref), u5 (copy), u6 (copy), MarketplaceService (copy)
    u66.ItemRarities = {};
    u66.CosmeticsController = Knit.GetController("CosmeticsController");

    for _, child in pairs(ReplicatedStorage.Shared.Inventory:GetChildren()) do
        u66.ItemRarities[child.Name] = require(child);
    end;

    task.spawn(function() -- Line: 325
        -- upvalues: Gamepasses (ref), u66 (copy), LocalPlayer (ref)
        local function bindLobbyGamepassStand(p67, u68) -- Line: 326
            -- upvalues: Gamepasses (ref), u66 (ref), LocalPlayer (ref)
            local v69 = workspace:FindFirstChild(p67);
            local v70 = v69 and v69:FindFirstChild("ProxPart") and v69.ProxPart:FindFirstChild("Buy");

            if v69 then
                u68 = v69:GetAttribute("Gamepass") or u68;
            end;

            local v71 = Gamepasses[u68];

            if not (v70 and (v71 and typeof(v71.ID) == "number")) then
                return;
            end;

            u66.BaseTrove:Connect(v70.Triggered, function(p72) -- Line: 335
                -- upvalues: LocalPlayer (ref), u66 (ref), u68 (copy)
                if p72 == LocalPlayer then
                    u66:PromptGamepass(u68);
                end;
            end);
        end;

        bindLobbyGamepassStand("VIP", "VIP");
        bindLobbyGamepassStand("Titles", "LegendaryTitles");
    end);
    local Shop = LocalPlayer.PlayerGui:WaitForChild("Shop");
    task.spawn(function() -- Line: 348
        -- upvalues: Shop (copy), PackOddsCalculator (ref)
        local Packs = Shop.BG.ShopUI:WaitForChild("Inside"):WaitForChild("Packs");

        local function fmtRarityPct(p73) -- Line: 350
            local v74 = math.floor((p73 or 0) * 10000 + 0.5) / 100;

            if v74 == math.floor(v74) then
                return string.format("%d%%", v74);
            end;

            return string.format("%.2f%%", v74);
        end;

        local v75 = PackOddsCalculator.RarityDistribution(false);
        local v76 = PackOddsCalculator.RarityDistribution(true);

        local function applyFace(p77, p78) -- Line: 357
            local v79 = p77:FindFirstChild("Rar%eText");
            local v80 = p77:FindFirstChild("Epic%Text");
            local v81 = p77:FindFirstChild("Legendary%Text");

            if not (v79 and (v80 and v81)) then
                return;
            end;

            local v82 = math.floor((p78.Rare or 0) * 10000 + 0.5) / 100;
            local v83;

            if v82 == math.floor(v82) then
                v83 = string.format("%d%%", v82);
            else
                v83 = string.format("%.2f%%", v82);
            end;

            v79.Text = v83;
            local v84 = math.floor((p78.Epic or 0) * 10000 + 0.5) / 100;
            local v85;

            if v84 == math.floor(v84) then
                v85 = string.format("%d%%", v84);
            else
                v85 = string.format("%.2f%%", v84);
            end;

            v80.Text = v85;
            local v86 = math.floor((p78.Legendary or 0) * 10000 + 0.5) / 100;
            local v87;

            if v86 == math.floor(v86) then
                v87 = string.format("%d%%", v86);
            else
                v87 = string.format("%.2f%%", v86);
            end;

            v81.Text = v87;
        end;

        for _, child in Packs:GetChildren() do
            if child:IsA("Frame") then
                local NormalFrame = child:FindFirstChild("NormalFrame");

                if NormalFrame then
                    applyFace(NormalFrame, v75);
                end;

                local RobuxFrame = child:FindFirstChild("RobuxFrame");

                if RobuxFrame then
                    applyFace(RobuxFrame, v76);
                end;
            end;
        end;
    end);
    local Passes = Shop.BG.ShopUI.Inside:WaitForChild("Passes");
    local LegendaryTitles = Passes:FindFirstChild("LegendaryTitles");

    if not LegendaryTitles then
        local VIP = Passes:FindFirstChild("VIP");

        if VIP then
            LegendaryTitles = VIP:Clone();
            LegendaryTitles.Name = "LegendaryTitles";
            LegendaryTitles.LayoutOrder = 1;
            LegendaryTitles.Text.Text = "LEGENDARY TITLES";
            LegendaryTitles.Icon.Image = "rbxassetid://119074980578683";
            LegendaryTitles.PassGoldImage.ImageColor3 = Color3.fromRGB(33, 57, 125);
            LegendaryTitles.Gift.Visible = false;
            LegendaryTitles.Parent = Passes;
        end;
    end;

    if LegendaryTitles then
        local LegendaryTitles2 = Gamepasses.LegendaryTitles;
        local RobuxButton = LegendaryTitles.RobuxButton;
        local Gift = LegendaryTitles:FindFirstChild("Gift");

        if LegendaryTitles2 and typeof(LegendaryTitles2.ID) == "number" then
            RobuxButton:SetAttribute("Gamepass", LegendaryTitles2.ID);
            local GiftProductId = LegendaryTitles2.GiftProductId;

            if Gift then
                Gift:SetAttribute("ID", GiftProductId);
                Gift.Visible = typeof(GiftProductId) == "number";

                if typeof(GiftProductId) == "number" then
                    Knit.GetController("Gift"):RegisterButton(Gift, GiftProductId);
                end;
            end;
        else
            RobuxButton:SetAttribute("Gamepass", nil);
            RobuxButton.TextLabel.Text = "COMING SOON";

            if Gift then
                Gift:SetAttribute("ID", nil);
                Gift.Visible = false;
            end;
        end;
    end;

    workspace.ShopRig.Humanoid:LoadAnimation(ReplicatedStorage.Assets.Emotes.Headless):Play();
    u66.BaseTrove:Connect(workspace.Shop.Touched, function(p88) -- Line: 428
        -- upvalues: u1 (ref), LocalPlayer (ref)
        if p88.Parent ~= u1 then
            return;
        end;

        LocalPlayer.PlayerGui.HUD.Enabled = false;
        LocalPlayer.PlayerGui.InGameUI.Enabled = false;
        LocalPlayer.PlayerGui.Shop.Enabled = true;
    end);
    u3.UpdateGamepasses:Connect(function(p89) -- Line: 435
        -- upvalues: u4 (ref), u5 (ref)
        u4 = p89;
        u5:Fire(p89);
    end);

    for _, descendant in pairs(Shop:GetDescendants()) do
        if descendant.Name ~= "Gift" then
            if descendant:IsA("ImageButton") == false then
                if descendant:IsA("Frame") ~= false and (descendant.Name:match("Frame") ~= nil and descendant.Parent == Shop.BG) then
                    u66.BaseTrove:Connect(descendant.Bttn.MouseButton1Click, function() -- Line: 446
                        -- upvalues: u66 (copy), descendant (copy)
                        u66:Scroll(descendant:GetAttribute("Tab"));
                    end);

                    if descendant:GetAttribute("ID") ~= nil or descendant:GetAttribute("Gamepass") ~= nil then
                        task.spawn(function() -- Line: 452
                            -- upvalues: descendant (copy), u6 (ref), MarketplaceService (ref), u4 (ref)
                            local Name = descendant.Parent.Name;
                            u6:ObserveGamepasses(function(p90) -- Line: 454
                                -- upvalues: Name (copy), descendant (ref)
                                if p90[Name] then
                                    descendant.TextLabel.Text = "OWNED";
                                end;
                            end);
                            local u91 = nil;

                            if descendant:GetAttribute("Gamepass") == nil then
                                local ProductInfo = MarketplaceService:GetProductInfo(descendant:GetAttribute("ID"), Enum.InfoType.Product);

                                if u4[descendant.Name] then
                                    return;
                                end;

                                descendant.TextLabel.Text = ProductInfo.PriceInRobux and `{ProductInfo.PriceInRobux}` or "OFFSALE";
                            else
                                if not pcall(function() -- Line: 462
                                    -- upvalues: u91 (ref), MarketplaceService (ref), descendant (ref)
                                    u91 = MarketplaceService:GetProductInfo(descendant:GetAttribute("Gamepass"), Enum.InfoType.GamePass);
                                end) then
                                    print(descendant:GetAttribute("Gamepass"), descendant.Parent.Name);
                                end;

                                if u91 then
                                    descendant.Parent.Text.Text = u91.Name;
                                end;

                                if u4[Name] then
                                    return;
                                end;

                                descendant.TextLabel.Text = u91.PriceInRobux and ` {u91.PriceInRobux}` or "OFFSALE";
                            end;
                        end);
                        u66.BaseTrove:Connect(descendant.MouseButton1Click, function() -- Line: 484
                            -- upvalues: descendant (copy), MarketplaceService (ref), LocalPlayer (ref)
                            if descendant:GetAttribute("Gamepass") == nil then
                                MarketplaceService:PromptProductPurchase(LocalPlayer, descendant:GetAttribute("ID"));

                                return;
                            end;

                            MarketplaceService:PromptGamePassPurchase(LocalPlayer, descendant:GetAttribute("Gamepass"));
                        end);
                    end;
                end;
            elseif descendant:GetAttribute("ID") ~= nil or descendant:GetAttribute("Gamepass") ~= nil then
                task.spawn(function() -- Line: 452
                    -- upvalues: descendant (copy), u6 (ref), MarketplaceService (ref), u4 (ref)
                    local Name = descendant.Parent.Name;
                    u6:ObserveGamepasses(function(p90) -- Line: 454
                        -- upvalues: Name (copy), descendant (ref)
                        if p90[Name] then
                            descendant.TextLabel.Text = "OWNED";
                        end;
                    end);
                    local u91 = nil;

                    if descendant:GetAttribute("Gamepass") == nil then
                        local ProductInfo = MarketplaceService:GetProductInfo(descendant:GetAttribute("ID"), Enum.InfoType.Product);

                        if u4[descendant.Name] then
                            return;
                        end;

                        descendant.TextLabel.Text = ProductInfo.PriceInRobux and `{ProductInfo.PriceInRobux}` or "OFFSALE";
                    else
                        if not pcall(function() -- Line: 462
                            -- upvalues: u91 (ref), MarketplaceService (ref), descendant (ref)
                            u91 = MarketplaceService:GetProductInfo(descendant:GetAttribute("Gamepass"), Enum.InfoType.GamePass);
                        end) then
                            print(descendant:GetAttribute("Gamepass"), descendant.Parent.Name);
                        end;

                        if u91 then
                            descendant.Parent.Text.Text = u91.Name;
                        end;

                        if u4[Name] then
                            return;
                        end;

                        descendant.TextLabel.Text = u91.PriceInRobux and ` {u91.PriceInRobux}` or "OFFSALE";
                    end;
                end);
                u66.BaseTrove:Connect(descendant.MouseButton1Click, function() -- Line: 484
                    -- upvalues: descendant (copy), MarketplaceService (ref), LocalPlayer (ref)
                    if descendant:GetAttribute("Gamepass") == nil then
                        MarketplaceService:PromptProductPurchase(LocalPlayer, descendant:GetAttribute("ID"));

                        return;
                    end;

                    MarketplaceService:PromptGamePassPurchase(LocalPlayer, descendant:GetAttribute("Gamepass"));
                end);
            end;
        end;
    end;

    u66.BaseTrove:Connect(Shop.BG.ItemsInside.Exit.MouseButton1Click, function() -- Line: 493
        -- upvalues: Shop (copy)
        Shop.BG.ItemsInside.Visible = false;
    end);
    u66.BaseTrove:Connect(Shop.BG.ShopUI.Inside.Packs.Cards.ItemsInside.MouseButton1Click, function() -- Line: 497
        -- upvalues: u66 (copy)
        u66:ItemsInside("Cards");
    end);
    u66.BaseTrove:Connect(Shop.BG.ShopUI.Inside.Packs.Emotes.ItemsInside.MouseButton1Click, function() -- Line: 501
        -- upvalues: u66 (copy)
        u66:ItemsInside("Emotes");
    end);
    u66.BaseTrove:Connect(Shop.BG.ShopUI.Inside.Packs.GoalEffects.ItemsInside.MouseButton1Click, function() -- Line: 505
        -- upvalues: u66 (copy)
        u66:ItemsInside("GoalEffects");
    end);
    Shop.BG.ShopUI.Inside.Packs.MVP.ItemsInside.Visible = true;
    u66.BaseTrove:Connect(Shop.BG.ShopUI.Inside.Packs.MVP.ItemsInside.MouseButton1Click, function() -- Line: 510
        -- upvalues: u66 (copy)
        u66:ItemsInside("MVP");
    end);
    u66:Cycle(Shop);
    u66:CycleEmotes();
end;

function u6.KnitInit(u92) -- Line: 527
    -- upvalues: u3 (ref), Knit (copy), Trove (copy), LocalPlayer (copy), u1 (ref), u2 (ref), HumanoidRootPart (ref)
    u3 = Knit.GetService("MarketService");
    u92.BaseTrove = Trove.new();
    u92.BaseTrove:Connect(LocalPlayer.CharacterAdded, function(p93) -- Line: 531
        -- upvalues: u1 (ref), u2 (ref), HumanoidRootPart (ref)
        u1 = p93;
        u2 = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
    end);
    u92.BaseTrove:Connect(game.Players.PlayerRemoving, function(p94) -- Line: 537
        -- upvalues: LocalPlayer (ref), u1 (ref), HumanoidRootPart (ref), u2 (ref), u92 (copy)
        if p94 == LocalPlayer then
            u1 = nil;
            HumanoidRootPart = nil;
            u2 = nil;
            u92.BaseTrove:Destroy();
        end;
    end);
end;

return u6;
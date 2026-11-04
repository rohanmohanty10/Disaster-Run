  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("UserInputService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
game:GetService("TweenService");
local MarketplaceService = game:GetService("MarketplaceService");
local AvatarEditorService = game:GetService("AvatarEditorService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local CollectionService = game:GetService("CollectionService");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.Tweens);
local Trove = require(ReplicatedStorage.Shared.Trove);
require(ReplicatedStorage.Shared.SoundManager);
local Popup = require(ReplicatedStorage.Shared.Popup);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local Icons = require(ReplicatedStorage2.Shared.Configs.Icons);
local Emotes = require(ReplicatedStorage2.Shared.Emotes.Emotes);
local Shop = require(script.Parent.Shop);
local environment = require(ReplicatedStorage.Shared.environment);
local LocalPlayer = game.Players.LocalPlayer;
local ItemDisplayNames = require(ReplicatedStorage2.Shared.Configs.ItemDisplayNames);
local MVPCutscenes = require(ReplicatedStorage2.Shared.MVPCutscenes);
local ClientGlobals = require(ReplicatedStorage2.ClientModules.ClientGlobals);
local TitleConfig = require(ReplicatedStorage2.Shared.Configs.TitleConfig);
local Gamepasses = require(ReplicatedStorage2.Shared.Configs.Gamepasses);
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local Humanoid = u1:WaitForChild("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local u2 = Knit.CreateController({
    Name = "Customization"
});
tick();

function u2.KnitStart(u3) -- Line: 45
    -- upvalues: Knit (copy), LocalPlayer (copy), ReplicatedStorage (copy), Emotes (copy), Trove (copy), AvatarEditorService (copy), Players (copy), u2 (copy), Gamepasses (copy), Shop (copy), TitleConfig (copy), HumanoidRootPart (ref), MVPCutscenes (copy), ItemDisplayNames (copy), Icons (copy), CollectionService (copy), RunService (copy), environment (copy), VfxManager (copy), Debris (copy), Popup (copy), ClientGlobals (copy), MarketplaceService (copy)
    u3.CS = Knit.GetService("CustomizationService");
    u3.Emotes = Knit.GetController("EmoteController");
    local u4 = tick();
    local u5 = {
        Common = 7,
        Uncommon = 6,
        Rare = 5,
        Epic = 4,
        Legendary = 3,
        Gamepass = 2,
        Limited = 2,
        Mythic = 1
    };
    local Customization = LocalPlayer.PlayerGui:WaitForChild("Customization");
    local BG = Customization:WaitForChild("BG");
    local CustomizationGUIFrame = BG:WaitForChild("CustomizationGUIFrame");
    u3.CustomFrame = CustomizationGUIFrame;

    if not CustomizationGUIFrame.Buttons:FindFirstChild("Titles") then
        local v6 = CustomizationGUIFrame.Buttons.Cards:Clone();
        v6.Name = "Titles";
        v6.TitleText.Text = "Titles";
        v6.Icon.Image = "rbxassetid://85943057172993";
        v6.Icon.ImageColor3 = Color3.fromRGB(255, 222, 72);
        v6.New.Visible = false;
        v6.Parent = CustomizationGUIFrame.Buttons;
    end;

    local u7 = nil;
    u3.InventoryData = u7;
    local u8 = {};
    local u9 = nil;
    local u10 = {};

    for _, child in pairs(ReplicatedStorage.Shared.Inventory:GetChildren()) do
        u8[child.Name] = require(child);
    end;

    u8.Emotes = {};

    for i, v in Emotes do
        u8.Emotes[i] = v.meta.rarity;
    end;

    while u7 == nil do
        local Profile, v11, v12 = u3.CS:GetProfile();
        u7 = Profile;
        u9 = v11;
        u3.InventoryData = u7;
        u3.GamepassData = u9;
        task.wait(0.1);
        u10 = v12 or {};
    end;

    if not u7.BallSkins or #u7.BallSkins == 0 then
        LocalPlayer.PlayerGui.Customization.BG.CustomizationGUIFrame.Buttons.BallSkins.Visible = false;
    end;

    if not u7.StyleSkins or #u7.StyleSkins == 0 then
        LocalPlayer.PlayerGui.Customization.BG.CustomizationGUIFrame.Buttons.StyleSkins.Visible = false;
    end;

    local u13 = false;
    u3.NewItems = {};
    u3.EmotesEquipped = u7.EmotesEquipped;
    u3.ButtonTrove = Trove.new();
    local u14 = "Emotes";
    local u15 = false;

    local function LoadOutfits() -- Line: 142
        -- upvalues: u14 (ref), AvatarEditorService (ref), LocalPlayer (ref), ReplicatedStorage (ref), u3 (copy), u7 (ref), Players (ref)
        if u14 ~= "AwakeningOutfit" then
            return;
        end;

        local Outfits = AvatarEditorService:GetOutfits(Enum.OutfitSource.All, Enum.OutfitType.All);
        print(Outfits.IsFinished, u14);

        while not Outfits.IsFinished and u14 == "AwakeningOutfit" do
            local CurrentPage = Outfits:GetCurrentPage();
            print(#CurrentPage);

            for _, v in CurrentPage do
                if v.IsEditable then
                    task.spawn(function() -- Line: 159
                        -- upvalues: LocalPlayer (ref), v (copy), ReplicatedStorage (ref), u3 (ref), u7 (ref), Players (ref), u14 (ref)
                        local v16 = LocalPlayer.PlayerGui.Customization.BG.CustomizationGUIFrame.Items:FindFirstChild(v.Id);
                        local v17 = v16 or ReplicatedStorage.Assets.UI.Common:Clone();
                        v17.Item.Text = v.Name;
                        v17.Name = v.Id;
                        v17:SetAttribute("SearchName", v.Name);
                        local StyleOutfitTarget = u3.StyleOutfitTarget;

                        if StyleOutfitTarget then
                            local v18 = u7.StyleAwakeningOutfits and u7.StyleAwakeningOutfits[StyleOutfitTarget];
                            local v19;

                            if v18 == nil then
                                v19 = false;
                            else
                                v19 = v18.Id == v.Id;
                            end;

                            v17.Equipped.Visible = v19;
                        else
                            v17.Equipped.Visible = u7.AwakeningOutfitId == v.Id;
                        end;

                        v17.Parent = LocalPlayer.PlayerGui.Customization.BG.CustomizationGUIFrame.Items;

                        if not v16 then
                            v17.Activated:Connect(function() -- Line: 175
                                -- upvalues: u3 (ref), v (ref)
                                if u3.StyleOutfitTarget then
                                    u3.CS:SetStyleAWKOutfit(u3.StyleOutfitTarget, v.Id);

                                    return;
                                end;

                                u3.CS:EquipAWKOutfit(v.Id);
                            end);
                            local v20 = ReplicatedStorage.Assets.UI.ITEM:Clone();
                            v20.Parent = v17;
                            v20.WorldModel.Rig.Humanoid:ApplyDescription(Players:GetHumanoidDescriptionFromOutfitId(v.Id));
                            local v21 = v20.WorldModel.Rig.Humanoid:LoadAnimation(ReplicatedStorage.Assets.Emotes.Default);
                            v21:Play();
                            v21.Looped = true;
                        end;

                        if u14 ~= "AwakeningOutfit" then
                            v17:Destroy();
                        end;
                    end);
                end;
            end;

            Outfits:AdvanceToNextPageAsync();
        end;
    end;

    AvatarEditorService.PromptAllowInventoryReadAccessCompleted:Connect(function(p22) -- Line: 201
        -- upvalues: u15 (ref), LoadOutfits (copy)
        if p22 == Enum.AvatarPromptResult.Success then
            u15 = true;
            LoadOutfits();
        end;
    end);
    local u23 = false;

    function u2.FilterItems(p24) -- Line: 210
        local SearchBox = p24.CustomFrame:FindFirstChild("SearchBox");

        if not SearchBox then
            return;
        end;

        local string_lower_ret = string.lower(SearchBox.Text);

        for _, child in pairs(p24.CustomFrame.Items:GetChildren()) do
            if child:IsA("ImageButton") then
                local Attribute = child:GetAttribute("SearchName");

                if not Attribute then
                    local Item = child:FindFirstChild("Item");
                    Attribute = Item and Item.Text or child.Name;
                end;

                child.Visible = string_lower_ret == "" and true or string.find(string.lower(Attribute), string_lower_ret, 1, true) ~= nil;
            end;
        end;
    end;

    function u2.SortItems(p25) -- Line: 234
        local v26 = {};

        for _, child in pairs(p25.CustomFrame.Items:GetChildren()) do
            if child:IsA("ImageButton") and child.Visible then
                table.insert(v26, child);
            end;
        end;

        table.sort(v26, function(p27, p28) -- Line: 242
            local v29;

            if p27:FindFirstChild("Equipped") then
                v29 = p27.Equipped.Visible or false;
            else
                v29 = false;
            end;

            local v30;

            if p28:FindFirstChild("Equipped") then
                v30 = p28.Equipped.Visible or false;
            else
                v30 = false;
            end;

            if v29 ~= v30 then
                return v29;
            end;

            local v31 = p27:GetAttribute("RarityValue") or (tonumber(p27.Name) or 999);
            local v32 = p28:GetAttribute("RarityValue") or (tonumber(p28.Name) or 999);

            if v31 == v32 then
                return (p27:FindFirstChild("Item") and p27.Item.Text or p27.Name) < (p28:FindFirstChild("Item") and p28.Item.Text or p28.Name);
            end;

            return v31 < v32;
        end);

        for i, v in ipairs(v26) do
            v.LayoutOrder = i;
        end;
    end;

    local function LoadTitles() -- Line: 271
        -- upvalues: u3 (copy), u7 (ref), u9 (ref), u10 (ref), Trove (ref), CustomizationGUIFrame (copy), ReplicatedStorage (ref), Gamepasses (ref), Shop (ref), TitleConfig (ref)
        local Profile, v33, v34 = u3.CS:GetProfile();

        if Profile then
            u7 = Profile;
            u9 = v33;
            u10 = v34 or {};
            u3.InventoryData = u7;
            u3.GamepassData = u9;
        end;

        if u3.ButtonTrove then
            u3.ButtonTrove:Destroy();
        end;

        u3.ButtonTrove = Trove.new();

        for _, child in CustomizationGUIFrame.Items:GetChildren() do
            if child:IsA("ImageButton") then
                child:Destroy();
            end;
        end;

        local function createTitleItem(u35, p36, p37, u38, u39, p40) -- Line: 294
            -- upvalues: ReplicatedStorage (ref), u7 (ref), CustomizationGUIFrame (ref), u3 (ref), Gamepasses (ref), Shop (ref)
            local v41 = ReplicatedStorage.Assets.UI.Gamepass:Clone();
            v41.Name = `Title_{u35}`;
            v41:SetAttribute("SearchName", p36);
            v41:SetAttribute("RarityValue", p40);
            v41.Item.Text = p36;
            v41.Item.TextColor3 = Color3.fromHex(p37);
            v41.Icon.Image = "rbxassetid://85943057172993";
            v41.Equipped.Visible = (u7.TitlesEquipped or "") == u35;
            v41.New.Visible = false;
            v41.Parent = CustomizationGUIFrame.Items;
            u3.ButtonTrove:Connect(v41.MouseButton1Click, function() -- Line: 306
                -- upvalues: u38 (copy), Gamepasses (ref), u39 (copy), Shop (ref), u3 (ref), u35 (copy)
                if u38 then
                    u3.CS.Customize:Fire("Titles", u35);

                    return;
                end;

                if Gamepasses[u39] then
                    Shop:PromptGamepass(u39);
                end;
            end);
        end;

        local v42 = ReplicatedStorage.Assets.UI.Gamepass:Clone();
        v42.Name = "Title_None";
        v42:SetAttribute("SearchName", "No Title");
        v42:SetAttribute("RarityValue", 0);
        v42.Item.Text = "No Title";
        v42.Icon.Visible = false;
        v42.New.Visible = false;
        v42.Equipped.Visible = (u7.TitlesEquipped or "") == "";
        v42.Parent = CustomizationGUIFrame.Items;
        u3.ButtonTrove:Connect(v42.MouseButton1Click, function() -- Line: 327
            -- upvalues: u3 (ref)
            u3.CS.Customize:Fire("Titles", "");
        end);

        for i, v in ipairs(TitleConfig.DisplayOrder) do
            local v43 = TitleConfig[v];

            if v43.Source == "ChatTag" then
                if table.find(u10, v43.ChatTag) ~= nil then
                    createTitleItem(v, v43.DisplayName, v43.Color, true, nil, i);
                end;
            elseif table.find(u7.Titles or {}, v) ~= nil then
                createTitleItem(v, v43.DisplayName, v43.Color, true, v43.Gamepass, i);
            end;
        end;

        u3:FilterItems();
        u3:SortItems();
    end;

    local function ResetButtons(u44) -- Line: 350
        -- upvalues: u14 (ref), LocalPlayer (ref), u3 (copy), u7 (ref), HumanoidRootPart (ref), Trove (ref), CustomizationGUIFrame (copy), Shop (ref), u15 (ref), AvatarEditorService (ref), LoadOutfits (copy), LoadTitles (copy), ReplicatedStorage (ref), u5 (copy), u8 (copy), MVPCutscenes (ref), ItemDisplayNames (ref), Icons (ref), Knit (ref), CollectionService (ref), RunService (ref), u23 (ref), environment (ref), VfxManager (ref), Debris (ref), Popup (ref), BG (copy)
        u14 = u44.Name;
        local Children = LocalPlayer.PlayerGui.Customization.BG.CustomizationGUIFrame.Buttons:GetChildren();

        for _, v in pairs(Children) do
            if v:IsA("ImageButton") ~= false then
                v.Visible = true;

                if u3.NewItems[v.Name] then
                    v.New.Visible = true;
                    LocalPlayer.PlayerGui.Customization.BG.CustomizationGUIFrame.Buttons[v.Name].New.Visible = true;
                else
                    v.New.Visible = false;
                    LocalPlayer.PlayerGui.Customization.BG.CustomizationGUIFrame.Buttons[v.Name].New.Visible = false;
                end;

                if not u7.StyleSkins or #u7.StyleSkins == 0 then
                    LocalPlayer.PlayerGui.Customization.BG.CustomizationGUIFrame.Buttons.StyleSkins.Visible = false;
                end;

                if not u7.BallSkins or #u7.BallSkins == 0 then
                    LocalPlayer.PlayerGui.Customization.BG.CustomizationGUIFrame.Buttons.BallSkins.Visible = false;
                end;
            end;
        end;

        u44.Visible = true;
        LocalPlayer.PlayerGui.Customization.BG.CustomizationGUIFrame.Selected.Icon.Image = u44.Icon.Image;

        if u44.Name == "GoalEffects" then
            workspace.CurrentCamera.CFrame = workspace.GoalEffectCam.CFrame;
            LocalPlayer.PlayerGui.Customization.BG["Name&RankFrame"].Visible = false;
            LocalPlayer.PlayerGui.Customization.BG.EnterButtonFrame.Visible = false;
        else
            LocalPlayer.PlayerGui.Customization.BG.EnterButtonFrame.Visible = true;
            LocalPlayer.PlayerGui.Customization.BG["Name&RankFrame"].Visible = true;
            workspace.CurrentCamera.CFrame = HumanoidRootPart.CFrame * CFrame.new(-2, 0, -6.5) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
        end;

        u3.ButtonTrove:Destroy();
        u3.ButtonTrove = Trove.new();
        local Children2 = CustomizationGUIFrame.Items:GetChildren();

        for _, v in pairs(Children2) do
            if v:IsA("ImageButton") ~= false then
                v:Destroy();
            end;
        end;

        LocalPlayer.PlayerGui.Customization.BG.Wheel.Visible = u44.Name == "Emotes";
        task.defer(function() -- Line: 401
            -- upvalues: u3 (ref)
            task.wait(0.1);
            u3:FilterItems();
        end);

        if u44.Name == "AwakeningOutfit" then
            if u3.StyleOutfitTarget then
                CustomizationGUIFrame.Selected.TitleText.Text = `{u3.StyleOutfitTarget} Outfit`;
            end;

            if not Shop:HasGamepass("AwakeningOutfits") then
                Shop:PromptGamepass("AwakeningOutfits");
            end;

            if u15 then
                LoadOutfits();

                return;
            end;

            AvatarEditorService:PromptAllowInventoryReadAccess();

            return;
        end;

        if u44.Name == "Titles" then
            LoadTitles();

            return;
        end;

        if u44.Name == "BallSkins" and #u7[u44.Name] > 0 then
            local u45 = ReplicatedStorage.Assets.UI.Common:Clone();
            u45.Parent = CustomizationGUIFrame.Items;
            u45.Name = u5[u45.Name];
            u45:SetAttribute("RarityValue", tonumber(u45.Name) or 999);
            u45.Item.Text = "None";
            u45:SetAttribute("SearchName", "None");

            if u7[u44.Name .. "Equipped"] == "" then
                u45.Equipped.Visible = true;
                u45.Name = "0";
            end;

            u3:SortItems();
            u3.ButtonTrove:Connect(u45.MouseButton1Click, function() -- Line: 452
                -- upvalues: u44 (copy), u45 (copy), LocalPlayer (ref), CustomizationGUIFrame (ref), u3 (ref)
                local v46 = tostring(u44);

                if v46 ~= "Cosmetics" and u45.Equipped.Visible then
                    return;
                end;

                LocalPlayer.PlayerGui.Customization.BG.Wheel.Visible = false;

                for _, child in pairs(CustomizationGUIFrame.Items:GetChildren()) do
                    if child:IsA("ImageButton") and child ~= u45 then
                        child.Equipped.Visible = false;
                    end;
                end;

                print(u45);
                u45.Equipped.Visible = true;

                if not u45:GetAttribute("RarityValue") then
                    u45:SetAttribute("RarityValue", tonumber(u45.Name) or 999);
                end;

                u45.Name = "0";
                u3.CS.Customize:Fire(v46, "");
                u3:FilterItems();
                u3:SortItems();
            end);
        end;

        for _, v in pairs(u7[u44.Name]) do
            task.defer(function() -- Line: 488
                -- upvalues: u8 (ref), u44 (copy), v (copy), MVPCutscenes (ref), ItemDisplayNames (ref), ReplicatedStorage (ref), CustomizationGUIFrame (ref), u5 (ref), Icons (ref), u3 (ref), u7 (ref), Knit (ref), CollectionService (ref), RunService (ref), LocalPlayer (ref), u23 (ref), environment (ref), VfxManager (ref), Debris (ref), Popup (ref)
                local v47 = u8[u44.Name][v];

                if v47 == nil then
                    return;
                end;

                local v48 = MVPCutscenes[v] and MVPCutscenes[v].Display;
                local u49 = v48 or (ItemDisplayNames[v] or v);
                local string_split_ret = string.split(v48 or (ItemDisplayNames[v] or v), ".-.-.-.");
                local v50 = string_split_ret[1];

                if string_split_ret[2] then
                    v50 = v50 .. " - " .. string_split_ret[2];
                end;

                local u51 = ReplicatedStorage.Assets.UI[v47]:Clone();

                if ItemDisplayNames[v] then
                    u51:SetAttribute("OriginalName", v);
                end;

                u51.Parent = CustomizationGUIFrame.Items;
                u51.Name = u5[u51.Name];
                u51:SetAttribute("RarityValue", tonumber(u51.Name) or 999);
                u51.Item.Text = v50;
                u51:SetAttribute("SearchName", v50);
                local v52 = Icons[u44.Name] and Icons[u44.Name][v] or Icons[v];

                if v52 and u44.Name ~= "Emotes" then
                    u51.Icon.Image = v52;
                end;

                if u3.NewItems[u44.Name] and u3.NewItems[u44.Name][v] then
                    u51.New.Visible = true;
                end;

                if u44.Name == "Emotes" then
                    for _, v2 in pairs(u7.EmotesEquipped) do
                        if v2 == v then
                            u51.Equipped.Visible = true;
                            u51.Name = "0";
                            break;
                        end;
                    end;

                    local ViewportFrame = Instance.new("ViewportFrame");
                    ViewportFrame:AddTag("EmoteViewport");
                    ViewportFrame:SetAttribute("Emote", v);
                    ViewportFrame.Size = UDim2.fromScale(1, 1);
                    ViewportFrame.BackgroundTransparency = 1;
                    ViewportFrame.Parent = u51;
                elseif u44.Name == "Cosmetics" then
                    local v53 = ReplicatedStorage.Assets.Cosmetics:FindFirstChild(v);

                    if v53 and v53:GetAttribute("InventoryPreview") then
                        local v54 = Knit.GetController("CosmeticIcon"):CreateCosmeticIcon(v53);
                        v54.ZIndex = u51.Icon.ZIndex;
                        v54.Parent = u51.Icon;
                        u51.Icon.Image = "";
                    end;

                    for _, v2 in pairs(u7.CosmeticsEquipped) do
                        if v2 == v then
                            u51.Name = "0";
                            u51.Equipped.Visible = true;
                            break;
                        end;
                    end;
                else
                    if u44.Name == "Cards" then
                        u51.Icon.Image = ReplicatedStorage.Assets.Customization.Cards[v].Image;
                        local v55 = ReplicatedStorage.Assets.Customization.Cards[v];

                        for _, v2 in v55:GetTags() do
                            CollectionService:AddTag(u51.Icon, v2);
                        end;

                        for i, v2 in v55:GetAttributes() do
                            u51.Icon:SetAttribute(i, v2);
                        end;

                        if ReplicatedStorage.Assets.Customization.Cards[v]:GetAttribute("Rainbow") then
                            local u56 = nil;
                            u56 = RunService.RenderStepped:Connect(function() -- Line: 575
                                -- upvalues: u51 (copy), u56 (ref)
                                if not (u51 and u51:FindFirstChild("Icon")) then
                                    u56:Disconnect();

                                    return;
                                end;

                                local v57 = tick() % 10 / 10;
                                local Color3_fromHSV_ret = Color3.fromHSV(v57, 0.8, 1);
                                u51.Icon.ImageColor3 = Color3_fromHSV_ret;
                            end);
                        end;
                    end;

                    if u7[u44.Name .. "Equipped"] == v then
                        u51.Equipped.Visible = true;
                        u51.Name = "0";
                    end;
                end;

                u3.ButtonTrove:Connect(u51.MouseButton1Click, function() -- Line: 595
                    -- upvalues: u3 (ref), u44 (ref), v (ref), u51 (copy), LocalPlayer (ref), CustomizationGUIFrame (ref), u49 (copy), u23 (ref), environment (ref), ReplicatedStorage (ref), VfxManager (ref), Debris (ref), u7 (ref), Popup (ref)
                    if u3.NewItems[u44.Name] and u3.NewItems[u44.Name][v] then
                        u3.NewItems[u44.Name][v] = nil;
                        u51.New.Visible = false;
                        local v58 = false;

                        for _, _ in pairs(u3.NewItems[u44.Name]) do
                            v58 = true;
                            break;
                        end;

                        if v58 == false then
                            u3.NewItems[u44.Name] = nil;
                            u44.New.Visible = false;
                            LocalPlayer.PlayerGui.Customization.BG.CustomizationGUIFrame.Buttons[u44.Name].New.Visible = false;
                        end;
                    end;

                    local v59 = false;

                    for _, _ in pairs(u3.NewItems) do
                        v59 = true;
                    end;

                    if v59 == false then
                        LocalPlayer.PlayerGui.HUD.Buttons.Customization.Button.New.Visible = false;
                    end;

                    local v60 = tostring(u44);

                    if tostring(u44) == "Emotes" then
                        LocalPlayer.PlayerGui.Customization.BG.Wheel.Visible = true;
                        u3:EmoteSelect(u51, u44, v);

                        return;
                    end;

                    if tostring(u44) == "StyleSkins" then
                        for _, child in pairs(CustomizationGUIFrame.Items:GetChildren()) do
                            if child:IsA("ImageButton") and child ~= u51 then
                                child.Equipped.Visible = false;
                            end;
                        end;

                        local v61 = u3.CS:EquipStyleSkin(u49);
                        u51.Equipped.Visible = v61 == u49;

                        if not u51:GetAttribute("RarityValue") then
                            u51:SetAttribute("RarityValue", tonumber(u51.Name) or 999);
                        end;

                        if u51.Equipped.Visible then
                            u51.Name = "0";
                        else
                            local Attribute = u51:GetAttribute("RarityValue");

                            if Attribute then
                                u51.Name = tostring(Attribute);
                            end;
                        end;

                        u3:FilterItems();
                        u3:SortItems();

                        return;
                    end;

                    if tostring(u44) == "GoalEffects" then
                        if u23 then
                            return;
                        end;

                        u23 = true;
                        task.delay(0.1, function() -- Line: 665
                            -- upvalues: u23 (ref)
                            u23 = false;
                        end);

                        if environment.mode == "LTM" then
                            if ReplicatedStorage.Effects.GoalEffects:FindFirstChild(v) then
                                task.spawn(function() -- Line: 685
                                    -- upvalues: ReplicatedStorage (ref), v (ref)
                                    require(ReplicatedStorage.Effects.GoalEffects[v])({
                                        IsInventory = true,
                                        Pos = workspace.Goals.Home.CFrame * CFrame.new(0, 2, 0)
                                    });
                                end);
                            else
                                local v62 = ReplicatedStorage.Assets.GoalEffects[v]:Clone();
                                v62.Parent = workspace.Goals.Home;
                                v62:PivotTo(workspace.Goals.Home.CFrame);
                                VfxManager.Emit(v62);
                                Debris:AddItem(v62, 4);
                            end;
                        elseif ReplicatedStorage.Effects.GoalEffects:FindFirstChild(v) then
                            task.spawn(function() -- Line: 670
                                -- upvalues: ReplicatedStorage (ref), v (ref)
                                require(ReplicatedStorage.Effects.GoalEffects[v])({
                                    Pos = workspace.Goals.Home.CFrame * CFrame.new(0, 2, 0)
                                });
                            end);
                        else
                            local v63 = ReplicatedStorage.Assets.GoalEffects[v]:Clone();
                            v63.Parent = workspace.Goals.Home;
                            v63:PivotTo(workspace.Goals.Home.CFrame);
                            VfxManager.Emit(v63);
                            Debris:AddItem(v63, 4);
                        end;
                    end;

                    if v60 ~= "Cosmetics" and u51.Equipped.Visible then
                        return;
                    end;

                    LocalPlayer.PlayerGui.Customization.BG.Wheel.Visible = false;
                    local v64 = u51:GetAttribute("OriginalName") or u51.Item.Text;
                    local v65 = nil;

                    if v60 == "Cosmetics" then
                        local v66 = u3.GamepassData.SecondCosmeticSlot and 2 or 1;

                        if v66 == 1 then
                            for _, child in pairs(CustomizationGUIFrame.Items:GetChildren()) do
                                if child:IsA("ImageButton") and child ~= u51 then
                                    child.Equipped.Visible = false;
                                end;
                            end;
                        end;

                        local v67 = nil;

                        for i, v2 in u7.CosmeticsEquipped do
                            if v66 < tonumber(i) then
                                v65 = "1";
                            elseif v2 == "" then
                                v65 = i;
                            elseif v2 == v64 then
                                v65 = i;
                                v67 = true;
                                break;
                            end;
                        end;

                        if v66 == 2 and not (v67 or v65) then
                            Popup.Popup(nil, "You must unequip a cosmetic to equip a new one");

                            return;
                        end;
                    else
                        for _, child in pairs(CustomizationGUIFrame.Items:GetChildren()) do
                            if child:IsA("ImageButton") and child ~= u51 then
                                child.Equipped.Visible = false;
                            end;
                        end;
                    end;

                    u51.Equipped.Visible = not u51.Equipped.Visible;

                    if not u51:GetAttribute("RarityValue") then
                        u51:SetAttribute("RarityValue", tonumber(u51.Name) or 999);
                    end;

                    if u51.Equipped.Visible then
                        u51.Name = "0";
                    else
                        local Attribute = u51:GetAttribute("RarityValue");

                        if Attribute then
                            u51.Name = tostring(Attribute);
                        end;
                    end;

                    u3.CS.Customize:Fire(v60, v64, v65);
                    u3:FilterItems();
                    u3:SortItems();
                end);
            end);
        end;

        task.defer(function() -- Line: 779
            -- upvalues: u3 (ref)
            task.wait(0.1);
            u3:FilterItems();
            u3:SortItems();
        end);

        if u44.Name == "Cosmetics" then
            if not u3.GamepassData.SecondCosmeticSlot then
                BG.CosmeticButton.Visible = true;

                return;
            end;

            BG.CosmeticButton.Visible = false;
        end;
    end;

    u3.OpenTab = ResetButtons;
    ClientGlobals.PlayerData:Listen({ "Customization" }, function() -- Line: 800
        -- upvalues: u3 (copy), u7 (ref), u9 (ref), u10 (ref), u14 (ref), LoadOutfits (copy), LoadTitles (copy)
        local Profile, v68, v69 = u3.CS:GetProfile();
        u7 = Profile;
        u9 = v68;
        u10 = v69 or {};
        u3.InventoryData = u7;
        u3.GamepassData = u9;
        u3.EmotesEquipped = u7.EmotesEquipped;

        if u14 == "AwakeningOutfit" then
            LoadOutfits();

            return;
        end;

        if u14 == "Titles" then
            LoadTitles();
        end;
    end);
    Shop:ObserveGamepasses(function() -- Line: 814
        -- upvalues: u14 (ref), LoadTitles (copy)
        if u14 == "Titles" then
            LoadTitles();
        end;
    end);
    ClientGlobals.PlayerData:Observe({ "Gamepasses", "SecondCosmeticSlot" }, function() -- Line: 820
        -- upvalues: u3 (copy), BG (copy)
        if u3.GamepassData.SecondCosmeticSlot then
            BG.CosmeticButton.Visible = false;

            return;
        end;

        BG.CosmeticButton.Visible = true;
    end);
    u3.Trove:Connect(u3.CS.Customize, function(p70) -- Line: 831
        -- upvalues: u7 (ref), u3 (copy), u14 (ref), LoadOutfits (copy), LoadTitles (copy)
        table.clear(u7);
        table.clear(u3.EmotesEquipped);
        u7 = p70;
        u3.InventoryData = u7;
        u3.EmotesEquipped = u7.EmotesEquipped;

        if u14 == "AwakeningOutfit" then
            LoadOutfits();

            return;
        end;

        if u14 == "Titles" then
            LoadTitles();
        end;
    end);
    u3.Trove:Connect(Customization:GetPropertyChangedSignal("Enabled"), function() -- Line: 846
        -- upvalues: Customization (copy), u13 (ref), u7 (ref), u9 (ref), u10 (ref), u3 (copy), BG (copy), ResetButtons (copy), CustomizationGUIFrame (copy), LocalPlayer (ref), Knit (ref)
        if not Customization.Enabled then
            local v71 = u3.StyleOutfitTarget ~= nil;
            u3.StyleOutfitTarget = nil;

            if v71 then
                task.defer(function() -- Line: 882
                    -- upvalues: LocalPlayer (ref), Knit (ref)
                    if LocalPlayer.PlayerGui.PickTeam.Enabled or LocalPlayer.PlayerGui.InGameUI.Enabled then
                        return;
                    end;

                    local Controller = Knit.GetController("UIController");

                    for _, v in Controller.Frames do
                        if v.Enabled then
                            return;
                        end;
                    end;

                    Controller:Open("Style");
                end);
            end;

            return;
        end;

        u13 = true;
        table.clear(u7);
        local Profile, v72, v73 = u3.CS:GetProfile();
        u7 = Profile;
        u9 = v72;
        u10 = v73;
        u10 = u10 or {};
        u3.InventoryData = u7;
        u3.GamepassData = u9;
        table.clear(u3.EmotesEquipped);

        while u7 == nil do
            local Profile2, v74, v75 = u3.CS:GetProfile();
            u7 = Profile2;
            u9 = v74;
            u10 = v75;
            u10 = u10 or {};
            u3.InventoryData = u7;
            u3.GamepassData = u9;
            task.wait(0.1);
        end;

        u3.EmotesEquipped = u7.EmotesEquipped;
        u13 = false;
        BG["Name&RankFrame"].EnterName.Text = u7.JerseyPlr;
        BG["Name&RankFrame"].EnterNumber.Text = u7.JerseyNumber;

        if u3.StyleOutfitTarget then
            ResetButtons(CustomizationGUIFrame.Buttons.AwakeningOutfit);

            return;
        end;

        CustomizationGUIFrame.Selected.TitleText.Text = CustomizationGUIFrame.Buttons.Emotes.TitleText.Text;
        ResetButtons(CustomizationGUIFrame.Buttons.Emotes);
    end);
    u3.Trove:Connect(CustomizationGUIFrame:WaitForChild("Selected").MouseButton1Click, function() -- Line: 899
        -- upvalues: CustomizationGUIFrame (copy), u14 (ref)
        CustomizationGUIFrame.Buttons.Visible = not CustomizationGUIFrame.Buttons.Visible;
        CustomizationGUIFrame.Buttons[u14].Visible = false;
    end);

    for _, child in pairs(CustomizationGUIFrame:WaitForChild("Buttons"):GetChildren()) do
        if child:IsA("ImageButton") ~= false then
            u3.Trove:Connect(child.MouseButton1Click, function() -- Line: 906
                -- upvalues: u4 (ref), u13 (ref), LocalPlayer (ref), CustomizationGUIFrame (copy), child (copy), ResetButtons (copy)
                if u4 > tick() then
                    return;
                end;

                u4 = tick() + 0.15;

                while u13 do
                    task.wait(0.11);
                end;

                LocalPlayer.PlayerGui.Customization.BG.Wheel.Visible = false;
                CustomizationGUIFrame.Buttons.Visible = false;
                CustomizationGUIFrame.Selected.TitleText.Text = child.TitleText.Text;

                if child.Name == "Emotes" then
                    LocalPlayer.PlayerGui.Customization.BG.Wheel.Visible = true;
                end;

                ResetButtons(child);
            end);
        end;
    end;

    u3.Trove:Connect(BG.EnterButtonFrame.Enter.MouseButton1Click, function() -- Line: 927
        -- upvalues: u3 (copy), BG (copy)
        u3.CS.Jersey:Fire(BG["Name&RankFrame"].EnterName.Text, BG["Name&RankFrame"].EnterNumber.Text);
    end);
    local SearchBox = CustomizationGUIFrame:FindFirstChild("SearchBox");

    if SearchBox and SearchBox:IsA("TextBox") then
        u3.Trove:Connect(SearchBox:GetPropertyChangedSignal("Text"), function() -- Line: 934
            -- upvalues: u3 (copy)
            u3:FilterItems();
            u3:SortItems();
        end);
    end;

    if u3.GamepassData.SecondCosmeticSlot then
        BG.CosmeticButton.Visible = false;
    else
        BG.CosmeticButton.Visible = true;
        u3.Trove:Connect(BG.CosmeticButton.MouseButton1Click, function() -- Line: 942
            -- upvalues: MarketplaceService (ref), LocalPlayer (ref), BG (copy)
            MarketplaceService:PromptGamePassPurchase(LocalPlayer, BG.CosmeticButton:GetAttribute("Gamepass"));
        end);
    end;

    BG["Name&RankFrame"].EnterName.Text = u7.JerseyPlr;
    BG["Name&RankFrame"].EnterNumber.Text = u7.JerseyNumber;
    u3.Trove:Connect(BG["Name&RankFrame"].EnterName:GetPropertyChangedSignal("Text"), function() -- Line: 954
        -- upvalues: BG (copy)
        if string.len(BG["Name&RankFrame"].EnterName.Text) > 8 then
            BG["Name&RankFrame"].EnterName.Text = string.sub(BG["Name&RankFrame"].EnterName.Text, 1, 8);
        end;
    end);
    u3.Trove:Connect(BG["Name&RankFrame"].EnterNumber:GetPropertyChangedSignal("Text"), function() -- Line: 960
        -- upvalues: BG (copy)
        BG["Name&RankFrame"].EnterNumber.Text = BG["Name&RankFrame"].EnterNumber.Text:gsub("%D+", "");

        if string.len(BG["Name&RankFrame"].EnterNumber.Text) > 2 then
            BG["Name&RankFrame"].EnterNumber.Text = string.sub(BG["Name&RankFrame"].EnterNumber.Text, 1, 2);
        end;
    end);
end;

function u2.OpenForStyleOutfit(p76: table, p77: string) -- Line: 968
    -- upvalues: Shop (copy), LocalPlayer (copy), Knit (copy)
    if not Shop:HasGamepass("AwakeningOutfits") then
        Shop:PromptGamepass("AwakeningOutfits");

        return;
    end;

    local Customization = LocalPlayer.PlayerGui.Customization;
    p76.StyleOutfitTarget = p77;

    if not Customization.Enabled then
        Knit.GetController("UIController"):Open("Customization");

        return;
    end;

    p76.CustomFrame.Selected.TitleText.Text = `{p77} Outfit`;
    p76.OpenTab(p76.CustomFrame.Buttons.AwakeningOutfit);
end;

function u2.EmoteSelect(u78, u79, u80, u81) -- Line: 983
    -- upvalues: Trove (copy), LocalPlayer (copy)
    if u78.EmoteTrove then
        u78.EmoteTrove:Destroy();
    end;

    u78.EmoteTrove = Trove.new();
    local u82 = tick();
    local Children = LocalPlayer.PlayerGui.Customization.BG.Wheel:GetChildren();

    for _, v in pairs(Children) do
        if v:IsA("ImageButton") ~= false then
            u78.EmoteTrove:Connect(v.MouseButton1Click, function() -- Line: 993
                -- upvalues: u82 (ref), LocalPlayer (ref), u81 (copy), u79 (copy), u78 (copy), u80 (copy), v (copy)
                if u82 > tick() then
                    return;
                end;

                u82 = tick() + 0.2;

                for _, child in LocalPlayer.PlayerGui.Customization.BG.CustomizationGUIFrame.Items:GetChildren() do
                    if child.Name == u81 and child:FindFirstChild("Equipped") then
                        child.Equipped.Visible = false;
                    end;
                end;

                u79.Equipped.Visible = true;

                if not u79:GetAttribute("RarityValue") then
                    u79:SetAttribute("RarityValue", tonumber(u79.Name) or 999);
                end;

                u79.Name = "0";
                u78.CS.Customize:Fire(u80.Name, u81, v.Name);
                u78:FilterItems();
                u78:SortItems();
            end);
        end;
    end;
end;

function u2.KnitInit(u83) -- Line: 1021
    -- upvalues: Trove (copy), LocalPlayer (copy), u1 (ref), Humanoid (ref), HumanoidRootPart (ref)
    u83.Trove = Trove.new();
    u83.Trove:Connect(LocalPlayer.CharacterAdded, function(p84) -- Line: 1025
        -- upvalues: u1 (ref), Humanoid (ref), HumanoidRootPart (ref)
        u1 = p84;
        Humanoid = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
    end);
    u83.Trove:Connect(game.Players.PlayerRemoving, function(p85) -- Line: 1031
        -- upvalues: LocalPlayer (ref), u1 (ref), HumanoidRootPart (ref), Humanoid (ref), u83 (copy)
        if p85 == LocalPlayer then
            u1 = nil;
            HumanoidRootPart = nil;
            Humanoid = nil;
            u83.Trove:Destroy();
        end;
    end);
end;

return u2;
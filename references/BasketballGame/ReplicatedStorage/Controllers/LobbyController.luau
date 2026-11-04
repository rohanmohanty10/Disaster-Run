 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local MarketplaceService = game:GetService("MarketplaceService");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
game:GetService("TeleportService");
local SocialService = game:GetService("SocialService");
local LocalPlayer = Players.LocalPlayer;
local u1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
local u2 = u1:FindFirstChildOfClass("Humanoid");
local HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.Essentials);
local Trove = require(ReplicatedStorage.Shared.Utility.Trove);
local NumberUtil = require(ReplicatedStorage.Shared.Utility.NumberUtil);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local ScriptableEmotes = require(ReplicatedStorage.Shared.Tables.ScriptableEmotes);
local ScriptableCosmetics = require(ReplicatedStorage.Shared.Tables.ScriptableCosmetics);
local GetHumDescription = require(ReplicatedStorage.Shared.Utility.GetHumDescription);
local GetUnixTime = require(ReplicatedStorage.Shared.Utility.GetUnixTime);
local Halloween = require(ReplicatedStorage.Shared.Tables.Halloween);
local u3 = Trove.new();
local u4 = Knit.CreateController({
    Name = "LobbyController"
});

function u4.Speakers(p5) -- Line: 31
    for _, child in workspace:WaitForChild("Lobby"):WaitForChild("Misc"):WaitForChild("Speakers"):GetChildren() do
        local v6 = child;

        for _, child2 in script.Speaker:GetChildren() do
            child2:Clone().Parent = v6;
        end;
    end;
end;

function u4.TouchingParts(p7, p8) -- Line: 39
    -- upvalues: Knit (copy), LocalPlayer (copy), u1 (ref), TweenService (copy), ReplicatedStorage (copy), Halloween (copy)
    Knit.GetService("StatsService");
    local Controller = Knit.GetController("Team");
    p8:WaitForChild("Play").Touched:Connect(function(p9) -- Line: 43
        -- upvalues: LocalPlayer (ref), u1 (ref), Controller (copy), TweenService (ref)
        if LocalPlayer.Team ~= game.Teams.Visitor then
            return;
        end;

        if LocalPlayer.PlayerGui.PickTeam.Enabled then
            return;
        end;

        if p9.Parent ~= u1 then
            return;
        end;

        if Controller:TimeSinceLastButtonClick() < 1 then
            return;
        end;

        local workspace_CurrentCamera = workspace.CurrentCamera;
        workspace_CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        workspace_CurrentCamera.CFrame = workspace.PlayCamera.CFrame * CFrame.new(0, 0, -20);
        TweenService:Create(workspace_CurrentCamera, TweenInfo.new(0.3), {
            CFrame = workspace.PlayCamera.CFrame
        }):Play();
        LocalPlayer.PlayerGui.HUD.Enabled = false;
        LocalPlayer.PlayerGui.PickTeam.Enabled = true;
    end);
    p8:WaitForChild("Quests").Touched:Connect(function(p10) -- Line: 59
        -- upvalues: LocalPlayer (ref), ReplicatedStorage (ref), u1 (ref)
        if LocalPlayer.Team ~= game.Teams.Visitor and ReplicatedStorage.GameValues.State.Value == "Playing" then
            return;
        end;

        if LocalPlayer.PlayerGui.SeasonPass.Enabled then
            return;
        end;

        if LocalPlayer.PlayerGui.Quests.Enabled then
            return;
        end;

        if LocalPlayer.PlayerGui.Crates.Enabled then
            return;
        end;

        if LocalPlayer.PlayerGui.PickTeam.Enabled then
            return;
        end;

        if p10.Parent ~= u1 then
            return;
        end;

        LocalPlayer.PlayerGui.HUD.Enabled = false;
        LocalPlayer.PlayerGui.Quests.Enabled = true;
    end);
    p8:WaitForChild("Shop").Touched:Connect(function(p11) -- Line: 72
        -- upvalues: LocalPlayer (ref), u1 (ref), Knit (ref)
        if LocalPlayer.Team ~= game.Teams.Visitor then
            return;
        end;

        if LocalPlayer.PlayerGui.Shop.Enabled then
            return;
        end;

        if LocalPlayer.PlayerGui.PickTeam.Enabled then
            return;
        end;

        if p11.Parent ~= u1 then
            return;
        end;

        Knit.GetController("UIController"):Focus(true, LocalPlayer.PlayerGui:FindFirstChild("Shop"):FindFirstChild("BG"));
        LocalPlayer.PlayerGui.Shop.Enabled = true;
    end);
    p8:WaitForChild("Merchant").Touched:Connect(function(p12) -- Line: 84
        -- upvalues: LocalPlayer (ref), ReplicatedStorage (ref), u1 (ref), Knit (ref)
        if LocalPlayer.Team ~= game.Teams.Visitor and ReplicatedStorage.GameValues.State.Value == "Playing" then
            return;
        end;

        if LocalPlayer.PlayerGui.Merchant.Enabled then
            return;
        end;

        if LocalPlayer.PlayerGui.PickTeam.Enabled then
            return;
        end;

        if p12.Parent ~= u1 then
            return;
        end;

        Knit.GetController("UIController"):Focus(true, LocalPlayer.PlayerGui:FindFirstChild("Merchant"):FindFirstChild("Content"));
        LocalPlayer.PlayerGui.HUD.Enabled = false;
        LocalPlayer.PlayerGui.Merchant.Enabled = true;
    end);
    p8:WaitForChild("HoopRewards").Touched:Connect(function(p13) -- Line: 97
        -- upvalues: LocalPlayer (ref), ReplicatedStorage (ref), u1 (ref), Knit (ref)
        if LocalPlayer.Team ~= game.Teams.Visitor and ReplicatedStorage.GameValues.State.Value == "Playing" then
            return;
        end;

        if LocalPlayer.PlayerGui.HoopRewards.Enabled then
            return;
        end;

        if LocalPlayer.PlayerGui.PickTeam.Enabled then
            return;
        end;

        if p13.Parent ~= u1 then
            return;
        end;

        Knit.GetController("UIController"):Focus(true, LocalPlayer.PlayerGui:FindFirstChild("HoopRewards"):FindFirstChild("BG"));
        LocalPlayer.PlayerGui.HUD.Enabled = false;
        LocalPlayer.PlayerGui.HoopRewards.Enabled = true;
    end);
    p8:WaitForChild("StyleQuests").Touched:Connect(function(p14) -- Line: 110
        -- upvalues: Halloween (ref), LocalPlayer (ref), ReplicatedStorage (ref), u1 (ref), Knit (ref)
        if Halloween.Enabled then
            return;
        end;

        if LocalPlayer.Team ~= game.Teams.Visitor and ReplicatedStorage.GameValues.State.Value == "Playing" then
            return;
        end;

        if LocalPlayer.PlayerGui.StyleQuests.Enabled then
            return;
        end;

        if LocalPlayer.PlayerGui.PickTeam.Enabled then
            return;
        end;

        if p14.Parent ~= u1 then
            return;
        end;

        Knit.GetController("UIController"):Focus(true, LocalPlayer.PlayerGui:FindFirstChild("StyleQuests"):FindFirstChild("Content"));
        LocalPlayer.PlayerGui.HUD.Enabled = false;
        LocalPlayer.PlayerGui.StyleQuests.Enabled = true;
    end);
    p8:WaitForChild("NoLimited").Touched:Connect(function(p15) -- Line: 124
        -- upvalues: LocalPlayer (ref), ReplicatedStorage (ref), u1 (ref), Knit (ref)
        if LocalPlayer.Team ~= game.Teams.Visitor and ReplicatedStorage.GameValues.State.Value == "Playing" then
            return;
        end;

        if LocalPlayer.PlayerGui.NoLimited.Enabled then
            return;
        end;

        if LocalPlayer.PlayerGui.PickTeam.Enabled then
            return;
        end;

        if p15.Parent ~= u1 then
            return;
        end;

        Knit.GetController("UIController"):Focus(true, LocalPlayer.PlayerGui:FindFirstChild("NoLimited"):FindFirstChild("BG"));
        LocalPlayer.PlayerGui.NoLimited.Enabled = true;
    end);
end;

function u4.Animations(p16, p17) -- Line: 137
    local Folder = Instance.new("Folder");
    Folder.Name = "Rigs";
    Folder.Parent = workspace;

    for _, child in script.Rigs:GetChildren() do
        local v18 = child:Clone();
        v18.Parent = Folder;
        local v19 = child;

        for _, child2 in script.Animations:GetChildren() do
            if child2.Name == v19.Name then
                v18.Humanoid:LoadAnimation(child2):Play();
            end;
        end;
    end;
end;

function u4.Gamepasses(p20) -- Line: 154
    -- upvalues: Knit (copy), Trove (copy), GetHumDescription (copy), LocalPlayer (copy), ReplicatedStorage (copy), ScriptableEmotes (copy), MarketplaceService (copy), RunService (copy)
    local Controller = Knit.GetController("Network");
    local Controller2 = Knit.GetController("UIController");
    local Controller3 = Knit.GetController("PromptController");
    local u21 = {
        Toxic = 1070581223,
        Anime = 1070998282
    };
    local u22 = {
        Toxic = 3238744677,
        Anime = 3238744600
    };
    local u23 = {
        Toxic = { "L", "Clap", "Sleeping", "Cold" },
        Anime = { "The Honored One", "Touch Glasses", "Gambler", "Warm Up" }
    };
    local u24 = {
        Toxic = {},
        Anime = {}
    };
    local u25 = Trove.new();
    local u26 = script.GamepassRigs:Clone();
    u26.Parent = workspace;
    task.spawn(function() -- Line: 184
        -- upvalues: GetHumDescription (ref), LocalPlayer (ref), u26 (copy), u23 (copy), ReplicatedStorage (ref), u24 (copy), Controller3 (copy), u21 (copy), u22 (copy), Knit (ref), u25 (copy), ScriptableEmotes (ref)
        local v27 = GetHumDescription.FromUserId(LocalPlayer.UserId);

        for _, child in u26:GetChildren() do
            child:WaitForChild("Humanoid"):ApplyDescription(v27);
            local u28 = child;

            for _, v in u23[child.Name] do
                local v29 = u28.Humanoid:LoadAnimation(ReplicatedStorage.Assets.EmoteAnimations:FindFirstChild(v));
                v29.Looped = true;
                table.insert(u24[u28.Name], v29);
            end;

            local v30 = Controller3.SpawnPurchasePrompt(u28.HumanoidRootPart, `Purchase {u28.Name} Emotes!`, true, u21[u28.Name]);

            if u22[u28.Name] then
                v30.UIOffset = Vector2.new(0, 40);
                local v31 = Controller3.SpawnPurchasePrompt(u28.HumanoidRootPart, `Gift {u28.Name} Emotes!`, false, u22[u28.Name], true);
                v31.UIOffset = Vector2.new(0, -40);
                v31.KeyboardKeyCode = Enum.KeyCode.R;
                v31.GamepadKeyCode = Enum.KeyCode.ButtonY;
                v31.Triggered:Connect(function() -- Line: 205
                    -- upvalues: Knit (ref), u22 (ref), u28 (copy)
                    Knit.GetController("GiftingController").PromptGiftPlayer(u22[u28.Name]);
                end);
            end;
        end;

        local v32 = 1;

        while task.wait() do
            u25:Clean();

            for _, child in u26:GetChildren() do
                local v33 = child;

                for _, v in u24[child.Name] do
                    v:Stop();
                end;

                u24[v33.Name][v32]:Play();

                if ScriptableEmotes[u23[v33.Name][v32]] then
                    task.spawn(ScriptableEmotes[u23[v33.Name][v32]], {
                        Character = v33
                    }, u25);
                end;
            end;

            local v34 = v32 + 1;
            v32 = v34 > 4 and 1 or v34;
            task.wait(4);
        end;
    end);
    local v35 = script.VIP:Clone();
    v35.Parent = workspace;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.OutlineColor = Color3.new(1, 1, 1);
    Highlight.OutlineTransparency = 0;
    Highlight.FillColor = Color3.new(1, 0, 0);
    Highlight.FillTransparency = 1;
    Highlight.Parent = v35.Crown;
    local _, v36 = Controller3.SpawnSubscriptionPrompt(v35, "Purchase VIP!", "EXP-664152387388310014", nil, nil, function() -- Line: 249
        -- upvalues: LocalPlayer (ref), Controller2 (copy)
        LocalPlayer.PlayerGui.VIPPack.Enabled = not LocalPlayer.PlayerGui.VIPPack.Enabled;
        Controller2:Focus(LocalPlayer.PlayerGui.VIPPack.Enabled, LocalPlayer.PlayerGui.VIPPack);
    end);
    LocalPlayer.PlayerGui.VIPPack.BG.RobuxButton.MouseButton1Down:Connect(function() -- Line: 255
        -- upvalues: Controller (copy), MarketplaceService (ref), LocalPlayer (ref)
        if Controller.Player.IsVIPSubscribed then
            return;
        end;

        MarketplaceService:PromptSubscriptionPurchase(LocalPlayer, "EXP-664152387388310014");
    end);
    LocalPlayer.PlayerGui.VIPPack.BG.RobuxButton.Text.Text = v36;
    local Crown = v35.Crown;
    local Position = Crown.Position;
    RunService.RenderStepped:Connect(function(p37) -- Line: 266
        -- upvalues: LocalPlayer (ref), Crown (copy), Position (copy)
        if LocalPlayer.Team ~= game.Teams.Visitor then
            return;
        end;

        local v38 = Crown;
        v38.Orientation = v38.Orientation + Vector3.new(0, 30, 0) * p37;
        local v39 = time() * 3.141592653589793 * 0.5;
        Crown.Position = Position + Vector3.new(0, 1, 0) * math.sin(v39) * 0.25;
    end);
end;

function u4.UGCs(p40) -- Line: 274
    -- upvalues: Knit (copy)
    Knit.GetController("Network");
    Knit.GetController("UIController");
    local Controller = Knit.GetController("PromptController");

    for _, child in workspace:WaitForChild("Lobby"):WaitForChild("UGCs"):GetChildren() do
        Controller.SpawnPurchasePrompt(child.Main, "BUY", "Asset", child:GetAttribute("ProductId"));
    end;
end;

local u41 = {};

function u4.PreviewGoalEffect(u42: table, u43: string, u44: number) -- Line: 286
    -- upvalues: u4 (copy), Knit (copy), LocalPlayer (copy), u41 (copy), MarketplaceService (copy), u3 (copy), ReplicatedStorage (copy), Effects (copy)
    u4:ClosePreview();
    Knit.GetController("UIController"):Focus(false);
    workspace.Camera.CameraType = Enum.CameraType.Scriptable;
    workspace.Camera.CFrame = workspace.GoalEffectsCam.CFrame;
    local Enabled = LocalPlayer.PlayerGui.HUD.Enabled;
    task.spawn(function() -- Line: 297
        -- upvalues: LocalPlayer (ref), u41 (ref), u44 (copy), MarketplaceService (ref)
        LocalPlayer.PlayerGui.GoalEffectPreview.Content.Buy.TextLabel.Text = "...";
        local v45 = u41[u44];

        if not v45 then
            v45 = MarketplaceService:GetProductInfo(u44, Enum.InfoType.Product).PriceInRobux;
            u41[u44] = v45;
        end;

        LocalPlayer.PlayerGui.GoalEffectPreview.Content.Buy.TextLabel.Text = `{utf8.char(57346)}{v45}`;
    end);
    LocalPlayer.PlayerGui.GoalEffectPreview.Enabled = true;
    LocalPlayer.PlayerGui.HUD.Enabled = false;
    u3:Add(function() -- Line: 313
        -- upvalues: LocalPlayer (ref), Enabled (copy)
        workspace.Camera.CameraType = Enum.CameraType.Custom;
        LocalPlayer.PlayerGui.GoalEffectPreview.Enabled = false;
        LocalPlayer.PlayerGui.HUD.Enabled = Enabled;
    end);
    u3:Add(task.spawn(function() -- Line: 320
        -- upvalues: ReplicatedStorage (ref), u43 (copy), u42 (copy), LocalPlayer (ref)
        local v46 = require(ReplicatedStorage.Effects.GoalEffects.Client:FindFirstChild(u43) or ReplicatedStorage.Effects.GoalEffects.Client.EmitEffects);

        while true do
            v46(u42, {
                Locker = true,
                Player = LocalPlayer,
                Vfx = ReplicatedStorage.Assets.GoalEffects:FindFirstChild(u43),
                CFrame = CFrame.new(workspace.Hoops.Away.Hoop.Position)
            });
            task.wait(5);
        end;
    end));
    local Service = Knit.GetService("LimitedShopService");
    local Controller = Knit.GetController("GiftingController");
    local Content = LocalPlayer.PlayerGui.GoalEffectPreview.Content;
    u3:Add(Content.Buy.MouseButton1Click:Connect(function() -- Line: 341
        -- upvalues: Service (copy), LocalPlayer (ref), u44 (copy), MarketplaceService (ref), Effects (ref)
        if Service:CanPurchaseLimitedItem(LocalPlayer, u44) == true then
            MarketplaceService:PromptProductPurchase(LocalPlayer, u44);

            return;
        end;

        Effects:Popup("Couldn\'t purchase item at this time!", 5, Color3.fromRGB(255, 0, 0));
    end));
    u3:Add(Content.Gift.MouseButton1Click:Connect(function() -- Line: 350
        -- upvalues: Controller (copy), u44 (copy), Service (copy), Effects (ref)
        Controller.PromptGiftPlayer(u44, function(p47: userdata) -- Line: 351
            -- upvalues: Service (ref), u44 (ref), Effects (ref)
            local v48 = Service:CanPurchaseLimitedItem(p47, u44);

            if not v48 then
                Effects:Popup(`{p47.Name} already owns this item!`, 5, Color3.fromRGB(255, 0, 0));
            end;

            return v48;
        end);
    end));
    u3:Add(Content.Close.MouseButton1Click:Connect(function() -- Line: 361
        -- upvalues: u4 (ref)
        u4:ClosePreview();
    end));
    local u49 = tick();
    u3:Add(Content.Try.MouseButton1Click:Connect(function() -- Line: 366
        -- upvalues: u49 (ref), ReplicatedStorage (ref), u43 (copy), u42 (copy), LocalPlayer (ref)
        if u49 > tick() then
            return;
        end;

        u49 = tick() + 1;
        require(ReplicatedStorage.Effects.GoalEffects.Client:FindFirstChild(u43) or ReplicatedStorage.Effects.GoalEffects.Client.EmitEffects)(u42, {
            Locker = true,
            Player = LocalPlayer,
            Vfx = ReplicatedStorage.Assets.GoalEffects:FindFirstChild(u43),
            CFrame = CFrame.new(workspace.Hoops.Away.Hoop.Position)
        });
    end));
end;

function u4.PreviewCutsceneEmote(p50: table, p51: string, u52: number) -- Line: 380
    -- upvalues: u4 (copy), Knit (copy), LocalPlayer (copy), u41 (copy), MarketplaceService (copy), u3 (copy), ScriptableEmotes (copy), Effects (copy)
    u4:ClosePreview();
    local Controller = Knit.GetController("EmotesController");
    Knit.GetController("UIController"):Focus(false);
    workspace.Camera.CameraType = Enum.CameraType.Scriptable;
    local Enabled = LocalPlayer.PlayerGui.HUD.Enabled;

    if u52 then
        task.spawn(function() -- Line: 392
            -- upvalues: LocalPlayer (ref), u41 (ref), u52 (copy), MarketplaceService (ref)
            LocalPlayer.PlayerGui.GoalEffectPreview.Content.Buy.TextLabel.Text = "...";
            local v53 = u41[u52];

            if not v53 then
                v53 = MarketplaceService:GetProductInfo(u52, Enum.InfoType.Product).PriceInRobux;
                u41[u52] = v53;
            end;

            LocalPlayer.PlayerGui.GoalEffectPreview.Content.Buy.TextLabel.Text = `{utf8.char(57346)}{v53}`;
        end);
    end;

    LocalPlayer.PlayerGui.GoalEffectPreview.Enabled = true;
    LocalPlayer.PlayerGui.HUD.Enabled = false;
    u3:Add(function() -- Line: 409
        -- upvalues: LocalPlayer (ref), Enabled (copy)
        workspace.Camera.CameraType = Enum.CameraType.Custom;
        LocalPlayer.PlayerGui.GoalEffectPreview.Enabled = false;
        LocalPlayer.PlayerGui.HUD.Enabled = Enabled;
    end);
    local u54 = ScriptableEmotes[p51];
    local u55 = u3:Add(Controller.CharacterRig:Clone());
    u55.HumanoidRootPart.CFrame = workspace.StartPositions.Normal.Away.CF.CFrame;
    u3:Add(task.spawn(function() -- Line: 421
        -- upvalues: u55 (copy), u54 (copy)
        while true do
            local task_spawn_ret = task.spawn(function() -- Line: 423
                -- upvalues: u55 (ref), u54 (ref)
                local v56 = u55:Clone();
                v56.Parent = workspace.Debris;
                u54({
                    Character = v56,
                    Team = {
                        GetPlayers = function() -- Line: 430, Name: GetPlayers
                            return {};
                        end
                    }
                });
                v56:Destroy();
            end);

            repeat
                task.wait();
            until coroutine.status(task_spawn_ret) == "dead";

            task.wait(1);
        end;
    end));
    local Service = Knit.GetService("LimitedShopService");
    local Controller2 = Knit.GetController("GiftingController");
    local Content = LocalPlayer.PlayerGui.GoalEffectPreview.Content;

    if u52 then
        u3:Add(Content.Buy.MouseButton1Click:Connect(function() -- Line: 453
            -- upvalues: Service (copy), LocalPlayer (ref), u52 (copy), MarketplaceService (ref), Effects (ref)
            if Service:CanPurchaseLimitedItem(LocalPlayer, u52) == true then
                MarketplaceService:PromptProductPurchase(LocalPlayer, u52);

                return;
            end;

            Effects:Popup("Couldn\'t purchase item at this time!", 5, Color3.fromRGB(255, 0, 0));
        end));
        u3:Add(Content.Gift.MouseButton1Click:Connect(function() -- Line: 462
            -- upvalues: Controller2 (copy), u52 (copy), Service (copy), Effects (ref)
            Controller2.PromptGiftPlayer(u52, function(p57: userdata) -- Line: 463
                -- upvalues: Service (ref), u52 (ref), Effects (ref)
                local v58 = Service:CanPurchaseLimitedItem(p57, u52);

                if not v58 then
                    Effects:Popup(`{p57.Name} already owns this item!`, 5, Color3.fromRGB(255, 0, 0));
                end;

                return v58;
            end);
        end));
    else
        Content.Buy.Visible = false;
        Content.Gift.Visible = false;
        u3:Add(function() -- Line: 476
            -- upvalues: Content (copy)
            Content.Buy.Visible = true;
            Content.Gift.Visible = true;
        end);
    end;

    u3:Add(Content.Close.MouseButton1Click:Connect(function() -- Line: 481
        -- upvalues: u4 (ref)
        u4:ClosePreview();
    end));
    Content.Try.Visible = false;

    if not u52 then
        Content.Buy.Visible = false;
        Content.Gift.Visible = false;
    end;

    u3:Add(function() -- Line: 490
        -- upvalues: Content (copy)
        Content.Try.Visible = true;
        Content.Buy.Visible = true;
        Content.Gift.Visible = true;
    end);
end;

function u4.ClosePreview(p59) -- Line: 497
    -- upvalues: u3 (copy)
    u3:Clean();
end;

function u4.LimitedShop(p60) -- Line: 501
    -- upvalues: Knit (copy), Effects (copy), u4 (copy), ReplicatedStorage (copy), LocalPlayer (copy), MarketplaceService (copy), Trove (copy), ScriptableEmotes (copy), ScriptableCosmetics (copy), RunService (copy), GetUnixTime (copy), NumberUtil (copy)
    local Controller = Knit.GetController("PromptController");
    local Controller2 = Knit.GetController("GiftingController");
    local Controller3 = Knit.GetController("EncryptedAssetsController");
    local Controller4 = Knit.GetController("Network");
    local Service = Knit.GetService("LimitedShopService");
    local Service2 = Knit.GetService("MarketService");
    local Limiteds = workspace:WaitForChild("Lobby"):WaitForChild("Limiteds");
    local u61 = {};

    local function UpdatePrompts(u62: userdata) -- Line: 512
        -- upvalues: u61 (copy), Controller4 (copy), Controller (copy), Controller2 (copy), Service (copy), Effects (ref), u4 (ref), ReplicatedStorage (ref), LocalPlayer (ref), MarketplaceService (ref), UpdatePrompts (copy)
        local v63 = u61[u62];
        v63:Clean();

        if u62:GetAttribute("ProductId") == nil then
            return;
        end;

        local v64 = table.find(Controller4.Player.Customization.Inventory[u62:GetAttribute("ItemType")], u62:GetAttribute("ItemName")) ~= nil;
        local v65;

        if u62:GetAttribute("IsGamepass") then
            v65 = nil;
        else
            v65 = v63:Add(Controller.SpawnPurchasePrompt(u62, "GIFT", false, u62:GetAttribute("ProductId"), true));
            v65.Triggered:Connect(function() -- Line: 530
                -- upvalues: Controller2 (ref), u62 (copy), Service (ref), Effects (ref)
                Controller2.PromptGiftPlayer(u62:GetAttribute("ProductId"), function(p66: userdata) -- Line: 531
                    -- upvalues: Service (ref), u62 (ref), Effects (ref)
                    local v67 = Service:CanPurchaseLimitedItem(p66, u62:GetAttribute("ProductId"));

                    if not v67 then
                        Effects:Popup(`Can't purchase this item for {p66.Name}!`, 5, Color3.fromRGB(255, 0, 0));
                    end;

                    return v67;
                end);
            end);
        end;

        local u68 = nil;

        if u62:GetAttribute("ItemType") == "GoalEffects" then
            u68 = v63:Add(Controller.SpawnPurchasePrompt(u62, "PREVIEW", false, nil, true));
            u68.Triggered:Connect(function() -- Line: 547
                -- upvalues: u4 (ref), u62 (copy)
                u4:PreviewGoalEffect(u62:GetAttribute("ItemName"), u62:GetAttribute("ProductId"));
            end);
            u68.ObjectText = "Preview Goal Effect";
            u68.UIOffset = Vector2.new(0, 80);
            u68.KeyboardKeyCode = Enum.KeyCode.T;
            u68.GamepadKeyCode = Enum.KeyCode.ButtonB;

            if v65 then
                v65.PromptShown:Connect(function() -- Line: 557
                    -- upvalues: u68 (ref)
                    u68.Enabled = true;
                end);
                v65.PromptHidden:Connect(function() -- Line: 560
                    -- upvalues: u68 (ref)
                    u68.Enabled = false;
                end);
            end;

            v63:Add(task.spawn(function() -- Line: 565
                -- upvalues: u62 (copy), ReplicatedStorage (ref), LocalPlayer (ref)
                local Attribute = u62:GetAttribute("ItemName");
                local v69 = require(ReplicatedStorage.Effects.GoalEffects.Client:FindFirstChild(Attribute) or ReplicatedStorage.Effects.GoalEffects.Client.EmitEffects);

                while true do
                    v69({}, {
                        Locker = true,
                        Preview = true,
                        Player = LocalPlayer,
                        Vfx = ReplicatedStorage.Assets.GoalEffects:WaitForChild(Attribute),
                        CFrame = CFrame.new(u62:WaitForChild("GoalEffects"):WaitForChild("Rim"):WaitForChild("EffectRoot").WorldPosition)
                    });
                    task.wait(5);
                end;
            end));
        elseif u62:GetAttribute("ItemTypeDisplay") == "CUTSCENE EMOTE" then
            u68 = v63:Add(Controller.SpawnPurchasePrompt(u62, "PREVIEW", false, nil, true));
            u68.Triggered:Connect(function() -- Line: 583
                -- upvalues: u4 (ref), u62 (copy)
                u4:PreviewCutsceneEmote(u62:GetAttribute("ItemName"), u62:GetAttribute("ProductId"));
            end);
            u68.ObjectText = "Preview Cutscene";
            u68.UIOffset = Vector2.new(0, 80);
            u68.KeyboardKeyCode = Enum.KeyCode.T;
            u68.GamepadKeyCode = Enum.KeyCode.ButtonB;

            if v65 then
                v65.PromptShown:Connect(function() -- Line: 593
                    -- upvalues: u68 (ref)
                    u68.Enabled = true;
                end);
                v65.PromptHidden:Connect(function() -- Line: 596
                    -- upvalues: u68 (ref)
                    u68.Enabled = false;
                end);
            end;
        end;

        if not v64 then
            local v70 = v63:Add(Controller.SpawnPurchasePrompt(u62, "BUY", u62:GetAttribute("IsGamepass"), u62:GetAttribute("ProductId"), true));
            v70.Triggered:Connect(function() -- Line: 604
                -- upvalues: Service (ref), LocalPlayer (ref), u62 (copy), MarketplaceService (ref), Effects (ref), UpdatePrompts (ref)
                if Service:CanPurchaseLimitedItem(LocalPlayer, u62:GetAttribute("ProductId")) ~= true then
                    Effects:Popup("Couldn\'t purchase item at this time!", 5, Color3.fromRGB(255, 0, 0));
                    UpdatePrompts(u62);

                    return;
                end;

                if not u62:GetAttribute("IsGamepass") then
                    MarketplaceService:PromptProductPurchase(LocalPlayer, u62:GetAttribute("ProductId"));

                    return;
                end;

                if u62:GetAttribute("IsGamepass") == "Asset" then
                    MarketplaceService:PromptPurchase(LocalPlayer, u62:GetAttribute("ProductId"));

                    return;
                end;

                MarketplaceService:PromptGamePassPurchase(LocalPlayer, u62:GetAttribute("ProductId"));
            end);

            if v65 then
                v65.UIOffset = Vector2.new(0, -40);
                v65.KeyboardKeyCode = Enum.KeyCode.R;
                v65.GamepadKeyCode = Enum.KeyCode.ButtonY;
                v70.UIOffset = Vector2.new(0, 40);
            end;

            if u68 then
                u68.UIOffset = Vector2.new(0, 120);
            end;
        end;
    end;

    local LimitedShopTemplates = ReplicatedStorage.Assets.LimitedShopTemplates;
    local u71 = {};
    local u95 = {
        CutsceneEmote = function(p72: userdata, p73: any) -- Line: 641, Name: CutsceneEmote
            -- upvalues: Trove (ref), ScriptableEmotes (ref)
            p73.Billboard.BillboardGui.ItemName.Text = `{string.upper(p72.ItemName)}`;

            if p72.ItemTypeDisplay then
                p73.Billboard.BillboardGui.Category.Text = `{string.upper(p72.ItemTypeDisplay)}`;
            end;

            local v74 = Trove.new();
            v74:AttachToInstance(p73.Character);
            task.spawn(ScriptableEmotes[p72.ItemName .. "_LimitedShop"], {
                Character = p73.Character
            }, v74);
        end,

        DuoEmote = function(p75: userdata, p76: any) -- Line: 652, Name: DuoEmote
            -- upvalues: Trove (ref), ReplicatedStorage (ref), ScriptableEmotes (ref)
            p76.Billboard.BillboardGui.ItemName.Text = `{string.upper(p75.ItemName)}`;

            if p75.ItemTypeDisplay then
                p76.Billboard.BillboardGui.Category.Text = `{string.upper(p75.ItemTypeDisplay)}`;
            end;

            p76:PivotTo(p76:GetPivot() * CFrame.Angles(0, 1.5707963267948966, 0));
            local v77 = Trove.new();
            v77:AttachToInstance(p76["1"]);
            local v78 = require(ReplicatedStorage.Shared.Tables.Customization).Emotes[p75.ItemName];
            task.spawn(ScriptableEmotes[v78.DuoCallback], {
                Character = p76["1"]
            }, {
                Character = p76["2"]
            }, v77);
        end,

        Emotes = function(u79: userdata, u80: any) -- Line: 685, Name: Emotes
            -- upvalues: ReplicatedStorage (ref), Trove (ref), ScriptableEmotes (ref)
            u80.Billboard.BillboardGui.ItemName.Text = `{string.upper(u79.ItemName)}`;

            if u79.ItemTypeDisplay then
                u80.Billboard.BillboardGui.Category.Text = `{string.upper(u79.ItemTypeDisplay)}`;
            end;

            local v81 = ReplicatedStorage.Assets.EmoteAnimations:WaitForChild(u79.Anim or u79.ItemName);
            local v82 = u80.Character.Humanoid:LoadAnimation(v81);
            local u83 = Trove.new();
            u83:AttachToInstance(u80.Character);

            if ScriptableEmotes[u79.ItemName] then
                if u79.ItemName == "Jackpot!" or (u79.ItemName == "Perfect Mind" or (u79.ItemName == "Skateboard" or (u79.ItemName == "Killer" or u79.ItemName == "Card Flip"))) then
                    v82.DidLoop:Connect(function() -- Line: 699
                        -- upvalues: u83 (copy), ScriptableEmotes (ref), u79 (copy), u80 (copy)
                        u83:Clean();
                        ScriptableEmotes[u79.ItemName]({
                            Character = u80.Character
                        }, u83);
                    end);
                else
                    task.spawn(ScriptableEmotes[u79.ItemName], {
                        Character = u80.Character
                    }, u83);
                end;
            end;

            v82.Priority = Enum.AnimationPriority.Action2;
            v82.Looped = true;
            v82:Play();
        end,

        GoalEffects = function(p84: userdata, p85: any) -- Line: 713, Name: GoalEffects
            p85.Billboard.BillboardGui.ItemName.Text = `{string.upper(p84.ItemName)}`;

            if p84.ItemTypeDisplay then
                p85.Billboard.BillboardGui.Category.Text = `{string.upper(p84.ItemTypeDisplay)}`;
            end;
        end,

        Cosmetics = function(p86: userdata, p87: any) -- Line: 720, Name: Cosmetics
            -- upvalues: ReplicatedStorage (ref), ScriptableCosmetics (ref), Trove (ref)
            local u88 = ReplicatedStorage.Assets.Cosmetics:FindFirstChild(p86.ItemName):Clone();
            u88.Parent = p87.Character;
            p87.Billboard.BillboardGui.ItemName.Text = `{string.upper(p86.ItemName)}`;

            if p86.ItemTypeDisplay then
                p87.Billboard.BillboardGui.Category.Text = `{string.upper(p86.ItemTypeDisplay)}`;
            end;

            if p86.Emote then
                local v89 = ReplicatedStorage.Assets.EmoteAnimations:WaitForChild(p86.Emote);
                local v90 = p87.Character.Humanoid:LoadAnimation(v89);
                v90.Priority = Enum.AnimationPriority.Action2;
                v90.Looped = true;
                v90:Play();
            end;

            if p86.IsTurnedAround then
                p87.Character:PivotTo(p87.Character:GetPivot() * CFrame.Angles(0, 3.141592653589793, 0));
            end;

            if p86.IsOnRight then
                p87.Character:PivotTo(p87.Character:GetPivot() * CFrame.fromEulerAngles(0, 1.5707963267948966, 0));
            end;

            if ScriptableCosmetics[p86.ItemName] then
                local u91 = Trove.new();
                u91:AttachToInstance(u88);
                u91:Add(u88.AncestryChanged:Connect(function() -- Line: 748
                    -- upvalues: u88 (copy), u91 (copy)
                    if not u88:IsDescendantOf(workspace) then
                        u91:Destroy();
                    end;
                end));
                task.spawn(ScriptableCosmetics[p86.ItemName], p87.Character, u88, u91);
            end;
        end,

        Cards = function(p92: userdata, p93: any) -- Line: 757, Name: Cards
            -- upvalues: ReplicatedStorage (ref)
            p93.Billboard.BillboardGui.ItemName.Text = string.upper(p92.ItemName);

            if p92.ItemTypeDisplay then
                p93.Billboard.BillboardGui.Category.Text = `{string.upper(p92.ItemTypeDisplay)}`;
            end;

            local v94 = ReplicatedStorage.Assets.Cards:FindFirstChild(p92.ItemName):Clone();
            v94.Visible = true;
            v94.Size = UDim2.fromScale(1, 10);
            v94.AnchorPoint = Vector2.new(0.5, 0.75);
            v94:FindFirstChildOfClass("ViewportFrame"):Destroy();
            local UIAspectRatioConstraint = Instance.new("UIAspectRatioConstraint");
            UIAspectRatioConstraint.AspectRatio = 1.778;
            UIAspectRatioConstraint.AspectType = Enum.AspectType.FitWithinMaxSize;
            UIAspectRatioConstraint.Parent = v94;

            for _, child in v94:GetChildren() do
                if child:IsA("TextLabel") and child.Name ~= "Txt" then
                    child.Text = "--";
                end;
            end;

            v94.Parent = p93.Root.BillboardGui;
        end
    };

    local function UpdateItemPreview(p96: userdata) -- Line: 786
        -- upvalues: u71 (copy), Controller3 (copy), LimitedShopTemplates (copy), u95 (copy)
        local v97 = u71[p96];
        v97:Clean();

        if not p96:GetAttribute("ItemName") then
            return;
        end;

        while not Controller3.HasLoaded do
            task.wait();
        end;

        local Attributes = p96:GetAttributes();
        local v98 = p96.CFrame + Vector3.new(0, 1, 0) * p96.Size.Y * 0.5;

        if Attributes.ItemTypeDisplay == "DUO EMOTE" then
            Attributes.ItemType = "DuoEmote";
        elseif Attributes.ItemTypeDisplay == "CUTSCENE EMOTE" then
            Attributes.ItemType = "CutsceneEmote";
        end;

        local v99 = v97:Add(LimitedShopTemplates:FindFirstChild(Attributes.ItemType):Clone());
        local BoundingBox, v100 = v99:GetBoundingBox();
        v99:PivotTo((v98 + Vector3.new(0, 1, 0) * v100.Y * 0.5 + (v99:GetPivot().Position - BoundingBox.Position)) * CFrame.fromEulerAngles(0, -1.5707963267948966, 0));
        v99.Parent = p96;
        task.defer(u95[Attributes.ItemType], Attributes, v99);
    end;

    for _, child in Limiteds:GetChildren() do
        if child:IsA("Model") then
            u61[child.Main] = Trove.new();
            u71[child.Main] = Trove.new();

            if child.Main:GetAttribute("ProductId") ~= nil then
                task.spawn(UpdatePrompts, child.Main);
            end;

            child.Main.AttributeChanged:Connect(function() -- Line: 829
                -- upvalues: UpdatePrompts (copy), child (copy)
                UpdatePrompts(child.Main);
            end);
            task.spawn(UpdateItemPreview, child.Main);
            child.Main:GetAttributeChangedSignal("ItemName"):Connect(function() -- Line: 835
                -- upvalues: UpdateItemPreview (copy), child (copy)
                UpdateItemPreview(child.Main);
            end);
        end;
    end;

    Service2.OnPlayerPurchased:Connect(function() -- Line: 840
        -- upvalues: Limiteds (copy), UpdatePrompts (copy)
        for _, child in Limiteds:GetChildren() do
            if child:IsA("Model") then
                UpdatePrompts(child.Main);
            end;
        end;
    end);
    local u101 = Trove.new();
    local ExpiryTime = workspace.Lobby.Limiteds:WaitForChild("Billboard"):WaitForChild("BillboardGui"):WaitForChild("ExpiryTime");
    local ExpiryTime2 = workspace.Lobby.Limiteds:WaitForChild("1"):WaitForChild("Billboard"):WaitForChild("BillboardGui"):WaitForChild("ExpiryTime");

    local function UpdateExpiryTime(u102: table) -- Line: 854
        -- upvalues: u101 (copy), RunService (ref), GetUnixTime (ref), ExpiryTime (copy), NumberUtil (ref), ExpiryTime2 (copy)
        u101:Clean();
        local u103 = nil;
        u101:Add(RunService.Heartbeat:Connect(function() -- Line: 858
            -- upvalues: GetUnixTime (ref), u103 (ref), u102 (copy), ExpiryTime (ref), NumberUtil (ref), ExpiryTime2 (ref)
            local v104 = GetUnixTime();

            if v104 == u103 then
                return;
            end;

            u103 = v104;
            local v105 = u102.limited - v104;
            local v106 = u102.mythic - v104;
            ExpiryTime.Text = `TIME LEFT: {v105 > 0 and NumberUtil.AdaptiveClockString(v105) or "EXPIRED!"}`;
            ExpiryTime2.Text = `TIME LEFT: {v106 > 0 and NumberUtil.AdaptiveClockString(v106) or "EXPIRED!"}`;
        end));
    end;

    local u107 = Service.ExpiryTime:Get();

    if u107 ~= nil then
        u101:Clean();
        local u108 = nil;
        u101:Add(RunService.Heartbeat:Connect(function() -- Line: 858
            -- upvalues: GetUnixTime (ref), u108 (ref), u107 (copy), ExpiryTime (copy), NumberUtil (ref), ExpiryTime2 (copy)
            local v109 = GetUnixTime();

            if v109 == u108 then
                return;
            end;

            u108 = v109;
            local v110 = u107.limited - v109;
            local v111 = u107.mythic - v109;
            ExpiryTime.Text = `TIME LEFT: {v110 > 0 and NumberUtil.AdaptiveClockString(v110) or "EXPIRED!"}`;
            ExpiryTime2.Text = `TIME LEFT: {v111 > 0 and NumberUtil.AdaptiveClockString(v111) or "EXPIRED!"}`;
        end));
    end;

    Service.ExpiryTime:Observe(UpdateExpiryTime);
end;

function u4.UpdateTimer(p112, p113) -- Line: 881
    -- upvalues: Knit (copy), Trove (copy), RunService (copy), GetUnixTime (copy), NumberUtil (copy), SocialService (copy)
    local Service = Knit.GetService("UpdateTimerService");
    local BillboardGui = p113.Play.BillboardGui;
    local EventFollow = p113.Play.EventFollowAtt.EventFollow;
    local u114 = Trove.new();
    local u115 = nil;

    local function UpdateTimer(u116) -- Line: 890
        -- upvalues: u114 (copy), BillboardGui (copy), RunService (ref), GetUnixTime (ref), NumberUtil (ref), SocialService (ref), EventFollow (copy), Knit (ref), u115 (ref)
        u114:Clean();
        BillboardGui.UpdateName.Text = u116.UpdateName;
        BillboardGui.MiscMessage.Text = u116.MiscMessage;
        local u117 = nil;
        u114:Add(RunService.Heartbeat:Connect(function() -- Line: 897
            -- upvalues: GetUnixTime (ref), u117 (ref), u116 (copy), BillboardGui (ref), NumberUtil (ref)
            local v118 = GetUnixTime();

            if v118 == u117 then
                return;
            end;

            u117 = v118;
            local v119 = u116.UpdateTime - v118;
            BillboardGui.Timer.Text = `{v119 > 0 and string.upper(NumberUtil.AdaptiveClockString(v119)) or "NOW"}`;
        end));
        local success, result = pcall(function() -- Line: 909
            -- upvalues: SocialService (ref), u116 (copy)
            return SocialService:GetEventRsvpStatusAsync(u116.EventId);
        end);

        if not success then
            EventFollow.Enabled = false;

            return;
        end;

        EventFollow.Enabled = result ~= Enum.RsvpStatus.Going;

        local function updateRsvp(p120) -- Line: 920
            -- upvalues: EventFollow (ref), Knit (ref)
            if p120 ~= Enum.RsvpStatus.Going then
                EventFollow.ActionText = "Follow Event";
                EventFollow.Enabled = true;

                return;
            end;

            EventFollow.ActionText = "Unfollow Event";
            EventFollow.Enabled = false;
            Knit.GetService("RsvpService"):Rsvped();
        end;

        if result == Enum.RsvpStatus.Going then
            Knit.GetService("RsvpService"):Rsvped();
        elseif u116.EventId ~= u115 then
            u115 = u116.EventId;
            task.delay(180, function() -- Line: 938
                -- upvalues: u116 (copy), u115 (ref), SocialService (ref), EventFollow (ref), Knit (ref)
                if u116.EventId ~= u115 then
                    return;
                end;

                if SocialService:PromptRsvpToEventAsync(u116.EventId) ~= Enum.RsvpStatus.Going then
                    EventFollow.ActionText = "Follow Event";
                    EventFollow.Enabled = true;

                    return;
                end;

                EventFollow.ActionText = "Unfollow Event";
                EventFollow.Enabled = false;
                Knit.GetService("RsvpService"):Rsvped();
            end);
        end;

        u114:Add(EventFollow.Triggered:Connect(function() -- Line: 945
            -- upvalues: SocialService (ref), u116 (copy), EventFollow (ref), Knit (ref)
            if SocialService:PromptRsvpToEventAsync(u116.EventId) ~= Enum.RsvpStatus.Going then
                EventFollow.ActionText = "Follow Event";
                EventFollow.Enabled = true;

                return;
            end;

            EventFollow.ActionText = "Unfollow Event";
            EventFollow.Enabled = false;
            Knit.GetService("RsvpService"):Rsvped();
        end));
    end;

    local v121 = Service.UpdateTimer:Get();

    if v121 ~= nil then
        UpdateTimer(v121);
    end;

    Service.UpdateTimer:Observe(UpdateTimer);
end;

function u4.RankedSeasonTimer(p122) -- Line: 959
end;

function u4.ProServers(p123) -- Line: 986
    -- upvalues: Knit (copy)
    local Controller = Knit.GetController("Network");
    local Service = Knit.GetService("CustomServerService");
    local ProServers = workspace.Lobby:WaitForChild("ProServers");

    if Controller.ServerType ~= "NoLimited" and Controller.Player.Level < 35 then
        ProServers:Destroy();

        return;
    end;

    local Podium = ProServers.Podium;

    if Controller.ServerType ~= "Pro" and Controller.ServerType ~= "NoLimited" then
        Podium.Prompt.Prompt.Triggered:Connect(function() -- Line: 1006
            -- upvalues: Service (copy)
            Service:JoinPro();
        end);

        return;
    end;

    Podium.LevelGui:Destroy();
    Podium.ProServersText.ButtonName.Text = "NORMAL SERVERS";
    Podium.Prompt.Prompt.Triggered:Connect(function() -- Line: 1002
        -- upvalues: Service (copy)
        Service:JoinNormal();
    end);
end;

function u4.KnitStart(p124) -- Line: 1012
    -- upvalues: LocalPlayer (copy), RunService (copy)
    local TouchingParts = workspace:WaitForChild("TouchingParts");
    task.spawn(p124.LimitedShop);
    task.spawn(p124.Gamepasses);
    task.spawn(p124.UGCs);
    task.spawn(p124.TouchingParts, p124, TouchingParts);
    task.spawn(p124.UpdateTimer, p124, TouchingParts);
    task.spawn(p124.RankedSeasonTimer, p124, TouchingParts);
    task.spawn(p124.Speakers);
    task.spawn(p124.Animations);
    task.spawn(p124.ProServers);
    LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("HUD");
    local Children = workspace:WaitForChild("Lobby"):WaitForChild("ToSpin"):GetChildren();
    local Limiteds = workspace:WaitForChild("Lobby"):WaitForChild("Limiteds");
    local v125 = 0;

    while task.wait() do
        if LocalPlayer.Team == game.Teams.Visitor then
            local v126 = RunService.Heartbeat:Wait();
            v125 = v125 + v126 * 10;

            if v125 >= 360 then
                v125 = v125 - 360;
            end;

            for _, v in Children do
                v.CFrame = CFrame.new(v.Position) * CFrame.fromEulerAngles(0, math.rad(v125), 0);
            end;

            local ToSpin = workspace.Lobby.Spinwheel.ToSpin;
            ToSpin.CFrame = ToSpin.CFrame * CFrame.fromEulerAngles(0, 0, (math.rad(v126 * 35)));

            for _, child in Limiteds:GetChildren() do
                if child:IsA("Model") then
                    local Bone = child.Basketballs.Bone;
                    Bone.CFrame = Bone.CFrame * CFrame.fromEulerAngles(0, math.rad(v126 * 35), 0);
                    local v127 = child.Basketballs["Bone.001"];
                    v127.CFrame = v127.CFrame * CFrame.fromEulerAngles(0, math.rad(v126 * -35), 0);
                    local v128 = child.Basketballs["Bone.002"];
                    v128.CFrame = v128.CFrame * CFrame.fromEulerAngles(0, math.rad(v126 * -35), 0);
                end;
            end;
        end;
    end;
end;

function u4.KnitInit(p129) -- Line: 1059
    -- upvalues: LocalPlayer (copy), u1 (ref), u2 (ref), HumanoidRootPart (ref)
    LocalPlayer.CharacterAdded:Connect(function(p130) -- Line: 1060
        -- upvalues: u1 (ref), u2 (ref), HumanoidRootPart (ref)
        u1 = p130;
        u2 = u1:WaitForChild("Humanoid");
        HumanoidRootPart = u1:WaitForChild("HumanoidRootPart");
    end);
end;

return u4;
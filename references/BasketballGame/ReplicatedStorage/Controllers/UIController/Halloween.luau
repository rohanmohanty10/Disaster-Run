 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ContextActionService = game:GetService("ContextActionService");
local RunService = game:GetService("RunService");
local SoundService = game:GetService("SoundService");
local TweenService = game:GetService("TweenService");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Trove = require(ReplicatedStorage.Shared.Utility.Trove);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Halloween = require(ReplicatedStorage.Shared.Tables.Halloween);
local Customization = require(ReplicatedStorage.Shared.Tables.Customization);
local HalloweenPresentation = require(ReplicatedStorage.Shared.Utility.HalloweenPresentation);
local HalloweenPickups = require(ReplicatedStorage.Shared.Utility.HalloweenPickups);
local LocalPlayer = Players.LocalPlayer;
local u1 = nil;
local u2 = nil;
local v3 = Knit.CreateController({
    Name = "HalloweenController"
});

function v3.IsAvailable(p4) -- Line: 25
    -- upvalues: LocalPlayer (copy), Halloween (copy), u1 (ref)
    local Spectate = LocalPlayer.PlayerGui:FindFirstChild("Spectate");
    local Enabled = Halloween.Enabled;

    if Enabled then
        if LocalPlayer:GetAttribute("HalloweenActive") == true and (u1.Loaded == true and LocalPlayer.Team == game.Teams.Visitor) then
            Enabled = not (game.ReplicatedFirst.InLoadingScreen.Value or workspace:FindFirstChild("CamRig"));

            if Enabled then
                if Spectate then
                    Spectate = Spectate.Enabled;
                end;

                Enabled = not Spectate;
            end;
        else
            Enabled = false;
        end;
    end;

    return Enabled;
end;

function v3.PlaySound(p5, p6, p7) -- Line: 33
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), SoundService (copy)
    local v8 = ({
        OpenMusic = "Open",
        EvilChime = "Chime",
        UIClick = "Click",
        UIHover = "HoverUI"
    })[p6] or p6;
    local v9 = ReplicatedStorage.Assets.SFX.UI.Halloween:FindFirstChild(v8) or ReplicatedStorage.Assets.SFX.UI:FindFirstChild(v8);

    if v9 then
        local v10 = SfxManager:playSound({
            Duration = 20,
            Sound = v9,
            Parent = SoundService
        });

        if v10 and p7 then
            v10.PlaybackSpeed = p7;
        end;

        if v10 and (p5.Presentation and p5.Presentation.IsOpen()) then
            p5.Audio:Add(v10);
        end;

        return v10;
    end;
end;

function v3.ClearRewardPreview(p11, p12) -- Line: 45
    local RewardPreview = p12:FindFirstChild("RewardPreview");

    if RewardPreview then
        RewardPreview:Destroy();
    end;

    p12.ImageTransparency = 0;
end;

function v3.RenderReward(p13, p14, p15) -- Line: 51
    -- upvalues: Customization (copy), Knit (copy), ReplicatedStorage (copy)
    p13:ClearRewardPreview(p14);

    if not p15 then
        return;
    end;

    local v16 = p15.Item and Customization[p15.Category];

    if v16 then
        v16 = v16[p15.Item];
    end;

    local Icon = p15.Icon;

    if Icon then
        v16 = Icon;
    elseif v16 then
        v16 = v16.IconId or v16.Icon;
    end;

    if typeof(v16) == "number" and v16 > 0 then
        p14.Image = "rbxassetid://" .. tostring(v16);
    elseif typeof(v16) == "string" and v16 ~= "" then
        p14.Image = v16;
    end;

    if p15.Category == "GoalEffects" then
        local v17 = Knit.GetController("Shop").GoalIcons[p15.Item];

        if v17 then
            p14.Image = v17;
        end;
    else
        if p15.Category == "Candy" then
            p14.Image = p13.Frame.CandyFrame.Icon.Image;

            return;
        end;

        if p15.Category == "Cards" then
            local v18 = ReplicatedStorage.Assets.Cards:FindFirstChild(p15.Item);
            local v19 = v18 and v18:FindFirstChild("DesignHolder") and v18.DesignHolder:FindFirstChild("Design");

            if v19 and v19:IsA("ImageLabel") then
                p14.Image = v19.Image;
            end;
        elseif p15.Category == "Emotes" then
            local v20 = p15.PreviewAnimation or p15.Item;
            local v21 = ReplicatedStorage.Assets.EmoteAnimations:FindFirstChild(v20);
            local v22 = v21 and v21:IsA("Animation") and tonumber(v21.AnimationId:match("%d+$"));

            if not v22 or v22 <= 0 then
                return;
            end;

            local Controller = Knit.GetController("EmotesController");
            local v23 = Controller.CharacterRig or ReplicatedStorage.Assets.Misc.TemplateRig;
            local ViewportFrame = Instance.new("ViewportFrame");
            ViewportFrame.Name = "RewardPreview";
            ViewportFrame.Size = UDim2.fromScale(1, 1);
            ViewportFrame.BackgroundTransparency = 1;
            ViewportFrame.Ambient = Color3.new(1, 1, 1);
            ViewportFrame.LightColor = Color3.new(1, 1, 1);
            ViewportFrame.Active = false;
            ViewportFrame.ZIndex = p14.ZIndex;
            ViewportFrame.Parent = p14;
            p14.ImageTransparency = 1;
            Controller:CreatePreview(p15.Item, ViewportFrame, v23, v20);
        end;
    end;
end;

function v3.Show(u24) -- Line: 94
    -- upvalues: LocalPlayer (copy), u1 (ref), SoundService (copy), TweenService (copy), ReplicatedStorage (copy), ContextActionService (copy)
    u24.Gui.Enabled = true;
    local Misc = LocalPlayer.PlayerGui:FindFirstChild("Misc");

    if Misc and u24.PopupDisplayOrder == nil then
        u24.PopupDisplayOrder = Misc.DisplayOrder;
        Misc.DisplayOrder = math.max(Misc.DisplayOrder, u24.Gui.DisplayOrder + 1);
    end;

    u24.HudWasEnabled = LocalPlayer.PlayerGui.HUD.Enabled;
    LocalPlayer.PlayerGui.HUD.Enabled = false;
    u1:Focus(true, u24.Frame);

    if u24.MusicRestore then
        u24.MusicRestore:Cancel();
        u24.MusicRestore = nil;
    end;

    if u24.MusicVolume == nil then
        u24.MusicVolume = SoundService.AllMusic.Music.Volume;
    end;

    TweenService:Create(SoundService.AllMusic.Music, TweenInfo.new(0.25), {
        Volume = 0
    }):Play();
    local v25 = ReplicatedStorage.Assets.SFX.UI.Halloween.Music:Clone();
    v25.Looped = false;
    v25.SoundGroup = SoundService.AllMusic;
    v25.Volume = 0.35;
    v25.Parent = SoundService;
    u24.Music = u24.Audio:Add(v25);
    v25:Play();
    ContextActionService:BindActionAtPriority("CloseHalloween", function(p26, p27) -- Line: 117
        -- upvalues: u24 (copy)
        if p27 == Enum.UserInputState.Begin then
            u24:Close();
        end;

        return Enum.ContextActionResult.Sink;
    end, false, Enum.ContextActionPriority.High.Value, Enum.KeyCode.Escape, Enum.KeyCode.ButtonB);
end;

function v3.Hide(u28) -- Line: 123
    -- upvalues: ContextActionService (copy), TweenService (copy), SoundService (copy), u1 (ref), LocalPlayer (copy)
    u28.Restoring = true;
    ContextActionService:UnbindAction("CloseHalloween");
    u28.Audio:Clean();
    u28.Music = nil;

    if u28.MusicVolume ~= nil then
        local u29 = TweenService:Create(SoundService.AllMusic.Music, TweenInfo.new(0.25), {
            Volume = u28.MusicVolume
        });
        u28.MusicRestore = u29;
        u29.Completed:Once(function(p30) -- Line: 131
            -- upvalues: u28 (copy), u29 (copy)
            if p30 == Enum.PlaybackState.Completed and u28.MusicRestore == u29 then
                u28.MusicVolume = nil;
                u28.MusicRestore = nil;
            end;
        end);
        u29:Play();
    end;

    if u1.FocusedUI == u28.Frame then
        u1:Focus(false);
    end;

    if u28.HudWasEnabled and LocalPlayer.Team == game.Teams.Visitor then
        LocalPlayer.PlayerGui.HUD.Enabled = true;
    end;

    u28.HudWasEnabled = nil;
    u28.Gui.Enabled = false;
    local Misc = LocalPlayer.PlayerGui:FindFirstChild("Misc");

    if Misc and u28.PopupDisplayOrder ~= nil then
        Misc.DisplayOrder = u28.PopupDisplayOrder;
    end;

    u28.PopupDisplayOrder = nil;
    u28.Restoring = false;
end;

function v3.Open(p31) -- Line: 153
    -- upvalues: u1 (ref)
    if p31.Opening or (p31.Presentation.IsOpen() or (u1.FocusOpen or not p31:IsAvailable())) then
        return;
    end;

    p31.Opening = true;
    p31:UpdateState();
    p31.Opening = false;
    p31.Presentation.Open();
end;

function v3.Close(p32, p33) -- Line: 161
    -- upvalues: TweenService (copy)
    if not p33 and p32.Presentation.CloseOverlay() then
        return;
    end;

    if p33 or p32.Presentation.IsAnimating() then
        p32.Presentation.ForceClose();

        return;
    end;

    if p32.Presentation.IsOpen() then
        if p32.Music then
            TweenService:Create(p32.Music, TweenInfo.new(0.2), {
                Volume = 0
            }):Play();
        end;

        p32.Presentation.Close();
    end;
end;

function v3.IsOfferOwned(p34, p35) -- Line: 171
    if not p35 or p35.Rewards then
        return false;
    end;

    local v36 = p34.Network and p34.Network.Player;
    local u37 = v36 and v36.Customization and v36.Customization.Inventory;

    if not u37 then
        return false;
    end;

    local function owns(p38) -- Line: 176
        -- upvalues: u37 (copy)
        local v39;

        if p38 then
            v39 = u37[p38.Category];
        else
            v39 = p38;
        end;

        if p38 then
            if p38.Item == nil or typeof(v39) ~= "table" then
                p38 = false;
            else
                p38 = table.find(v39, p38.Item) ~= nil;
            end;
        end;

        return p38;
    end;

    if p35.Grants then
        if #p35.Grants == 0 then
            return false;
        end;

        for _, v in p35.Grants do
            local v40;

            if v then
                v40 = u37[v.Category];
            else
                v40 = v;
            end;

            local v41;

            if v then
                if v.Item == nil or typeof(v40) ~= "table" then
                    v41 = false;
                else
                    v41 = table.find(v40, v.Item) ~= nil;
                end;
            else
                v41 = v;
            end;

            if not v41 then
                return false;
            end;
        end;

        return true;
    end;

    local Reward = p35.Reward;
    local v42;

    if Reward then
        v42 = u37[Reward.Category];
    else
        v42 = Reward;
    end;

    if Reward then
        if Reward.Item == nil or typeof(v42) ~= "table" then
            Reward = false;
        else
            Reward = table.find(v42, Reward.Item) ~= nil;
        end;
    end;

    return Reward == true;
end;

function v3.Purchase(p43, p44, p45) -- Line: 190
    -- upvalues: Effects (copy), Halloween (copy), LocalPlayer (copy), u2 (ref)
    if p43.PurchasePending or p43.Presentation.IsUnboxing() then
        return;
    end;

    if not p44 then
        return;
    end;

    if p43:IsOfferOwned(p44) then
        Effects:Popup("You already own this reward. Nothing was spent.");

        return;
    end;

    if p45 == nil or p45 == "Candy" then
        local v46;

        if p44 == Halloween.CandyChest then
            v46 = LocalPlayer:GetAttribute("HalloweenChestCredits");
        else
            v46 = p44 ~= Halloween.Broom and 0 or LocalPlayer:GetAttribute("HalloweenBroomCredits");
        end;

        p45 = (v46 or 0) > 0 and "Credit" or "Candy";
    end;

    if p45 ~= "Credit" and not p44.Enabled then
        Effects:Popup("This item is coming soon.");

        return;
    end;

    if p45 ~= "Credit" and (p44.RequiresDaily ~= false and LocalPlayer:GetAttribute("HalloweenUnlocked") ~= true) then
        Effects:Popup("Finish your daily quests first.");

        return;
    end;

    p43.PurchasePending = true;

    if p45 == "Robux" then
        local v47, v48, v49 = pcall(u2.PromptPurchase, u2, p44.Id);
        p43.PurchasePending = false;

        if not (v47 and v48) then
            Effects:Popup(v49 or "Couldn\'t open the purchase prompt.");
        end;

        return;
    end;

    local v50, v51, v52, v53 = pcall(u2.Purchase, u2, p44.Id, p45);
    p43.PurchasePending = false;

    if not (v50 and v51) then
        Effects:Popup(v50 and v52 and v52 or "Couldn\'t complete the purchase. Please try again.");

        return;
    end;

    if v53 and (p44.Rewards and p43.Presentation.IsOpen()) then
        p43.Presentation.PlayUnboxing(v53.Icon, v53.Name, p44, v53);

        return;
    end;

    Effects:Popup("Purchased " .. tostring(p44.ItemName or (v53 and v53.Name or "item")) .. "!", 2.5, Color3.fromRGB(125, 255, 150));
end;

function v3.UpdateState(p54) -- Line: 229
    -- upvalues: LocalPlayer (copy)
    p54.Presentation.SetCandy(LocalPlayer:GetAttribute("HalloweenCandy") or 0);
    p54.Presentation.SetChestCredits(LocalPlayer:GetAttribute("HalloweenChestCredits") or 0);
    p54.Presentation.SetBroomCredits(LocalPlayer:GetAttribute("HalloweenBroomCredits") or 0);
    local v55 = LocalPlayer:GetAttribute("HalloweenUnlocked") == true;

    if p54.Unlocked ~= v55 then
        p54.Unlocked = v55;
        p54.Presentation.SetLocked(not v55);
    end;
end;

function v3.UpdateArea(p56, p57) -- Line: 240
    -- upvalues: LocalPlayer (copy)
    local TouchingParts = workspace:FindFirstChild("TouchingParts");

    if TouchingParts then
        TouchingParts = TouchingParts:FindFirstChild("StyleQuests");
    end;

    local Character = LocalPlayer.Character;
    local v58;

    if Character then
        v58 = Character:FindFirstChild("HumanoidRootPart");
    else
        v58 = Character;
    end;

    if Character then
        Character = Character:FindFirstChildOfClass("Humanoid");
    end;

    local v59;

    if p57 and (TouchingParts and (TouchingParts:IsA("BasePart") and (v58 and (Character and Character.Health > 0)))) then
        local v60 = TouchingParts.CFrame:PointToObjectSpace(v58.Position);
        local v61 = TouchingParts.Size / 2;

        if math.abs(v60.X) <= v61.X and math.abs(v60.Y) <= v61.Y then
            v59 = math.abs(v60.Z) <= v61.Z;
        else
            v59 = false;
        end;
    else
        v59 = false;
    end;

    local v62;

    if v59 then
        v62 = not p56.InEventArea;
    else
        v62 = v59;
    end;

    p56.InEventArea = v59;

    if v62 then
        p56:Open();
    end;
end;

function v3.KnitStart(u63) -- Line: 257
    -- upvalues: u1 (ref), Knit (copy), u2 (ref), LocalPlayer (copy), Trove (copy), HalloweenPresentation (copy), Halloween (copy), HalloweenPickups (copy), RunService (copy)
    u1 = Knit.GetController("UIController");
    u63.Network = Knit.GetController("Network");
    u2 = Knit.GetService("HalloweenService");
    u63.Gui = LocalPlayer.PlayerGui:WaitForChild("Halloween");
    u63.Frame = u63.Gui.HalloweenEvent;
    u63.Button = LocalPlayer.PlayerGui:WaitForChild("HUD"):WaitForChild("Bundles"):WaitForChild("HalloweenButton");
    u63.Audio = Trove.new();
    u63.Presentation = HalloweenPresentation(u63.Gui, u63.Button, {
        Catalog = Halloween,

        Open = function() -- Line: 267, Name: Open
            -- upvalues: u63 (copy)
            u63:Open();
        end,

        Close = function() -- Line: 268, Name: Close
            -- upvalues: u63 (copy)
            u63:Close();
        end,

        Hide = function() -- Line: 269, Name: Hide
            -- upvalues: u63 (copy)
            u63:Show();
        end,

        Show = function() -- Line: 270, Name: Show
            -- upvalues: u63 (copy)
            u63:Hide();
        end,

        Sound = function(p64) -- Line: 271, Name: Sound
            -- upvalues: u63 (copy)
            return u63:PlaySound(p64);
        end,

        RenderReward = function(p65, p66) -- Line: 272, Name: RenderReward
            -- upvalues: u63 (copy)
            u63:RenderReward(p65, p66);
        end,

        ClearRewardPreview = function(p67) -- Line: 273, Name: ClearRewardPreview
            -- upvalues: u63 (copy)
            u63:ClearRewardPreview(p67);
        end
    });
    u63.Presentation.Init();
    task.spawn(function() -- Line: 276
        -- upvalues: Halloween (ref), u63 (copy)
        local v68 = {};

        for _, v in Halloween.Offers do
            if v.RobuxEnabled and (v.ProductId and (v.ProductId > 0 and not v68[v.ProductId])) then
                v68[v.ProductId] = true;
                local GetProductInfoAsync = game:GetService("MarketplaceService").GetProductInfoAsync;
                local MarketplaceService = game:GetService("MarketplaceService");
                local success, result = pcall(GetProductInfoAsync, MarketplaceService, v.ProductId, Enum.InfoType.Product);

                if success and typeof(result.PriceInRobux) == "number" then
                    u63.Presentation.SetRobuxPrice(v.ProductId, result.PriceInRobux);
                end;
            end;
        end;
    end);
    u63:UpdateState();

    for _, v in ipairs({ "HalloweenCandy", "HalloweenUnlocked", "HalloweenChestCredits", "HalloweenBroomCredits" }) do
        LocalPlayer:GetAttributeChangedSignal(v):Connect(function() -- Line: 290
            -- upvalues: u63 (copy)
            u63:UpdateState();
        end);
    end;

    u63.Presentation.PurchaseRequested:Connect(function(p69, p70, p71) -- Line: 292
        -- upvalues: Halloween (ref), u63 (copy)
        local v72 = Halloween.Rows[p69];

        if v72 then
            v72 = v72[p70];
        end;

        u63:Purchase(v72, p71);
    end);
    u63.Presentation.BatChestPressed:Connect(function() -- Line: 296
        -- upvalues: Halloween (ref), u63 (copy)
        if Halloween.Chest.Enabled ~= true then
            return;
        end;

        u63:Purchase(Halloween.Chest);
    end);
    u63.Gui:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 300
        -- upvalues: u63 (copy)
        if not (u63.Gui.Enabled or u63.Restoring) then
            u63:Close(true);
        end;
    end);
    LocalPlayer.CharacterRemoving:Connect(function() -- Line: 303
        -- upvalues: u63 (copy)
        u63:Close(true);
    end);
    u63.PickupPresentation = HalloweenPickups(LocalPlayer.PlayerGui:WaitForChild("HalloweenPickups"), {
        PlaySound = function(p73, p74) -- Line: 305, Name: PlaySound
            -- upvalues: u63 (copy)
            u63:PlaySound(p73, p74);
        end
    });
    u2.CreditGranted:Connect(function(p75) -- Line: 307
        -- upvalues: Halloween (ref), u63 (copy)
        local Offer = Halloween.GetOffer(p75);

        if Offer then
            u63:Purchase(Offer, "Credit");
        end;
    end);
    u2.Collected:Connect(function(p76, p77, p78) -- Line: 311
        -- upvalues: u63 (copy)
        u63.PickupPresentation.Collected(p76, p77, p78);
    end);
    local u79 = 0;
    RunService.Heartbeat:Connect(function(p80) -- Line: 315
        -- upvalues: u79 (ref), u63 (copy), u1 (ref)
        u79 = u79 + p80;

        if u79 < 0.2 then
            return;
        end;

        u79 = 0;
        local v81 = u63:IsAvailable();
        u63:UpdateArea(v81);
        local v82 = u63.Presentation.IsOpen();
        u63.Button.Visible = v81 and not v82 and not u1.FocusOpen;

        if v82 and (not v81 or u1.FocusedUI ~= u63.Frame) then
            u63:Close(true);
        end;
    end);
end;

return v3;
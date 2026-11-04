 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local MarketplaceService = game:GetService("MarketplaceService");
local Players = game:GetService("Players");
local AvatarEditorService = game:GetService("AvatarEditorService");
local LocalPlayer = Players.LocalPlayer;
local Mouse = LocalPlayer:GetMouse();
local Knit = require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.Essentials);
local Trove = require(ReplicatedStorage.Shared.Utility.Trove);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local CustomScrollbar = require(ReplicatedStorage.Shared.Utility.CustomScrollbar);
local Rarities = require(ReplicatedStorage.Shared.Tables.Rarities);
local Customization = require(ReplicatedStorage.Shared.Tables.Customization);
local GetHumDescription = require(ReplicatedStorage.Shared.Utility.GetHumDescription);
require(ReplicatedStorage.Shared.Functions.CalculateBallTrajectory);
local u1 = nil;
local u2 = nil;
local u3 = nil;
local u4 = Trove.new();
local u5 = nil;
local u6 = CFrame.new(40.914, 3.75, -187.839) * CFrame.fromEulerAnglesXYZ(0, 0.09754645189396309, 0);
local CFrame_new_ret = CFrame.new(37.635, 0.908, -194.194);
local CFrame_lookAlong_ret = CFrame.lookAlong(CFrame_new_ret.Position, u6.Position * Vector3.new(1, 0, 1) - CFrame_new_ret.Position * Vector3.new(1, 0, 1));
local u7 = Knit.CreateController({
    Name = "LockerController"
});
local u8 = nil;

function u7.GetSearchString(p9) -- Line: 38
    -- upvalues: LocalPlayer (copy)
    return string.lower(LocalPlayer.PlayerGui.Locker.Content.Search.Text);
end;

function u7.OnSearchChanged(p10: table, u11: function) -- Line: 44
    -- upvalues: LocalPlayer (copy), u7 (copy)
    LocalPlayer.PlayerGui.Locker.Content.Search:GetPropertyChangedSignal("Text"):Connect(function() -- Line: 47
        -- upvalues: u11 (copy), u7 (ref)
        u11(u7:GetSearchString());
    end);
end;

function u7.UpdateSubMenu(p12: table, p13: string?) -- Line: 52
    -- upvalues: u3 (ref), u4 (copy), LocalPlayer (copy), TweenService (copy), u6 (copy), u5 (ref), CustomScrollbar (copy)
    if u3 then
        u3.Visible = false;
        u3 = nil;
        u4:Clean();
    end;

    if p13 == nil then
        return;
    end;

    local v14 = LocalPlayer.PlayerGui.Locker.Content.Content:FindFirstChild(p13);

    if LocalPlayer.PlayerGui.Locker.Enabled then
        TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            CFrame = u6
        }):Play();
    end;

    if not v14 then
        return;
    end;

    if p13 == "GoalEffects" then
        TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            CFrame = workspace.GoalEffectsCam.CFrame
        }):Play();
    elseif p13 == "ShotEffects" then
        TweenService:Create(workspace.CurrentCamera, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            CFrame = workspace.ShotEffectsCam.CFrame
        }):Play();
    end;

    v14.Visible = true;
    local Scrollbar = LocalPlayer.PlayerGui.Locker.Content.Content.Scrollbar;

    if u5 ~= nil then
        u5:Destroy();
        u5 = nil;
    end;

    if v14:IsA("ScrollingFrame") then
        Scrollbar.Visible = true;
        u5 = CustomScrollbar.new(v14, Scrollbar);
        u5:Start();
    else
        Scrollbar.Visible = false;
    end;

    u3 = v14;
end;

function u7.SetupSubMenuButtons(p15) -- Line: 103
    -- upvalues: LocalPlayer (copy), u7 (copy), u3 (ref)
    for _, child in LocalPlayer.PlayerGui.Locker.Content.Categories:GetChildren() do
        if child:IsA("GuiButton") then
            child.MouseButton1Click:Connect(function() -- Line: 109
                -- upvalues: u7 (ref), u3 (ref), child (copy)
                local v16;

                if u3 == child.Name then
                    v16 = nil;
                else
                    v16 = child.Name or nil;
                end;

                u7:UpdateSubMenu(v16);
            end);
        end;
    end;
end;

function u7.ColorRngInit(p17) -- Line: 115
    -- upvalues: LocalPlayer (copy), u1 (ref), ReplicatedStorage (copy), u2 (ref), Knit (copy)
    local ColorRng = LocalPlayer.PlayerGui.Locker.Content.Content.ColorRng;

    local function UpdatePreviews() -- Line: 118
        -- upvalues: u1 (ref), ColorRng (copy)
        local BallTrailColor = u1.Player.Customization.BallTrailColor;
        local v18 = BallTrailColor == "" and Color3.fromHSV(1, 0, 1) or Color3.fromHex(BallTrailColor);
        ColorRng.TrailColor.Preview.BackgroundColor3 = v18;
        ColorRng.TrailColor.Title.Text = `Ball Trail Color ({u1.Player.TrailColorSpins} Spins Left)`;
        local ZoneColor = u1.Player.Customization.ZoneColor;
        local v19 = ZoneColor == "" and Color3.fromHSV(1, 0, 1) or Color3.fromHex(ZoneColor);
        ColorRng.ZoneColor.Preview.BackgroundColor3 = v19;
        ColorRng.ZoneColor.Title.Text = `Zone Color ({u1.Player.ZoneColorSpins} Spins Left)`;
    end;

    ReplicatedStorage.Controllers.NewData.Changed:Connect(UpdatePreviews);
    task.spawn(UpdatePreviews);
    ColorRng.TrailColor.Buttons.Reroll.MouseButton1Click:Connect(function() -- Line: 139
        -- upvalues: u2 (ref)
        u2:RandomizeTrailColor();
    end);
    ColorRng.TrailColor.Buttons.Gift.MouseButton1Click:Connect(function() -- Line: 142
        -- upvalues: Knit (ref)
        Knit.GetController("GiftingController").PromptGiftPlayer(2782446755);
    end);
    ColorRng.ZoneColor.Buttons.Reroll.MouseButton1Click:Connect(function() -- Line: 147
        -- upvalues: u2 (ref)
        u2:RandomizeZoneColor();
    end);
    ColorRng.ZoneColor.Buttons.Gift.MouseButton1Click:Connect(function() -- Line: 150
        -- upvalues: Knit (ref)
        Knit.GetController("GiftingController").PromptGiftPlayer(3403078506);
    end);
end;

function u7.ColorWheelInit(p20) -- Line: 156
    -- upvalues: LocalPlayer (copy), u4 (copy), RunService (copy), Mouse (copy), UserInputService (copy), Knit (copy)
    local ColorWheel = LocalPlayer.PlayerGui.Locker.Content.Content.ColorWheel;
    local u21 = 1;
    local u22 = 1;
    local u23 = 1;

    local function StartUpdatingValue() -- Line: 161
        -- upvalues: u4 (ref), RunService (ref), ColorWheel (copy), Mouse (ref), u23 (ref), u21 (ref), u22 (ref), UserInputService (ref)
        local u26 = u4:Add(RunService.Heartbeat:Connect(function() -- Line: 162
            -- upvalues: ColorWheel (ref), Mouse (ref), u23 (ref), u21 (ref), u22 (ref)
            local Y = ColorWheel.Value.AbsolutePosition.Y;
            local v24 = Y + ColorWheel.Value.AbsoluteSize.Y;
            local v25 = (math.clamp(Mouse.Y, Y, v24) - Y) / (v24 - Y);
            ColorWheel.Value.Bar.Position = UDim2.fromScale(0.5, v25);
            u23 = 1 - v25;
            ColorWheel.Preview.BackgroundColor3 = Color3.fromHSV(u21, u22, u23);
        end));
        local u27 = nil;
        u27 = u4:Add(UserInputService.InputEnded:Connect(function(p28) -- Line: 176
            -- upvalues: u4 (ref), u26 (copy), u27 (ref)
            if p28.UserInputType ~= Enum.UserInputType.MouseButton1 and p28.UserInputType ~= Enum.UserInputType.Touch then
                return;
            end;

            u4:Remove(u26);
            u4:Remove(u27);
        end));
    end;

    local function StartUpdatingHueSat() -- Line: 186
        -- upvalues: u4 (ref), RunService (ref), ColorWheel (copy), Mouse (ref), u21 (ref), u22 (ref), u23 (ref), UserInputService (ref)
        local u36 = u4:Add(RunService.Heartbeat:Connect(function() -- Line: 187
            -- upvalues: ColorWheel (ref), Mouse (ref), u21 (ref), u22 (ref), u23 (ref)
            local AbsoluteSize = ColorWheel.Wheel.Background.AbsoluteSize;
            local v29 = ColorWheel.Wheel.Background.AbsolutePosition + AbsoluteSize * 0.5;
            local v30 = v29 - AbsoluteSize * 0.5;
            local v31 = v29 + AbsoluteSize * 0.5;
            local v32 = Vector2.new(Mouse.X, Mouse.Y):Min(v31):Max(v30);

            if (v32 - v29).Magnitude > AbsoluteSize.Y * 0.5 then
                v32 = v29 + (v32 - v29).Unit * AbsoluteSize.Y * 0.5;
            end;

            local v33 = (v32 - v30) / (v31 - v30);
            ColorWheel.Wheel.Background.Cursor.Position = UDim2.fromScale(v33.X, v33.Y);
            local v34 = v32 - v29;
            local v35 = 1 - (3.141592653589793 - math.atan2(v34.Y, v34.X)) / 6.283185307179586;
            u21 = math.clamp(v35, 0, 1);
            u22 = math.clamp(v34.Magnitude / (AbsoluteSize.Y * 0.5), 0, 1);
            ColorWheel.Preview.BackgroundColor3 = Color3.fromHSV(u21, u22, u23);
        end));
        local u37 = nil;
        u37 = u4:Add(UserInputService.InputEnded:Connect(function(p38) -- Line: 211
            -- upvalues: u4 (ref), u36 (copy), u37 (ref)
            if p38.UserInputType ~= Enum.UserInputType.MouseButton1 and p38.UserInputType ~= Enum.UserInputType.Touch then
                return;
            end;

            u4:Remove(u36);
            u4:Remove(u37);
        end));
    end;

    ColorWheel.Wheel.Background.MouseButton1Down:Connect(function() -- Line: 221
        -- upvalues: StartUpdatingHueSat (copy)
        StartUpdatingHueSat();
    end);
    ColorWheel.Value.Background.MouseButton1Down:Connect(function() -- Line: 225
        -- upvalues: StartUpdatingValue (copy)
        StartUpdatingValue();
    end);
    ColorWheel.Value.Bar.MouseButton1Down:Connect(function() -- Line: 228
        -- upvalues: StartUpdatingValue (copy)
        StartUpdatingValue();
    end);
    LocalPlayer:WaitForChild("BallTrailColor").Changed:Connect(function() -- Line: 232
        -- upvalues: LocalPlayer (ref), ColorWheel (copy), u21 (ref), u22 (ref), u23 (ref)
        local Value = LocalPlayer.BallTrailColor.Value;
        local v39 = Value == "" and Color3.fromHSV(1, 1, 1) or Color3.fromHex(Value);
        ColorWheel.Preview.BackgroundColor3 = v39;
        local v40, v41, v42 = v39:ToHSV();
        u21 = v40;
        u22 = v41;
        u23 = v42;
    end);
    ColorWheel.Save.MouseButton1Click:Connect(function() -- Line: 241
        -- upvalues: Knit (ref), u21 (ref), u22 (ref), u23 (ref)
        Knit.GetService("CustomizationService").UpdateBasketBallTrail:Fire(Color3.fromHSV(u21, u22, u23));
    end);
    ColorWheel.Reset.MouseButton1Click:Connect(function() -- Line: 244
        -- upvalues: Knit (ref)
        Knit.GetService("CustomizationService").UpdateBasketBallTrail:Fire(nil);
    end);
end;

function u7.EmotesInit(p43) -- Line: 249
    -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy), Trove (copy), u1 (ref), Knit (copy), Customization (copy), u7 (copy), Rarities (copy)
    local Emotes = LocalPlayer.PlayerGui.Locker.Content.Content.Emotes;
    local _ = ReplicatedStorage.Assets.EmoteAnimations;
    local u44 = Trove.new();

    local function IsEmoteEquipped(p45: string) -- Line: 255
        -- upvalues: u1 (ref)
        for i = 1, 8 do
            if u1.Player.Customization.Equipped.Emotes[`Emotes{i}`] and u1.Player.Customization.Equipped.Emotes[`Emotes{i}`] == p45 then
                return true, i;
            end;

            local _ = i;
        end;

        return false, -1;
    end;

    local u46 = nil;

    function u7.UpdateEmoteItems(p47) -- Line: 267
        -- upvalues: Emotes (copy), u44 (copy), Knit (ref), u1 (ref), Customization (ref), IsEmoteEquipped (copy), u7 (ref), ReplicatedStorage (ref), u46 (ref), Rarities (ref)
        for _, child in Emotes:GetChildren() do
            if child:IsA("GuiButton") then
                child:Destroy();
            end;
        end;

        u44:Clean();
        local Controller = Knit.GetController("EmotesController");

        while not Controller.CharacterRig do
            task.wait();
        end;

        local v48 = {
            Rare = 5,
            Epic = 4,
            Legendary = 3,
            Mythic = 2,
            Limited = 1
        };

        for _, v in u1.Player.Customization.Inventory.Emotes do
            local v49 = Customization.Emotes[v];

            if v49 then
                local u50 = script.EmoteItem:Clone();
                u50:WaitForChild("TextLabel").Text = v;
                u50.LayoutOrder = v48[v49.Rarity] + (IsEmoteEquipped(v) and -1000000 or 0);
                u50.Name = v;
                u50.Parent = Emotes;
                Controller:CreatePreview(v, u50:WaitForChild("ViewportFrame"), Controller.CharacterRig);
                u44:Add(u50.MouseButton1Click:Connect(function() -- Line: 307
                    -- upvalues: u7 (ref), ReplicatedStorage (ref), v (copy), u46 (ref), u44 (ref), u50 (copy)
                    if u7.LockerRig then
                        for _, v2 in u7.LockerRig.Humanoid.Animator:GetPlayingAnimationTracks() do
                            v2:Stop(0);
                        end;

                        local v51 = ReplicatedStorage.Assets.EmoteAnimations:FindFirstChild(v);
                        local v52 = u7.LockerRig.Humanoid.Animator:LoadAnimation(v51);
                        v52.Looped = false;
                        v52:Play(0);
                    end;

                    u7.LastSelectedEmote = v;

                    if u46 then
                        u44:Remove(u46);
                    end;

                    local v53 = u44:Add(script.SelectedEmote:Clone());
                    v53.Parent = u50;
                    u46 = v53;
                end));
                u50.ImageColor3 = IsEmoteEquipped(u50.Name) and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 255, 255);
                u50.LockerItem_Outline.UIGradient.Color = ColorSequence.new(Rarities.Colors[v49.Rarity]);
            else
                warn((`config doesn't exist for emote '{v}'`));
            end;
        end;
    end;

    u7:OnSearchChanged(function(p54: string) -- Line: 342
        -- upvalues: Emotes (copy)
        for _, child in Emotes:GetChildren() do
            if child:IsA("GuiButton") then
                child.Visible = string.find(string.lower(child.TextLabel.Text), p54) ~= nil;
            end;
        end;
    end);
    Emotes:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 352
        -- upvalues: Emotes (copy), u7 (ref), LocalPlayer (ref), Knit (ref)
        if Emotes.Visible == false and u7.LockerRig then
            for _, v in u7.LockerRig.Humanoid.Animator:GetPlayingAnimationTracks() do
                v:Stop(0);
            end;

            u7.LockerRigIdleTrack:Play(0);
        end;

        if LocalPlayer.PlayerGui.Locker.Enabled and Emotes.Visible then
            u7.LastSelectedEmote = nil;
            u7:UpdateEmoteItems();
        end;

        local Controller = Knit.GetController("EmotesController");
        Controller:ToggleGui(Emotes.Visible and LocalPlayer.PlayerGui.Locker.Enabled, true);
    end);
    LocalPlayer.PlayerGui.Locker:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 371
        -- upvalues: LocalPlayer (ref), Emotes (copy), u7 (ref), u44 (copy), Knit (ref)
        if LocalPlayer.PlayerGui.Locker.Enabled and Emotes.Visible then
            u7.LastSelectedEmote = nil;
            u7:UpdateEmoteItems();
        else
            for _, child in Emotes:GetChildren() do
                if child:IsA("GuiButton") then
                    child:Destroy();
                end;
            end;

            u44:Clean();
        end;

        local Controller = Knit.GetController("EmotesController");
        Controller:ToggleGui(Emotes.Visible and LocalPlayer.PlayerGui.Locker.Enabled, true);
    end);
end;

function u7.GoalEffectsInit(p55) -- Line: 391
    -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy), u1 (ref), u2 (ref), u7 (copy), Customization (copy), u8 (ref), Rarities (copy)
    local GoalEffects = LocalPlayer.PlayerGui.Locker.Content.Content.GoalEffects;
    local _ = ReplicatedStorage.Assets.GoalEffects;
    local u56 = {};

    function u7.EquipGoalEffect(u57: table, u58: string) -- Line: 397
        -- upvalues: ReplicatedStorage (ref), LocalPlayer (ref), u1 (ref), u2 (ref), u7 (ref)
        task.spawn(function() -- Line: 398
            -- upvalues: ReplicatedStorage (ref), u58 (copy), u57 (copy), LocalPlayer (ref)
            if ReplicatedStorage.Effects.GoalEffects.Client:FindFirstChild(u58) then
                require(ReplicatedStorage.Effects.GoalEffects.Client[u58])(u57, {
                    Locker = true,
                    Player = LocalPlayer,
                    Vfx = ReplicatedStorage.Assets.GoalEffects:FindFirstChild(u58),
                    CFrame = CFrame.new(workspace.Hoops.Away.Hoop.Position)
                });

                return;
            end;

            require(ReplicatedStorage.Effects.GoalEffects.Client.EmitEffects)(u57, {
                Locker = true,
                Player = LocalPlayer,
                Vfx = ReplicatedStorage.Assets.GoalEffects:FindFirstChild(u58),
                CFrame = CFrame.new(workspace.Hoops.Away.Hoop.Position)
            });
        end);
        u1.Player.Customization.Equipped.GoalEffects = u58;
        u2.Equip:Fire(u58, "GoalEffects");
        u7:UpdateGoalEffectItems();
    end;

    function u7.UpdateGoalEffectItems(p59) -- Line: 427
        -- upvalues: GoalEffects (copy), u56 (copy), u1 (ref), Customization (ref), u8 (ref), u7 (ref), Rarities (ref)
        for _, child in GoalEffects:GetChildren() do
            if child:IsA("GuiButton") then
                child:Destroy();
            end;
        end;

        for _, v in u56 do
            v:Disconnect();
        end;

        table.clear(u56);
        local v60 = {
            Rare = 5,
            Epic = 4,
            Legendary = 3,
            Mythic = 2,
            Limited = 1
        };

        for _, v in u1.Player.Customization.Inventory.GoalEffects do
            local v61 = Customization.GoalEffects[v];

            if v61 then
                local v62 = script.EmoteItem:Clone();
                v62:WaitForChild("TextLabel").Text = v;
                v62.LayoutOrder = v60[v61.Rarity];
                v62.Name = v;
                v62.Parent = GoalEffects;
                local GoalIcons = u8.GoalIcons;

                if GoalIcons[v] then
                    v62.Icon.Visible = true;
                    v62.Icon.Image = GoalIcons[v];
                end;

                if u1.Player.Customization.Equipped.GoalEffects == v then
                    v62.LayoutOrder = v62.LayoutOrder - 1000000;
                end;

                u56[v62] = v62.MouseButton1Click:Connect(function() -- Line: 472
                    -- upvalues: u7 (ref), v (copy)
                    u7:EquipGoalEffect(v);
                end);
                v62.ImageColor3 = u1.Player.Customization.Equipped.GoalEffects == v62.Name and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 255, 255);
                v62.LockerItem_Outline.UIGradient.Color = ColorSequence.new(Rarities.Colors[v61.Rarity]);
            else
                warn((`config doesn't exist for goal effect '{v}'`));
            end;
        end;
    end;

    u7:OnSearchChanged(function(p63: string) -- Line: 487
        -- upvalues: GoalEffects (copy)
        for _, child in GoalEffects:GetChildren() do
            if child:IsA("GuiButton") then
                child.Visible = string.find(string.lower(child.TextLabel.Text), p63) ~= nil;
            end;
        end;
    end);
    GoalEffects:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 497
        -- upvalues: u7 (ref)
        u7:UpdateGoalEffectItems();
    end);
    LocalPlayer.PlayerGui.Locker:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 499
        -- upvalues: LocalPlayer (ref), GoalEffects (copy), u56 (copy)
        if not LocalPlayer.PlayerGui.Locker.Enabled then
            for _, child in GoalEffects:GetChildren() do
                if child:IsA("GuiButton") then
                    child:Destroy();
                end;
            end;

            for _, v in u56 do
                v:Disconnect();
            end;

            table.clear(u56);
        end;
    end);
end;

function u7.ShotEffectsInit(p64) -- Line: 516
    -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy), Trove (copy), u1 (ref), u2 (ref), u7 (copy), Customization (copy), u8 (ref), Rarities (copy)
    local ShotEffects = LocalPlayer.PlayerGui.Locker.Content.Content.ShotEffects;
    local _ = ReplicatedStorage.Assets.ShotEffects;
    local u65 = Trove.new();
    local u66 = {};

    function u7.EquipShotEffect(u67: table, u68: string) -- Line: 524
        -- upvalues: u1 (ref), u65 (copy), ReplicatedStorage (ref), LocalPlayer (ref), u2 (ref), u7 (ref)
        local v69 = (u68 == u1.Player.Customization.Equipped.ShotEffects or not u68) and "" or u68;
        task.spawn(function() -- Line: 527
            -- upvalues: u65 (ref), u1 (ref), ReplicatedStorage (ref), u68 (copy), u67 (copy), LocalPlayer (ref)
            u65:Clean();
            local v70 = u65:Add(script.Basketball:Clone());
            v70.Parent = workspace.Debris;
            v70.CFrame = CFrame.new(71.57, 4, -297.507) * CFrame.Angles(0, 1.5707963267948966, 0);
            local BallTrailColor = u1.Player.Customization.BallTrailColor;
            local v71 = BallTrailColor == "" and Color3.fromHSV(1, 0, 1) or Color3.fromHex(BallTrailColor);

            for _, child in v70.Trails:GetChildren() do
                child.Color = ColorSequence.new(v71);
            end;

            local v72 = workspace.Hoops.Away.Hoop.Position - v70.Position;
            local math_log_ret = math.log(0.75 + v72.Magnitude * 0.045);
            v70.AssemblyLinearVelocity = v72 / math_log_ret + Vector3.new(0, workspace.Gravity * math_log_ret * 0.5, 0);

            if ReplicatedStorage.Effects.ShotEffects.Client:FindFirstChild(u68) then
                require(ReplicatedStorage.Effects.ShotEffects.Client[u68])(u67, {
                    Locker = true,
                    Vfx = ReplicatedStorage.Assets.ShotEffects:FindFirstChild(u68),
                    Char = LocalPlayer.Character,
                    Ball = v70
                });
            elseif ReplicatedStorage.Assets.ShotEffects:FindFirstChild(u68) and ReplicatedStorage.Assets.ShotEffects:FindFirstChild(u68):GetAttribute("Ranked") then
                require(ReplicatedStorage.Effects.ShotEffects.Client.RankedShotEffects)(u67, {
                    Locker = true,
                    Vfx = ReplicatedStorage.Assets.ShotEffects:FindFirstChild(u68),
                    Char = LocalPlayer.Character,
                    Ball = v70
                });
            else
                require(ReplicatedStorage.Effects.ShotEffects.Client.EmitEffects)(u67, {
                    Locker = true,
                    Vfx = ReplicatedStorage.Assets.ShotEffects:FindFirstChild(u68),
                    Char = LocalPlayer.Character,
                    Ball = v70
                });
            end;

            u65:Add(task.delay(1.5, function() -- Line: 581
                -- upvalues: u65 (ref)
                u65:Clean();
            end));
        end);
        u1.Player.Customization.Equipped.ShotEffects = v69;
        u2.Equip:Fire(v69, "ShotEffects");
        u7:UpdateShotEffectItems();
    end;

    function u7.UpdateShotEffectItems(p73) -- Line: 592
        -- upvalues: ShotEffects (copy), u66 (copy), u1 (ref), Customization (ref), u8 (ref), u7 (ref), Rarities (ref)
        for _, child in ShotEffects:GetChildren() do
            if child:IsA("GuiButton") then
                child:Destroy();
            end;
        end;

        for _, v in u66 do
            v:Disconnect();
        end;

        table.clear(u66);
        local v74 = {
            Rare = 5,
            Epic = 4,
            Legendary = 3,
            Mythic = 2,
            Limited = 1
        };

        for _, v in u1.Player.Customization.Inventory.ShotEffects do
            local v75 = Customization.ShotEffects[v];

            if v75 then
                local v76 = script.EmoteItem:Clone();
                v76:WaitForChild("TextLabel").Text = v;
                v76.LayoutOrder = v74[v75.Rarity];
                v76.Name = v;
                v76.Parent = ShotEffects;
                local ShotIcons = u8.ShotIcons;

                if ShotIcons[v] then
                    v76.Icon.Visible = true;
                    v76.Icon.Image = ShotIcons[v];
                end;

                if u1.Player.Customization.Equipped.ShotEffects == v then
                    v76.LayoutOrder = v76.LayoutOrder - 1000000;
                end;

                u66[v76] = v76.MouseButton1Click:Connect(function() -- Line: 637
                    -- upvalues: u7 (ref), v (copy)
                    u7:EquipShotEffect(v);
                end);
                v76.ImageColor3 = u1.Player.Customization.Equipped.ShotEffects == v76.Name and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 255, 255);
                v76.LockerItem_Outline.UIGradient.Color = ColorSequence.new(Rarities.Colors[v75.Rarity]);
            else
                warn((`config doesn't exist for goal effect '{v}'`));
            end;
        end;
    end;

    u7:OnSearchChanged(function(p77: string) -- Line: 652
        -- upvalues: ShotEffects (copy)
        for _, child in ShotEffects:GetChildren() do
            if child:IsA("GuiButton") then
                child.Visible = string.find(string.lower(child.TextLabel.Text), p77) ~= nil;
            end;
        end;
    end);
    ShotEffects:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 662
        -- upvalues: u7 (ref)
        u7:UpdateShotEffectItems();
    end);
    LocalPlayer.PlayerGui.Locker:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 664
        -- upvalues: LocalPlayer (ref), ShotEffects (copy), u66 (copy)
        if not LocalPlayer.PlayerGui.Locker.Enabled then
            for _, child in ShotEffects:GetChildren() do
                if child:IsA("GuiButton") then
                    child:Destroy();
                end;
            end;

            for _, v in u66 do
                v:Disconnect();
            end;

            table.clear(u66);
        end;
    end);
end;

function u7.CardsInit(p78) -- Line: 681
    -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy), u1 (ref), u2 (ref), u7 (copy), Customization (copy), u8 (ref), Rarities (copy)
    local Cards = LocalPlayer.PlayerGui.Locker.Content.Content.Cards;
    local _ = ReplicatedStorage.Assets.Cards;
    local u79 = {};

    function u7.EquipCard(p80: table, p81: string) -- Line: 687
        -- upvalues: u1 (ref), u2 (ref), u7 (ref)
        u1.Player.Customization.Equipped.Cards = p81;
        u2.Equip:Fire(p81, "Cards");
        u7:UpdateCards();
    end;

    function u7.UpdateCards(p82) -- Line: 694
        -- upvalues: Cards (copy), u79 (copy), u1 (ref), Customization (ref), u8 (ref), u7 (ref), Rarities (ref)
        for _, child in Cards:GetChildren() do
            if child:IsA("GuiButton") then
                child:Destroy();
            end;
        end;

        for _, v in u79 do
            v:Disconnect();
        end;

        table.clear(u79);
        local v83 = {
            Rare = 5,
            Epic = 4,
            Legendary = 3,
            Mythic = 2,
            Limited = 1
        };

        for _, v in u1.Player.Customization.Inventory.Cards do
            local v84 = Customization.Cards[v];

            if v84 then
                local v85 = script.EmoteItem:Clone();
                v85:WaitForChild("TextLabel").Text = v;
                v85.LayoutOrder = v83[v84.Rarity];
                v85.Name = v;
                v85.Parent = Cards;
                local Cards2 = u8.Cards;

                if Cards2[v] then
                    v85.Icon.Visible = true;
                    v85.Icon.Image = Cards2[v];
                end;

                if u1.Player.Customization.Equipped.Cards == v then
                    v85.LayoutOrder = v85.LayoutOrder - 1000000;
                end;

                u79[v85] = v85.MouseButton1Click:Connect(function() -- Line: 740
                    -- upvalues: u7 (ref), v (copy)
                    u7:EquipCard(v);
                end);
                v85.ImageColor3 = u1.Player.Customization.Equipped.Cards == v85.Name and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 255, 255);
                v85.LockerItem_Outline.UIGradient.Color = ColorSequence.new(Rarities.Colors[v84.Rarity]);
            else
                warn((`config doesn't exist for cards '{v}'`));
            end;
        end;
    end;

    u7:OnSearchChanged(function(p86: string) -- Line: 755
        -- upvalues: Cards (copy)
        for _, child in Cards:GetChildren() do
            if child:IsA("GuiButton") then
                child.Visible = string.find(string.lower(child.TextLabel.Text), p86) ~= nil;
            end;
        end;
    end);
    Cards:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 765
        -- upvalues: u7 (ref)
        u7:UpdateCards();
    end);
    LocalPlayer.PlayerGui.Locker:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 767
        -- upvalues: LocalPlayer (ref), Cards (copy), u79 (copy)
        if not LocalPlayer.PlayerGui.Locker.Enabled then
            for _, child in Cards:GetChildren() do
                if child:IsA("GuiButton") then
                    child:Destroy();
                end;
            end;

            for _, v in u79 do
                v:Disconnect();
            end;

            table.clear(u79);
        end;
    end);
end;

function u7.OutfitsInit(p87) -- Line: 784
    -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy), Trove (copy), Customization (copy), u1 (ref), MarketplaceService (copy), u2 (ref), u7 (copy), Knit (copy), GetHumDescription (copy), Rarities (copy), AvatarEditorService (copy)
    local Outfits = LocalPlayer.PlayerGui.Locker.Content.Content.Outfits;
    local Outfits2 = ReplicatedStorage.Assets.Outfits;
    local u88 = Trove.new();
    local u89 = {};
    local u90 = {
        Rare = 5,
        Epic = 4,
        Legendary = 3,
        Mythic = 2,
        Limited = 1
    };
    local u91 = {};

    for i in Customization.Emotes do
        table.insert(u89, i);
    end;

    local function IsOutfitEquipped(p92: string) -- Line: 805
        -- upvalues: u1 (ref)
        return u1.Player.Customization.Equipped.Outfits == (tonumber(p92) or p92);
    end;

    function u7.EquipOutfit(p93: table, p94: string) -- Line: 809
        -- upvalues: u1 (ref), MarketplaceService (ref), LocalPlayer (ref), ReplicatedStorage (ref), u2 (ref), u7 (ref)
        if not u1.Player.OwnedGamepasses["1090339361"] then
            MarketplaceService:PromptGamePassPurchase(LocalPlayer, 1090339361);

            return;
        end;

        local v95 = u1.Player.Customization.Equipped.Outfits == (tonumber(p94) or p94);
        local Value = ReplicatedStorage.Controllers.NewData.Value;
        u2.Equip:Fire(v95 and "" or p94, "Outfits");

        while Value == ReplicatedStorage.Controllers.NewData.Value do
            ReplicatedStorage.Controllers.NewData.Changed:Wait();
        end;

        u7:UpdateOutfits();
    end;

    local function CreateOutfitButton(u96: string, p97: string?) -- Line: 828
        -- upvalues: Customization (ref), u89 (copy), Knit (ref), u88 (copy), u90 (copy), u1 (ref), Outfits (copy), Outfits2 (copy), ReplicatedStorage (ref), u91 (copy), GetHumDescription (ref), u7 (ref), Rarities (ref)
        local v98 = Customization.Outfits[u96];
        local v99 = v98 == nil and {
            Rarity = "Rare",
            Emote = u89[math.random(1, #u89)]
        } or v98;
        local Controller = Knit.GetController("EmotesController");
        local v100 = u88:Add(script.EmoteItem:Clone());
        v100:WaitForChild("TextLabel").Text = p97 or u96;
        v100.LayoutOrder = u90[v99.Rarity] + (u1.Player.Customization.Equipped.Outfits == (tonumber(u96) or u96) and -1000000 or 0);
        v100.Name = u96;
        v100.Parent = Outfits;
        local v101 = Outfits2:FindFirstChild(u96) or ReplicatedStorage.AwakeningTemplates:FindFirstChild(u96);

        if v101 == nil then
            if not u91[u96] then
                task.spawn(function() -- Line: 850
                    -- upvalues: u91 (ref), u96 (copy), GetHumDescription (ref), ReplicatedStorage (ref)
                    u91[u96] = true;
                    local v102 = GetHumDescription.FromOutfitId((tonumber(u96)));
                    local v103 = ReplicatedStorage.Assets.Misc.TemplateRig:Clone();
                    v103.Name = `{u96}`;
                    v103.Parent = workspace;
                    v103.Humanoid:ApplyDescriptionReset(v102);
                    v103.Parent = ReplicatedStorage.AwakeningTemplates;
                    u91[u96] = nil;
                end);
            end;

            v101 = ReplicatedStorage.AwakeningTemplates:WaitForChild(u96);
        end;

        Controller:CreatePreview(v99.Emote, v100:WaitForChild("ViewportFrame"), v101);
        v100.MouseButton1Click:Connect(function() -- Line: 870
            -- upvalues: u7 (ref), u96 (copy)
            u7:EquipOutfit(u96);
        end);
        local Name = v100.Name;
        v100.ImageColor3 = u1.Player.Customization.Equipped.Outfits == (tonumber(Name) or Name) and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 255, 255);
        v100.LockerItem_Outline.UIGradient.Color = ColorSequence.new(Rarities.Colors[v99.Rarity]);
    end;

    function u7.UpdateOutfits(p104) -- Line: 878
        -- upvalues: u88 (copy), Customization (ref), CreateOutfitButton (copy), AvatarEditorService (ref)
        u88:Clean();

        for i in Customization.Outfits do
            u88:Add(task.spawn(CreateOutfitButton, i));
        end;

        u88:Add(task.spawn(function() -- Line: 885
            -- upvalues: AvatarEditorService (ref), u88 (ref), CreateOutfitButton (ref)
            local Outfits3 = AvatarEditorService:GetOutfits(Enum.OutfitSource.Created, Enum.OutfitType.Avatar);

            while true do
                for _, v in Outfits3:GetCurrentPage() do
                    u88:Add(task.spawn(CreateOutfitButton, tostring(v.Id), v.Name));
                end;

                if Outfits3.IsFinished then
                    return;
                end;

                Outfits3:AdvanceToNextPageAsync();
            end;
        end));
    end;

    u7:OnSearchChanged(function(p105: string) -- Line: 902
        -- upvalues: Outfits (copy)
        for _, child in Outfits:GetChildren() do
            if child:IsA("GuiButton") then
                child.Visible = string.find(string.lower(child.TextLabel.Text), p105) ~= nil;
            end;
        end;
    end);
    local u106 = false;
    Outfits:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 914
        -- upvalues: Outfits (copy), u106 (ref), AvatarEditorService (ref), u7 (ref)
        if Outfits.Visible == false then
            return;
        end;

        if not u106 then
            AvatarEditorService:PromptAllowInventoryReadAccess();
            u106 = AvatarEditorService.PromptAllowInventoryReadAccessCompleted:Wait() == Enum.AvatarPromptResult.Success;

            if not u106 then
                return;
            end;
        end;

        u7:UpdateOutfits();
    end);
    LocalPlayer.PlayerGui.Locker:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 932
        -- upvalues: LocalPlayer (ref), u88 (copy)
        if not LocalPlayer.PlayerGui.Locker.Enabled then
            u88:Clean();
        end;
    end);
end;

function u7.MVPCutscenesInit(p107) -- Line: 939
    -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy), Trove (copy), u1 (ref), u7 (copy), u2 (ref), Knit (copy), Customization (copy), Rarities (copy)
    local MVPCutscenes = LocalPlayer.PlayerGui.Locker.Content.Content.MVPCutscenes;
    local MVPCutscenes2 = ReplicatedStorage.Assets.MVPCutscenes;
    local u108 = Trove.new();

    function u7.EquipMVPCutscene(p109: table, p110: string) -- Line: 947
        -- upvalues: u1 (ref), u7 (ref), MVPCutscenes2 (copy), u2 (ref)
        local u111 = (p110 == u1.Player.Customization.Equipped.MVPCutscenes or not p110) and "" or p110;
        task.spawn(function() -- Line: 950
            -- upvalues: u7 (ref), MVPCutscenes2 (ref), u111 (copy)
            if u7.LockerRig then
                for _, v in u7.LockerRig.Humanoid.Animator:GetPlayingAnimationTracks() do
                    v:Stop(0);
                end;

                local v112 = MVPCutscenes2:FindFirstChild(u111);

                if v112 then
                    local v113 = u7.LockerRig.Humanoid.Animator:LoadAnimation(v112.Animations.Player1);
                    v113.Looped = false;
                    v113:Play(0);
                end;
            end;
        end);
        u1.Player.Customization.Equipped.MVPCutscenes = u111;
        u2.Equip:Fire(u111, "MVPCutscenes");
        u7:UpdateMVPCutsceneItems();
    end;

    function u7.UpdateMVPCutsceneItems(p114) -- Line: 972
        -- upvalues: MVPCutscenes (copy), u108 (copy), Knit (ref), u1 (ref), Customization (ref), u7 (ref), Rarities (ref)
        for _, child in MVPCutscenes:GetChildren() do
            if child:IsA("GuiButton") then
                child:Destroy();
            end;
        end;

        u108:Clean();
        local Controller = Knit.GetController("EmotesController");

        while not Controller.CharacterRig do
            task.wait();
        end;

        local v115 = {
            Rare = 5,
            Epic = 4,
            Legendary = 3,
            Mythic = 2,
            Limited = 1
        };

        for _, v in u1.Player.Customization.Inventory.MVPCutscenes do
            local v116 = Customization.MVPCutscenes[v];

            if v116 then
                local v117 = script.EmoteItem:Clone();
                v117:WaitForChild("TextLabel").Text = v;
                v117.LayoutOrder = v115[v116.Rarity];
                v117.Name = v;
                v117.Parent = MVPCutscenes;

                if u1.Player.Customization.Equipped.MVPCutscenes == v then
                    v117.LayoutOrder = v117.LayoutOrder - 1000000;
                end;

                u108:Add(v117.MouseButton1Click:Connect(function() -- Line: 1014
                    -- upvalues: u7 (ref), v (copy)
                    u7:EquipMVPCutscene(v);
                end));
                v117.ImageColor3 = u1.Player.Customization.Equipped.MVPCutscenes == v117.Name and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 255, 255);
                v117.LockerItem_Outline.UIGradient.Color = ColorSequence.new(Rarities.Colors[v116.Rarity]);
            else
                warn((`config doesn't exist for mvp cutscene '{v}'`));
            end;
        end;
    end;

    u7:OnSearchChanged(function(p118: string) -- Line: 1029
        -- upvalues: MVPCutscenes (copy)
        for _, child in MVPCutscenes:GetChildren() do
            if child:IsA("GuiButton") then
                child.Visible = string.find(string.lower(child.TextLabel.Text), p118) ~= nil;
            end;
        end;
    end);
    MVPCutscenes:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 1039
        -- upvalues: u7 (ref)
        u7:UpdateMVPCutsceneItems();
    end);
    LocalPlayer.PlayerGui.Locker:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 1041
        -- upvalues: LocalPlayer (ref), MVPCutscenes (copy), u108 (copy)
        if not LocalPlayer.PlayerGui.Locker.Enabled then
            for _, child in MVPCutscenes:GetChildren() do
                if child:IsA("GuiButton") then
                    child:Destroy();
                end;
            end;

            u108:Clean();
        end;
    end);
end;

function u7.CosmeticsInit(p119) -- Line: 1054
    -- upvalues: LocalPlayer (copy), ReplicatedStorage (copy), u1 (ref), u2 (ref), u7 (copy), Customization (copy), Rarities (copy), CFrame_lookAlong_ret (copy), Trove (copy)
    local Cosmetics = LocalPlayer.PlayerGui.Locker.Content.Content.Cosmetics;
    local _ = ReplicatedStorage.Assets.Cosmetics;
    local u120 = {};

    function u7.EquipCosmetic(p121: table, p122: string) -- Line: 1060
        -- upvalues: u1 (ref), u2 (ref), u7 (ref)
        local v123 = (p122 == u1.Player.Customization.Equipped.Cosmetics or not p122) and "" or p122;
        u1.Player.Customization.Equipped.Cosmetics = v123;
        u2.Equip:Fire(v123, "Cosmetics");
        u7:UpdateCosmetics();
    end;

    function u7.UpdateCosmetics(p124) -- Line: 1069
        -- upvalues: Cosmetics (copy), u120 (copy), u1 (ref), Customization (ref), u7 (ref), Rarities (ref), ReplicatedStorage (ref), CFrame_lookAlong_ret (ref), Trove (ref)
        for _, child in Cosmetics:GetChildren() do
            if child:IsA("GuiButton") then
                child:Destroy();
            end;
        end;

        for _, v in u120 do
            v:Disconnect();
        end;

        table.clear(u120);
        local v125 = {
            Rare = 5,
            Epic = 4,
            Legendary = 3,
            Mythic = 2,
            Limited = 1
        };

        for _, v in u1.Player.Customization.Inventory.Cosmetics do
            if v ~= "" then
                local v126 = Customization.Cosmetics[v];

                if v126 then
                    local v127 = script.EmoteItem:Clone();
                    v127:WaitForChild("TextLabel").Text = v;
                    v127.LayoutOrder = v125[v126.Rarity];
                    v127.Name = v;
                    v127.Parent = Cosmetics;

                    if u1.Player.Customization.Equipped.Cosmetics == v then
                        v127.LayoutOrder = v127.LayoutOrder - 1000000;
                    end;

                    if v126.IconId then
                        v127.Icon.Visible = true;
                        v127.Icon.Image = `rbxassetid://{v126.IconId}`;
                    end;

                    u120[v127] = v127.MouseButton1Click:Connect(function() -- Line: 1118
                        -- upvalues: u7 (ref), v (copy)
                        u7:EquipCosmetic(v);
                    end);
                    v127.ImageColor3 = u1.Player.Customization.Equipped.Cosmetics == v127.Name and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 255, 255);
                    v127.LockerItem_Outline.UIGradient.Color = ColorSequence.new(Rarities.Colors[v126.Rarity]);
                else
                    warn((`config doesn't exist for cosmetic '{v}'`));
                end;
            end;
        end;

        if u7.LockerRig ~= nil then
            local LockerRig = u7.LockerRig;

            if LockerRig:FindFirstChild("EQUIPPED_COSMETIC") then
                LockerRig:FindFirstChild("EQUIPPED_COSMETIC"):Destroy();
            end;

            local v128 = ReplicatedStorage.Assets.Cosmetics:FindFirstChild(u1.Player.Customization.Equipped.Cosmetics);

            if v128 == nil then
                LockerRig:PivotTo(CFrame_lookAlong_ret);
            else
                task.wait(0.1);
                local CFrame_Angles = CFrame.Angles;
                local v129 = v128:GetAttribute("YOffset") or 0;
                LockerRig:PivotTo(CFrame_lookAlong_ret * CFrame_Angles(0, math.rad(v129), 0));
                local u130 = v128:Clone();
                u130.Name = "EQUIPPED_COSMETIC";
                u130.Parent = LockerRig;
                local ScriptableCosmetics = require(ReplicatedStorage.Shared.Tables.ScriptableCosmetics);

                if ScriptableCosmetics[u1.Player.Customization.Equipped.Cosmetics] then
                    local u131 = Trove.new();
                    u131:AttachToInstance(u130);
                    u131:Add(u130.AncestryChanged:Connect(function() -- Line: 1149
                        -- upvalues: u130 (copy), u131 (copy)
                        if not u130:IsDescendantOf(workspace) then
                            u131:Destroy();
                        end;
                    end));
                    task.spawn(ScriptableCosmetics[u1.Player.Customization.Equipped.Cosmetics], LockerRig, u130, u131);
                end;
            end;
        end;
    end;

    u7:OnSearchChanged(function(p132: string) -- Line: 1163
        -- upvalues: Cosmetics (copy)
        for _, child in Cosmetics:GetChildren() do
            if child:IsA("GuiButton") then
                child.Visible = string.find(string.lower(child.TextLabel.Text), p132) ~= nil;
            end;
        end;
    end);
    Cosmetics:GetPropertyChangedSignal("Visible"):Connect(function() -- Line: 1173
        -- upvalues: Cosmetics (copy), u7 (ref)
        if Cosmetics.Visible == true then
            u7:UpdateCosmetics();

            return;
        end;

        if u7.LockerRig then
            u7.LockerRig:PivotTo(CFrame.new(0, 1000000, 0));
        end;
    end);
    LocalPlayer.PlayerGui.Locker:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 1185
        -- upvalues: LocalPlayer (ref), Cosmetics (copy), u120 (copy)
        if not LocalPlayer.PlayerGui.Locker.Enabled then
            for _, child in Cosmetics:GetChildren() do
                if child:IsA("GuiButton") then
                    child:Destroy();
                end;
            end;

            for _, v in u120 do
                v:Disconnect();
            end;

            table.clear(u120);
        end;
    end);
end;

function u7.JerseyNumberInit(p133) -- Line: 1202
    -- upvalues: LocalPlayer (copy), Effects (copy), Knit (copy), u7 (copy)
    local JerseyNumber = LocalPlayer.PlayerGui.Locker.Content.Content.JerseyNumber;

    function u7.UpdateJerseyNumber(p134: table, p135: number?) -- Line: 1205
        -- upvalues: JerseyNumber (copy), Effects (ref), Knit (ref)
        local v136 = p135 or tonumber(JerseyNumber.Number.Text);

        if not v136 then
            Effects:Popup("Invalid Jersey Number", 2, Color3.fromRGB(255, 0, 0));

            return;
        end;

        local math_round_ret = math.round(v136);
        local math_clamp_ret = math.clamp(math_round_ret, 1, 99);
        local v137 = Knit.GetService("CustomizationService"):UpdateJerseyNumber(math_clamp_ret);

        if v137 then
            Effects:Popup(`Jersey Number Updated To: {v137}`, 2, Color3.fromRGB(0, 255, 0));

            return;
        end;

        Effects:Popup("Invalid Jersey Number", 2, Color3.fromRGB(255, 0, 0));
    end;

    JerseyNumber:WaitForChild("Set").MouseButton1Click:Connect(function() -- Line: 1225
        -- upvalues: u7 (ref)
        u7:UpdateJerseyNumber();
    end);
    JerseyNumber:WaitForChild("Number").ReturnPressedFromOnScreenKeyboard:Connect(function() -- Line: 1226
        -- upvalues: u7 (ref)
        u7:UpdateJerseyNumber();
    end);
end;

function u7.ChatTagInit(p138) -- Line: 1229
    -- upvalues: LocalPlayer (copy), Knit (copy), Customization (copy), u1 (ref), Rarities (copy), u7 (copy)
    local ChatTags = LocalPlayer.PlayerGui.Locker.Content.Content.ChatTags;
    local Service = Knit.GetService("ChatTagService");
    local Controller = Knit.GetController("ChatController");
    local u139 = {
        Rare = 5,
        Epic = 4,
        Legendary = 3,
        Mythic = 2,
        Limited = 1
    };

    local function updateChatTags(p140: table) -- Line: 1244
        -- upvalues: ChatTags (copy), Controller (copy), Customization (ref), Service (copy), LocalPlayer (ref), u1 (ref), u139 (copy), Rarities (ref)
        for _, child in ChatTags:GetChildren() do
            if child:IsA("ImageButton") then
                child:Destroy();
            end;
        end;

        for _, v in p140 do
            local v141 = Controller.ChatTags[v];
            local u142 = Customization.ChatTags[v];

            if v141 == Controller.DYNAMIC then
                v141 = Service:ResolvePrefix(LocalPlayer, v);
                local UIGradient = Instance.new("UIGradient");
                UIGradient.Color = v141.color;
                v141.color = UIGradient;
            end;

            local v143 = script.EmoteItem:Clone();
            v143.Activated:Connect(function() -- Line: 1266
                -- upvalues: u1 (ref), v (copy), Service (ref), ChatTags (ref), u139 (ref), u142 (copy)
                local v144;

                if u1.Player.Customization.Equipped.ChatTag == v then
                    v144 = Service:EquipTag(nil);
                else
                    v144 = Service:EquipTag(v);
                end;

                for _, child in ChatTags:GetChildren() do
                    if child:IsA("ImageButton") then
                        child.ImageColor3 = v144 == child.Name and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 255, 255);
                        child.LayoutOrder = u139[u142 and u142.Rarity or "Limited"] + (v144 == child.Name and -1000000 or 0);
                    end;
                end;
            end);
            v143.TextLabel.Text = v141.tag;
            v141.color:Clone().Parent = v143.TextLabel;
            v143.TextLabel.Size = UDim2.fromScale(0.85, 0.85);
            v143.TextLabel.Position = UDim2.fromScale(0.5, 0.5);
            v143.TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
            v143.LayoutOrder = u139[u142 and (u142.Rarity or "Limited") or "Limited"] + (u1.Player.Customization.Equipped.ChatTag == v143.Name and -1000000 or 0);
            v143.Name = v;
            v143.Parent = ChatTags;
            v143.ImageColor3 = u1.Player.Customization.Equipped.ChatTag == v143.Name and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 255, 255);
            v143.LockerItem_Outline.UIGradient.Color = ColorSequence.new(Rarities.Colors[u142 and u142.Rarity or "Limited"]);
        end;
    end;

    u7:OnSearchChanged(function(p145: string) -- Line: 1299
        -- upvalues: ChatTags (copy)
        for _, child in ChatTags:GetChildren() do
            if child:IsA("GuiButton") then
                child.Visible = string.find(string.lower(child.TextLabel.Text), p145) ~= nil;
            end;
        end;
    end);
    Service.ChatTags:Observe(updateChatTags);
end;

function u7.KnitStart(p146) -- Line: 1312
    -- upvalues: u1 (ref), Knit (copy), u2 (ref), u8 (ref), u7 (copy), GetHumDescription (copy), LocalPlayer (copy), ReplicatedStorage (copy), u6 (copy), CFrame_lookAlong_ret (copy), u5 (ref)
    u1 = Knit.GetController("Network");
    u2 = Knit.GetService("CustomizationService");
    u8 = Knit.GetController("Shop");
    u7:SetupSubMenuButtons();
    u7:ColorRngInit();
    u7:EmotesInit();
    u7:GoalEffectsInit();
    u7:ShotEffectsInit();
    u7:JerseyNumberInit();
    u7:OutfitsInit();
    u7:MVPCutscenesInit();
    u7:CosmeticsInit();
    u7:CardsInit();
    u7:ChatTagInit();
    task.spawn(function() -- Line: 1332
        -- upvalues: GetHumDescription (ref), LocalPlayer (ref), ReplicatedStorage (ref), u7 (ref), u6 (ref), CFrame_lookAlong_ret (ref), u5 (ref)
        local v147 = GetHumDescription.FromUserId(LocalPlayer.UserId);
        local u148 = ReplicatedStorage.Assets.Misc.TemplateRig:Clone();
        u148.Parent = workspace;
        u148.Humanoid:ApplyDescriptionReset(v147);
        u148.Name = "LockerRig";
        u148.HumanoidRootPart.Anchored = true;
        u148:PivotTo(CFrame.new(0, 1000000, 0));

        for _, child in u148:GetChildren() do
            if child:IsA("Accessory") and (child.AccessoryType == Enum.AccessoryType.Back or child.AccessoryType == Enum.AccessoryType.Hat) then
                child:Destroy();
            end;
        end;

        u7.LockerRig = u148;
        local v149 = u148.Humanoid:LoadAnimation(ReplicatedStorage.Assets.Animations.Movement.Idle);
        v149:Play();
        u7.LockerRigIdleTrack = v149;
        LocalPlayer.PlayerGui.Locker:GetPropertyChangedSignal("Enabled"):Connect(function() -- Line: 1356
            -- upvalues: u7 (ref), LocalPlayer (ref), u6 (ref), u148 (copy), CFrame_lookAlong_ret (ref), u5 (ref)
            u7:UpdateSubMenu("Emotes");

            if not LocalPlayer.PlayerGui.Locker.Enabled then
                u148:PivotTo(CFrame.new(0, 1000000, 0));

                if u5 then
                    u5:Stop();
                end;

                return;
            end;

            workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable;
            workspace.CurrentCamera.CFrame = u6;
            u148:PivotTo(CFrame_lookAlong_ret);
        end);
    end);
    task.spawn(function() -- Line: 1378
        -- upvalues: ReplicatedStorage (ref)
        local v150 = ReplicatedStorage.Assets.Misc.TemplateRig:Clone();
        v150.Parent = workspace;

        for _, descendant in ReplicatedStorage.Assets.MVPCutscenes:GetDescendants() do
            if descendant:IsA("Animation") then
                local v151 = v150.Humanoid:LoadAnimation(descendant);
                v151:Play();

                while v151.Length < 1 do
                    task.wait();
                end;

                task.wait(0.1);
                v151:Stop();
            end;
        end;

        v150:Destroy();
    end);
end;

return u7;
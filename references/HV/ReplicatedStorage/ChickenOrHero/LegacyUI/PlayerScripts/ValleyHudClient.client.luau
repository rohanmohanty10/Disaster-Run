 

 

local StarterGui = game:GetService("StarterGui");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local u1 = true;
local BindableEvent = Instance.new("BindableEvent");
local u2 = BindableEvent.Event:Connect(function() -- Line: 9
    -- upvalues: LocalPlayer (copy)
    local LobbyResetEvent = game.ReplicatedStorage.ChickenOrHero.Game:FindFirstChild("LobbyResetEvent");

    if LobbyResetEvent and LocalPlayer:GetAttribute("InMatch") ~= true then
        LobbyResetEvent:FireServer();
    end;
end);
local u3 = nil;
local u4 = nil;

local function apply() -- Line: 16
    -- upvalues: u3 (ref), LocalPlayer (copy), BindableEvent (copy), u4 (ref), StarterGui (copy)
    local v5;

    if LocalPlayer:GetAttribute("InMatch") == true then
        v5 = false;
    else
        v5 = BindableEvent;
    end;

    u3 = v5;

    if u3 == u4 then
        return;
    end;

    if pcall(StarterGui.SetCore, StarterGui, "ResetButtonCallback", u3) then
        u4 = u3;
    end;
end;

local u6 = LocalPlayer:GetAttributeChangedSignal("InMatch"):Connect(apply);
script.Destroying:Connect(function() -- Line: 26
    -- upvalues: u1 (ref), u6 (copy), u2 (copy), BindableEvent (copy)
    u1 = false;
    u6:Disconnect();
    u2:Disconnect();
    BindableEvent:Destroy();
end);
task.spawn(function() -- Line: 33
    -- upvalues: u1 (ref), u3 (ref), LocalPlayer (copy), BindableEvent (copy), u4 (ref), StarterGui (copy)
    while u1 do
        local v7;

        if LocalPlayer:GetAttribute("InMatch") == true then
            v7 = false;
        else
            v7 = BindableEvent;
        end;

        u3 = v7;

        if u3 ~= u4 and pcall(StarterGui.SetCore, StarterGui, "ResetButtonCallback", u3) then
            u4 = u3;
        end;

        if u4 ~= nil and u4 == u3 then
            return;
        end;

        task.wait(1);
    end;
end);
local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local TweenService = game:GetService("TweenService");
local LocalPlayer2 = Players.LocalPlayer;
local Presentation = game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Presentation");
local HudNavigation = require(Presentation:WaitForChild("HudNavigation"));
local ValleyHudView = require(Presentation:WaitForChild("ValleyHudView"));
local UpdateLogConfig = require(Presentation:WaitForChild("UpdateLogConfig"));
local Skin = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local ValleyHUD = LocalPlayer2:WaitForChild("PlayerGui"):WaitForChild("ValleyHUD");
ValleyHudView.ensureDrawer(ValleyHUD);
local Navigation = ValleyHUD.DrawerClip.Panel.Navigation;
local u8 = require(Presentation:WaitForChild("HudDrawer")).new(ValleyHUD, HudNavigation, ValleyHudView);
local Panel = ValleyHUD.SettingsShade.Panel;
local u9 = Panel:FindFirstChild("Rows") or Panel;
local Panel2 = ValleyHUD.UpdatesShade.Panel;
local CandyCorn = require(game.ReplicatedStorage.ChickenOrHero:WaitForChild("Game"):WaitForChild("CandyCorn"));
local CandyCorn2 = ValleyHUD.Wallet:FindFirstChild("CandyCorn");

if not CandyCorn2 then
    CandyCorn2 = ValleyHUD.Wallet.Coins:Clone();
    CandyCorn2.Name = "CandyCorn";
    CandyCorn2.Position = UDim2.fromOffset(0, -44);
    local UIScale = Instance.new("UIScale");
    UIScale.Name = "Small";
    UIScale.Scale = 0.875;
    UIScale.Parent = CandyCorn2;

    for _, child in CandyCorn2.Icon:GetChildren() do
        child:Destroy();
    end;

    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.Name = "CandyIcon";
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Size = UDim2.fromScale(1, 1);
    ImageLabel.Image = CandyCorn.Icon;
    ImageLabel.ScaleType = Enum.ScaleType.Fit;
    ImageLabel.Parent = CandyCorn2.Icon;
    CandyCorn2.Label.Text = "CANDY CORN";
    CandyCorn2.Parent = ValleyHUD.Wallet;
end;

local FallenKingConfig = require(game.ReplicatedStorage.ChickenOrHero.Game:WaitForChild("FallenKingConfig"));
local Color3_fromRGB_ret = Color3.fromRGB(110, 255, 140);
local Souls = ValleyHUD.Wallet:FindFirstChild("Souls");

if not Souls then
    Souls = CandyCorn2:Clone();
    Souls.Name = "Souls";
    local CandyIcon = Souls.Icon:FindFirstChild("CandyIcon");
    CandyIcon.Name = "SoulIcon";
    CandyIcon.Image = "rbxassetid://92036662316128";
    Souls.Label.Text = "SOUL ESSENCE";
    Souls.Label.TextScaled = true;
    Souls.Label.TextWrapped = false;
    Souls.Visible = false;
    Souls.Parent = ValleyHUD.Wallet;
end;

local u10 = tonumber(LocalPlayer2:GetAttribute("FallenKingCarried")) or 0;
local u11 = 0;

local function fitCandyRow() -- Line: 113
    -- upvalues: ValleyHUD (copy), CandyCorn2 (ref), Souls (ref)
    local Coins = ValleyHUD.Wallet.Coins;

    for _, v in { CandyCorn2, Souls } do
        v.Size = Coins.Size;
        local v12 = v;

        for _, v2 in { "Value", "Label" } do
            local v13 = v12:FindFirstChild(v2);
            local v14 = Coins:FindFirstChild(v2);

            if v13 and v14 then
                v13.Size = v14.Size;
                v13.TextSize = v14.TextSize;
            end;
        end;
    end;
end;

fitCandyRow();
ValleyHUD.Wallet.Coins:GetPropertyChangedSignal("Size"):Connect(fitCandyRow);
local u15 = nil;
local u16 = nil;
local u17 = nil;
local u18 = nil;
local u19 = {};

local function connect(p20, p21) -- Line: 133
    -- upvalues: u19 (copy)
    table.insert(u19, p20:Connect(p21));
end;

local TextLabel = Instance.new("TextLabel");
TextLabel.Name = "HighPingBadge";
TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
TextLabel.Position = UDim2.new(1, -6, 0, 3);
TextLabel.Size = UDim2.fromOffset(22, 22);
TextLabel.BackgroundColor3 = Color3.fromRGB(211, 65, 58);
TextLabel.BorderSizePixel = 0;
TextLabel.Font = Enum.Font.GothamBlack;
TextLabel.Text = "!";
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255);
TextLabel.TextScaled = true;
TextLabel.ZIndex = ValleyHUD.Servers.ZIndex + 1;
TextLabel.Parent = ValleyHUD.Servers;
local UICorner = Instance.new("UICorner");
UICorner.CornerRadius = UDim.new(1, 0);
UICorner.Parent = TextLabel;
local UIStroke = Instance.new("UIStroke");
UIStroke.Color = Color3.new(0, 0, 0);
UIStroke.Thickness = 1.5;
UIStroke.Parent = TextLabel;
Skin.badge(TextLabel);
local AttributeChangedSignal = LocalPlayer2:GetAttributeChangedSignal("HighPingWarning");
table.insert(u19, AttributeChangedSignal:Connect(function() -- Line: 157, Name: updatePingBadge
    -- upvalues: TextLabel (copy), LocalPlayer2 (copy)
    TextLabel.Visible = LocalPlayer2:GetAttribute("HighPingWarning") == true;
end));
TextLabel.Visible = LocalPlayer2:GetAttribute("HighPingWarning") == true;

local function number(p22) -- Line: 162
    local math_floor_ret = math.floor(p22 or 0);
    local math_max_ret = math.max(0, math_floor_ret);

    return tostring(math_max_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
end;

local function ready() -- Line: 166
    -- upvalues: LocalPlayer2 (copy)
    local v23;

    if LocalPlayer2:GetAttribute("ClientReady") == true then
        v23 = not (LocalPlayer2:GetAttribute("ScreenPresentationActive") or (LocalPlayer2:GetAttribute("TutorialRouting") or LocalPlayer2:GetAttribute("TutorialSession"))) and not LocalPlayer2:GetAttribute("AdminRefreshActive");
    else
        v23 = false;
    end;

    return v23;
end;

local function volume() -- Line: 173
    -- upvalues: LocalPlayer2 (copy)
    local Attribute = LocalPlayer2:GetAttribute("MusicVolume");

    return type(Attribute) == "number" and (Attribute == Attribute and math.clamp(Attribute, 0, 1)) or 1;
end;

local function setVolume(p24) -- Line: 177
    -- upvalues: LocalPlayer2 (copy)
    local v25 = math.floor(p24 * 100 + 0.5) / 100;
    LocalPlayer2:SetAttribute("MusicVolume", (math.clamp(v25, 0, 1)));
end;

local function emoteVolume() -- Line: 181
    -- upvalues: LocalPlayer2 (copy)
    local Attribute = LocalPlayer2:GetAttribute("EmoteVolume");

    return type(Attribute) == "number" and (Attribute == Attribute and math.clamp(Attribute, 0, 1)) or 1;
end;

local function setEmoteVolume(p26) -- Line: 185
    -- upvalues: LocalPlayer2 (copy)
    local v27 = math.floor(p26 * 100 + 0.5) / 100;
    LocalPlayer2:SetAttribute("EmoteVolume", (math.clamp(v27, 0, 1)));
end;

local function updateSettings() -- Line: 188
    -- upvalues: u9 (copy), LocalPlayer2 (copy), ValleyHudView (copy)
    local EmoteSlider = u9:FindFirstChild("EmoteSlider");

    if EmoteSlider then
        local Attribute = LocalPlayer2:GetAttribute("EmoteVolume");
        local v28 = type(Attribute) == "number" and Attribute == Attribute and (math.clamp(Attribute, 0, 1) or 1) or 1;
        u9.EmoteVolume.Text = math.floor(v28 * 100 + 0.5) .. "%";
        EmoteSlider.Fill.Size = UDim2.new(v28, 0, 0, 6);
        EmoteSlider.Knob.Position = UDim2.fromScale(v28, 0.5);
    end;

    local v29 = LocalPlayer2:GetAttribute("ChatNotificationsEnabled") == true;
    u9.ChatNotifications.Text = v29 and "ON" or "OFF";
    ValleyHudView.toggle(u9.ChatNotifications, v29);
    local v30 = workspace:GetAttribute("PrivateServerHitboxesEnabled") == true;
    u9.ShowHitboxes.Text = v30 and "ON" or "OFF";
    ValleyHudView.toggle(u9.ShowHitboxes, v30);
    local v31 = workspace:GetAttribute("PrivateServerBotsDisabled") == true;
    u9.DisableBots.Text = v31 and "ON" or "OFF";
    ValleyHudView.toggle(u9.DisableBots, v31);
    local Attribute = LocalPlayer2:GetAttribute("MusicVolume");
    local v32 = type(Attribute) == "number" and (Attribute == Attribute and math.clamp(Attribute, 0, 1)) or 1;
    local v33 = LocalPlayer2:GetAttribute("MusicMuted") == true;
    u9.Volume.Text = math.floor(v32 * 100 + 0.5) .. "%";
    u9.MusicSlider.Fill.Size = UDim2.new(v32, 0, 0, 6);
    u9.MusicSlider.Knob.Position = UDim2.fromScale(v32, 0.5);
    u9.Mute.Text = v33 and "ON" or "OFF";
    ValleyHudView.toggle(u9.Mute, v33);
    local v34 = LocalPlayer2:GetAttribute("EmoteSoundsMuted") == true;
    u9.EmoteSounds.Text = v34 and "ON" or "OFF";
    ValleyHudView.toggle(u9.EmoteSounds, v34);
    local v35 = LocalPlayer2:GetAttribute("SpectatorHints") ~= false;
    u9.Hints.Text = v35 and "ON" or "OFF";
    ValleyHudView.toggle(u9.Hints, v35);
    local v36 = LocalPlayer2:GetAttribute("PrivateInvitesOff") ~= true;
    u9.PrivateInvites.Text = v36 and "ON" or "OFF";
    ValleyHudView.toggle(u9.PrivateInvites, v36);
    local v37 = LocalPlayer2:GetAttribute("HostButtonHidden") ~= true;
    u9.HostButton.Text = v37 and "ON" or "OFF";
    ValleyHudView.toggle(u9.HostButton, v37);
    local v38 = LocalPlayer2:GetAttribute("HideBoardRank") ~= true;
    u9.BoardRank.Text = v38 and "ON" or "OFF";
    ValleyHudView.toggle(u9.BoardRank, v38);
end;

local function close() -- Line: 228
    -- upvalues: u15 (ref), u18 (ref), ValleyHUD (copy), LocalPlayer2 (copy), u17 (ref), GuiService (copy), u16 (ref)
    if not u15 then
        return;
    end;

    u15 = nil;
    u18 = nil;
    ValleyHUD.SettingsShade.Visible = false;
    ValleyHUD.UpdatesShade.Visible = false;
    LocalPlayer2:SetAttribute("SettingsOpen", nil);
    LocalPlayer2:SetAttribute("UpdateLogOpen", nil);

    if u17 ~= nil then
        pcall(function() -- Line: 239
            -- upvalues: u17 (ref)
            game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, u17);
        end);
        u17 = nil;
    end;

    if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(ValleyHUD) then
        GuiService.SelectedObject = u16 and (u16.Parent and u16) or nil;
    end;
end;

local function open(p39) -- Line: 248
    -- upvalues: ready (copy), u15 (ref), close (copy), HudNavigation (copy), u17 (ref), u16 (ref), GuiService (copy), ValleyHUD (copy), LocalPlayer2 (copy), UserInputService (copy)
    if not ready() then
        return;
    end;

    if u15 == p39 then
        close();

        return;
    end;

    HudNavigation.opening(p39);
    close();
    local success, result = pcall(function() -- Line: 258
        return game.StarterGui:GetCoreGuiEnabled(Enum.CoreGuiType.PlayerList);
    end);
    u17 = success and result and result or nil;
    pcall(function() -- Line: 262
        game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList, false);
    end);
    u16 = GuiService.SelectedObject;
    u15 = p39;
    ValleyHUD[p39 .. "Shade"].Visible = true;
    LocalPlayer2:SetAttribute(p39 == "Settings" and "SettingsOpen" or "UpdateLogOpen", true);
    LocalPlayer2:SetAttribute("SpectateRequestedExit", os.clock());

    if UserInputService.PreferredInput == Enum.PreferredInput.Gamepad then
        GuiService.SelectedObject = ValleyHUD[p39 .. "Shade"].Panel.Close;
    end;
end;

local u40 = { "StarterPackOpen", "LikeRewardOpen", "CreatorPanelOpen", "MapVoteOpen", "ReleaseCameraForUI", "EmoteWheelOpen", "AnnouncementComposerOpen", "ArmoryOpen", "JourneyOpen", "ServerBrowserOpen", "BalloonOfferOpen", "FairPlayNoticeOpen", "ConnectionQualityOpen", "AdminConsoleActive", "ChoiceSpotlightActive", "HostPanelOpen", "AdminPanelOpen", "PrivateInviteOpen", "CodesOpen", "CombineOpen", "FootballEventOpen", "EventKnivesOpen", "PumpkinSacrificeOpen", "PumpkinsOpen", "HalloweenShopOpen", "GhostTraderActive", "FallenKingSpoilsOpen", "FallenKingAltarOpen" };

local function otherMenu() -- Line: 304
    -- upvalues: u40 (copy), LocalPlayer2 (copy)
    for _, v in u40 do
        if LocalPlayer2:GetAttribute(v) then
            return true;
        end;
    end;

    return false;
end;

local function refresh() -- Line: 312
    -- upvalues: u15 (ref), ready (copy), u40 (copy), LocalPlayer2 (copy), close (copy), u8 (copy), Navigation (copy), ValleyHUD (copy), HudNavigation (copy), UserInputService (copy), ValleyHudView (copy), CandyCorn2 (ref), CandyCorn (copy), Souls (ref), FallenKingConfig (copy), u10 (ref), updateSettings (copy)
    if u15 then
        if ready() then
            local v41 = false;

            for _, v in u40 do
                if LocalPlayer2:GetAttribute(v) then
                    v41 = true;
                    break;
                end;
            end;

            if v41 then
                close();
            end;
        else
            close();
        end;
    end;

    local v42 = ready();

    if v42 then
        local v43 = false;

        for _, v in u40 do
            if LocalPlayer2:GetAttribute(v) then
                v43 = true;
                break;
            end;
        end;

        v42 = not (v43 or u15) and not LocalPlayer2:GetAttribute("Spectating");
    end;

    u8:setAvailable(v42);
    Navigation.Visible = v42;
    local Spectate = ValleyHUD.Spectate;
    local v44;

    if v42 then
        if HudNavigation.available.Spectate == true then
            v44 = not u8:isOpen();
        else
            v44 = false;
        end;
    else
        v44 = v42;
    end;

    Spectate.Visible = v44;
    ValleyHUD.Spectate.Active = ValleyHUD.Spectate.Visible;
    ValleyHUD.Spectate.Selectable = ValleyHUD.Spectate.Visible;
    local v45;

    if v42 then
        v45 = HudNavigation.available.Servers == true;
    else
        v45 = v42;
    end;

    ValleyHUD.Servers.Visible = v45;
    ValleyHUD.Updates.Visible = v42;
    local Wallet = ValleyHUD.Wallet;
    local v46 = ready();

    if v46 then
        local v47 = false;

        for _, v in u40 do
            if LocalPlayer2:GetAttribute(v) then
                v47 = true;
                break;
            end;
        end;

        v46 = not v47 and (not u15 and not LocalPlayer2:GetAttribute("Spectating"));
    end;

    Wallet.Visible = v46;
    Navigation.CursorHint.Visible = UserInputService.PreferredInput == Enum.PreferredInput.KeyboardAndMouse;

    for _, v in ValleyHudView.Order do
        local v48 = Navigation[v];
        local v49 = HudNavigation.available[v] == true;
        local v50;

        if v49 then
            v50 = u8:isOpen();
        else
            v50 = v49;
        end;

        v48.Active = v50;
        v48.Selectable = v48.Active;
        v48.Caption.TextTransparency = v49 and 0 or 0.48;
        v48.Icon.Visible = v49;
        v48.Accent.BackgroundTransparency = v49 and 0.18 or 0.8;
        v48.BackgroundTransparency = v49 and 0.12 or 0.38;
    end;

    local v51 = LocalPlayer2:GetAttribute("AFK") == true;
    local AFKToggle = ValleyHUD.AFKToggle;

    if v42 then
        v42 = not u8:isOpen();
    end;

    AFKToggle.Visible = v42;
    ValleyHUD.AFKToggle.Active = ValleyHUD.AFKToggle.Visible and HudNavigation.available.AFK == true;
    ValleyHUD.AFKToggle.Selectable = ValleyHUD.AFKToggle.Active;
    ValleyHUD.AFKToggle.Caption.Text = v51 and "AFK: On" or "AFK: Off";
    ValleyHudView.afkMark(ValleyHUD.AFKToggle, not v51);
    ValleyHUD.AFKToggle.Caption.TextColor3 = v51 and ValleyHudView.Mint or ValleyHudView.Paper;
    ValleyHUD.AFKToggle.StateDot.Visible = v51;
    ValleyHudView.awayLook(ValleyHUD.AFKToggle, v51);
    ValleyHUD.AFKToggle.Caption.TextTransparency = ValleyHUD.AFKToggle.Active and 0 or 0.48;
    local v52;

    if LocalPlayer2:GetAttribute("MusicMuted") == true then
        v52 = true;
    else
        local Attribute = LocalPlayer2:GetAttribute("MusicVolume");
        v52 = (type(Attribute) == "number" and (Attribute == Attribute and math.clamp(Attribute, 0, 1)) or 1) == 0;
    end;

    Navigation.Music.Caption.Text = v52 and "MUSIC · OFF" or "MUSIC · ON";
    Navigation.Music.StateDot.Visible = not v52;
    ValleyHudView.musicIcon(Navigation.Music, v52);
    local wallet = HudNavigation.wallet;
    local Value = ValleyHUD.Wallet.Coins.Value;
    local v53;

    if wallet.loaded then
        local math_floor_ret = math.floor(wallet.coins or 0);
        local math_max_ret = math.max(0, math_floor_ret);
        v53 = tostring(math_max_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") or "—";
    else
        v53 = "—";
    end;

    Value.Text = v53;
    local Value2 = ValleyHUD.Wallet.Gems.Value;
    local v54;

    if wallet.loaded then
        local math_floor_ret = math.floor(wallet.gems or 0);
        local math_max_ret = math.max(0, math_floor_ret);
        v54 = tostring(math_max_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") or "—";
    else
        v54 = "—";
    end;

    Value2.Text = v54;
    local Attribute = LocalPlayer2:GetAttribute("CandyCorn");
    CandyCorn2.Visible = CandyCorn.active(workspace:GetServerTimeNow());
    local Value3 = CandyCorn2.Value;
    local v55;

    if type(Attribute) == "number" then
        local math_floor_ret = math.floor(Attribute or 0);
        local math_max_ret = math.max(0, math_floor_ret);
        v55 = tostring(math_max_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
    else
        v55 = "—";
    end;

    Value3.Text = v55;
    local v56 = FallenKingConfig.active(workspace:GetServerTimeNow()) and u10 > 0;
    Souls.Visible = v56;
    local v57 = ValleyHUD.Wallet.Size.Y.Offset >= 100;
    local v58;

    if CandyCorn2.Visible then
        if v57 then
            v58 = UDim2.fromOffset(0, -88);
        else
            v58 = UDim2.fromOffset(146, -44);
        end;
    else
        v58 = UDim2.fromOffset(0, -44);
    end;

    Souls.Position = v58;
    local Value4 = Souls.Value;
    local math_floor_ret = math.floor(u10 or 0);
    local math_max_ret = math.max(0, math_floor_ret);
    Value4.Text = tostring(math_max_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
    updateSettings();
end;

for _, v in ValleyHudView.Order do
    table.insert(u19, Navigation[v].Activated:Connect(function() -- Line: 368
        -- upvalues: HudNavigation (copy), v (copy)
        HudNavigation.activate(v);
    end));
end;

table.insert(u19, Navigation.Music.Activated:Connect(function() -- Line: 374
    -- upvalues: HudNavigation (copy)
    HudNavigation.activate("Music");
end));
HudNavigation.register("Music", function() -- Line: 377
    -- upvalues: LocalPlayer2 (copy)
    local Attribute = LocalPlayer2:GetAttribute("MusicVolume");

    if (type(Attribute) == "number" and (Attribute == Attribute and math.clamp(Attribute, 0, 1)) or 1) ~= 0 then
        LocalPlayer2:SetAttribute("MusicMuted", LocalPlayer2:GetAttribute("MusicMuted") ~= true);

        return;
    end;

    LocalPlayer2:SetAttribute("MusicVolume", 1);
    LocalPlayer2:SetAttribute("MusicMuted", false);
end);
HudNavigation.setAvailable("Music", true);
table.insert(u19, ValleyHUD.AFKToggle.Activated:Connect(function() -- Line: 386
    -- upvalues: HudNavigation (copy)
    HudNavigation.activate("AFK");
end));
table.insert(u19, ValleyHUD.Spectate.Activated:Connect(function() -- Line: 389
    -- upvalues: HudNavigation (copy)
    HudNavigation.activate("Spectate");
end));
table.insert(u19, ValleyHUD.Servers.Activated:Connect(function() -- Line: 392
    -- upvalues: HudNavigation (copy)
    HudNavigation.activate("Servers");
end));
table.insert(u19, ValleyHUD.Updates.Activated:Connect(function() -- Line: 395
    -- upvalues: open (copy)
    open("Updates");
end));
HudNavigation.register("Settings", function() -- Line: 398
    -- upvalues: open (copy)
    open("Settings");
end);
HudNavigation.setAvailable("Settings", true);
table.insert(u19, HudNavigation.Opening.Event:Connect(function(p59) -- Line: 402
    -- upvalues: close (copy)
    if p59 ~= "Settings" and p59 ~= "Updates" then
        close();
    end;
end));
table.insert(u19, u9.ChatNotifications.Activated:Connect(function() -- Line: 407
    -- upvalues: LocalPlayer2 (copy), updateSettings (copy)
    LocalPlayer2:SetAttribute("ChatNotificationsEnabled", LocalPlayer2:GetAttribute("ChatNotificationsEnabled") ~= true);
    updateSettings();
end));
table.insert(u19, u9.ShowHitboxes.Activated:Connect(function() -- Line: 411
    -- upvalues: LocalPlayer2 (copy), Presentation (copy)
    if workspace:GetAttribute("PrivateServerSettingsOwnerId") ~= LocalPlayer2.UserId then
        return;
    end;

    local PrivateServerSettingsEvent = Presentation:FindFirstChild("PrivateServerSettingsEvent");

    if PrivateServerSettingsEvent then
        PrivateServerSettingsEvent:FireServer("Hitboxes", workspace:GetAttribute("PrivateServerHitboxesEnabled") ~= true);
    end;
end));
local AttributeChangedSignal2 = workspace:GetAttributeChangedSignal("PrivateServerHitboxesEnabled");
table.insert(u19, AttributeChangedSignal2:Connect(updateSettings));
table.insert(u19, u9.DisableBots.Activated:Connect(function() -- Line: 421
    -- upvalues: LocalPlayer2 (copy), Presentation (copy)
    if workspace:GetAttribute("PrivateServerSettingsOwnerId") ~= LocalPlayer2.UserId then
        return;
    end;

    local PrivateServerSettingsEvent = Presentation:FindFirstChild("PrivateServerSettingsEvent");

    if PrivateServerSettingsEvent then
        PrivateServerSettingsEvent:FireServer(workspace:GetAttribute("PrivateServerBotsDisabled") ~= true);
    end;
end));
local AttributeChangedSignal3 = workspace:GetAttributeChangedSignal("PrivateServerSettingsOwnerId");
table.insert(u19, AttributeChangedSignal3:Connect(function() -- Line: 430
    -- upvalues: ValleyHudView (copy), ValleyHUD (copy), updateSettings (copy)
    ValleyHudView.layout(ValleyHUD);
    updateSettings();
end));
table.insert(u19, u9.PrivateInvites.Activated:Connect(function() -- Line: 435
    -- upvalues: LocalPlayer2 (copy)
    LocalPlayer2:SetAttribute("PrivateInvitesOff", LocalPlayer2:GetAttribute("PrivateInvitesOff") ~= true);
end));
table.insert(u19, u9.HostButton.Activated:Connect(function() -- Line: 438
    -- upvalues: LocalPlayer2 (copy)
    LocalPlayer2:SetAttribute("HostButtonHidden", LocalPlayer2:GetAttribute("HostButtonHidden") ~= true);
end));
table.insert(u19, u9.BoardRank.Activated:Connect(function() -- Line: 442
    -- upvalues: LocalPlayer2 (copy)
    LocalPlayer2:SetAttribute("HideBoardRank", LocalPlayer2:GetAttribute("HideBoardRank") ~= true);
end));
local AttributeChangedSignal4 = LocalPlayer2:GetAttributeChangedSignal("HideBoardRank");
table.insert(u19, AttributeChangedSignal4:Connect(updateSettings));
local AttributeChangedSignal5 = LocalPlayer2:GetAttributeChangedSignal("PrivateInvitesOff");
table.insert(u19, AttributeChangedSignal5:Connect(updateSettings));
local AttributeChangedSignal6 = LocalPlayer2:GetAttributeChangedSignal("HostButtonHidden");
table.insert(u19, AttributeChangedSignal6:Connect(updateSettings));
local AttributeChangedSignal7 = workspace:GetAttributeChangedSignal("PrivateServerHostId");
table.insert(u19, AttributeChangedSignal7:Connect(function() -- Line: 448
    -- upvalues: ValleyHudView (copy), ValleyHUD (copy), updateSettings (copy)
    ValleyHudView.layout(ValleyHUD);
    updateSettings();
end));
local AttributeChangedSignal8 = workspace:GetAttributeChangedSignal("PrivateServerBotsDisabled");
table.insert(u19, AttributeChangedSignal8:Connect(updateSettings));
table.insert(u19, Panel.Close.Activated:Connect(close));
table.insert(u19, Panel2.Close.Activated:Connect(close));
table.insert(u19, u9.Mute.Activated:Connect(function() -- Line: 455
    -- upvalues: LocalPlayer2 (copy)
    LocalPlayer2:SetAttribute("MusicMuted", LocalPlayer2:GetAttribute("MusicMuted") ~= true);
end));
table.insert(u19, u9.EmoteSounds.Activated:Connect(function() -- Line: 458
    -- upvalues: LocalPlayer2 (copy)
    LocalPlayer2:SetAttribute("EmoteSoundsMuted", LocalPlayer2:GetAttribute("EmoteSoundsMuted") ~= true);
end));
table.insert(u19, u9.Hints.Activated:Connect(function() -- Line: 461
    -- upvalues: LocalPlayer2 (copy)
    LocalPlayer2:SetAttribute("SpectatorHints", LocalPlayer2:GetAttribute("SpectatorHints") == false);
end));
local MusicSlider = u9.MusicSlider;

local function slide(p60) -- Line: 465
    -- upvalues: MusicSlider (copy), LocalPlayer2 (copy)
    local v61 = (p60 - MusicSlider.AbsolutePosition.X) / math.max(MusicSlider.AbsoluteSize.X, 1) * 100 + 0.5;
    local v62 = math.floor(v61) / 100;
    LocalPlayer2:SetAttribute("MusicVolume", (math.clamp(v62, 0, 1)));
end;

table.insert(u19, MusicSlider.InputBegan:Connect(function(p63) -- Line: 468
    -- upvalues: u18 (ref), MusicSlider (copy), LocalPlayer2 (copy)
    if p63.UserInputType == Enum.UserInputType.MouseButton1 or p63.UserInputType == Enum.UserInputType.Touch then
        u18 = p63;
        local v64 = (p63.Position.X - MusicSlider.AbsolutePosition.X) / math.max(MusicSlider.AbsoluteSize.X, 1) * 100 + 0.5;
        local v65 = math.floor(v64) / 100;
        LocalPlayer2:SetAttribute("MusicVolume", (math.clamp(v65, 0, 1)));
    end;
end));
table.insert(u19, UserInputService.InputChanged:Connect(function(p66) -- Line: 474
    -- upvalues: u18 (ref), MusicSlider (copy), LocalPlayer2 (copy)
    if u18 and (p66 == u18 or u18.UserInputType == Enum.UserInputType.MouseButton1 and p66.UserInputType == Enum.UserInputType.MouseMovement) then
        local v67 = (p66.Position.X - MusicSlider.AbsolutePosition.X) / math.max(MusicSlider.AbsoluteSize.X, 1) * 100 + 0.5;
        local v68 = math.floor(v67) / 100;
        LocalPlayer2:SetAttribute("MusicVolume", (math.clamp(v68, 0, 1)));
    end;
end));
table.insert(u19, UserInputService.InputEnded:Connect(function(p69) -- Line: 488
    -- upvalues: u18 (ref)
    if p69 == u18 or p69.UserInputType == Enum.UserInputType.MouseButton1 then
        u18 = nil;
    end;
end));
table.insert(u19, UserInputService.WindowFocusReleased:Connect(function() -- Line: 493
    -- upvalues: u18 (ref)
    u18 = nil;
end));
local EmoteSlider = u9:FindFirstChild("EmoteSlider");

if EmoteSlider then
    local u70 = nil;

    local function slideEmote(p71) -- Line: 500
        -- upvalues: EmoteSlider (copy), LocalPlayer2 (copy)
        local v72 = (p71 - EmoteSlider.AbsolutePosition.X) / math.max(EmoteSlider.AbsoluteSize.X, 1) * 100 + 0.5;
        local v73 = math.floor(v72) / 100;
        LocalPlayer2:SetAttribute("EmoteVolume", (math.clamp(v73, 0, 1)));
    end;

    table.insert(u19, EmoteSlider.InputBegan:Connect(function(p74) -- Line: 503
        -- upvalues: u70 (ref), EmoteSlider (copy), LocalPlayer2 (copy)
        if p74.UserInputType == Enum.UserInputType.MouseButton1 or p74.UserInputType == Enum.UserInputType.Touch then
            u70 = p74;
            local v75 = (p74.Position.X - EmoteSlider.AbsolutePosition.X) / math.max(EmoteSlider.AbsoluteSize.X, 1) * 100 + 0.5;
            local v76 = math.floor(v75) / 100;
            LocalPlayer2:SetAttribute("EmoteVolume", (math.clamp(v76, 0, 1)));
        end;
    end));
    table.insert(u19, UserInputService.InputChanged:Connect(function(p77) -- Line: 509
        -- upvalues: u70 (ref), EmoteSlider (copy), LocalPlayer2 (copy)
        if u70 and (p77 == u70 or u70.UserInputType == Enum.UserInputType.MouseButton1 and p77.UserInputType == Enum.UserInputType.MouseMovement) then
            local v78 = (p77.Position.X - EmoteSlider.AbsolutePosition.X) / math.max(EmoteSlider.AbsoluteSize.X, 1) * 100 + 0.5;
            local v79 = math.floor(v78) / 100;
            LocalPlayer2:SetAttribute("EmoteVolume", (math.clamp(v79, 0, 1)));
        end;
    end));
    table.insert(u19, UserInputService.InputEnded:Connect(function(p80) -- Line: 520
        -- upvalues: u70 (ref)
        if p80 == u70 or p80.UserInputType == Enum.UserInputType.MouseButton1 then
            u70 = nil;
        end;
    end));
    table.insert(u19, UserInputService.WindowFocusReleased:Connect(function() -- Line: 525
        -- upvalues: u70 (ref)
        u70 = nil;
    end));
    table.insert(u19, UserInputService.InputBegan:Connect(function(p81) -- Line: 528
        -- upvalues: u15 (ref), GuiService (copy), EmoteSlider (copy), UserInputService (copy), LocalPlayer2 (copy)
        if u15 == "Settings" and (GuiService.SelectedObject == EmoteSlider and not UserInputService:GetFocusedTextBox()) then
            if p81.KeyCode == Enum.KeyCode.Left or p81.KeyCode == Enum.KeyCode.DPadLeft then
                local Attribute = LocalPlayer2:GetAttribute("EmoteVolume");
                local v82 = (type(Attribute) == "number" and (Attribute == Attribute and math.clamp(Attribute, 0, 1)) or 1) - 0.05;
                local v83 = math.floor(v82 * 100 + 0.5) / 100;
                LocalPlayer2:SetAttribute("EmoteVolume", (math.clamp(v83, 0, 1)));

                return;
            end;

            if p81.KeyCode == Enum.KeyCode.Right or p81.KeyCode == Enum.KeyCode.DPadRight then
                local Attribute = LocalPlayer2:GetAttribute("EmoteVolume");
                local v84 = (type(Attribute) == "number" and (Attribute == Attribute and math.clamp(Attribute, 0, 1)) or 1) + 0.05;
                local v85 = math.floor(v84 * 100 + 0.5) / 100;
                LocalPlayer2:SetAttribute("EmoteVolume", (math.clamp(v85, 0, 1)));
            end;
        end;
    end));
end;

table.insert(u19, UserInputService.InputBegan:Connect(function(p86) -- Line: 538
    -- upvalues: UserInputService (copy), u15 (ref), close (copy), GuiService (copy), MusicSlider (copy), LocalPlayer2 (copy)
    if UserInputService:GetFocusedTextBox() then
        return;
    end;

    if u15 and (p86.KeyCode == Enum.KeyCode.Escape or p86.KeyCode == Enum.KeyCode.ButtonB) then
        close();

        return;
    end;

    if u15 == "Settings" and GuiService.SelectedObject == MusicSlider then
        if p86.KeyCode == Enum.KeyCode.Left or p86.KeyCode == Enum.KeyCode.DPadLeft then
            local Attribute = LocalPlayer2:GetAttribute("MusicVolume");
            local v87 = (type(Attribute) == "number" and (Attribute == Attribute and math.clamp(Attribute, 0, 1)) or 1) - 0.05;
            local v88 = math.floor(v87 * 100 + 0.5) / 100;
            LocalPlayer2:SetAttribute("MusicVolume", (math.clamp(v88, 0, 1)));

            return;
        end;

        if p86.KeyCode == Enum.KeyCode.Right or p86.KeyCode == Enum.KeyCode.DPadRight then
            local Attribute = LocalPlayer2:GetAttribute("MusicVolume");
            local v89 = (type(Attribute) == "number" and (Attribute == Attribute and math.clamp(Attribute, 0, 1)) or 1) + 0.05;
            local v90 = math.floor(v89 * 100 + 0.5) / 100;
            LocalPlayer2:SetAttribute("MusicVolume", (math.clamp(v90, 0, 1)));
        end;
    end;
end));
local TextService = game:GetService("TextService");
local Entries = Panel2.Entries;
Entries:SetAttribute("SelfManagedText", true);
Entries.AutomaticCanvasSize = Enum.AutomaticSize.None;
Entries.Padding.PaddingBottom = UDim.new(0, 0);
Entries.Padding.PaddingRight = UDim.new(0.02, 0);
local u91 = {};

for i, v in UpdateLogConfig.Entries do
    local Frame = Instance.new("Frame");
    Frame.Name = "Entry" .. i;
    Frame.BackgroundTransparency = 1;
    Frame.LayoutOrder = i;
    Frame.Parent = Entries;
    local u92 = {};

    local function text(p93, p94, p95, p96, p97) -- Line: 567
        -- upvalues: Skin (copy), Frame (copy), u92 (copy)
        local TextLabel2 = Instance.new("TextLabel");
        TextLabel2.Name = p93;
        TextLabel2:SetAttribute("SelfManagedText", true);
        TextLabel2.TextScaled = false;
        TextLabel2.TextWrapped = true;
        TextLabel2.TextTruncate = Enum.TextTruncate.None;
        TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
        TextLabel2.TextYAlignment = Enum.TextYAlignment.Top;
        TextLabel2.BackgroundTransparency = 1;
        TextLabel2.Font = p97 and Enum.Font.GothamBold or Enum.Font.Gotham;
        TextLabel2.TextColor3 = p96;
        TextLabel2.Text = p94;
        Skin.textStroke(TextLabel2, 1);
        TextLabel2.Parent = Frame;
        table.insert(u92, {
            label = TextLabel2,
            factor = p95
        });
    end;

    text("Date", v.Date, 0.72, ValleyHudView.Gold, true);
    text("Title", v.Title, 1.4, ValleyHudView.Paper, true);

    for i2, v2 in v.Items do
        text("Note" .. i2, "•  " .. v2, 1, ValleyHudView.Muted, false);
    end;

    table.insert(u91, {
        card = Frame,
        rows = u92
    });
end;

local u98 = nil;

local function layoutLog() -- Line: 592
    -- upvalues: Entries (copy), u98 (ref), ValleyHUD (copy), u91 (copy), TextService (copy)
    local AbsoluteSize = Entries.AbsoluteSize;

    if AbsoluteSize.X <= 0 or (AbsoluteSize.Y <= 0 or AbsoluteSize == u98) then
        return;
    end;

    u98 = AbsoluteSize;
    local math_floor_ret = math.floor(AbsoluteSize.Y * 0.045 + 0.5);
    local math_max_ret = math.max(1, math_floor_ret);
    local v99 = ValleyHUD.AbsoluteSize.Y < 500;

    if v99 then
        math_max_ret = math.max(math_max_ret, 15);
    end;

    local math_max_ret2 = math.max(1, AbsoluteSize.X * 0.98);
    local v100 = AbsoluteSize.Y * 0.008;
    local v101 = AbsoluteSize.Y * 0.035;
    local v102 = 0;

    for _, v in u91 do
        local v103 = 0;

        for _, v2 in v.rows do
            local label = v2.label;
            local math_floor_ret2 = math.floor(math_max_ret * v2.factor + 0.5);
            label.TextSize = math.max(1, math_floor_ret2);

            if v2.factor == 1 then
                local v104;

                if v99 then
                    v104 = Enum.Font.GothamMedium;
                else
                    v104 = Enum.Font.Gotham;
                end;

                label.Font = v104;
            end;

            local TextSize = TextService:GetTextSize(label.Text, label.TextSize, label.Font, Vector2.new(math_max_ret2, 1000000));
            v2.height = math.max(label.TextSize, TextSize.Y) + label.TextSize * 0.15;
            v2.top = v103;
            v103 = v103 + (v2.height + v100);
        end;

        v.height = v103;
        v102 = v102 + v103;
    end;

    local v105 = v102 + (math.max(0, #u91 - 1) * v101 + AbsoluteSize.Y * 0.02);
    local math_max_ret3 = math.max(AbsoluteSize.Y, v105);
    Entries.CanvasSize = UDim2.fromScale(0, math_max_ret3 / AbsoluteSize.Y);
    Entries.List.Padding = UDim.new(v101 / math_max_ret3, 0);

    for _, v in u91 do
        v.card.Size = UDim2.fromScale(1, v.height / math_max_ret3);
        local v106 = v;

        for _, v2 in v.rows do
            v2.label.Position = UDim2.fromScale(0, v2.top / v106.height);
            v2.label.Size = UDim2.fromScale(1, v2.height / v106.height);
        end;
    end;
end;

local PropertyChangedSignal = Entries:GetPropertyChangedSignal("AbsoluteSize");
table.insert(u19, PropertyChangedSignal:Connect(layoutLog));
layoutLog();
Panel2.Heading.Text = UpdateLogConfig.Title;
local u107 = 0;
local u108 = nil;
table.insert(u19, HudNavigation.Opening.Event:Connect(function() -- Line: 642, Name: clearNotice
    -- upvalues: u107 (ref), u108 (ref), ValleyHUD (copy)
    u107 = u107 + 1;

    if u108 then
        u108:Cancel();
        u108 = nil;
    end;

    ValleyHUD.Notice.Visible = false;
end));
local PropertyChangedSignal2 = Navigation:GetPropertyChangedSignal("Visible");
table.insert(u19, PropertyChangedSignal2:Connect(function() -- Line: 651
    -- upvalues: Navigation (copy), u107 (ref), u108 (ref), ValleyHUD (copy)
    if not Navigation.Visible then
        u107 = u107 + 1;

        if u108 then
            u108:Cancel();
            u108 = nil;
        end;

        ValleyHUD.Notice.Visible = false;
    end;
end));
table.insert(u19, HudNavigation.Notice.Event:Connect(function(p109) -- Line: 656
    -- upvalues: u107 (ref), u108 (ref), ValleyHUD (copy), Navigation (copy), u8 (copy), TweenService (copy)
    u107 = u107 + 1;

    if u108 then
        u108:Cancel();
        u108 = nil;
    end;

    ValleyHUD.Notice.Visible = false;

    if not (Navigation.Visible and u8:isOpen()) then
        return;
    end;

    local u110 = u107;
    ValleyHUD.Notice.Text = p109;
    ValleyHUD.Notice.TextTransparency = 1;
    ValleyHUD.Notice.TextStrokeTransparency = 1;
    ValleyHUD.Notice.Visible = true;
    u108 = TweenService:Create(ValleyHUD.Notice, TweenInfo.new(0.16), {
        TextTransparency = 0,
        TextStrokeTransparency = 0.4
    });
    u108:Play();
    task.delay(2.6, function() -- Line: 668
        -- upvalues: u107 (ref), u110 (copy), u108 (ref), TweenService (ref), ValleyHUD (ref)
        if u107 ~= u110 then
            return;
        end;

        u108 = TweenService:Create(ValleyHUD.Notice, TweenInfo.new(0.3), {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        });
        u108:Play();
        task.delay(0.3, function() -- Line: 674
            -- upvalues: u107 (ref), u110 (ref), ValleyHUD (ref)
            if u107 == u110 then
                ValleyHUD.Notice.Visible = false;
            end;
        end);
    end);
end));

for _, v in { "Shop", "Inventory", "Spectate", "Journey", "Abilities", "Settings", "Codes", "Music", "Servers", "Updates" } do
    local u111 = Navigation:FindFirstChild(v) or ValleyHUD:FindFirstChild(v);

    if u111 then
        local function hover(p112) -- Line: 684
            -- upvalues: u111 (copy), TweenService (copy), ValleyHudView (copy)
            if u111.Active then
                TweenService:Create(u111, TweenInfo.new(0.12), {
                    BackgroundColor3 = p112 and ValleyHudView.Hover or ValleyHudView.Ink
                }):Play();
            end;
        end;

        table.insert(u19, u111.MouseEnter:Connect(function() -- Line: 695
            -- upvalues: hover (copy)
            hover(true);
        end));
        table.insert(u19, u111.MouseLeave:Connect(function() -- Line: 698
            -- upvalues: hover (copy)
            hover(false);
        end));
        table.insert(u19, u111.SelectionGained:Connect(function() -- Line: 701
            -- upvalues: hover (copy)
            hover(true);
        end));
        table.insert(u19, u111.SelectionLost:Connect(function() -- Line: 704
            -- upvalues: hover (copy)
            hover(false);
        end));
    end;
end;

for _, v in { "ClientReady", "InMatch", "GameRole", "ScreenPresentationActive", "TutorialRouting", "TutorialSession", "AdminRefreshActive", "Spectating", "AFK", "MusicMuted", "EmoteSoundsMuted", "MusicVolume", "EmoteVolume", "SpectatorHints", "SettingsOpen", "UpdateLogOpen" } do
    local AttributeChangedSignal9 = LocalPlayer2:GetAttributeChangedSignal(v);
    table.insert(u19, AttributeChangedSignal9:Connect(refresh));
end;

for _, v in u40 do
    local AttributeChangedSignal9 = LocalPlayer2:GetAttributeChangedSignal(v);
    table.insert(u19, AttributeChangedSignal9:Connect(refresh));
end;

local AttributeChangedSignal9 = LocalPlayer2:GetAttributeChangedSignal("InMatch");
table.insert(u19, AttributeChangedSignal9:Connect(function() -- Line: 734
    -- upvalues: LocalPlayer2 (copy), close (copy)
    if LocalPlayer2:GetAttribute("InMatch") then
        close();
    end;
end));
local PropertyChangedSignal3 = UserInputService:GetPropertyChangedSignal("PreferredInput");
table.insert(u19, PropertyChangedSignal3:Connect(refresh));
local AttributeChangedSignal10 = LocalPlayer2:GetAttributeChangedSignal("CandyCorn");
table.insert(u19, AttributeChangedSignal10:Connect(refresh));
table.insert(u19, HudNavigation.Changed.Event:Connect(refresh));
local PropertyChangedSignal4 = ValleyHUD:GetPropertyChangedSignal("AbsoluteSize");
table.insert(u19, PropertyChangedSignal4:Connect(function() -- Line: 742
    -- upvalues: ValleyHudView (copy), ValleyHUD (copy)
    ValleyHudView.layout(ValleyHUD);
end));

local function updateBoostLabels() -- Line: 747
    -- upvalues: LocalPlayer2 (copy), ValleyHUD (copy), Skin (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();

    for i, v in {
        Coins = { "CoinBoostEndsAt", "AdminCoinBoostEndsAt" },
        Gems = { "GemBoostEndsAt", "AdminGemBoostEndsAt" }
    } do
        local v113 = LocalPlayer2:GetAttribute(v[1]) or 0;
        local v114 = workspace:GetAttribute(v[2]) or 0;
        local math_max_ret = math.max(v113, v114);
        local v115;

        if type(math_max_ret) == "number" and (math_max_ret == math_max_ret and math_max_ret < (1 / 0)) then
            local math_ceil_ret = math.ceil(math_max_ret - ServerTimeNow);
            v115 = math.max(0, math_ceil_ret) or 0;
        else
            v115 = 0;
        end;

        local Label = ValleyHUD.Wallet[i].Label;
        Label.TextScaled = true;
        Label.TextWrapped = false;
        Label.Text = v115 > 0 and string.format("%s [2X - %02d:%02d]", i:upper(), math.floor(v115 / 60), v115 % 60) or i:upper();
        Label.TextColor3 = v115 > 0 and Skin.Palette.boost or Skin.Palette.textSecondary;
        local v116 = ValleyHUD:FindFirstChild("2x" .. i .. "Timer");

        if v116 and v116:IsA("TextLabel") then
            local Attribute = workspace:GetAttribute(v[2]);
            local v117;

            if type(Attribute) == "number" and (Attribute == Attribute and Attribute < (1 / 0)) then
                local math_ceil_ret = math.ceil(Attribute - ServerTimeNow);
                v117 = math.max(0, math_ceil_ret) or 0;
            else
                v117 = 0;
            end;

            v116.Visible = v117 > 0;
            v116.Text = v117 > 0 and string.format("2x %s: %dm %ds", i, math.floor(v117 / 60), v117 % 60) or "";
        end;
    end;
end;

local AttributeChangedSignal11 = LocalPlayer2:GetAttributeChangedSignal("CoinBoostEndsAt");
table.insert(u19, AttributeChangedSignal11:Connect(updateBoostLabels));
local AttributeChangedSignal12 = LocalPlayer2:GetAttributeChangedSignal("GemBoostEndsAt");
table.insert(u19, AttributeChangedSignal12:Connect(updateBoostLabels));
local AttributeChangedSignal13 = workspace:GetAttributeChangedSignal("AdminCoinBoostEndsAt");
table.insert(u19, AttributeChangedSignal13:Connect(updateBoostLabels));
local AttributeChangedSignal14 = workspace:GetAttributeChangedSignal("AdminGemBoostEndsAt");
table.insert(u19, AttributeChangedSignal14:Connect(updateBoostLabels));
local u118 = 0;
local Heartbeat = game:GetService("RunService").Heartbeat;
table.insert(u19, Heartbeat:Connect(function(p119) -- Line: 790
    -- upvalues: u118 (ref), updateBoostLabels (copy)
    u118 = u118 + p119;

    if u118 >= 0.2 then
        u118 = 0;
        updateBoostLabels();
    end;
end));
updateBoostLabels();
local TweenInfo_new_ret = TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out);
local TweenInfo_new_ret2 = TweenInfo.new(0.32, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local TweenInfo_new_ret3 = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In);
local TweenInfo_new_ret4 = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out, 0, true);
local u120 = 0;

local function soulsTarget() -- Line: 807
    -- upvalues: LocalPlayer2 (copy), u11 (ref)
    local v121 = (tonumber(LocalPlayer2:GetAttribute("FallenKingCarried")) or 0) - u11;

    return math.max(0, v121);
end;

local function soulText(p122, p123, p124, p125) -- Line: 810
    -- upvalues: Souls (ref), Color3_fromRGB_ret (copy)
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.AnchorPoint = Vector2.new(0, 0.5);
    TextLabel2.Position = p124;
    TextLabel2.Size = p125;
    TextLabel2.FontFace = Souls.Value.FontFace;
    TextLabel2.TextScaled = true;
    TextLabel2.TextXAlignment = Enum.TextXAlignment.Left;
    TextLabel2.TextColor3 = Color3_fromRGB_ret;
    TextLabel2.TextStrokeTransparency = 0;
    TextLabel2.Text = p123;
    TextLabel2.ZIndex = 50;
    TextLabel2.Parent = p122;

    return TextLabel2;
end;

local function soulsChanged() -- Line: 826
    -- upvalues: LocalPlayer2 (copy), u11 (ref), u120 (ref), u10 (ref), soulText (copy), Souls (ref), TweenService (copy), refresh (copy)
    local v126 = (tonumber(LocalPlayer2:GetAttribute("FallenKingCarried")) or 0) - u11;
    local math_max_ret = math.max(0, v126);
    u120 = u120 + 1;

    if math_max_ret < u10 then
        local u127 = u120;
        local u128 = u10;
        local math_floor_ret = math.floor(u128 - math_max_ret or 0);
        local math_max_ret2 = math.max(0, math_floor_ret);
        local v129 = soulText(Souls, "-" .. tostring(math_max_ret2):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", ""), UDim2.new(1, 6, 0.5, 0), UDim2.fromOffset(70, 26));
        TweenService:Create(v129, TweenInfo.new(0.9, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextTransparency = 1,
            TextStrokeTransparency = 1,
            Position = UDim2.new(1, 6, 0.5, -26)
        }):Play();
        task.delay(0.95, v129.Destroy, v129);
        task.spawn(function() -- Line: 839
            -- upvalues: u120 (ref), u127 (copy), u10 (ref), u128 (copy), math_max_ret (copy), Souls (ref), refresh (ref)
            local os_clock_ret = os.clock();

            while u120 == u127 do
                local v130 = (os.clock() - os_clock_ret) / 0.8;
                local math_min_ret = math.min(1, v130);
                u10 = math.round(u128 + (math_max_ret - u128) * math_min_ret);
                local Value = Souls.Value;
                local math_floor_ret2 = math.floor(u10 or 0);
                local math_max_ret3 = math.max(0, math_floor_ret2);
                Value.Text = tostring(math_max_ret3):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");

                if math_min_ret >= 1 then
                    task.wait(0.4);

                    if u120 == u127 then
                        refresh();

                        return;
                    end;

                    break;
                end;

                task.wait();
            end;
        end);
    else
        u10 = math_max_ret;
    end;

    refresh();
end;

local function soulCollected() -- Line: 861
    -- upvalues: u11 (ref), refresh (copy), LocalPlayer2 (copy), Souls (ref), ValleyHUD (copy), FallenKingConfig (copy), soulsChanged (copy), GuiService (copy), soulText (copy), TweenService (copy), TweenInfo_new_ret (copy), TweenInfo_new_ret2 (copy), TweenInfo_new_ret3 (copy), TweenInfo_new_ret4 (copy)
    u11 = u11 + 1;
    refresh();
    local workspace_CurrentCamera = workspace.CurrentCamera;
    local v131 = LocalPlayer2.Character and LocalPlayer2.Character:FindFirstChild("HumanoidRootPart");
    local Icon = Souls:FindFirstChild("Icon");

    if not (workspace_CurrentCamera and (v131 and (Icon and (ValleyHUD.Enabled and (ValleyHUD.Wallet.Visible and FallenKingConfig.active(workspace:GetServerTimeNow())))))) then
        u11 = math.max(0, u11 - 1);
        soulsChanged();

        return;
    end;

    local v132;

    if ValleyHUD.IgnoreGuiInset then
        v132 = Vector2.zero;
    else
        v132 = GuiService:GetGuiInset();
    end;

    local v133, v134 = workspace_CurrentCamera:WorldToViewportPoint(v131.Position + Vector3.new(0, 3, 0));
    local v135;

    if v134 then
        v135 = Vector2.new(v133.X, v133.Y) - v132;
    else
        v135 = ValleyHUD.AbsoluteSize / 2;
    end;

    local Frame = Instance.new("Frame");
    Frame.Name = "SoulPop";
    Frame.AnchorPoint = Vector2.new(0.5, 0.5);
    Frame.BackgroundTransparency = 1;
    Frame.Position = UDim2.fromOffset(v135.X, v135.Y);
    Frame.Size = UDim2.fromOffset(0, 0);
    Frame.ZIndex = 50;
    local ImageLabel = Instance.new("ImageLabel");
    ImageLabel.BackgroundTransparency = 1;
    ImageLabel.Image = "rbxassetid://92036662316128";
    ImageLabel.ScaleType = Enum.ScaleType.Fit;
    ImageLabel.Size = UDim2.fromScale(0.5, 1);
    ImageLabel.ZIndex = 50;
    ImageLabel.Parent = Frame;
    local u136 = soulText(Frame, "+1", UDim2.fromScale(0.52, 0.5), UDim2.fromScale(0.48, 0.8));
    Frame.Parent = ValleyHUD;
    TweenService:Create(Frame, TweenInfo_new_ret, {
        Size = UDim2.fromOffset(96, 46)
    }):Play();
    TweenService:Create(Frame, TweenInfo_new_ret2, {
        Position = UDim2.fromOffset(v135.X, v135.Y - 44)
    }):Play();
    task.delay(0.55, function() -- Line: 893
        -- upvalues: Frame (copy), Icon (copy), TweenService (ref), TweenInfo_new_ret3 (ref), u136 (copy)
        if not Frame.Parent then
            return;
        end;

        local v137 = Icon.AbsolutePosition + Icon.AbsoluteSize / 2;
        local math_max_ret = math.max(Icon.AbsoluteSize.Y, 16);
        TweenService:Create(Frame, TweenInfo_new_ret3, {
            Position = UDim2.fromOffset(v137.X + math_max_ret / 2, v137.Y),
            Size = UDim2.fromOffset(math_max_ret * 2, math_max_ret)
        }):Play();
        TweenService:Create(u136, TweenInfo_new_ret3, {
            TextTransparency = 1,
            TextStrokeTransparency = 1
        }):Play();
    end);
    task.delay(1.05, function() -- Line: 906
        -- upvalues: Frame (copy), u11 (ref), soulsChanged (ref), Souls (ref), TweenService (ref), TweenInfo_new_ret4 (ref)
        Frame:Destroy();
        u11 = math.max(0, u11 - 1);
        soulsChanged();
        local Small = Souls:FindFirstChild("Small");

        if Small then
            TweenService:Create(Small, TweenInfo_new_ret4, {
                Scale = 1
            }):Play();
        end;
    end);
end;

local AttributeChangedSignal15 = LocalPlayer2:GetAttributeChangedSignal("FallenKingCarried");
table.insert(u19, AttributeChangedSignal15:Connect(soulsChanged));
task.spawn(function() -- Line: 917
    -- upvalues: Souls (ref), soulCollected (copy), u19 (copy)
    local FallenKingEvent = game.ReplicatedStorage.ChickenOrHero.Game:WaitForChild("FallenKingEvent", 30);

    if FallenKingEvent and Souls.Parent then
        table.insert(u19, FallenKingEvent.OnClientEvent:Connect(function(p138) -- Line: 920
            -- upvalues: soulCollected (ref)
            if p138 == "Collected" then
                soulCollected();
            end;
        end));
    end;
end);
ValleyHudView.layout(ValleyHUD);
refresh();
script.Destroying:Connect(function() -- Line: 930
    -- upvalues: close (copy), u8 (copy), u19 (copy)
    close();
    u8:destroy();

    for _, v in u19 do
        v:Disconnect();
    end;
end);
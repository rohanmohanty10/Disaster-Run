 

 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local GamepadService = game:GetService("GamepadService");
local ContextActionService = game:GetService("ContextActionService");
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local Emotes = ChickenOrHero:WaitForChild("Emotes");
local EmoteEvent = Emotes:WaitForChild("EmoteEvent");
local Weapons = ChickenOrHero:WaitForChild("Weapons");
local ArmoryEvent = Weapons:WaitForChild("ArmoryEvent");
local ArmoryNavigation = Weapons:WaitForChild("ArmoryNavigation");
local EmoteCatalog = require(Emotes.EmoteCatalog);
local EmotePlayback = require(Emotes.EmotePlayback);
local HudNavigation = require(ChickenOrHero.Presentation.HudNavigation);
local EmoteWheelView = require(ChickenOrHero.Presentation.EmoteWheelView);
local ValleyToast = require(ChickenOrHero.Presentation.ValleyToast);
local Skin = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local Theme = Skin.Theme;
EmotePlayback.watch();
local Color3_fromRGB_ret = Color3.fromRGB(80, 255, 100);
local textMuted = Skin.Palette.textMuted;
local u1 = { "StarterPackOpen", "LikeRewardOpen", "CreatorPanelOpen", "CreatorUIHidden", "CreatorCameraActive", "MapVoteOpen", "ReleaseCameraForUI", "ScreenPresentationActive", "AdminRefreshActive", "FairPlayNoticeOpen", "BalloonOfferOpen", "MatchSummaryVisible", "AdminConsoleActive", "AnnouncementComposerOpen", "Spectating" };
local u2 = { "ArmoryOpen", "JourneyOpen", "SettingsOpen", "UpdateLogOpen", "ServerBrowserOpen", "CombineOpen", "PumpkinSacrificeOpen", "PumpkinsOpen", "HalloweenShopOpen", "GhostTraderActive", "FallenKingSpoilsOpen", "FallenKingAltarOpen" };
local u3 = {
    [Enum.KeyCode.One] = 1,
    [Enum.KeyCode.Two] = 2,
    [Enum.KeyCode.Three] = 3,
    [Enum.KeyCode.Four] = 4,
    [Enum.KeyCode.Five] = 5,
    [Enum.KeyCode.Six] = 6
};
local G = Enum.KeyCode.G;
local DPadUp = Enum.KeyCode.DPadUp;
local u4, u5 = EmoteWheelView.build(PlayerGui);
local Wheel = u4.Shade.Wheel;
local Center = Wheel.Center;
local u6 = false;
local u7 = {
    loaded = false,
    pending = false,
    emotes = {},
    emoteSlots = {}
};
local u8 = 0;
local u9 = (-1 / 0);
local u10 = (-1 / 0);
local u11 = false;
local u12 = false;
local u13 = nil;
local Vector2_zero = Vector2.zero;
local u14 = nil;
local u15 = nil;
local u16 = {};

local function on(p17, p18) -- Line: 53
    -- upvalues: u16 (copy)
    local v19 = p17:Connect(p18);
    table.insert(u16, v19);

    return v19;
end;

local function any(p20) -- Line: 55
    -- upvalues: LocalPlayer (copy)
    for _, v in p20 do
        if LocalPlayer:GetAttribute(v) == true then
            return true;
        end;
    end;

    return false;
end;

local function ready() -- Line: 59
    -- upvalues: EmoteCatalog (copy), LocalPlayer (copy), u1 (copy)
    local Enabled = EmoteCatalog.Enabled;

    if Enabled then
        if LocalPlayer:GetAttribute("ClientReady") == true then
            local v21 = false;

            for _, v in u1 do
                if LocalPlayer:GetAttribute(v) == true then
                    v21 = true;
                    break;
                end;
            end;

            Enabled = not v21;
        else
            Enabled = false;
        end;
    end;

    return Enabled;
end;

local function equipped() -- Line: 62
    -- upvalues: u7 (copy)
    return type(u7.emoteSlots) == "table" and u7.emoteSlots or {};
end;

local function entryAt(p22) -- Line: 65
    -- upvalues: u7 (copy), EmoteCatalog (copy)
    local v23 = (type(u7.emoteSlots) == "table" and (u7.emoteSlots or {}) or {})[p22];

    if type(v23) ~= "string" or (v23 == "" or not (EmoteCatalog.get(v23) and v23)) then
        v23 = nil;
    end;

    return v23;
end;

local function refresh() -- Line: 70
    -- upvalues: u9 (ref), ArmoryEvent (copy)
    if os.clock() - u9 < 0.75 then
        return;
    end;

    u9 = os.clock();
    ArmoryEvent:FireServer("Get");
end;

local function setStatus(p24, p25, p26) -- Line: 75
    -- upvalues: u6 (ref), Wheel (copy), u8 (ref), ValleyToast (copy)
    if not u6 then
        if not p26 then
            ValleyToast.show(p24);
        end;

        return;
    end;

    Wheel.Status.Text = p24;
    u8 = os.clock() + (p25 or 4);
end;

local function comingSoon() -- Line: 80
    -- upvalues: u10 (ref), ValleyToast (copy)
    if os.clock() - u10 >= 2 then
        u10 = os.clock();
        ValleyToast.show("Coming soon!");
    end;
end;

local u27 = {};
local u28 = {};

local function clearPreview(p29) -- Line: 88
    -- upvalues: u27 (copy), EmotePlayback (copy)
    local v30 = u27[p29];
    u27[p29] = nil;

    if v30 then
        EmotePlayback.dispose(v30.track);
    end;
end;

local function cancel() -- Line: 91
    -- upvalues: LocalPlayer (copy), EmoteEvent (copy), u27 (copy), EmotePlayback (copy)
    local Character = LocalPlayer.Character;

    if Character and Character:GetAttribute("EmoteId") then
        EmoteEvent:FireServer("Stop");
        local v31 = u27[Character];
        u27[Character] = nil;

        if v31 then
            EmotePlayback.dispose(v31.track);
        end;

        local v32 = Character:FindFirstChildOfClass("Humanoid");

        if v32 then
            v32 = v32:FindFirstChildOfClass("Animator");
        end;

        if v32 then
            for _, v in v32:GetPlayingAnimationTracks() do
                if v.Name:sub(1, 12) == "ValleyEmote_" then
                    v:Stop(0.08);
                end;
            end;
        end;
    end;
end;

local function gamepadCursor(p33) -- Line: 102
    -- upvalues: u11 (ref), UserInputService (copy), GamepadService (copy), Center (copy)
    if p33 then
        if not (u11 or (UserInputService.PreferredInput ~= Enum.PreferredInput.Gamepad or GamepadService.GamepadCursorEnabled)) then
            u11 = pcall(GamepadService.EnableGamepadCursor, GamepadService, Center);
        end;
    elseif u11 then
        u11 = false;

        if GamepadService.GamepadCursorEnabled then
            pcall(GamepadService.DisableGamepadCursor, GamepadService);
        end;
    end;
end;

local u34 = nil;

local function back(p35, p36) -- Line: 114
    -- upvalues: u34 (ref)
    if p36 ~= Enum.UserInputState.Begin then
        return Enum.ContextActionResult.Pass;
    end;

    u34();

    return Enum.ContextActionResult.Sink;
end;

local function bindBack(p37) -- Line: 118
    -- upvalues: u12 (ref), ContextActionService (copy), back (copy)
    if p37 == u12 then
        return;
    end;

    u12 = p37;

    if p37 then
        ContextActionService:BindActionAtPriority("ValleyEmoteWheelBack", back, false, Enum.ContextActionPriority.High.Value + 100, Enum.KeyCode.ButtonB);

        return;
    end;

    ContextActionService:UnbindAction("ValleyEmoteWheelBack");
end;

u34 = function() -- Line: 124, Name: close
    -- upvalues: u6 (ref), u4 (copy), LocalPlayer (copy), u12 (ref), ContextActionService (copy), u11 (ref), GamepadService (copy)
    if not u6 then
        return;
    end;

    u6 = false;
    u4.Shade.Visible = false;
    LocalPlayer:SetAttribute("EmoteWheelOpen", nil);

    if u12 ~= false then
        u12 = false;
        ContextActionService:UnbindAction("ValleyEmoteWheelBack");
    end;

    if u11 then
        u11 = false;

        if GamepadService.GamepadCursorEnabled then
            pcall(GamepadService.DisableGamepadCursor, GamepadService);
        end;
    end;
end;

local function render() -- Line: 130
    -- upvalues: LocalPlayer (copy), EmoteCatalog (copy), Center (copy), EmoteWheelView (copy), u4 (copy), u5 (copy), textMuted (copy), Theme (copy), u7 (copy), UserInputService (copy), Wheel (copy), Color3_fromRGB_ret (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:GetAttribute("EmoteId");
    end;

    if EmoteCatalog.ComingSoon then
        Center.EmoteName.Text = "COMING SOON";
        EmoteWheelView.setStop(u4, false);

        for _, v in u5 do
            v.Number.Visible = false;
            v.Caption.Text = "COMING SOON";
            v.Caption.TextColor3 = textMuted;
            v.Source.Text = "";
            v.Border.Color = Theme.Border;
            v.Border.Transparency = 0.5;
        end;

        return;
    end;

    local v38 = type(u7.emoteSlots) == "table" and (u7.emoteSlots or {}) or {};
    local v39 = UserInputService.PreferredInput == Enum.PreferredInput.KeyboardAndMouse;
    local v40;

    if type(Character) == "string" then
        v40 = EmoteCatalog.get(Character);
    else
        v40 = false;
    end;

    Center.EmoteName.Text = v40 and v40.Name or "EMOTES";
    EmoteWheelView.setStop(u4, Character ~= nil);
    local v41 = EmoteCatalog.ultimate(LocalPlayer:GetAttribute("EquippedKnife"));
    Wheel.Ultimate.Visible = v41 ~= nil;
    Wheel.Ultimate.Text = (v41 == nil or Character ~= v41) and "ULTIMATE" or "STOP ULTIMATE";

    for i, v in u5 do
        local v42 = v38[i];
        local v43;

        if type(v42) == "string" and v42 ~= "" then
            v43 = EmoteCatalog.get(v42) or nil;
        else
            v43 = nil;
        end;

        local v44;

        if v39 then
            v44 = v43 ~= nil;
        else
            v44 = v39;
        end;

        v.Number.Visible = v44;

        if v43 then
            local v45 = Character == v42;
            v.Caption.Text = v43.Name;
            v.Caption.TextColor3 = Theme.Paper;
            v.Source.Text = v45 and "PLAYING · WALK AWAY TO STOP" or (EmoteCatalog.available(v42) and "" or "NOT RELEASED YET");
            v.Source.TextColor3 = v45 and Color3_fromRGB_ret or Theme.Purple;
            v.Border.Color = v45 and Color3_fromRGB_ret or Theme.Border;
            v.Border.Transparency = 0;
        else
            v.Caption.Text = "EMPTY";
            v.Caption.TextColor3 = textMuted;
            v.Source.Text = "EQUIP ONE IN MY EMOTES";
            v.Source.TextColor3 = textMuted;
            v.Border.Color = Theme.Border;
            v.Border.Transparency = 0.5;
        end;
    end;
end;

local function openShop(p46) -- Line: 169
    -- upvalues: LocalPlayer (copy), u6 (ref), Wheel (copy), u8 (ref), ValleyToast (copy), u34 (ref), ArmoryNavigation (copy)
    if LocalPlayer:GetAttribute("InMatch") ~= true then
        u34();
        ArmoryNavigation:Fire(p46);

        return;
    end;

    local v47 = p46 == "Emotes" and "Open My Emotes in the lobby." or "Open the Emote Crate in the lobby.";

    if not u6 then
        ValleyToast.show(v47);

        return;
    end;

    Wheel.Status.Text = v47;
    u8 = os.clock() + 4;
end;

local function choose(p48) -- Line: 176
    -- upvalues: EmoteCatalog (copy), u10 (ref), ValleyToast (copy), u7 (copy), LocalPlayer (copy), u6 (ref), Wheel (copy), u8 (ref), u34 (ref), ArmoryNavigation (copy), cancel (copy), EmoteEvent (copy)
    if EmoteCatalog.ComingSoon then
        if os.clock() - u10 >= 2 then
            u10 = os.clock();
            ValleyToast.show("Coming soon!");
        end;

        return;
    end;

    local v49 = (type(u7.emoteSlots) == "table" and (u7.emoteSlots or {}) or {})[p48];

    if type(v49) ~= "string" or (v49 == "" or not (EmoteCatalog.get(v49) and v49)) then
        v49 = nil;
    end;

    if not v49 then
        if LocalPlayer:GetAttribute("InMatch") ~= true then
            u34();
            ArmoryNavigation:Fire("Emotes");

            return;
        end;

        if not u6 then
            ValleyToast.show("Open My Emotes in the lobby.");

            return;
        end;

        Wheel.Status.Text = "Open My Emotes in the lobby.";
        u8 = os.clock() + 4;

        return;
    end;

    local Character = LocalPlayer.Character;

    if Character and Character:GetAttribute("EmoteId") == v49 then
        cancel();
        u34();

        return;
    end;

    if not EmoteCatalog.available(v49) then
        if not u6 then
            ValleyToast.show("This emote is not released yet.");

            return;
        end;

        Wheel.Status.Text = "This emote is not released yet.";
        u8 = os.clock() + 4;

        return;
    end;

    EmoteEvent:FireServer("Play", v49);

    if not u6 then
        return;
    end;

    Wheel.Status.Text = "Starting…";
    u8 = os.clock() + 3;
end;

local function open() -- Line: 185
    -- upvalues: u6 (ref), EmoteCatalog (copy), LocalPlayer (copy), u1 (copy), u10 (ref), ValleyToast (copy), HudNavigation (copy), Vector2_zero (ref), UserInputService (copy), Wheel (copy), u8 (ref), u4 (copy), EmoteWheelView (copy), render (copy), u9 (ref), ArmoryEvent (copy), u12 (ref), ContextActionService (copy), back (copy), u11 (ref), GamepadService (copy), Center (copy)
    if u6 then
        return true;
    end;

    if EmoteCatalog.ComingSoon then
        local Enabled = EmoteCatalog.Enabled;

        if Enabled then
            if LocalPlayer:GetAttribute("ClientReady") == true then
                local v50 = false;

                for _, v in u1 do
                    if LocalPlayer:GetAttribute(v) == true then
                        v50 = true;
                        break;
                    end;
                end;

                Enabled = not v50;
            else
                Enabled = false;
            end;
        end;

        if Enabled and os.clock() - u10 >= 2 then
            u10 = os.clock();
            ValleyToast.show("Coming soon!");
        end;

        return false;
    end;

    local Enabled = EmoteCatalog.Enabled;

    if Enabled then
        if LocalPlayer:GetAttribute("ClientReady") == true then
            local v51 = false;

            for _, v in u1 do
                if LocalPlayer:GetAttribute(v) == true then
                    v51 = true;
                    break;
                end;
            end;

            Enabled = not v51;
        else
            Enabled = false;
        end;
    end;

    if not Enabled then
        return false;
    end;

    HudNavigation.opening("Emotes");
    LocalPlayer:SetAttribute("SpectateRequestedExit", os.clock());
    u6 = true;
    Vector2_zero = UserInputService:GetMouseLocation();
    Wheel.Status.Text = "";
    u8 = 0;
    u4.Shade.Visible = true;
    LocalPlayer:SetAttribute("EmoteWheelOpen", true);
    EmoteWheelView.layout(u4);
    render();

    if os.clock() - u9 >= 0.75 then
        u9 = os.clock();
        ArmoryEvent:FireServer("Get");
    end;

    if u12 ~= true then
        u12 = true;
        ContextActionService:BindActionAtPriority("ValleyEmoteWheelBack", back, false, Enum.ContextActionPriority.High.Value + 100, Enum.KeyCode.ButtonB);
    end;

    task.defer(function() -- Line: 198
        -- upvalues: u6 (ref), u11 (ref), UserInputService (ref), GamepadService (ref), Center (ref)
        if u6 and not (u11 or (UserInputService.PreferredInput ~= Enum.PreferredInput.Gamepad or GamepadService.GamepadCursorEnabled)) then
            u11 = pcall(GamepadService.EnableGamepadCursor, GamepadService, Center);
        end;
    end);

    return true;
end;

local function quick(p52) -- Line: 203
    -- upvalues: EmoteCatalog (copy), u6 (ref), choose (copy), u7 (copy), u9 (ref), ArmoryEvent (copy), ValleyToast (copy)
    if EmoteCatalog.ComingSoon then
        return;
    end;

    if u6 then
        choose(p52);

        return;
    end;

    if not u7.loaded then
        if os.clock() - u9 < 0.75 then
            return;
        end;

        u9 = os.clock();
        ArmoryEvent:FireServer("Get");

        return;
    end;

    local v53 = (type(u7.emoteSlots) == "table" and (u7.emoteSlots or {}) or {})[p52];

    if type(v53) ~= "string" or (v53 == "" or not (EmoteCatalog.get(v53) and v53)) then
        v53 = nil;
    end;

    if v53 then
        choose(p52);

        return;
    end;

    ValleyToast.show(("Slot %d is empty. Equip an emote in My Emotes."):format(p52));
end;

local function release() -- Line: 212
    -- upvalues: u13 (ref), u34 (ref)
    u13 = nil;
    u34();
end;

local v54 = u4.Open.Activated:Connect(function() -- Line: 201, Name: toggle
    -- upvalues: u6 (ref), u34 (ref), open (copy)
    if u6 then
        u34();

        return;
    end;

    open();
end);
table.insert(u16, v54);
local v55 = Wheel.Close.Activated:Connect(u34);
table.insert(u16, v55);

for i, v in u5 do
    local v56 = v.Activated:Connect(function() -- Line: 218
        -- upvalues: u6 (ref), choose (copy), i (copy)
        if u6 then
            choose(i);
        end;
    end);
    table.insert(u16, v56);
    local v58 = v.MouseEnter:Connect(function() -- Line: 221
        -- upvalues: u13 (ref), G (copy), u6 (ref), UserInputService (copy), Vector2_zero (ref), i (copy), u7 (copy), EmoteCatalog (copy), LocalPlayer (copy), choose (copy)
        if u13 ~= G or (not u6 or (UserInputService:GetMouseLocation() - Vector2_zero).Magnitude < 12) then
            return;
        end;

        local v57 = (type(u7.emoteSlots) == "table" and (u7.emoteSlots or {}) or {})[i];

        if type(v57) ~= "string" or (v57 == "" or not (EmoteCatalog.get(v57) and v57)) then
            v57 = nil;
        end;

        local Character = LocalPlayer.Character;

        if v57 then
            if Character then
                Character = Character:GetAttribute("EmoteId");
            end;

            if v57 ~= Character then
                choose(i);
            end;
        end;
    end);
    table.insert(u16, v58);
end;

local v59 = Center.MyEmotes.Activated:Connect(function() -- Line: 227
    -- upvalues: u6 (ref), LocalPlayer (copy), Wheel (copy), u8 (ref), ValleyToast (copy), u34 (ref), ArmoryNavigation (copy)
    if u6 then
        if LocalPlayer:GetAttribute("InMatch") == true then
            if not u6 then
                ValleyToast.show("Open My Emotes in the lobby.");

                return;
            end;

            Wheel.Status.Text = "Open My Emotes in the lobby.";
            u8 = os.clock() + 4;

            return;
        end;

        u34();
        ArmoryNavigation:Fire("Emotes");
    end;
end);
table.insert(u16, v59);
local v60 = Wheel.GetEmotes.Activated:Connect(function() -- Line: 228
    -- upvalues: u6 (ref), LocalPlayer (copy), Wheel (copy), u8 (ref), ValleyToast (copy), u34 (ref), ArmoryNavigation (copy)
    if u6 then
        if LocalPlayer:GetAttribute("InMatch") == true then
            if not u6 then
                ValleyToast.show("Open the Emote Crate in the lobby.");

                return;
            end;

            Wheel.Status.Text = "Open the Emote Crate in the lobby.";
            u8 = os.clock() + 4;

            return;
        end;

        u34();
        ArmoryNavigation:Fire("EmoteCrate");
    end;
end);
table.insert(u16, v60);
local v62 = Wheel.Ultimate.Activated:Connect(function() -- Line: 229
    -- upvalues: u6 (ref), EmoteCatalog (copy), LocalPlayer (copy), cancel (copy), u34 (ref), EmoteEvent (copy), Wheel (copy), u8 (ref)
    local v61 = u6 and EmoteCatalog.ultimate(LocalPlayer:GetAttribute("EquippedKnife"));

    if not v61 then
        return;
    end;

    local Character = LocalPlayer.Character;

    if Character and Character:GetAttribute("EmoteId") == v61 then
        cancel();
        u34();

        return;
    end;

    EmoteEvent:FireServer("Play", v61);

    if not u6 then
        return;
    end;

    Wheel.Status.Text = "Starting…";
    u8 = os.clock() + 3;
end);
table.insert(u16, v62);
local v63 = Center.Stop.Activated:Connect(function() -- Line: 236
    -- upvalues: cancel (copy), u34 (ref)
    cancel();
    u34();
end);
table.insert(u16, v63);
local v65 = HudNavigation.Opening.Event:Connect(function(p64) -- Line: 237
    -- upvalues: u34 (ref)
    if p64 ~= "Emotes" then
        u34();
    end;
end);
table.insert(u16, v65);
local v66 = LocalPlayer.CharacterAdded:Connect(function() -- Line: 238
    -- upvalues: u34 (ref)
    u34();
end);
table.insert(u16, v66);
local v69 = ArmoryEvent.OnClientEvent:Connect(function(p67, p68) -- Line: 239
    -- upvalues: u7 (copy), u6 (ref), render (copy)
    if p67 ~= "State" or type(p68) ~= "table" then
        return;
    end;

    u7.loaded = p68.loaded == true;
    u7.pending = p68.pending == true;

    if type(p68.emotes) == "table" then
        u7.emotes = p68.emotes;
    end;

    if type(p68.emoteSlots) == "table" then
        u7.emoteSlots = p68.emoteSlots;
    end;

    if u6 then
        render();
    end;
end);
table.insert(u16, v69);
local v72 = EmoteEvent.OnClientEvent:Connect(function(p70, p71) -- Line: 246
    -- upvalues: u6 (ref), Wheel (copy), u8 (ref), ValleyToast (copy), u34 (ref)
    if p70 ~= "State" or (type(p71) ~= "table" or (type(p71.message) ~= "string" or p71.message == "")) then
        if p70 == "NeedKnife" and (type(p71) == "string" and p71 ~= "") then
            ValleyToast.show(p71);

            return;
        end;

        if p70 == "Playing" then
            u34();
        end;

        return;
    end;

    local message = p71.message;

    if not u6 then
        ValleyToast.show(message);

        return;
    end;

    Wheel.Status.Text = message;
    u8 = os.clock() + 4;
end);
table.insert(u16, v72);
local v77 = UserInputService.InputBegan:Connect(function(p73, p74) -- Line: 253
    -- upvalues: UserInputService (copy), u6 (ref), u34 (ref), DPadUp (copy), open (copy), G (copy), u13 (ref), u3 (copy), EmoteCatalog (copy), LocalPlayer (copy), u1 (copy), quick (copy)
    if UserInputService:GetFocusedTextBox() then
        return;
    end;

    if u6 and p73.KeyCode == Enum.KeyCode.Escape then
        u34();

        return;
    end;

    if p74 then
        return;
    end;

    if p73.KeyCode == DPadUp then
        if u6 then
            u34();

            return;
        end;

        open();

        return;
    end;

    if p73.KeyCode == G then
        u13 = G;
        open();

        return;
    end;

    local v75 = u3[p73.KeyCode];

    if v75 then
        local Enabled = EmoteCatalog.Enabled;

        if Enabled then
            if LocalPlayer:GetAttribute("ClientReady") == true then
                local v76 = false;

                for _, v in u1 do
                    if LocalPlayer:GetAttribute(v) == true then
                        v76 = true;
                        break;
                    end;
                end;

                Enabled = not v76;
            else
                Enabled = false;
            end;
        end;

        if Enabled then
            quick(v75);
        end;
    end;
end);
table.insert(u16, v77);
local v79 = UserInputService.InputEnded:Connect(function(p78) -- Line: 262
    -- upvalues: u13 (ref), u34 (ref)
    if u13 and p78.KeyCode == u13 then
        u13 = nil;
        u34();
    end;
end);
table.insert(u16, v79);
local v80 = UserInputService.WindowFocusReleased:Connect(function() -- Line: 264
    -- upvalues: u13 (ref), u34 (ref)
    if u13 then
        u13 = nil;
        u34();
    end;
end);
table.insert(u16, v80);
local v81 = UserInputService:GetPropertyChangedSignal("PreferredInput"):Connect(function() -- Line: 265
    -- upvalues: EmoteWheelView (copy), u4 (copy), UserInputService (copy), u6 (ref), render (copy)
    EmoteWheelView.badge(u4, UserInputService.PreferredInput);

    if u6 then
        render();
    end;
end);
table.insert(u16, v81);
local u82 = 0;
local v98 = RunService.Heartbeat:Connect(function(p83) -- Line: 270
    -- upvalues: LocalPlayer (copy), u14 (ref), u15 (ref), cancel (copy), u82 (ref), EmoteCatalog (copy), u1 (copy), u6 (ref), u34 (ref), UserInputService (copy), u4 (copy), u2 (copy), PlayerGui (copy), u8 (ref), Wheel (copy), render (copy), RunService (copy), u28 (copy), Players (copy), u27 (copy), EmotePlayback (copy)
    local Character = LocalPlayer.Character;
    local v84;

    if Character then
        v84 = Character:FindFirstChild("HumanoidRootPart");
    else
        v84 = Character;
    end;

    local v85 = Character and Character:GetAttribute("EmoteId") and Character:GetAttribute("EmoteStartedAt");

    if v85 and v84 then
        if v85 == u15 then
            if u14 then
                local v86 = v84.Position - u14;

                if v86.X * v86.X + v86.Z * v86.Z > 9 then
                    u14 = nil;
                    cancel();
                end;
            end;
        else
            u14 = v84.Position;
            u15 = v85;
        end;
    else
        u14 = nil;
        u15 = nil;
    end;

    u82 = u82 + p83;

    if u82 < 0.1 then
        return;
    end;

    u82 = 0;
    local Enabled = EmoteCatalog.Enabled;

    if Enabled then
        if LocalPlayer:GetAttribute("ClientReady") == true then
            local v87 = false;

            for _, v in u1 do
                if LocalPlayer:GetAttribute(v) == true then
                    v87 = true;
                    break;
                end;
            end;

            Enabled = not v87;
        else
            Enabled = false;
        end;
    end;

    if u6 and (not Enabled or EmoteCatalog.ComingSoon) then
        u34();
    end;

    local v88 = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled;
    local Open = u4.Open;

    if Enabled then
        local v89 = not u6;

        if v89 then
            local v90 = false;

            for _, v in u2 do
                if LocalPlayer:GetAttribute(v) == true then
                    v90 = true;
                    break;
                end;
            end;

            local v91 = not v90;

            if v91 then
                if not v88 then
                    if LocalPlayer:GetAttribute("LightsOutDark") == true then
                        v88 = false;
                    else
                        v88 = true;
                    end;
                end;
            else
                v88 = v91;
            end;
        else
            v88 = v89;
        end;
    else
        v88 = Enabled;
    end;

    Open.Visible = v88;
    local ValleyHUD = PlayerGui:FindFirstChild("ValleyHUD");

    if ValleyHUD then
        ValleyHUD = ValleyHUD:FindFirstChild("MenuToggle");
    end;

    if ValleyHUD then
        local AbsolutePosition = u4.AbsolutePosition;
        u4.Open.Position = UDim2.fromOffset(ValleyHUD.AbsolutePosition.X - AbsolutePosition.X, ValleyHUD.AbsolutePosition.Y + ValleyHUD.AbsoluteSize.Y + 6 - AbsolutePosition.Y);
    end;

    if u6 then
        if u8 > 0 and u8 < os.clock() then
            Wheel.Status.Text = "";
            u8 = 0;
        end;

        render();
    end;

    if RunService:IsStudio() and not EmoteCatalog.ComingSoon then
        table.clear(u28);

        for _, v in Players:GetPlayers() do
            local Character2 = v.Character;
            local v92;

            if Character2 then
                v92 = Character2:GetAttribute("EmoteId");
            else
                v92 = Character2;
            end;

            if Character2 and (v92 and (EmoteCatalog.get(v92) and not EmoteCatalog.assetId(v92))) then
                u28[Character2] = true;
                local v93 = u27[Character2];
                local Attribute = Character2:GetAttribute("EmoteStartedAt");

                if not (v93 and (v93.id == v92 and v93.stamp == Attribute)) then
                    local v94 = u27[Character2];
                    u27[Character2] = nil;

                    if v94 then
                        EmotePlayback.dispose(v94.track);
                    end;

                    local v95 = Character2:FindFirstChildOfClass("Humanoid");

                    if v95 then
                        v95 = v95:FindFirstChildOfClass("Animator");
                    end;

                    if v95 then
                        local v96 = EmotePlayback.load(v95, v92);
                        u27[Character2] = {
                            id = v92,
                            stamp = Attribute,
                            track = v96
                        };

                        if v96 then
                            v96:Play(0.15);
                        end;
                    end;
                end;
            end;
        end;

        for i in u27 do
            if not u28[i] then
                local v97 = u27[i];
                u27[i] = nil;

                if v97 then
                    EmotePlayback.dispose(v97.track);
                end;
            end;
        end;

        table.clear(u28);
    end;
end);
table.insert(u16, v98);
local v99 = u4:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 318
    -- upvalues: EmoteWheelView (copy), u4 (copy)
    EmoteWheelView.layout(u4);
end);
table.insert(u16, v99);
EmoteWheelView.badge(u4, UserInputService.PreferredInput);
EmoteWheelView.dim(u4, EmoteCatalog.ComingSoon);
EmoteWheelView.layout(u4);
render();

if os.clock() - u9 >= 0.75 then
    u9 = os.clock();
    ArmoryEvent:FireServer("Get");
end;

script.Destroying:Connect(function() -- Line: 321
    -- upvalues: u34 (ref), u13 (ref), u12 (ref), ContextActionService (copy), u11 (ref), GamepadService (copy), u16 (copy), u27 (copy), EmotePlayback (copy), u4 (copy)
    u34();
    u13 = nil;

    if u12 ~= false then
        u12 = false;
        ContextActionService:UnbindAction("ValleyEmoteWheelBack");
    end;

    if u11 then
        u11 = false;

        if GamepadService.GamepadCursorEnabled then
            pcall(GamepadService.DisableGamepadCursor, GamepadService);
        end;
    end;

    for _, v in u16 do
        v:Disconnect();
    end;

    table.clear(u16);

    for i in u27 do
        local v100 = u27[i];
        u27[i] = nil;

        if v100 then
            EmotePlayback.dispose(v100.track);
        end;
    end;

    u4:Destroy();
end);
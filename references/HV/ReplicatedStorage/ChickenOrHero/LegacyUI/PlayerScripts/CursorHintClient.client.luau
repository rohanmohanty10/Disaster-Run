 

 

local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local LocalPlayer = Players.LocalPlayer;
local v1 = UserInputService.PreferredInput == Enum.PreferredInput.KeyboardAndMouse;
LocalPlayer:SetAttribute("CursorHintPending", v1 or nil);

if not v1 then
    return;
end;

local EmoteEvent = game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Emotes"):WaitForChild("EmoteEvent");
local Skin = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local Panels = Skin.Panels;
local Theme = Skin.Theme;
local u2 = Panels.screen(LocalPlayer, "CursorWelcome", 74);
local u3 = Panels.make("Frame", u2, "Hint", {
    BorderSizePixel = 0,
    Visible = false,
    Active = false,
    Size = UDim2.fromOffset(430, 148),
    Position = UDim2.fromScale(0.5, 0.26),
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = Theme.Ink
});
Theme.surface(u3, Theme.Ink, Theme.Gold, 8, 0.45);
Panels.make("UIScale", u3, "Scale", {});
Panels.text(u3, "Eyebrow", "ONE QUICK CONTROL", 20, 13, 350, 18, 10, Theme.Gold);
Panels.text(u3, "Title", "Hold ALT to free your mouse", 20, 35, 390, 30, 20, Theme.Paper).Font = Enum.Font.GothamBold;
Panels.text(u3, "Body", "Use it to reach menus. Let go to look around again.", 20, 70, 390, 35, 13, Theme.Muted);
local v4 = Panels.button(u3, "Done", "GOT IT", 292, 110, 118, 28, Theme.Ink);
Theme.button(v4, Theme.Gold);
v4.TextSize = 11;
Skin.panel(u3, {
    radius = UDim.new(0, 14)
});
Skin.button(v4, "primary");
local u5 = false;
local u6 = false;
local u7 = false;

local function complete(p8) -- Line: 24
    -- upvalues: u7 (ref), u3 (copy), LocalPlayer (copy), EmoteEvent (copy)
    if u7 then
        return;
    end;

    u7 = true;
    u3.Visible = false;
    LocalPlayer:SetAttribute("CursorHintPending", nil);
    LocalPlayer:SetAttribute("CursorHintOpen", nil);

    if p8 then
        EmoteEvent:FireServer("CursorHintSeen");
        task.delay(2, function() -- Line: 27
            -- upvalues: LocalPlayer (ref), EmoteEvent (ref)
            if LocalPlayer.Parent then
                EmoteEvent:FireServer("CursorHintSeen");
            end;
        end);
    end;
end;

v4.Activated:Connect(function() -- Line: 29
    -- upvalues: complete (copy)
    complete(true);
end);
local u11 = EmoteEvent.OnClientEvent:Connect(function(p9, p10) -- Line: 30
    -- upvalues: u5 (ref), u6 (ref), u7 (ref), u3 (copy), LocalPlayer (copy)
    if p9 == "State" and type(p10) == "table" then
        u5 = p10.loaded;
        u6 = p10.cursorHintSeen == true;

        if u6 then
            if u7 then
                return;
            end;

            u7 = true;
            u3.Visible = false;
            LocalPlayer:SetAttribute("CursorHintPending", nil);
            LocalPlayer:SetAttribute("CursorHintOpen", nil);
        end;
    end;
end);
local u13 = UserInputService.InputBegan:Connect(function(p12) -- Line: 33
    -- upvalues: u3 (copy), complete (copy)
    if u3.Visible and (p12.KeyCode == Enum.KeyCode.LeftAlt or p12.KeyCode == Enum.KeyCode.RightAlt) then
        task.delay(0.6, function() -- Line: 34
            -- upvalues: complete (ref)
            complete(true);
        end);
    end;
end);
local u14 = { "CreatorPanelOpen", "CreatorUIHidden", "CreatorCameraActive", "MapVoteOpen", "InMatch", "ScreenPresentationActive", "TutorialRouting", "TutorialSession", "TutorialActive", "TutorialFinishing", "BalloonOfferOpen", "ArmoryOpen", "ServerBrowserOpen", "JourneyOpen", "SettingsOpen", "UpdateLogOpen", "AdminConsoleActive", "AnnouncementComposerOpen", "EmoteWheelOpen", "MatchSummaryVisible", "FairPlayNoticeOpen", "ConnectionQualityOpen", "AdminRefreshActive", "Spectating" };

local function permitted() -- Line: 37
    -- upvalues: LocalPlayer (copy), UserInputService (copy), u14 (copy)
    if LocalPlayer:GetAttribute("ClientReady") ~= true or (UserInputService:GetFocusedTextBox() or game:GetService("GuiService").MenuIsOpen) then
        return false;
    end;

    for _, v in u14 do
        if LocalPlayer:GetAttribute(v) == true then
            return false;
        end;
    end;

    return true;
end;

u2:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() -- Line: 42, Name: layout
    -- upvalues: u2 (copy), u3 (copy)
    local AbsoluteSize = u2.AbsoluteSize;
    u3.Scale.Scale = math.min(1.1, AbsoluteSize.X * 0.92 / 430, AbsoluteSize.Y * 0.6 / 148);
end);
local AbsoluteSize = u2.AbsoluteSize;
u3.Scale.Scale = math.min(1.1, AbsoluteSize.X * 0.92 / 430, AbsoluteSize.Y * 0.6 / 148);
EmoteEvent:FireServer("Get");
task.spawn(function() -- Line: 46
    -- upvalues: u2 (copy), u7 (ref), u5 (ref), EmoteEvent (copy), permitted (copy), u3 (copy), LocalPlayer (copy), u11 (copy), u13 (copy)
    local os_clock_ret = os.clock();
    local v15 = 0;
    local v16 = nil;

    while u2.Parent and not u7 do
        if not u5 and v15 < os.clock() then
            v15 = os.clock() + 3;
            EmoteEvent:FireServer("Get");
        end;

        if u5 and permitted() then
            v16 = v16 or os.clock();

            if os.clock() - v16 > 1.5 then
                u3.Visible = true;
                LocalPlayer:SetAttribute("CursorHintOpen", true);
            end;
        else
            u3.Visible = false;
            LocalPlayer:SetAttribute("CursorHintOpen", nil);
            v16 = nil;
        end;

        if not (u5 or (os.clock() - os_clock_ret <= 30 or u7)) then
            u7 = true;
            u3.Visible = false;
            LocalPlayer:SetAttribute("CursorHintPending", nil);
            LocalPlayer:SetAttribute("CursorHintOpen", nil);
        end;

        task.wait(0.2);
    end;

    u11:Disconnect();
    u13:Disconnect();
end);
script.Destroying:Connect(function() -- Line: 60
    -- upvalues: u7 (ref), u3 (copy), LocalPlayer (copy), u11 (copy), u13 (copy), u2 (copy)
    if not u7 then
        u7 = true;
        u3.Visible = false;
        LocalPlayer:SetAttribute("CursorHintPending", nil);
        LocalPlayer:SetAttribute("CursorHintOpen", nil);
    end;

    u11:Disconnect();
    u13:Disconnect();
    u2:Destroy();
end);
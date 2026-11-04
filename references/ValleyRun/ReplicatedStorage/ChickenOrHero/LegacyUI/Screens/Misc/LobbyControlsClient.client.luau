 

 

local HudNavigation = require(game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Presentation"):WaitForChild("HudNavigation"));
local Players = game:GetService("Players");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");
local LocalPlayer = Players.LocalPlayer;
local PlayerPreferences = game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Game"):WaitForChild("PlayerPreferences");
local LobbyControls = script.Parent:WaitForChild("MainFrame"):WaitForChild("LobbyControls");
local AFKF = LobbyControls:WaitForChild("AFKF");
local AFKButton = AFKF:WaitForChild("AFKButton");
local MuteIB = LobbyControls:WaitForChild("MusicControls"):WaitForChild("MuteF"):WaitForChild("MuteIB");
local Feedback = LobbyControls:WaitForChild("Feedback");
local KeyboardHint = LobbyControls:WaitForChild("KeyboardHint");
local u1 = {};
local u2 = 0;
local u3 = 0;

local function canAFK() -- Line: 15
    -- upvalues: LocalPlayer (copy)
    local v4;

    if LocalPlayer:GetAttribute("TutorialRouting") == true or (LocalPlayer:GetAttribute("TutorialSession") == true or LocalPlayer:GetAttribute("InMatch") == true) then
        v4 = false;
    else
        v4 = (LocalPlayer:GetAttribute("GameRole") or "Lobby") == "Lobby";
    end;

    return v4;
end;

local function update() -- Line: 18
    -- upvalues: LocalPlayer (copy), LobbyControls (copy), HudNavigation (copy), canAFK (copy), AFKF (copy), AFKButton (copy), MuteIB (copy), KeyboardHint (copy), UserInputService (copy), GuiService (copy)
    local v5 = LocalPlayer:GetAttribute("AFK") == true;
    local v6 = LocalPlayer:GetAttribute("MusicMuted") == true;
    LobbyControls.Visible = false;
    HudNavigation.setAvailable("AFK", (canAFK()));
    AFKF.Visible = canAFK();
    AFKButton.Active = canAFK();
    AFKButton.Selectable = canAFK();
    AFKButton.Text = v5 and "AFK: ON" or "AFK: OFF";
    AFKButton.TextColor3 = v5 and Color3.fromRGB(80, 255, 100) or Color3.fromRGB(255, 255, 255);
    MuteIB.Image = MuteIB[v6 and "Sound Off" or "Sound On"].Texture;
    MuteIB:SetAttribute("MusicMuted", v6);
    KeyboardHint.Visible = UserInputService.PreferredInput == Enum.PreferredInput.KeyboardAndMouse;
    KeyboardHint.Text = canAFK() and "Alt: cursor   K: AFK   M: music" or "Alt: cursor   M: music";

    if not canAFK() and GuiService.SelectedObject == AFKButton then
        GuiService.SelectedObject = MuteIB;
    end;
end;

local function say(p7) -- Line: 31
    -- upvalues: HudNavigation (copy), u3 (ref), Feedback (copy)
    HudNavigation.Notice:Fire(p7);
    u3 = os.clock() + 2.5;
    Feedback.Text = p7;
    Feedback.Visible = true;
    local u8 = u3;
    task.delay(2.5, function() -- Line: 35
        -- upvalues: u3 (ref), u8 (copy), Feedback (ref)
        if u3 == u8 then
            Feedback.Visible = false;
        end;
    end);
end;

local function toggleAFK() -- Line: 37
    -- upvalues: canAFK (copy), u2 (ref), PlayerPreferences (copy), LocalPlayer (copy)
    if not canAFK() or os.clock() < u2 then
        return;
    end;

    u2 = os.clock() + 0.5;
    PlayerPreferences:FireServer("SetAFK", LocalPlayer:GetAttribute("AFK") ~= true);
end;

HudNavigation.register("AFK", toggleAFK);
table.insert(u1, AFKButton.Activated:Connect(toggleAFK));
table.insert(u1, MuteIB.Activated:Connect(function() -- Line: 42, Name: toggleMusic
    -- upvalues: LocalPlayer (copy)
    LocalPlayer:SetAttribute("MusicMuted", LocalPlayer:GetAttribute("MusicMuted") ~= true);
end));
table.insert(u1, PlayerPreferences.OnClientEvent:Connect(function(p9, p10, p11, p12) -- Line: 46
    -- upvalues: update (copy), say (copy)
    if p9 == "AFKResult" then
        update();
        local v13;

        if p10 then
            v13 = p11 and "Sitting this match out." or "Ready for the next match.";
        else
            v13 = p12 or "Try again in the lobby.";
        end;

        say(v13);
    end;
end));

for _, v in { "AFK", "InMatch", "GameRole", "MusicMuted", "TutorialRouting", "TutorialSession" } do
    local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal(v);
    table.insert(u1, AttributeChangedSignal:Connect(update));
end;

local PropertyChangedSignal = UserInputService:GetPropertyChangedSignal("PreferredInput");
table.insert(u1, PropertyChangedSignal:Connect(update));
table.insert(u1, UserInputService.InputBegan:Connect(function(p14, p15) -- Line: 51
    -- upvalues: UserInputService (copy), GuiService (copy), toggleAFK (copy), LocalPlayer (copy)
    if p15 or (UserInputService:GetFocusedTextBox() or GuiService.MenuIsOpen) then
        return;
    end;

    if p14.KeyCode == Enum.KeyCode.K then
        toggleAFK();

        return;
    end;

    if p14.KeyCode == Enum.KeyCode.M then
        LocalPlayer:SetAttribute("MusicMuted", LocalPlayer:GetAttribute("MusicMuted") ~= true);

        return;
    end;

    if p14.KeyCode == Enum.KeyCode.LeftAlt or p14.KeyCode == Enum.KeyCode.RightAlt then
        LocalPlayer:SetAttribute("ReleaseCursorForControls", true);
    end;
end));
table.insert(u1, UserInputService.InputEnded:Connect(function(p16) -- Line: 57
    -- upvalues: LocalPlayer (copy)
    if p16.KeyCode == Enum.KeyCode.LeftAlt or p16.KeyCode == Enum.KeyCode.RightAlt then
        LocalPlayer:SetAttribute("ReleaseCursorForControls", nil);
    end;
end));
table.insert(u1, UserInputService.WindowFocusReleased:Connect(function() -- Line: 60
    -- upvalues: LocalPlayer (copy)
    LocalPlayer:SetAttribute("ReleaseCursorForControls", nil);
end));
script.Destroying:Connect(function() -- Line: 61
    -- upvalues: u1 (copy), LocalPlayer (copy)
    for _, v in u1 do
        v:Disconnect();
    end;

    LocalPlayer:SetAttribute("ReleaseCursorForControls", nil);
end);
update();
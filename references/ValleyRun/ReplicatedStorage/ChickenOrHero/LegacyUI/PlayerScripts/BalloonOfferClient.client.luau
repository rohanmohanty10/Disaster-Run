 

 

local Players = game:GetService("Players");
local SocialService = game:GetService("SocialService");
local RunService = game:GetService("RunService");
local UserInputService = game:GetService("UserInputService");
local LocalPlayer = Players.LocalPlayer;
local Weapons = game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Weapons");
local ArmoryEvent = Weapons:WaitForChild("ArmoryEvent");
local StarterPackEvent = Weapons.Parent:WaitForChild("Gear"):WaitForChild("StarterPackEvent");
local StarterPackConfig = require(Weapons.Parent.Gear:WaitForChild("StarterPackConfig"));
local ArmoryNavigation = Weapons:WaitForChild("ArmoryNavigation");
local Skin = require(game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero"):WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local Palette = Skin.Palette;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "BalloonOffer";
ScreenGui.ResetOnSpawn = false;
ScreenGui.DisplayOrder = 80;
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
ScreenGui.Parent = PlayerGui;
local Frame = Instance.new("Frame");
Frame.Name = "Card";
Frame.AnchorPoint = Vector2.new(0.5, 0.5);
Frame.Position = UDim2.fromScale(0.5, 0.5);
Frame.Size = UDim2.fromOffset(560, 430);
Frame.BackgroundColor3 = Color3.fromRGB(28, 25, 42);
Frame.BorderSizePixel = 0;
Frame.Visible = false;
Frame.Active = false;
Frame.Parent = ScreenGui;
local UIScale = Instance.new("UIScale");
UIScale.Parent = Frame;
local UICorner = Instance.new("UICorner");
UICorner.CornerRadius = UDim.new(0, 18);
UICorner.Parent = Frame;
local UIStroke = Instance.new("UIStroke");
UIStroke.Color = Color3.fromRGB(242, 137, 190);
UIStroke.Transparency = 0.4;
UIStroke.Parent = Frame;
Skin.card(Frame, Color3.fromRGB(120, 50, 95));
Skin.ring(Frame, Palette.emoteOffer, 2);

local function label(p1, p2, p3, p4, p5, p6, p7, p8) -- Line: 28
    -- upvalues: Palette (copy), Skin (copy), Frame (copy)
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = p1;
    TextLabel.Text = p2;
    TextLabel.Position = UDim2.fromOffset(p3, p4);
    TextLabel.Size = UDim2.fromOffset(p5, p6);
    TextLabel.Font = Enum.Font.GothamBold;
    TextLabel.TextSize = p7;
    TextLabel.TextColor3 = p8 or Palette.text;
    TextLabel.BackgroundTransparency = 1;
    TextLabel.TextWrapped = true;
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left;
    Skin.textStroke(TextLabel, 1);
    TextLabel.Parent = Frame;

    return TextLabel;
end;

local function button(p9, p10, p11, p12, p13, p14, p15) -- Line: 31
    -- upvalues: Palette (copy), Frame (copy)
    local TextButton = Instance.new("TextButton");
    TextButton.Name = p9;
    TextButton.Text = p10;
    TextButton.Position = UDim2.fromOffset(p11, p12);
    TextButton.Size = UDim2.fromOffset(p13, p14);
    TextButton.Font = Enum.Font.GothamBold;
    TextButton.TextSize = 16;
    TextButton.TextColor3 = Palette.text;
    TextButton.BackgroundColor3 = p15;
    TextButton.Parent = Frame;
    local UICorner2 = Instance.new("UICorner");
    UICorner2.CornerRadius = UDim.new(0, 9);
    UICorner2.Parent = TextButton;

    return TextButton;
end;

label("Eyebrow", "A LITTLE PARTY FAVOUR", 26, 22, 450, 24, 14, Palette.emoteOffer);
local v16 = button("Close", "×", 509, 12, 38, 36, Color3.fromRGB(44, 37, 55));
v16.Modal = true;
Skin.button(v16, "close");
label("Title", "FREE BALLOON\nDAGGER", 264, 77, 270, 72, 28);
label("Description", "Bring a friend to the Valley.\nKeep the party forever.", 264, 159, 263, 70, 18, Palette.textSecondary);
local ViewportFrame = Instance.new("ViewportFrame");
ViewportFrame.Name = "Dagger";
ViewportFrame.Position = UDim2.fromOffset(16, 54);
ViewportFrame.Size = UDim2.fromOffset(242, 214);
ViewportFrame.BackgroundTransparency = 1;
ViewportFrame.Ambient = Color3.fromRGB(210, 210, 220);
ViewportFrame.LightColor = Color3.new(1, 1, 1);
ViewportFrame.Parent = Frame;
local BalloonDagger = Weapons:WaitForChild("Models"):WaitForChild("BalloonDagger");
local WorldModel = Instance.new("WorldModel");
WorldModel.Parent = ViewportFrame;
local v17 = BalloonDagger:WaitForChild("Blade"):Clone();
local u18 = false;

for _, descendant in v17:GetDescendants() do
    if descendant:IsA("JointInstance") or (descendant:IsA("LuaSourceContainer") or descendant:IsA("WeldConstraint")) then
        descendant:Destroy();
    end;
end;

v17.CFrame = BalloonDagger:GetAttribute("PreviewRotation") or CFrame.identity;
v17.Anchored = true;
v17.Transparency = 0;
v17.Parent = WorldModel;
local Camera = Instance.new("Camera");
Camera.FieldOfView = 35;
Camera.Parent = ViewportFrame;
ViewportFrame.CurrentCamera = Camera;
local math_max_ret = math.max(v17.Size.X, v17.Size.Y, v17.Size.Z);
local u19 = label("Progress", "○  Invite a friend who joins through your invite.", 26, 266, 508, 50, 17, Palette.textSecondary);
local u20 = button("Invite", "INVITE A FRIEND", 26, 330, 250, 46, Color3.fromRGB(163, 72, 124));
local u21 = button("Claim", "CHECK CLAIM", 286, 330, 248, 46, Color3.fromRGB(55, 46, 72));
Skin.button(u20, "robux", {
    radius = UDim.new(0, 9)
});
local u22 = nil;
local u23 = label("Note", "Like or favourite if you enjoy the Valley — always optional.", 26, 385, 508, 26, 12, Palette.textBody);
local GuiService = game:GetService("GuiService");
local u24 = nil;
local u25 = {
    loaded = false,
    owned = {}
};
local u26 = false;
local u27 = false;
local u28 = 0;
local u29 = 0;
local u30 = 0;

local function permitted() -- Line: 54
    -- upvalues: LocalPlayer (copy)
    local v31;

    if LocalPlayer:GetAttribute("TutorialActive") == true or (LocalPlayer:GetAttribute("StarterPackOpen") == true or LocalPlayer:GetAttribute("TutorialFinishing") == true) then
        v31 = false;
    else
        v31 = not (LocalPlayer:GetAttribute("CreatorPanelOpen") or (LocalPlayer:GetAttribute("CreatorUIHidden") or LocalPlayer:GetAttribute("CreatorCameraActive")));

        if v31 then
            if LocalPlayer:GetAttribute("MapVoteOpen") == true or (LocalPlayer:GetAttribute("CursorHintPending") == true or (LocalPlayer:GetAttribute("CursorHintOpen") == true or (LocalPlayer:GetAttribute("EmoteWheelOpen") == true or (LocalPlayer:GetAttribute("AnnouncementComposerOpen") == true or (LocalPlayer:GetAttribute("JourneyOpen") == true or (LocalPlayer:GetAttribute("SettingsOpen") == true or (LocalPlayer:GetAttribute("UpdateLogOpen") == true or (LocalPlayer:GetAttribute("ClientReady") ~= true or (LocalPlayer:GetAttribute("InMatch") == true or (LocalPlayer:GetAttribute("ScreenPresentationActive") == true or (LocalPlayer:GetAttribute("AdminRefreshActive") == true or (LocalPlayer:GetAttribute("TutorialRouting") == true or (LocalPlayer:GetAttribute("AdminConsoleActive") == true or LocalPlayer:GetAttribute("ServerBrowserOpen") == true))))))))))))) then
                v31 = false;
            else
                v31 = LocalPlayer:GetAttribute("MatchSummaryVisible") ~= true;
            end;
        end;
    end;

    return v31;
end;

local function update() -- Line: 57
    -- upvalues: u25 (ref), u19 (copy), Palette (copy), u21 (copy), u20 (copy), u22 (ref), Skin (copy)
    local v32 = u25.owned.BalloonDagger == true;
    u19.Text = v32 and "✓  Unlocked! Your balloon dagger is yours forever." or "○  Invite a friend who joins through your invite.";
    u19.TextColor3 = v32 and Palette.unlocked or Palette.textSecondary;
    u21.Text = u25.loaded and (u25.equipped == "BalloonDagger" and "EQUIPPED ✓" or (v32 and "EQUIP DAGGER" or "CHECK CLAIM")) or "LOADING…";
    u20.Visible = not v32;
    local v33 = u25.loaded and u25.equipped == "BalloonDagger" and "dark" or (v32 and "primary" or "secondary");

    if v33 ~= u22 then
        u22 = v33;
        Skin.button(u21, v33, {
            radius = UDim.new(0, 9)
        });

        if v33 == "dark" then
            Skin.select(u21, true, Palette.green);
        end;
    end;

    u21.Position = UDim2.fromOffset(v32 and 26 or 286, 330);
    u21.Size = UDim2.fromOffset(v32 and 508 or 248, 46);
end;

local function show(p34) -- Line: 67
    -- upvalues: permitted (copy), u26 (ref), u24 (ref), GuiService (copy), Frame (copy), LocalPlayer (copy), ArmoryEvent (copy), update (copy), UserInputService (copy), u25 (ref), u21 (copy), u20 (copy)
    if p34 and not permitted() then
        return;
    end;

    if p34 and not u26 then
        u24 = GuiService.SelectedObject;
    end;

    if not p34 and (GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(Frame)) then
        GuiService.SelectedObject = u24 and (u24.Parent and u24) or nil;
    end;

    u26 = p34;
    Frame.Visible = p34;
    LocalPlayer:SetAttribute("BalloonOfferOpen", p34);

    if p34 then
        ArmoryEvent:FireServer("Get");
        update();

        if UserInputService.GamepadEnabled then
            GuiService.SelectedObject = u25.owned.BalloonDagger and u21 or u20;
        end;
    end;
end;

v16.Activated:Connect(function() -- Line: 74
    -- upvalues: GuiService (copy), Frame (copy), u24 (ref), u26 (ref), LocalPlayer (copy)
    if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(Frame) then
        GuiService.SelectedObject = u24 and (u24.Parent and u24) or nil;
    end;

    u26 = false;
    Frame.Visible = false;
    LocalPlayer:SetAttribute("BalloonOfferOpen", false);
end);
ArmoryNavigation.Event:Connect(function(p35) -- Line: 75
    -- upvalues: permitted (copy), u26 (ref), u24 (ref), GuiService (copy), Frame (copy), LocalPlayer (copy), ArmoryEvent (copy), update (copy), UserInputService (copy), u25 (ref), u21 (copy), u20 (copy)
    if p35 == "Balloon" then
        if not permitted() then
            return;
        end;

        if not u26 then
            u24 = GuiService.SelectedObject;
        end;

        u26 = true;
        Frame.Visible = true;
        LocalPlayer:SetAttribute("BalloonOfferOpen", true);
        ArmoryEvent:FireServer("Get");
        update();

        if UserInputService.GamepadEnabled then
            GuiService.SelectedObject = u25.owned.BalloonDagger and u21 or u20;
        end;
    end;
end);
ArmoryEvent.OnClientEvent:Connect(function(p36, p37) -- Line: 76
    -- upvalues: u25 (ref), update (copy), u23 (copy)
    if p36 == "State" and type(p37) == "table" then
        u25 = p37;
        update();

        if u25.owned.BalloonDagger then
            u23.Text = "Find it any time in My Knives.";
        end;
    end;
end);
u20.Activated:Connect(function() -- Line: 79
    -- upvalues: u26 (ref), u28 (ref), SocialService (copy), LocalPlayer (copy), u23 (copy)
    if not u26 or os.clock() - u28 < 3 then
        return;
    end;

    u28 = os.clock();
    task.spawn(function() -- Line: 81
        -- upvalues: SocialService (ref), LocalPlayer (ref), u26 (ref), u23 (ref)
        local success, result = pcall(SocialService.CanSendGameInviteAsync, SocialService, LocalPlayer);

        if not u26 then
            return;
        end;

        if success and result then
            u23.Text = pcall(SocialService.PromptGameInvite, SocialService, LocalPlayer) and "Your friend needs to join through your invite to unlock it." or "The invite window could not open. Please try again.";

            return;
        end;

        u23.Text = "Invites are unavailable here. Try the published game.";
    end);
end);
u21.Activated:Connect(function() -- Line: 89
    -- upvalues: u26 (ref), u29 (ref), u25 (ref), ArmoryEvent (copy), u23 (copy)
    if not u26 or os.clock() - u29 < 1 then
        return;
    end;

    u29 = os.clock();

    if u25.loaded and u25.owned.BalloonDagger then
        if u25.equipped ~= "BalloonDagger" then
            ArmoryEvent:FireServer("Equip", "BalloonDagger");
        end;
    else
        ArmoryEvent:FireServer("CheckRewards");
        u23.Text = "Not yet — your invited friend needs to join. It unlocks automatically.";
    end;
end);
UserInputService.InputBegan:Connect(function(p38, p39) -- Line: 98
    -- upvalues: u26 (ref), GuiService (copy), Frame (copy), u24 (ref), LocalPlayer (copy)
    if not p39 and (u26 and (p38.KeyCode == Enum.KeyCode.Escape or p38.KeyCode == Enum.KeyCode.ButtonB)) then
        if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(Frame) then
            GuiService.SelectedObject = u24 and (u24.Parent and u24) or nil;
        end;

        u26 = false;
        Frame.Visible = false;
        LocalPlayer:SetAttribute("BalloonOfferOpen", false);
    end;
end);
local u43 = RunService.RenderStepped:Connect(function(p40) -- Line: 99
    -- upvalues: u26 (ref), permitted (copy), GuiService (copy), Frame (copy), u24 (ref), LocalPlayer (copy), ScreenGui (copy), UIScale (copy), u30 (ref), Camera (copy), math_max_ret (copy)
    if u26 and not permitted() then
        if GuiService.SelectedObject and GuiService.SelectedObject:IsDescendantOf(Frame) then
            GuiService.SelectedObject = u24 and (u24.Parent and u24) or nil;
        end;

        u26 = false;
        Frame.Visible = false;
        LocalPlayer:SetAttribute("BalloonOfferOpen", false);
    end;

    if not u26 then
        return;
    end;

    local AbsoluteSize = ScreenGui.AbsoluteSize;
    UIScale.Scale = math.min(1, (AbsoluteSize.X - 28) / 560, (AbsoluteSize.Y - 28) / 430);
    u30 = u30 + math.min(p40, 0.1) * 0.25;
    local CFrame_lookAt = CFrame.lookAt;
    local v41 = math.sin(u30) * math_max_ret * 1.9;
    local v42 = math.cos(u30) * math_max_ret * 1.9;
    Camera.CFrame = CFrame_lookAt(Vector3.new(v41, math_max_ret * 0.08, v42), Vector3.new(0, 0, 0));
end);

local function starterDone() -- Line: 108
    -- upvalues: u25 (ref), StarterPackConfig (copy)
    if u25.starterPurchased or u25.starterPresented then
        return true;
    end;

    local v44 = StarterPackConfig.Enabled and game.GameId == StarterPackConfig.UniverseId;
    local v45;

    if u25.starterFirstMatch == true then
        v45 = not v44 or (u25.starterOfferEndsAt or 0) <= workspace:GetServerTimeNow();
    else
        v45 = false;
    end;

    return v45;
end;

local u46 = {};
local AttributeChangedSignal = LocalPlayer:GetAttributeChangedSignal("InMatch");
table.insert(u46, AttributeChangedSignal:Connect(function() -- Line: 114
    -- upvalues: LocalPlayer (copy), u18 (ref)
    if LocalPlayer:GetAttribute("InMatch") == true then
        u18 = true;
    end;
end));
local AttributeChangedSignal2 = LocalPlayer:GetAttributeChangedSignal("StarterPackOpen");
table.insert(u46, AttributeChangedSignal2:Connect(function() -- Line: 117
    -- upvalues: LocalPlayer (copy), u18 (ref)
    if LocalPlayer:GetAttribute("StarterPackOpen") == true then
        u18 = false;
    end;
end));
task.spawn(function() -- Line: 120
    -- upvalues: ScreenGui (copy), u27 (ref), u18 (ref), LocalPlayer (copy), permitted (copy), u25 (ref), StarterPackConfig (copy), u26 (ref), u24 (ref), GuiService (copy), Frame (copy), ArmoryEvent (copy), update (copy), UserInputService (copy), u21 (copy), u20 (copy), StarterPackEvent (copy)
    task.wait(5);

    while ScreenGui.Parent and not u27 do
        if u18 and (LocalPlayer:GetAttribute("InMatch") ~= true and (permitted() and (u25.loaded and (tonumber(u25.balloonPrompts) or 0) < 5))) then
            local v47;

            if u25.starterPurchased or u25.starterPresented then
                v47 = true;
            else
                local v48 = StarterPackConfig.Enabled and game.GameId == StarterPackConfig.UniverseId;

                if u25.starterFirstMatch == true then
                    v47 = not v48 or (u25.starterOfferEndsAt or 0) <= workspace:GetServerTimeNow();
                else
                    v47 = false;
                end;
            end;

            if v47 and (LocalPlayer:GetAttribute("ArmoryOpen") ~= true and (LocalPlayer:GetAttribute("ServerBrowserOpen") ~= true and LocalPlayer:GetAttribute("MatchSummaryVisible") ~= true)) then
                u27 = true;

                if not u25.owned.BalloonDagger then
                    task.wait(3);

                    if permitted() then
                        if permitted() then
                            if not u26 then
                                u24 = GuiService.SelectedObject;
                            end;

                            u26 = true;
                            Frame.Visible = true;
                            LocalPlayer:SetAttribute("BalloonOfferOpen", true);
                            ArmoryEvent:FireServer("Get");
                            update();

                            if UserInputService.GamepadEnabled then
                                GuiService.SelectedObject = u25.owned.BalloonDagger and u21 or u20;
                            end;
                        end;

                        StarterPackEvent:FireServer("BalloonShown");
                    else
                        u27 = false;
                    end;
                end;
            end;
        end;

        task.wait(1);
    end;
end);
ArmoryEvent:FireServer("Get");
script.Destroying:Connect(function() -- Line: 134
    -- upvalues: u43 (copy), u46 (copy), LocalPlayer (copy), ScreenGui (copy)
    u43:Disconnect();

    for _, v in u46 do
        v:Disconnect();
    end;

    LocalPlayer:SetAttribute("BalloonOfferOpen", nil);
    ScreenGui:Destroy();
end);
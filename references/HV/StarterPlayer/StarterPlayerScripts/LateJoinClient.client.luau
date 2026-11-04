 

 

if not require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).LateJoinExperiment then
    return;
end;

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = ReplicatedStorage:WaitForChild("ChickenOrHero");
local Game = ChickenOrHero:WaitForChild("Game");
local Session = Game:WaitForChild("Session");
local LateJoinRemote = Game:WaitForChild("LateJoinRemote", 30);

if not LateJoinRemote then
    return;
end;

local OldUIReskin = ChickenOrHero:FindFirstChild("OldUIReskin");

if OldUIReskin then
    OldUIReskin = OldUIReskin:FindFirstChild("Skin");
end;

local success, result = pcall(function() -- Line: 22
    -- upvalues: OldUIReskin (copy)
    local v1 = OldUIReskin and require(OldUIReskin);

    return v1;
end);
local u2 = success and result or nil;
local success2, result2 = pcall(function() -- Line: 26
    -- upvalues: ChickenOrHero (copy)
    return require(ChickenOrHero:WaitForChild("Interface"):WaitForChild("Telemetry", 10));
end);
local u3 = success2 and result2 or nil;
local u4 = {
    Prepare = true,
    SelectHero = true,
    HeroChoice = true,
    ChoiceReveal = true,
    HeroRun = true,
    GroupRun = true,
    FinalRun = true,
    RunResolution = true
};
local u5 = nil;
local u6 = nil;
local u7 = nil;
local u8 = nil;
local u9 = 0;
local u10 = 0;
local u11 = nil;

local function style(p12) -- Line: 47
    -- upvalues: u11 (ref), u2 (ref), u5 (ref), u6 (ref)
    if u11 == p12 then
        return;
    end;

    u11 = p12;

    if u2 then
        pcall(u2.button, u5, p12, {
            label = u6
        });

        return;
    end;

    u5.BackgroundColor3 = p12 == "primary" and Color3.fromRGB(64, 190, 90) or Color3.fromRGB(70, 70, 76);
end;

local function build() -- Line: 59
    -- upvalues: u5 (ref), u6 (ref), u11 (ref), u2 (ref), LocalPlayer (copy), u9 (ref), u10 (ref), LateJoinRemote (copy)
    u5 = Instance.new("ImageButton");
    u5.Name = "LateJoinPlay";
    u5.AnchorPoint = Vector2.new(0.5, 0);
    u5.Size = UDim2.fromOffset(190, 44);
    u5.AutoButtonColor = false;
    u5.BackgroundColor3 = Color3.fromRGB(64, 190, 90);
    u5.BorderSizePixel = 0;
    u5.Visible = false;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 8);
    UICorner.Parent = u5;
    u6 = Instance.new("TextLabel");
    u6.Name = "Label";
    u6.BackgroundTransparency = 1;
    u6.Size = UDim2.fromScale(1, 1);
    u6.Font = Enum.Font.GothamBlack;
    u6.TextScaled = true;
    u6.TextColor3 = Color3.new(1, 1, 1);
    u6.Text = "PLAY";
    u6.ZIndex = 2;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.PaddingTop = UDim.new(0.2, 0);
    UIPadding.PaddingBottom = UDim.new(0.2, 0);
    UIPadding.PaddingLeft = UDim.new(0.08, 0);
    UIPadding.PaddingRight = UDim.new(0.08, 0);
    UIPadding.Parent = u6;
    u6.Parent = u5;

    if u11 ~= "primary" then
        u11 = "primary";

        if u2 then
            pcall(u2.button, u5, "primary", {
                label = u6
            });
        else
            u5.BackgroundColor3 = Color3.fromRGB(64, 190, 90) or Color3.fromRGB(70, 70, 76);
        end;
    end;

    if u2 then
        pcall(u2.bindStates, u5);
    end;

    u5.Activated:Connect(function() -- Line: 91
        -- upvalues: LocalPlayer (ref), u9 (ref), u6 (ref), u11 (ref), u2 (ref), u5 (ref), u10 (ref), LateJoinRemote (ref)
        if LocalPlayer:GetAttribute("LateJoinQueued") == true or os.clock() < u9 then
            return;
        end;

        u6.Text = "JOINING...";

        if u11 ~= "dark" then
            u11 = "dark";

            if u2 then
                pcall(u2.button, u5, "dark", {
                    label = u6
                });
            else
                u5.BackgroundColor3 = Color3.fromRGB(70, 70, 76);
            end;
        end;

        u10 = os.clock();
        LateJoinRemote:FireServer("Play");
    end);
end;

local function banner() -- Line: 103
    -- upvalues: LocalPlayer (copy)
    local Notifications = LocalPlayer.PlayerGui:FindFirstChild("Notifications");

    if Notifications then
        Notifications = Notifications:FindFirstChild("MainFrame");
    end;

    if Notifications then
        Notifications = Notifications:FindFirstChild("NotificationsF");
    end;

    return Notifications;
end;

local function place() -- Line: 109
    -- upvalues: LocalPlayer (copy), u5 (ref), u7 (ref)
    local Notifications = LocalPlayer.PlayerGui:FindFirstChild("Notifications");

    if Notifications then
        Notifications = Notifications:FindFirstChild("MainFrame");
    end;

    if Notifications then
        Notifications = Notifications:FindFirstChild("NotificationsF");
    end;

    if not Notifications then
        if not u7 then
            u7 = Instance.new("ScreenGui");
            u7.Name = "LateJoin";
            u7.ResetOnSpawn = false;
            u7.DisplayOrder = 5;
            u7.Parent = LocalPlayer.PlayerGui;
        end;

        if u5.Parent ~= u7 then
            u5.Parent = u7;
        end;

        u5.Position = UDim2.new(0.5, 0, 0, 112);

        return;
    end;

    if u5.Parent ~= Notifications then
        u5.Parent = Notifications;
    end;

    local v13 = 8;

    for _, v in { "EscapeStreak", "ChoiceAnnouncement" } do
        local v14 = Notifications:FindFirstChild(v);

        if v14 and (v14:IsA("GuiObject") and v14.Visible) then
            local v15 = math.ceil((v14.AbsolutePosition.Y - Notifications.AbsolutePosition.Y + v14.AbsoluteSize.Y - Notifications.AbsoluteSize.Y) / (Notifications.AbsoluteSize.Y > 0 and Notifications.Size.Y.Offset > 0 and (Notifications.AbsoluteSize.Y / Notifications.Size.Y.Offset or 1) or 1)) + 8;
            v13 = math.max(v13, v15);
        end;
    end;

    u5.Position = UDim2.new(0.5, 0, 1, v13);
end;

local function update() -- Line: 144
    -- upvalues: Session (copy), LocalPlayer (copy), u4 (copy), u5 (ref), build (copy), place (copy), u6 (ref), u11 (ref), u2 (ref), u9 (ref), u10 (ref), u3 (ref), u8 (ref)
    local Attribute = Session:GetAttribute("Phase");
    local v16 = LocalPlayer:GetAttribute("LateJoinQueued") == true;
    local v17;

    if LocalPlayer:GetAttribute("LateJoinMode") == "PlayButton" and ((LocalPlayer:GetAttribute("GameRole") or "Lobby") == "Lobby" and (LocalPlayer:GetAttribute("InMatch") ~= true and LocalPlayer:GetAttribute("AFK") ~= true)) then
        v17 = u4[Attribute] == true;
    else
        v17 = false;
    end;

    if not v17 then
        if u5 then
            u5.Visible = false;
        end;

        return;
    end;

    if not u5 then
        build();
    end;

    place();

    if v16 then
        u6.Text = "JOINING NEXT ROUND";

        if u11 ~= "dark" then
            u11 = "dark";

            if u2 then
                pcall(u2.button, u5, "dark", {
                    label = u6
                });
            else
                u5.BackgroundColor3 = Color3.fromRGB(70, 70, 76);
            end;
        end;
    elseif u9 <= os.clock() and (u6.Text ~= "JOINING..." or os.clock() - u10 > 3) then
        u6.Text = "PLAY";

        if u11 ~= "primary" then
            u11 = "primary";

            if u2 then
                pcall(u2.button, u5, "primary", {
                    label = u6
                });
            else
                u5.BackgroundColor3 = Color3.fromRGB(64, 190, 90) or Color3.fromRGB(70, 70, 76);
            end;
        end;
    end;

    if not u5.Visible then
        u5.Visible = true;
        local Attribute2 = Session:GetAttribute("EscapeStreakState");
        local v18 = type(Attribute2) == "string" and string.match(Attribute2, "\"matchId\":\"([^\"]*)\"") or tostring(Attribute);

        if u3 and u8 ~= v18 then
            u8 = v18;
            pcall(u3.track, "late_join_button", "shown");
        end;
    end;
end;

LateJoinRemote.OnClientEvent:Connect(function(p19, p20) -- Line: 181
    -- upvalues: u5 (ref), u6 (ref), u11 (ref), u2 (ref), u9 (ref)
    if p19 ~= "PlayResult" or not u5 then
        return;
    end;

    if not p20 then
        u6.Text = "TRY AGAIN SOON";

        if u11 ~= "dark" then
            u11 = "dark";

            if u2 then
                pcall(u2.button, u5, "dark", {
                    label = u6
                });
            else
                u5.BackgroundColor3 = Color3.fromRGB(70, 70, 76);
            end;
        end;

        u9 = os.clock() + 2;
        task.delay(2, function() -- Line: 192
            -- upvalues: u6 (ref)
            if u6.Text == "TRY AGAIN SOON" then
                u6.Text = "PLAY";
            end;
        end);

        return;
    end;

    u6.Text = "JOINING NEXT ROUND";

    if u11 == "dark" then
        return;
    end;

    u11 = "dark";

    if u2 then
        pcall(u2.button, u5, "dark", {
            label = u6
        });

        return;
    end;

    u5.BackgroundColor3 = Color3.fromRGB(70, 70, 76);
end);

while LocalPlayer:GetAttribute("LateJoinSettled") ~= true do
    LocalPlayer:GetAttributeChangedSignal("LateJoinSettled"):Wait();
end;

if LocalPlayer:GetAttribute("LateJoinMode") ~= "PlayButton" then
    return;
end;

while LocalPlayer.Parent do
    local success3, result3 = pcall(update);

    if not success3 then
        warn("LateJoinClient: " .. tostring(result3));
        task.wait(2);
    end;

    task.wait(0.1);
end;
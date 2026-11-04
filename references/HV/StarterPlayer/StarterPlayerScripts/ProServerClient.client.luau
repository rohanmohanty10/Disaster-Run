 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TeleportService = game:GetService("TeleportService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game:GetService("ReplicatedStorage"):WaitForChild("ChickenOrHero");

if require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).ProServers ~= true then
    return;
end;

local ProServerRemote = ChickenOrHero:WaitForChild("Game"):WaitForChild("ProServerRemote", 60);

if not ProServerRemote then
    return;
end;

local Skin = require(ChickenOrHero:WaitForChild("OldUIReskin"):WaitForChild("Skin"));
local Panels = Skin.Panels;
local Palette = Skin.Palette;
local HudNavigation = require(ChickenOrHero.Presentation.HudNavigation);
local CutsceneScreen = require(ChickenOrHero.Presentation:WaitForChild("CutsceneScreen"));
local MapVoteConfig = require(ChickenOrHero.Game.MapVoteConfig);
local MapLocator = require(ChickenOrHero.Game:WaitForChild("MapLocator"));
local u1 = {};
local u2 = {
    Lobby = "In lobby",
    Intermission = "In lobby",
    MapVote = "Voting",
    Countdown = "Starting"
};
local u3 = {
    NA = "North America",
    SA = "South America",
    EU = "Europe",
    ME = "Middle East",
    AS = "Asia",
    OC = "Oceania",
    AF = "Africa"
};

for _, v in MapVoteConfig.Maps do
    u1[v.Id] = v.Name;
end;

local function level() -- Line: 50
    -- upvalues: LocalPlayer (copy)
    return tonumber(LocalPlayer:GetAttribute("Level")) or 0;
end;

local u4 = false;

local function unlocked() -- Line: 55
    -- upvalues: LocalPlayer (copy), u4 (ref)
    local v5;

    if (tonumber(LocalPlayer:GetAttribute("Level")) or 0) >= 25 then
        v5 = not u4;
    else
        v5 = false;
    end;

    return v5;
end;

local u6 = nil;
local u7 = { "Base", "StepCollider", "BackCollider" };

local function effect(p8) -- Line: 70
    return p8:IsA("ParticleEmitter") or (p8:IsA("Beam") or p8:IsA("Trail")) or (p8:IsA("Light") or p8:IsA("Fire") or (p8:IsA("Smoke") or p8:IsA("Sparkles")));
end;

local function shown(p9, p10) -- Line: 79
    -- upvalues: effect (copy)
    if p9 then
        for _, descendant in p9:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.LocalTransparencyModifier = p10 and 0 or 1;
            elseif effect(descendant) then
                local Attribute = descendant:GetAttribute("ProEffectOn");

                if Attribute == nil then
                    Attribute = descendant.Enabled;
                    descendant:SetAttribute("ProEffectOn", Attribute);
                end;

                descendant.Enabled = p10 and Attribute;
            end;
        end;
    end;
end;

local function topOf(p11) -- Line: 96
    local v12 = (-1 / 0);

    for _, descendant in p11:GetDescendants() do
        if descendant:IsA("BasePart") then
            local CFrame = descendant.CFrame;
            local v13 = descendant.Size / 2;
            local v14 = CFrame.Position.Y + math.abs(CFrame.RightVector.Y) * v13.X + math.abs(CFrame.UpVector.Y) * v13.Y + math.abs(CFrame.LookVector.Y) * v13.Z;
            v12 = math.max(v12, v14);
        end;
    end;

    return v12;
end;

local u15 = nil;

local function dress() -- Line: 114
    -- upvalues: u6 (ref), LocalPlayer (copy), u4 (ref), shown (copy), u7 (copy), u15 (ref), topOf (copy)
    if not (u6 and u6.Parent) then
        return;
    end;

    local v16;

    if (tonumber(LocalPlayer:GetAttribute("Level")) or 0) >= 25 then
        v16 = not u4;
    else
        v16 = false;
    end;

    local SmallPodium = u6:FindFirstChild("SmallPodium");
    local v17 = v16 or SmallPodium == nil;
    shown(u6:FindFirstChild("Podium"), v17);
    shown(u6:FindFirstChild("Star"), v17);
    local Lock = u6:FindFirstChild("Lock");
    local v18;

    if v17 then
        v18 = not v16;
    else
        v18 = v17;
    end;

    shown(Lock, v18);
    shown(SmallPodium, not v17);

    for _, v in u7 do
        local v19 = u6:FindFirstChild(v);

        if v19 and v19:IsA("BasePart") then
            v19.CanCollide = v17;
        end;
    end;

    local v20;

    if SmallPodium then
        v20 = SmallPodium:FindFirstChild("Base");
    else
        v20 = SmallPodium;
    end;

    if v20 then
        v20.CanCollide = not v17;
    end;

    local ProServersPrompt = u6:FindFirstChild("ProServersPrompt", true);

    if ProServersPrompt then
        ProServersPrompt.Enabled = v16;
    end;

    local v21;

    if SmallPodium then
        v21 = SmallPodium:FindFirstChild("Billboard", true);
    else
        v21 = SmallPodium;
    end;

    if v21 then
        v21.Enabled = not v17;
    end;

    local Base = u6:FindFirstChild("Base");

    if Base then
        Base = Base:FindFirstChild("BillboardAttachment");
    end;

    local v22;

    if Base then
        v22 = Base:FindFirstChild("Billboard");
    else
        v22 = Base;
    end;

    if v22 then
        v22.Enabled = v17 or v21 == nil;

        if not u15 or u15.attachment ~= Base then
            local Podium = u6:FindFirstChild("Podium");
            local v23;

            if SmallPodium and Podium then
                local v24 = topOf(Podium) - topOf(SmallPodium);
                v23 = math.max(0, v24);
            else
                v23 = 0;
            end;

            u15 = {
                attachment = Base,
                position = Base.Position,
                drop = v23 >= (1 / 0) and 0 or v23
            };
        end;

        Base.Position = u15.position - Vector3.new(0, v17 and 0 or u15.drop, 0);
        local Status = v22:FindFirstChild("Status");

        if Status and Status:IsA("TextLabel") then
            local v25;

            if v16 then
                v25 = "Open - Level " .. 25 .. "+";
            else
                v25 = "Locked - Level " .. 25;
            end;

            Status.Text = v25;
            local v26;

            if v16 then
                v26 = Color3.fromRGB(120, 230, 140);
            else
                v26 = Color3.fromRGB(255, 92, 92);
            end;

            Status.TextColor3 = v26;
        end;
    end;
end;

local u27 = nil;
local u28 = nil;

local function found(p29) -- Line: 163
    -- upvalues: u6 (ref), u28 (ref), u27 (ref), dress (copy)
    if p29.Name ~= "ProServersStand" or not p29:IsA("Model") then
        return;
    end;

    u6 = p29;

    if u28 then
        u28:Disconnect();
    end;

    local Base = p29:WaitForChild("Base", 10);

    if Base then
        Base = Base:FindFirstChild("ProServersPrompt", true);
    end;

    if Base and u6 == p29 then
        u28 = Base.Triggered:Connect(function() -- Line: 174
            -- upvalues: u27 (ref)
            u27();
        end);
    end;

    dress();
end;

local v30 = MapLocator.interactables(10);
v30.ChildAdded:Connect(found);
v30.ChildRemoved:Connect(function(p31) -- Line: 183
    -- upvalues: u6 (ref), u28 (ref)
    if p31 == u6 then
        u6 = nil;

        if u28 then
            u28:Disconnect();
            u28 = nil;
        end;
    end;
end);
local ProServersStand = v30:FindFirstChild("ProServersStand");

if ProServersStand then
    task.spawn(found, ProServersStand);
end;

local u32 = {};
local u33 = (-1 / 0);

local function loadFriends() -- Line: 200
    -- upvalues: u33 (ref), Players (copy), LocalPlayer (copy), u32 (ref)
    if os.clock() - u33 < 300 then
        return;
    end;

    u33 = os.clock();
    local success, result = pcall(Players.GetFriendsAsync, Players, LocalPlayer.UserId);

    if not success then
        return;
    end;

    local v34 = {};

    for i = 1, 20 do
        local _ = i;

        for _, v in result:GetCurrentPage() do
            v34[v.Id] = true;
        end;

        if result.IsFinished or not pcall(result.AdvanceToNextPageAsync, result) then
            break;
        end;
    end;

    u32 = v34;
end;

local v35 = Panels.screen(LocalPlayer, "ProServers", 68);
local u36, v37, v38 = Panels.panel(v35, "ProServersPanel", 600, 540);
local v39 = Panels.make("Frame", v37, "Header", {
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(20, 16),
    Size = UDim2.fromOffset(504, 76)
});
Skin.header(v39, {
    decoration = "wide"
});
Panels.make("ImageLabel", v39, "Emblem", {
    BackgroundTransparency = 1,
    Image = "rbxassetid://79478482083053",
    ZIndex = 2,
    Position = UDim2.fromOffset(8, 6),
    Size = UDim2.fromOffset(64, 64),
    ScaleType = Enum.ScaleType.Fit
});
local v40 = Panels.text(v39, "Eyebrow", "VALLEY RUN  /  LEVEL 25+", 82, 12, 300, 16, 11, Palette.gold);
v40.Font = Enum.Font.GothamBold;
v40.ZIndex = 2;
local v41 = Panels.text(v39, "Title", "PRO SERVERS", 82, 28, 320, 34, 28, Palette.text);
v41.Font = Enum.Font.GothamBold;
v41.ZIndex = 2;
Panels.text(v37, "Info", "9 players to start  ·  No bots  ·  Monthly PRO boards", 20, 104, 420, 28, 12, Palette.textSecondary).Font = Enum.Font.GothamBold;
local v42 = Panels.button(v37, "Refresh", "REFRESH", 460, 102, 120, 32);
v42.TextSize = 13;
Skin.button(v42, "secondary", {
    shimmer = false
});
local v43 = Panels.make("Frame", v37, "Rule", {
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(20, 144),
    Size = UDim2.fromOffset(560, 1)
});
Skin.band(v43, {
    color = Palette.neutral
});
local u44 = Panels.make("ScrollingFrame", v37, "List", {
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 4,
    Position = UDim2.fromOffset(20, 156),
    Size = UDim2.fromOffset(560, 262),
    VerticalScrollBarInset = Enum.ScrollBarInset.Always,
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    CanvasSize = UDim2.new()
});
Skin.scroll(u44);
Panels.make("UIListLayout", u44, "Layout", {
    Padding = UDim.new(0, 10),
    SortOrder = Enum.SortOrder.LayoutOrder
});
Panels.make("UIPadding", u44, "Padding", {
    PaddingTop = UDim.new(0, 2),
    PaddingLeft = UDim.new(0, 2),
    PaddingRight = UDim.new(0, 8)
});
local u45 = Panels.text(v37, "Empty", "", 20, 190, 560, 60, 15, Palette.textSecondary);
u45.TextXAlignment = Enum.TextXAlignment.Center;
local u46 = Panels.text(v37, "Status", "", 20, 426, 560, 24, 13, Palette.gold);
u46.Font = Enum.Font.GothamBold;
u46.TextXAlignment = Enum.TextXAlignment.Center;
local v47 = Panels.make("Frame", v37, "Footer", {
    BorderSizePixel = 0,
    Position = UDim2.fromOffset(20, 454),
    Size = UDim2.fromOffset(560, 70)
});
Skin.footer(v47);
local u48 = Panels.button(v47, "JoinRandom", "JOIN RANDOM", 10, 10, 540, 50);
u48.TextSize = 20;
Skin.button(u48, "primary");
local u49 = Panels.button(v47, "LeavePro", "LEAVE PRO", 10, 10, 150, 50);
u49.TextSize = 14;
Skin.button(u49, "secondary", {
    shimmer = false
});
u49.Visible = false;

local function say(p50) -- Line: 286
    -- upvalues: u46 (copy)
    u46.Text = p50 or "";
end;

local u51 = (-1 / 0);

local function joining() -- Line: 292
    -- upvalues: u51 (ref)
    return os.clock() - u51 < 50;
end;

local u52 = nil;

local function teleportScreen(p53) -- Line: 300
    -- upvalues: CutsceneScreen (copy), Panels (copy), Skin (copy), Palette (copy)
    local u54 = CutsceneScreen.new(p53, 200);
    u54:SetAttribute("CreatorCaptureExempt", true);
    u54:SetAttribute("SelfManagedText", true);
    Panels.make("Frame", u54, "Backdrop", {
        BackgroundTransparency = 0.06,
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1.5, 1.5),
        BackgroundColor3 = Color3.fromRGB(10, 12, 20)
    });

    local function centred(p55, p56, p57, p58, p59) -- Line: 312
        -- upvalues: Panels (ref), u54 (copy)
        local v60 = Panels.make(p55, u54, p56, p59);
        v60.AnchorPoint = Vector2.new(0.5, 0.5);
        v60.Position = UDim2.fromScale(0.5, p57);
        v60.Size = p58;
        v60.BackgroundTransparency = 1;

        return v60;
    end;

    local UDim2_fromScale_ret = UDim2.fromScale(0.5, 0.5);
    local v61 = Panels.make("ImageLabel", u54, "Rays", {
        ImageTransparency = 0.55,
        Image = Skin.Assets.Sunray,
        ImageColor3 = Palette.gold,
        ScaleType = Enum.ScaleType.Fit
    });
    v61.AnchorPoint = Vector2.new(0.5, 0.5);
    v61.Position = UDim2.fromScale(0.5, 0.4);
    v61.Size = UDim2_fromScale_ret;
    v61.BackgroundTransparency = 1;
    Panels.make("UIAspectRatioConstraint", v61, "Aspect", {});
    local UDim2_fromScale_ret2 = UDim2.fromScale(0.24, 0.24);
    local v62 = Panels.make("ImageLabel", u54, "Emblem", {
        Image = "rbxassetid://79478482083053",
        ScaleType = Enum.ScaleType.Fit
    });
    v62.AnchorPoint = Vector2.new(0.5, 0.5);
    v62.Position = UDim2.fromScale(0.5, 0.4);
    v62.Size = UDim2_fromScale_ret2;
    v62.BackgroundTransparency = 1;
    Panels.make("UIAspectRatioConstraint", v62, "Aspect", {});
    local UDim2_fromScale_ret3 = UDim2.fromScale(0.8, 0.075);
    local v63 = Panels.make("TextLabel", u54, "Title", {
        Text = "TELEPORTING...",
        TextScaled = true,
        Font = Enum.Font.GothamBlack,
        TextColor3 = Palette.gold
    });
    v63.AnchorPoint = Vector2.new(0.5, 0.5);
    v63.Position = UDim2.fromScale(0.5, 0.63);
    v63.Size = UDim2_fromScale_ret3;
    v63.BackgroundTransparency = 1;
    Panels.make("UITextSizeConstraint", v63, "Max", {
        MaxTextSize = 56
    });
    Skin.textStroke(v63, 3);
    local UDim2_fromScale_ret4 = UDim2.fromScale(0.8, 0.035);
    local v64 = Panels.make("TextLabel", u54, "Status", {
        Text = "",
        TextScaled = true,
        Font = Enum.Font.GothamBold,
        TextColor3 = Palette.text
    });
    v64.AnchorPoint = Vector2.new(0.5, 0.5);
    v64.Position = UDim2.fromScale(0.5, 0.7);
    v64.Size = UDim2_fromScale_ret4;
    v64.BackgroundTransparency = 1;
    Panels.make("UITextSizeConstraint", v64, "Max", {
        MaxTextSize = 22
    });
    Skin.textStroke(v64, 2);

    return u54, v61, v63, v64;
end;

local u65 = {};
local v66, v67, v68, v69 = teleportScreen("ProTeleporting");
u65.screen = v66;
u65.rays = v67;
u65.title = v68;
u65.status = v69;
u65.screen.Enabled = false;
u65.buttons = Panels.make("Frame", u65.screen, "Buttons", {
    BackgroundTransparency = 1,
    Visible = false,
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.8),
    Size = UDim2.fromOffset(340, 52)
});
local v70 = Panels.button(u65.buttons, "TryAgain", "TRY AGAIN", 0, 0, 200, 52);
v70.TextSize = 17;
Skin.button(v70, "primary");
local v71 = Panels.button(u65.buttons, "Close", "CLOSE", 212, 0, 128, 52);
v71.TextSize = 15;
Skin.button(v71, "secondary", {
    shimmer = false
});
Panels.cursorWhileVisible(u65.buttons);
u65.screen.Parent = LocalPlayer:WaitForChild("PlayerGui");

local function spinning(p72) -- Line: 365
    -- upvalues: u65 (copy), RunService (copy)
    if not p72 or u65.spin then
        if not p72 and u65.spin then
            u65.spin:Disconnect();
            u65.spin = nil;
        end;

        return;
    end;

    local os_clock_ret = os.clock();
    u65.spin = RunService.RenderStepped:Connect(function(p73) -- Line: 368
        -- upvalues: u65 (ref), os_clock_ret (copy)
        u65.rays.Rotation = (u65.rays.Rotation + p73 * 25) % 360;

        if not u65.failed then
            local string_rep = string.rep;
            local v74 = (os.clock() - os_clock_ret) * 2.5;
            local v75 = "TELEPORTING" .. string_rep(".", math.floor(v74) % 4);

            if u65.title.Text ~= v75 then
                u65.title.Text = v75;
            end;
        end;
    end);
end;

local function showTeleport(p76) -- Line: 382
    -- upvalues: u65 (copy), Palette (copy), RunService (copy)
    u65.failed = false;
    u65.buttons.Visible = false;
    u65.title.TextColor3 = Palette.gold;
    u65.status.Text = p76;
    u65.screen.Enabled = true;

    if u65.spin then
        return;
    end;

    local os_clock_ret = os.clock();
    u65.spin = RunService.RenderStepped:Connect(function(p77) -- Line: 368
        -- upvalues: u65 (ref), os_clock_ret (copy)
        u65.rays.Rotation = (u65.rays.Rotation + p77 * 25) % 360;

        if not u65.failed then
            local string_rep = string.rep;
            local v78 = (os.clock() - os_clock_ret) * 2.5;
            local v79 = "TELEPORTING" .. string_rep(".", math.floor(v78) % 4);

            if u65.title.Text ~= v79 then
                u65.title.Text = v79;
            end;
        end;
    end);
end;

local function hideTeleport() -- Line: 390
    -- upvalues: u65 (copy)
    u65.screen.Enabled = false;

    if u65.spin then
        u65.spin:Disconnect();
        u65.spin = nil;
    end;
end;

local function failTeleport(p80) -- Line: 394
    -- upvalues: u65 (copy), Palette (copy)
    u65.failed = true;
    u65.title.Text = "COULDN\'T TELEPORT";
    u65.title.TextColor3 = Palette.danger;
    u65.status.Text = p80;
    u65.buttons.Visible = true;
end;

local function join(p81, p82, p83) -- Line: 401
    -- upvalues: u51 (ref), u65 (copy), u46 (copy), u52 (ref), Palette (copy), RunService (copy), teleportScreen (copy), TeleportService (copy), ProServerRemote (copy)
    u51 = os.clock();
    u65.request = { p81, p82, p83 };
    u46.Text = p83 or "";
    u52(false);
    u65.failed = false;
    u65.buttons.Visible = false;
    u65.title.TextColor3 = Palette.gold;
    u65.status.Text = p83;
    u65.screen.Enabled = true;

    if not u65.spin then
        local os_clock_ret = os.clock();
        u65.spin = RunService.RenderStepped:Connect(function(p84) -- Line: 368
            -- upvalues: u65 (ref), os_clock_ret (copy)
            u65.rays.Rotation = (u65.rays.Rotation + p84 * 25) % 360;

            if not u65.failed then
                local string_rep = string.rep;
                local v85 = (os.clock() - os_clock_ret) * 2.5;
                local v86 = "TELEPORTING" .. string_rep(".", math.floor(v85) % 4);

                if u65.title.Text ~= v86 then
                    u65.title.Text = v86;
                end;
            end;
        end);
    end;

    local v87 = teleportScreen("ProTeleportGui");
    v87.Status.Text = p81 == "Leave" and "Going to a public server" or "Joining a Pro server";
    pcall(TeleportService.SetTeleportGui, TeleportService, v87);
    ProServerRemote:FireServer(p81, p82);
end;

v70.Activated:Connect(function() -- Line: 413
    -- upvalues: u65 (copy), join (copy)
    if u65.request then
        join(u65.request[1], u65.request[2], u65.request[3]);
    end;
end);
v71.Activated:Connect(function() -- Line: 418
    -- upvalues: u65 (copy), u52 (ref)
    u65.screen.Enabled = false;

    if u65.spin then
        u65.spin:Disconnect();
        u65.spin = nil;
    end;

    u52(true);
end);
local u88 = {};

local function clearRows() -- Line: 423
    -- upvalues: u88 (copy)
    for _, v in u88 do
        v:Destroy();
    end;

    table.clear(u88);
end;

local function row(u89, p90) -- Line: 429
    -- upvalues: Panels (copy), u44 (copy), Skin (copy), Palette (copy), u3 (copy), u1 (copy), u2 (copy), join (copy), u88 (copy)
    local v91 = #u89.friendIds > 0;
    local v92 = Panels.make("Frame", u44, "Server", {
        BorderSizePixel = 0,
        Size = UDim2.fromOffset(550, 72),
        LayoutOrder = p90
    });
    Skin.card(v92, v91 and "green" or nil, {
        radius = UDim.new(0, 10)
    });
    v92.BackgroundTransparency = v91 and 0 or 0.2;
    local v93 = Panels.text(v92, "Region", u89.region or "??", 12, 12, 48, 48, 16, Palette.gold);
    v93.Font = Enum.Font.GothamBold;
    v93.TextXAlignment = Enum.TextXAlignment.Center;
    v93.BackgroundTransparency = 0;
    Skin.card(v93, "Legendary", {
        radius = UDim.new(0, 8)
    });
    local v94 = Panels.text(v92, "Where", u3[u89.region] or "Unknown region", 72, 13, 220, 24, 16, Palette.text);
    v94.Font = Enum.Font.GothamBold;
    v94.TextTruncate = Enum.TextTruncate.AtEnd;
    Panels.text(v92, "Map", (u1[u89.map] or "Lobby") .. "  ·  " .. (u2[u89.phase] or "In a match"), 72, 38, 220, 20, 13, Palette.textBody).TextTruncate = Enum.TextTruncate.AtEnd;
    local v95 = Panels.text(v92, "Players", ("%d/%d"):format(u89.players, u89.max), 344, 14, 70, 24, 16, Palette.text);
    v95.Font = Enum.Font.GothamBold;
    v95.TextXAlignment = Enum.TextXAlignment.Right;
    Panels.text(v92, "PlayersLabel", "PLAYERS", 344, 38, 70, 18, 11, Palette.textMuted).TextXAlignment = Enum.TextXAlignment.Right;
    local v96 = Panels.make("Frame", v92, "Friends", {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(292, 0),
        Size = UDim2.fromOffset(46, 72)
    });
    Panels.make("UIListLayout", v96, "Layout", {
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = UDim.new(0, -8),
        SortOrder = Enum.SortOrder.LayoutOrder
    });

    for i, v in u89.friendIds do
        if i > 6 then
            break;
        end;

        local v97 = Panels.make("ImageLabel", v96, "Friend", {
            Size = UDim2.fromOffset(36, 36),
            BackgroundColor3 = Palette.avatar,
            Image = ("rbxthumb://type=AvatarHeadShot&id=%d&w=48&h=48"):format(v),
            LayoutOrder = i
        });
        Panels.make("UICorner", v97, "Corner", {
            CornerRadius = UDim.new(1, 0)
        });
        Panels.make("UIStroke", v97, "Outline", {
            Thickness = 2,
            Color = Palette.green
        });
    end;

    local u98 = u89.players >= u89.max;
    local v99 = Panels.button(v92, "Join", u98 and "FULL" or "JOIN", 424, 13, 112, 46);
    v99.TextSize = 15;
    v99.AutoButtonColor = not u98;
    Skin.button(v99, u98 and "disabled" or "primary", {
        shimmer = false
    });
    v99.Activated:Connect(function() -- Line: 484
        -- upvalues: u98 (copy), join (ref), u89 (copy)
        if not u98 then
            join("Join", u89.id, "Joining...");
        end;
    end);
    table.insert(u88, v92);
end;

local function render(p100, p101) -- Line: 491
    -- upvalues: u88 (copy), u49 (copy), u48 (copy), u32 (ref), row (copy), u45 (copy)
    for _, v in u88 do
        v:Destroy();
    end;

    table.clear(u88);
    u49.Visible = p101.pro == true;
    u48.Position = UDim2.fromOffset(p101.pro and 170 or 10, 10);
    u48.Size = UDim2.fromOffset(p101.pro and 380 or 540, 50);
    local v102 = {};

    for _, v in p100 do
        if type(v) == "table" and type(v.id) == "string" then
            local v103 = v;
            local v104 = {};

            for _, v2 in type(v.userIds) == "table" and (v.userIds or {}) or {} do
                if u32[v2] then
                    table.insert(v104, v2);
                end;
            end;

            local v105 = {
                id = v103.id,
                region = v103.region,
                map = v103.map,
                phase = v103.phase,
                players = tonumber(v103.players) or 0,
                max = tonumber(v103.max) or 30,
                friendIds = v104
            };
            table.insert(v102, v105);
        end;
    end;

    table.sort(v102, function(p106, p107) -- Line: 517
        if #p106.friendIds == #p107.friendIds then
            return p106.players > p107.players;
        end;

        return #p106.friendIds > #p107.friendIds;
    end);

    for i, v in v102 do
        row(v, i);
    end;

    u45.Text = #v102 == 0 and (p101.pro and "No other Pro servers right now." or "No Pro servers running right now.\nJOIN RANDOM starts one.") or "";
end;

local u108 = (-1 / 0);
local u109 = nil;
local u110 = nil;

local function ask() -- Line: 533
    -- upvalues: u108 (ref), u51 (ref), u46 (copy), ProServerRemote (copy)
    if os.clock() - u108 < 2 then
        return;
    end;

    u108 = os.clock();

    if os.clock() - u51 >= 50 then
        u46.Text = "Loading...";
    end;

    ProServerRemote:FireServer("List");
end;

u52 = function(p111) -- Line: 543
    -- upvalues: u36 (copy), HudNavigation (copy), u108 (ref), u51 (ref), u46 (copy), ProServerRemote (copy), loadFriends (copy), u109 (ref), render (copy), u110 (ref)
    u36.Visible = p111;

    if p111 then
        HudNavigation.opening("ProServers");

        if os.clock() - u108 >= 2 then
            u108 = os.clock();

            if os.clock() - u51 >= 50 then
                u46.Text = "Loading...";
            end;

            ProServerRemote:FireServer("List");
        end;

        task.spawn(function() -- Line: 549
            -- upvalues: loadFriends (ref), u109 (ref), u36 (ref), render (ref), u110 (ref)
            loadFriends();

            if u109 and u36.Visible then
                render(u109, u110);
            end;
        end);
    end;
end;

u27 = function() -- Line: 557
    -- upvalues: LocalPlayer (copy), u4 (ref), u52 (ref)
    local v112;

    if (tonumber(LocalPlayer:GetAttribute("Level")) or 0) >= 25 then
        v112 = not u4;
    else
        v112 = false;
    end;

    if not v112 or LocalPlayer:GetAttribute("InMatch") == true then
        return;
    end;

    u52(true);
end;

v38.Activated:Connect(function() -- Line: 563
    -- upvalues: u52 (ref)
    u52(false);
end);
v42.Activated:Connect(ask);
u48.Activated:Connect(function() -- Line: 567
    -- upvalues: join (copy)
    join("JoinRandom", nil, "Finding a Pro server...");
end);
u49.Activated:Connect(function() -- Line: 570
    -- upvalues: join (copy)
    join("Leave", nil, "Going to a public server...");
end);
HudNavigation.Opening.Event:Connect(function(p113) -- Line: 573
    -- upvalues: u36 (copy), u52 (ref)
    if p113 ~= "ProServers" and u36.Visible then
        u52(false);
    end;
end);
LocalPlayer:GetAttributeChangedSignal("InMatch"):Connect(function() -- Line: 578
    -- upvalues: LocalPlayer (copy), u36 (copy), u52 (ref)
    if LocalPlayer:GetAttribute("InMatch") == true and u36.Visible then
        u52(false);
    end;
end);
ProServerRemote.OnClientEvent:Connect(function(p114, p115, p116) -- Line: 583
    -- upvalues: u51 (ref), u46 (copy), u109 (ref), u110 (ref), render (copy), u65 (copy), Palette (copy)
    if p114 ~= "List" or (type(p115) ~= "table" or type(p116) ~= "table") then
        if p114 == "Reply" and type(p115) == "string" then
            u46.Text = p115 or "";

            if u65.screen.Enabled and not u65.failed then
                u65.status.Text = p115;
            end;

            if p116 == true then
                u51 = (-1 / 0);

                if u65.screen.Enabled then
                    u65.failed = true;
                    u65.title.Text = "COULDN\'T TELEPORT";
                    u65.title.TextColor3 = Palette.danger;
                    u65.status.Text = p115;
                    u65.buttons.Visible = true;
                end;
            end;
        end;

        return;
    end;

    if os.clock() - u51 >= 50 then
        u46.Text = "";
    end;

    u109 = p115;
    u110 = p116;
    render(p115, p116);
end);
local ProUnlockCutscene = require(ChickenOrHero.Presentation:WaitForChild("ProUnlockCutscene"));
local u117 = { "InMatch", "MatchSummaryVisible", "ScreenPresentationActive", "AdminRefreshActive", "FootballCutsceneActive", "FootballEventOpen", "Spectating", "StarterPackOpen", "LikeRewardOpen", "EventRsvpOpen", "CrateOpen", "SpinWheelOpen", "ArmoryOpen", "JourneyOpen", "CodesOpen", "SettingsOpen", "ServerBrowserOpen", "CombineOpen", "QuestsOpen", "UpdateLogOpen", "BalloonOfferOpen", "BundleOfferOpen", "EventKnivesOpen", "FairPlayNoticeOpen", "ConnectionQualityOpen", "HostPanelOpen", "AdminPanelOpen", "PrivateInviteOpen", "CreatorPanelOpen", "EmoteWheelOpen", "AnnouncementComposerOpen", "AdminConsoleActive", "ChoiceSpotlightActive", "ReleaseCameraForUI", "AlbieTalking", "EventIntroActive", "EventIntroUnseen", "TeamEventCelebrating", "TeamEventClaimInFrame", "CutsceneActive" };
local u118 = nil;
local u119 = false;

local function blocked() -- Line: 622
    -- upvalues: u6 (ref), LocalPlayer (copy), u117 (copy)
    if not (u6 and (u6.Parent and LocalPlayer.Character)) then
        return true;
    end;

    for _, v in u117 do
        if LocalPlayer:GetAttribute(v) == true then
            return true;
        end;
    end;

    return false;
end;

local function runUnlock() -- Line: 633
    -- upvalues: u4 (ref), blocked (copy), ProUnlockCutscene (copy), u6 (ref), dress (copy)
    local v120 = nil;

    while u4 do
        if blocked() then
            v120 = nil;
        elseif v120 then
            if os.clock() - v120 >= 1.5 then
                break;
            end;
        else
            v120 = os.clock();
        end;

        task.wait(0.25);
    end;

    local success, result = pcall(ProUnlockCutscene.play, u6, function() -- Line: 645
        -- upvalues: u4 (ref), dress (ref)
        u4 = false;
        dress();
    end);

    if not success then
        warn("[ProServers] unlock scene failed: " .. tostring(result));
    end;

    u4 = false;
    dress();
end;

LocalPlayer:GetAttributeChangedSignal("Level"):Connect(function() -- Line: 655
    -- upvalues: LocalPlayer (copy), u118 (ref), u119 (ref), u4 (ref), runUnlock (copy), dress (copy)
    local v121 = tonumber(LocalPlayer:GetAttribute("Level")) or 0;

    if u118 and not (u119 or (u118 >= 25 or v121 < 25)) then
        u119 = true;
        u4 = true;
        task.spawn(runUnlock);
    end;

    if u118 then
        u118 = v121;
    end;

    dress();
end);
task.spawn(function() -- Line: 668
    -- upvalues: LocalPlayer (copy), u118 (ref)
    if LocalPlayer:GetAttribute("StatsLoaded") ~= true then
        LocalPlayer:GetAttributeChangedSignal("StatsLoaded"):Wait();
    end;

    task.wait(1);
    u118 = tonumber(LocalPlayer:GetAttribute("Level")) or 0;
end);
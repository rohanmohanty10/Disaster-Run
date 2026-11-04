 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local TweenService = game:GetService("TweenService");
local StarterGui = game:GetService("StarterGui");
local LocalPlayer = Players.LocalPlayer;
local Admin = game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Admin");
local EventHostRemote = Admin:WaitForChild("EventHostRemote");
local EventHostCatalog = require(Admin:WaitForChild("EventHostCatalog"));
local EventHostLayout = require(Admin:WaitForChild("EventHostLayout"));
local ScreenGui = Instance.new("ScreenGui");
ScreenGui.Name = "ValleyEventAudience";
ScreenGui.ResetOnSpawn = false;
ScreenGui.DisplayOrder = 82;
ScreenGui.IgnoreGuiInset = false;
ScreenGui:SetAttribute("UIProportionalExclude", true);
ScreenGui:SetAttribute("SelfManagedText", true);
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui");
local Frame = Instance.new("Frame");
Frame.Name = "Root";
Frame.Size = UDim2.fromScale(1, 1);
Frame.BackgroundTransparency = 1;
Frame.Parent = ScreenGui;

local function label(p1) -- Line: 25
    -- upvalues: Frame (copy)
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Name = p1;
    TextLabel.AnchorPoint = Vector2.new(0.5, 0);
    TextLabel.BackgroundColor3 = Color3.fromRGB(15, 26, 38);
    TextLabel.BackgroundTransparency = 0.08;
    TextLabel.TextColor3 = Color3.fromRGB(232, 237, 228);
    TextLabel.TextScaled = true;
    TextLabel.TextWrapped = true;
    TextLabel.BorderSizePixel = 0;
    TextLabel.Font = Enum.Font.GothamMedium;
    TextLabel.Visible = false;
    TextLabel.Parent = Frame;
    local UICorner = Instance.new("UICorner");
    UICorner.CornerRadius = UDim.new(0, 10);
    UICorner.Parent = TextLabel;
    local UIPadding = Instance.new("UIPadding");
    UIPadding.PaddingLeft = UDim.new(0.04, 0);
    UIPadding.PaddingRight = UDim.new(0.04, 0);
    UIPadding.PaddingTop = UDim.new(0.14, 0);
    UIPadding.PaddingBottom = UDim.new(0.14, 0);
    UIPadding.Parent = TextLabel;

    return TextLabel;
end;

local u2 = label("EventCountdown");
local u3 = label("HostAnnouncement");
u2.TextColor3 = Color3.fromRGB(235, 201, 137);
u3.RichText = true;
u3.BackgroundTransparency = 1;
u3.TextStrokeTransparency = 0.45;

local function resize() -- Line: 54
    -- upvalues: Frame (copy), EventHostLayout (copy), u2 (copy), u3 (copy)
    local AbsoluteSize = Frame.AbsoluteSize;
    local v4, v5 = EventHostLayout.toast(AbsoluteSize.X, AbsoluteSize.Y);
    u2.Size = UDim2.fromOffset(math.min(420, AbsoluteSize.X * 0.8), 32);
    u2.Position = UDim2.fromScale(0.5, 0.07);
    u3.Size = UDim2.fromOffset(v4, v5);
    u3.Position = UDim2.new(0.5, 0, 0.07, 40);
end;

local function escape(p6) -- Line: 62
    return tostring(p6):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub("\"", "&quot;");
end;

local u7 = {};
local u8 = false;
local u9 = true;
local u10 = {};

local function notifyBoost(u11) -- Line: 67
    -- upvalues: u10 (copy), u9 (ref), StarterGui (copy)
    if type(u11) ~= "table" or (type(u11.id) ~= "string" or (type(u11.endsAt) ~= "number" or u11.endsAt <= workspace:GetServerTimeNow())) then
        return;
    end;

    local u12 = u11.mode == "DoubleCoins" and "Coins" or (u11.mode == "DoubleGems" and "Gems" or false);

    if not u12 or u10[u11.mode] == u11.id then
        return;
    end;

    u10[u11.mode] = u11.id;
    task.spawn(function() -- Line: 77
        -- upvalues: u9 (ref), u11 (copy), StarterGui (ref), u12 (copy)
        for i = 1, 5 do
            if not u9 or u11.endsAt <= workspace:GetServerTimeNow() then
                return;
            end;

            local SetCore = StarterGui.SetCore;
            local v13 = {
                Duration = 6,
                Title = "2X " .. string.upper(u12) .. " ENABLED!",
                Text = "An admin activated double " .. string.lower(u12) .. "! See your wallet for the countdown."
            };

            if pcall(SetCore, StarterGui, "SendNotification", v13) then
                return;
            end;

            task.wait(1);
            local _ = i;
        end;
    end);
end;

local function announce(p14) -- Line: 95
    -- upvalues: u7 (copy), u8 (ref), u9 (ref), u3 (copy), TweenService (copy)
    if #u7 >= 5 then
        table.remove(u7, 1);
    end;

    table.insert(u7, p14);

    if u8 then
        return;
    end;

    u8 = true;
    task.spawn(function() -- Line: 104
        -- upvalues: u9 (ref), u7 (ref), u3 (ref), TweenService (ref), u8 (ref)
        while u9 and #u7 > 0 do
            local table_remove_ret = table.remove(u7, 1);
            u3.Text = "<font color=\"#FF7777\"><b>" .. tostring(table_remove_ret.authorName):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub("\"", "&quot;") .. "</b></font> <font color=\"#7DCDE4\">" .. utf8.char(57344) .. "</font>: " .. tostring(table_remove_ret.message):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub("\"", "&quot;");
            u3.Visible = true;
            u3.TextTransparency = 1;
            TweenService:Create(u3, TweenInfo.new(0.2), {
                TextTransparency = 0
            }):Play();
            local seconds = table_remove_ret.seconds;
            local task_wait = task.wait;
            local v15;

            if type(seconds) == "number" and seconds == seconds then
                local math_floor_ret = math.floor(seconds);
                v15 = math.clamp(math_floor_ret, 3, 15) or 7;
            else
                v15 = 7;
            end;

            task_wait(v15);

            if not u9 then
                break;
            end;

            TweenService:Create(u3, TweenInfo.new(0.25), {
                TextTransparency = 1
            }):Play();
            task.wait(0.25);
        end;

        u8 = false;

        if u9 then
            u3.Visible = false;
        end;
    end);
end;

local u16 = nil;
local u17 = nil;
local u18 = nil;
local u19 = nil;
local u20 = {};
local u21 = {};

local function clear() -- Line: 133
    -- upvalues: u20 (copy), u17 (ref), u19 (ref), u18 (ref), u21 (copy), Lighting (copy), u16 (ref), u2 (copy)
    for _, v in u20 do
        v:Destroy();
    end;

    table.clear(u20);

    if u17 then
        u17:Destroy();
        u17 = nil;
    end;

    if u19 then
        u19:Destroy();
        u19 = nil;
        u18 = nil;
    end;

    for i, v in u21 do
        if Lighting[i] == v.applied then
            Lighting[i] = v.original;
        end;
    end;

    table.clear(u21);
    u16 = nil;
    u2.Visible = false;
end;

local function lighting(p22, p23) -- Line: 155
    -- upvalues: u21 (copy), Lighting (copy)
    u21[p22] = {
        original = Lighting[p22],
        applied = p23
    };
    Lighting[p22] = p23;
end;

local function apply(p24) -- Line: 159
    -- upvalues: EventHostCatalog (copy), clear (copy), u16 (ref), u17 (ref), Lighting (copy), u21 (copy), u19 (ref), u18 (ref)
    if type(p24) ~= "table" or (p24.mode == "DoubleCoins" or (p24.mode == "DoubleGems" or (not EventHostCatalog.Modes[p24.mode] or p24.endsAt <= workspace:GetServerTimeNow()))) then
        clear();

        return;
    end;

    if u16 and u16.id == p24.id then
        return;
    end;

    clear();
    u16 = p24;

    if p24.mode ~= "GoldenHour" and (p24.mode ~= "Blackout" and p24.mode ~= "MoonGravity") then
        if p24.mode == "Confetti" then
            u19 = Instance.new("Part");
            u19.Name = "EventConfettiLocal";
            u19.Size = Vector3.new(1, 1, 1);
            u19.Transparency = 1;
            u19.Anchored = true;
            u19.CanCollide = false;
            u19.CanTouch = false;
            u19.CanQuery = false;
            u19.Parent = workspace;
            u18 = Instance.new("ParticleEmitter");
            u18.Texture = "rbxasset://textures/particles/sparkles_main.dds";
            u18.Rate = 24;
            u18.Lifetime = NumberRange.new(2, 3);
            u18.Speed = NumberRange.new(4, 9);
            u18.Acceleration = Vector3.new(0, -10, 0);
            u18.SpreadAngle = Vector2.new(180, 180);
            u18.Rotation = NumberRange.new(0, 360);
            u18.RotSpeed = NumberRange.new(-80, 80);
            u18.Size = NumberSequence.new(0.25);
            u18.Color = ColorSequence.new({ ColorSequenceKeypoint.new(0, Color3.fromRGB(235, 201, 137)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(184, 157, 241)), ColorSequenceKeypoint.new(1, Color3.fromRGB(125, 205, 228)) });
            u18.Parent = u19;
        end;

        return;
    end;

    u17 = Instance.new("ColorCorrectionEffect");
    u17.Name = "EventHostColor";
    u17.Parent = Lighting;

    if p24.mode == "GoldenHour" then
        u21.ClockTime = {
            applied = 17.7,
            original = Lighting.ClockTime
        };
        Lighting.ClockTime = 17.7;
        u17.TintColor = Color3.fromRGB(255, 225, 179);
        u17.Saturation = 0.12;

        return;
    end;

    if p24.mode ~= "Blackout" then
        u17.TintColor = Color3.fromRGB(191, 216, 255);

        return;
    end;

    u21.ClockTime = {
        applied = 0,
        original = Lighting.ClockTime
    };
    Lighting.ClockTime = 0;
    u21.Brightness = {
        applied = 0.5,
        original = Lighting.Brightness
    };
    Lighting.Brightness = 0.5;
    local Color3_fromRGB_ret = Color3.fromRGB(45, 55, 78);
    u21.Ambient = {
        original = Lighting.Ambient,
        applied = Color3_fromRGB_ret
    };
    Lighting.Ambient = Color3_fromRGB_ret;
    local Color3_fromRGB_ret2 = Color3.fromRGB(56, 66, 88);
    u21.OutdoorAmbient = {
        original = Lighting.OutdoorAmbient,
        applied = Color3_fromRGB_ret2
    };
    Lighting.OutdoorAmbient = Color3_fromRGB_ret2;
    u17.TintColor = Color3.fromRGB(171, 197, 255);
    u17.Brightness = -0.08;
end;

local u25 = 0;
local u29 = RunService.Heartbeat:Connect(function(p26) -- Line: 217
    -- upvalues: u25 (ref), u16 (ref), clear (copy), u2 (copy), EventHostCatalog (copy), u20 (copy), Players (copy), u19 (ref), LocalPlayer (copy), u18 (ref)
    u25 = u25 + p26;

    if u25 < 0.1 or not u16 then
        return;
    end;

    u25 = 0;
    local v27 = u16.endsAt - workspace:GetServerTimeNow();
    local math_ceil_ret = math.ceil(v27);
    local math_max_ret = math.max(0, math_ceil_ret);

    if math_max_ret <= 0 then
        clear();

        return;
    end;

    u2.Visible = true;
    u2.Text = EventHostCatalog.Modes[u16.mode].Name .. " · " .. math.floor(math_max_ret / 60) .. ":" .. string.format("%02d", math_max_ret % 60);

    if u16.mode ~= "Rainbow" then
        if u19 then
            local Character = LocalPlayer.Character;

            if Character then
                Character = Character:FindFirstChild("HumanoidRootPart");
            end;

            u18.Enabled = Character ~= nil;

            if Character then
                u19.Position = Character.Position + Vector3.new(0, 12, 0);
            end;
        end;

        return;
    end;

    for i, v in u20 do
        if not i.Parent then
            v:Destroy();
            u20[i] = nil;
        end;
    end;

    for _, v in Players:GetPlayers() do
        local Character = v.Character;

        if Character and Character.Parent then
            local v28 = u20[Character];

            if not v28 then
                v28 = Instance.new("Highlight");
                v28.Name = "EventRainbowLocal";
                v28.Adornee = Character;
                v28.FillTransparency = 0.8;
                v28.OutlineTransparency = 0.1;
                v28.DepthMode = Enum.HighlightDepthMode.Occluded;
                v28.Parent = Character;
                u20[Character] = v28;
            end;

            v28.FillColor = Color3.fromHSV((workspace:GetServerTimeNow() * 0.12 + v.UserId % 10 * 0.1) % 1, 0.65, 1);
            v28.OutlineColor = v28.FillColor;
        end;
    end;
end);
local u32 = EventHostRemote.OnClientEvent:Connect(function(p30, p31) -- Line: 268
    -- upvalues: apply (copy), notifyBoost (copy), announce (copy)
    if p30 == "EventState" then
        apply(p31);

        return;
    end;

    if p30 == "BoostEnabled" then
        notifyBoost(p31);

        return;
    end;

    if p30 == "Announcement" and type(p31) == "table" then
        announce(p31);
    end;
end);
local u33 = Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(resize);
script.Destroying:Connect(function() -- Line: 278
    -- upvalues: u9 (ref), u32 (copy), u29 (copy), u33 (copy), clear (copy), ScreenGui (copy)
    u9 = false;
    u32:Disconnect();
    u29:Disconnect();
    u33:Disconnect();
    clear();
    ScreenGui:Destroy();
end);
resize();
EventHostRemote:FireServer("PublicSync");
 

 

local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local ReplicatedFirst = game:GetService("ReplicatedFirst");
local ContentProvider = game:GetService("ContentProvider");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local SoundService = game:GetService("SoundService");
local RunService = game:GetService("RunService");
ReplicatedFirst:RemoveDefaultLoadingScreen();

repeat
    task.wait();
until game:IsLoaded();

local Resources = ReplicatedStorage:WaitForChild("Resources");
local wiki = ReplicatedStorage:WaitForChild("wiki");
local mvpAnimations = require(wiki.mvpAnimations);
local packets = require(ReplicatedStorage.packets);
local Util = require(ReplicatedStorage.util.Util);
local v1 = true;

local function parser(p2) -- Line: 28
    -- upvalues: Resources (copy)
    local Attribute = p2:GetAttribute("style");
    local v3;

    if string.sub(Attribute, 0, 6) == "legacy" then
        v3 = Resources.Legacy;
        Attribute = string.split(Attribute, "legacy")[2];
    else
        v3 = nil;
    end;

    local v4 = v3 or Resources;
    local v5;

    if v4:FindFirstChild(Attribute) then
        v5 = v4:FindFirstChild(Attribute);
    else
        local string_sub_ret = string.sub(Attribute, 1, 1);
        local string_len_ret = string.len(Attribute);
        v5 = v4:FindFirstChild(string_sub_ret .. string.sub(Attribute, 2, string_len_ret));
    end;

    if v5 then
        local v6 = {};

        for _, descendant in v5:GetDescendants() do
            if descendant:IsA("Animation") then
                table.insert(v6, descendant);
            end;
        end;

        return {
            style = Attribute,
            data = v6
        };
    end;
end;

local function mvp_parser(p7) -- Line: 65
    -- upvalues: mvpAnimations (copy)
    local Attribute = p7:GetAttribute("mvp_anim");
    local v8;

    if mvpAnimations[Attribute] and mvpAnimations[Attribute].folder then
        v8 = mvpAnimations[Attribute].folder;
    else
        v8 = nil;
    end;

    if v8 then
        local v9 = {};

        for _, descendant in v8:GetDescendants() do
            if descendant:IsA("Animation") then
                table.insert(v9, descendant);
            end;
        end;

        return {
            mvp = Attribute,
            data = v9
        };
    end;
end;

local function LoadPlayersStyleStuff(u10, u11) -- Line: 91
    -- upvalues: parser (copy)
    repeat
        task.wait();
    until u10:GetAttribute("style");

    u10:GetAttributeChangedSignal("style"):Connect(function() -- Line: 94
        -- upvalues: u11 (copy), parser (ref), u10 (copy)
        u11(parser(u10));
    end);

    return parser(u10);
end;

local function LoadPlayersMVPStuff(u12, u13) -- Line: 101
    -- upvalues: mvp_parser (copy)
    repeat
        task.wait();
    until u12:GetAttribute("mvp_anim");

    u12:GetAttributeChangedSignal("mvp_anim"):Connect(function() -- Line: 104
        -- upvalues: u13 (copy), mvp_parser (ref), u12 (copy)
        u13(mvp_parser(u12));
    end);

    return mvp_parser(u12);
end;

local LocalPlayer = Players.LocalPlayer;
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local u14 = false;
local u15 = nil;
local u16 = false;
local u17 = script.loadingui:Clone();
u17.Parent = LocalPlayer.PlayerGui;
local Frame = u17.Frame;
local u18;

if UserInputService.KeyboardEnabled then
    u18 = true;
    local VideoFrame = Frame.VideoFrame;
    local v19 = math.random(2) == 1 and 99159135270424 or 96311774944804;
    VideoFrame.Video = `rbxassetid://{tostring(v19)}`;
    Frame.VideoFrame:Play();
    local u20 = false;
    Frame.VideoFrame.Loaded:Connect(function(p21: string) -- Line: 129
        -- upvalues: u20 (ref), u15 (ref), soundUtil (copy), SoundService (copy)
        u20 = true;
        u15 = soundUtil:play(script["opening theme"], SoundService);
    end);
    task.spawn(function() -- Line: 134
        -- upvalues: u17 (copy), LocalPlayer (copy), Frame (copy), u15 (ref), u20 (ref)
        while task.wait(0.1) and u17.Parent == LocalPlayer.PlayerGui do
            local TimePosition = Frame.VideoFrame.TimePosition;

            if u15 and u20 then
                if TimePosition < u15.TimeLength then
                    u15:Resume();

                    if math.abs(u15.TimePosition - TimePosition) > 0.15 then
                        u15.TimePosition = TimePosition;
                    end;
                else
                    u15:Pause();
                end;
            end;
        end;
    end);
else
    u18 = false;
end;

local u22 = SoundService:WaitForChild("football-crowd-3-69245");
local Volume = u22.Volume;
u22.Volume = 0;
local TweenInfo_new_ret = TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, false, 0);
local u23 = TweenService:Create(Frame.football, TweenInfo_new_ret, {
    Rotation = 360
});
u23:Play();
local u24 = nil;
local u25 = nil;
local u26 = {};
local u27 = {
    styles = {},
    mvps = {}
};
local u28 = {};
local u29 = nil;
task.defer(function() -- Line: 179
    -- upvalues: LocalPlayer (copy), u17 (copy), TweenService (copy), u15 (ref), soundUtil (copy), packets (copy), Frame (copy)
    repeat
        task.wait();
    until LocalPlayer:GetAttribute("epilepsy_screened") ~= nil;

    if LocalPlayer:GetAttribute("epilepsy_screened") then
        Frame.VideoFrame.Visible = true;

        return;
    end;

    local EpilepsyScreening = u17.EpilepsyScreening;
    EpilepsyScreening.Visible = true;
    TweenService:Create(EpilepsyScreening, TweenInfo.new(1), {
        GroupTransparency = 0
    }):Play();

    if u15 then
        local Muffle = u15.Muffle;
        Muffle.Enabled = true;
        TweenService:Create(Muffle, TweenInfo.new(1), {
            HighGain = -60,
            MidGain = -30
        }):Play();
    end;

    task.wait(2);
    EpilepsyScreening.Continue.Visible = true;
    EpilepsyScreening.Disable.Visible = true;
    EpilepsyScreening.Continue.MouseButton1Click:Once(function() -- Line: 208
        -- upvalues: soundUtil (ref), packets (ref)
        soundUtil:play(script.click, "default");
        packets.bytenet_epilepsyScreen.send(false);
    end);
    EpilepsyScreening.Disable.MouseButton1Click:Once(function() -- Line: 213
        -- upvalues: soundUtil (ref), packets (ref)
        soundUtil:play(script.click, "default");
        packets.bytenet_epilepsyScreen.send(true);
    end);
    LocalPlayer:GetAttributeChangedSignal("epilepsy_screened"):Wait();
    EpilepsyScreening.Visible = false;
end);

local function skip() -- Line: 226
    -- upvalues: u14 (ref), u23 (copy), u24 (ref), u25 (ref), Frame (copy), LocalPlayer (copy), u16 (ref), u22 (copy), Volume (copy), u15 (ref), u18 (ref), TweenService (copy), Util (copy), soundUtil (copy), SoundService (copy), u17 (copy), packets (copy)
    if u14 then
        return;
    end;

    u14 = true;

    if u23 then
        u23:Pause();
        u23:Destroy();
    end;

    if u24 then
        u24:Disconnect();
    end;

    if u25 then
        pcall(function() -- Line: 234
            -- upvalues: u25 (ref)
            task.cancel(u25);
        end);
    end;

    local TextLabel = Frame:FindFirstChild("TextLabel");

    if TextLabel then
        TextLabel.Text = "WAITING FOR SERVER";
    end;

    repeat
        task.wait();
    until LocalPlayer:GetAttribute("epilepsy_screened") == true;

    u16 = true;
    u22.Volume = Volume;
    Frame.VideoFrame:Pause();

    while not u15 and u18 do
        task.wait();
    end;

    if u15 then
        TweenService:Create(u15, TweenInfo.new(1), {
            PlaybackSpeed = 0
        }):Play();
    end;

    if not Util.isepilepsysafe() then
        Frame.flash.BackgroundTransparency = 0;
        TweenService:Create(Frame.flash, TweenInfo.new(0.5), {
            BackgroundTransparency = 1
        }):Play();
    end;

    soundUtil:play(script.skip, SoundService);
    soundUtil:play(script.loaded, SoundService);
    task.wait(1);
    TweenService:Create(Frame, TweenInfo.new(1), {
        GroupTransparency = 1
    }):Play();
    task.delay(1, u17.Destroy, u17);

    if u15 then
        task.delay(1, u15.Destroy, u15);
    end;

    packets.bytenet_loadingFinished.send();
end;

u25 = task.delay(3, function() -- Line: 283
    -- upvalues: Frame (copy), u24 (ref), skip (copy)
    Frame.skiptext.Visible = true;
    u24 = Frame.nodonttouch.MouseButton1Up:Connect(skip);
end);
pcall(function() -- Line: 287
    -- upvalues: Frame (copy)
    Frame.TextLabel.Text = "TIDYING UP";
    Frame.bar.bar.Size = UDim2.fromScale(0, 1);
end);
RunService.Heartbeat:Wait();

repeat
    task.wait();
until Players.LocalPlayer and Players.LocalPlayer:WaitForChild("setting");

repeat
    task.wait();
until UserInputService.GamepadEnabled or (UserInputService.TouchEnabled or UserInputService.KeyboardEnabled);

local v30 = Players.LocalPlayer:WaitForChild("setting"):FindFirstChild("loadonbaddeviceanyway") and Players.LocalPlayer.setting.loadonbaddeviceanyway.Value == true and true or false;

if UserInputService.GamepadEnabled or UserInputService.TouchEnabled then
    v1 = v30;
end;

local v31 = 0;

local function registerAnimationSet(p32, p33, p34) -- Line: 308
    -- upvalues: u26 (copy), u29 (ref)
    if p32[p33] or #p34 <= 1 then
        return;
    end;

    for _, v in p34 do
        table.insert(u26, v);
    end;

    p32[p33] = true;

    if u29 then
        u29 = #u26;
    end;
end;

local function player_management(u35) -- Line: 324
    -- upvalues: LoadPlayersStyleStuff (copy), u27 (copy), u26 (copy), u29 (ref), LoadPlayersMVPStuff (copy), u28 (copy)
    coroutine.wrap(function() -- Line: 325
        -- upvalues: LoadPlayersStyleStuff (ref), u35 (copy), u27 (ref), u26 (ref), u29 (ref)
        local v37 = LoadPlayersStyleStuff(u35, function(p36) -- Line: 326
            -- upvalues: u27 (ref), u26 (ref), u29 (ref)
            if not p36 then
                return;
            end;

            local styles = u27.styles;
            local style = p36.style;
            local data = p36.data;

            if not styles[style] then
                if #data <= 1 then
                    return;
                end;

                for _, v in data do
                    table.insert(u26, v);
                end;

                styles[style] = true;

                if u29 then
                    u29 = #u26;
                end;
            end;
        end);

        if v37 then
            local styles = u27.styles;
            local style = v37.style;
            local data = v37.data;

            if not styles[style] then
                if #data <= 1 then
                    return;
                end;

                for _, v in data do
                    table.insert(u26, v);
                end;

                styles[style] = true;

                if u29 then
                    u29 = #u26;
                end;
            end;
        end;
    end)();
    coroutine.wrap(function() -- Line: 335
        -- upvalues: LoadPlayersMVPStuff (ref), u35 (copy), u27 (ref), u26 (ref), u29 (ref)
        local v39 = LoadPlayersMVPStuff(u35, function(p38) -- Line: 336
            -- upvalues: u27 (ref), u26 (ref), u29 (ref)
            if not p38 then
                return;
            end;

            local mvps = u27.mvps;
            local mvp = p38.mvp;
            local data = p38.data;

            if not mvps[mvp] then
                if #data <= 1 then
                    return;
                end;

                for _, v in data do
                    table.insert(u26, v);
                end;

                mvps[mvp] = true;

                if u29 then
                    u29 = #u26;
                end;
            end;
        end);

        if v39 then
            local mvps = u27.mvps;
            local mvp = v39.mvp;
            local data = v39.data;

            if not mvps[mvp] then
                if #data <= 1 then
                    return;
                end;

                for _, v in data do
                    table.insert(u26, v);
                end;

                mvps[mvp] = true;

                if u29 then
                    u29 = #u26;
                end;
            end;
        end;
    end)();
    u28[u35] = true;
end;

if v1 then
    for _, v in Players:GetPlayers() do
        player_management(v);
    end;

    Players.PlayerAdded:Connect(player_management);
    Players.PlayerRemoving:Connect(function(p40) -- Line: 353
        -- upvalues: u28 (copy)
        u28[p40] = nil;
    end);

    if not u28[LocalPlayer] then
        player_management(LocalPlayer);
    end;
end;

repeat
    task.wait();
until #u26 ~= 0;

local v41 = {
    idleGoalBall = { {
            id = "http://www.roblox.com/asset/?id=117211762631778",
            weight = 9
        } },
    runBall = { {
            id = "http://www.roblox.com/asset/?id=85841393652976",
            weight = 10
        } },
    jumpGK = { {
            id = "http://www.roblox.com/asset/?id=105741699498700",
            weight = 10
        } }
};

if v1 then
    for _, v in v41 do
        for _, v2 in v do
            local Animation = Instance.new("Animation");
            Animation.AnimationId = v2.id;
            table.insert(u26, Animation);
        end;
    end;

    for _, child in Resources:GetChildren() do
        if child:IsA("Animation") then
            table.insert(u26, child);
        end;
    end;

    for _, child in Resources.Volley:GetChildren() do
        if child:IsA("Animation") then
            table.insert(u26, child);
        end;
    end;
end;

u29 = #u26;

if v1 then
    repeat
        task.wait(0.005);

        if u26[1] then
            task.spawn(function() -- Line: 405
                -- upvalues: ContentProvider (copy), u26 (copy)
                ContentProvider:PreloadAsync({ u26[1] });
            end);
            v31 = v31 + 1;
            table.remove(u26, 1);
            pcall(function() -- Line: 410
                -- upvalues: Frame (copy), u26 (copy), u29 (ref)
                Frame.TextLabel.Text = `{#u26}x | LOADING...`;
                local math_clamp_ret = math.clamp(#u26 / u29, 0, 1);
                local math_lerp_ret = math.lerp(1, 0, math_clamp_ret);
                Frame.bar.bar.Size = UDim2.fromScale(math.min(math_lerp_ret, 1), 1);
            end);
        end;

        repeat
            task.wait();
        until ContentProvider.RequestQueueSize <= 0;
    until #u26 <= 0 or u16;
end;

task.spawn(skip);

if v1 then
    RunService.Heartbeat:Connect(function() -- Line: 429
        -- upvalues: u26 (copy), ContentProvider (copy), UserInputService (copy)
        if u26[1] then
            task.spawn(function() -- Line: 431
                -- upvalues: ContentProvider (ref), u26 (ref)
                ContentProvider:PreloadAsync({ u26[1] });
            end);
            table.remove(u26, 1);

            repeat
                task.wait(UserInputService.KeyboardEnabled and 0.075 or 0.85);
            until ContentProvider.RequestQueueSize <= 0;
        end;
    end);
end;
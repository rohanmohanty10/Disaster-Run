  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local UserInputService = game:GetService("UserInputService");
local Players = game:GetService("Players");
local Workspace = game:GetService("Workspace");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AnimationHandler = require(ReplicatedStorage.ReplicatedModules.AnimationHandler);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local Signal = require(ReplicatedStorage.ReplicatedRoot.Libraries.Classes.Signal);
local LocalPlayer = Players.LocalPlayer;
local CurrentCamera = Workspace.CurrentCamera;
local u1 = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled;
local u2 = Random.new();
local u3 = { "Love it!", "So real 😭", "GOATED 🐐", "This!!", "Crying 😭🤚", "Iconic 👑", "Obsessed 😍", "Slay 💅", "No way 😱", "Yes king 👑", "Vibes 🌟", "I\'m dead 💀", "Goosebumps ✨", "Soooo good 🥹", "WHAT 😲", "Saving 🔖", "Sharing 📲", "OMGGG 🔥", "Repost 🔁", "Marry me 💍" };
local u4 = { "❤️", "💖", "💕", "💗", "💓", "💞", "🩷", "❤️‍🔥", "💘", "👍", "🔥" };
local u5 = {
    [Enum.KeyCode.ButtonA] = true,
    [Enum.KeyCode.ButtonR2] = true
};

local function Abbreviate(p6) -- Line: 37
    local v7 = math.floor(p6);

    if v7 >= 1000000000 then
        local v8 = v7 / 1000000000;

        if v8 >= 100 then
            return string.format("%dB", v8);
        end;

        return string.format("%.1fB", v8):gsub("%.0B", "B");
    end;

    if v7 >= 1000000 then
        local v9 = v7 / 1000000;

        if v9 >= 100 then
            return string.format("%dM", v9);
        end;

        return string.format("%.1fM", v9):gsub("%.0M", "M");
    end;

    if v7 < 1000 then
        return tostring(v7);
    end;

    local v10 = v7 / 1000;

    if v10 >= 100 then
        return string.format("%dk", v10);
    end;

    return string.format("%.1fk", v10):gsub("%.0k", "k");
end;

local function RandomComment() -- Line: 52
    -- upvalues: u2 (copy), u4 (copy), u3 (copy)
    if u2:NextNumber() < 0.72 then
        return u4[u2:NextInteger(1, #u4)];
    end;

    return u3[u2:NextInteger(1, #u3)];
end;

local u11 = {};
u11.__index = u11;

function u11.new(p12) -- Line: 62
    -- upvalues: Trove (copy), CurrentCamera (copy), u11 (copy), Signal (copy)
    local v13 = p12 or {};
    local v14 = {
        Likes = 0,
        Clicks = 0,
        StartTime = 0,
        NextPassiveComment = 0,
        MinigameEnded = false,
        Destroyed = false,
        MusicBaseVolume = nil,
        OriginalCameraType = nil,
        CameraHRP = nil,
        LikeBaseSize = nil,
        HintBaseSize = nil,
        Liked = nil,
        Ended = nil,
        Trove = Trove.new(),
        Duration = v13.Duration or 30,
        Goal = v13.Goal or 10000000,
        Increment = v13.Increment or 62000,
        IncrementJitter = v13.IncrementJitter or 0.3,
        Music = v13.Music or script:FindFirstChild("Music"),
        DanceAnimation = v13.DanceAnimation or 86511453732766,
        CameraDistance = v13.CameraDistance or 6,
        CameraHeight = v13.CameraHeight or 0.5,
        BaseFOV = CurrentCamera.FieldOfView
    };
    local v15 = setmetatable(v14, u11);
    v15.Liked = v15.Trove:Construct(Signal);
    v15.Ended = v15.Trove:Construct(Signal);

    return v15;
end;

function u11.GetHintText(p16) -- Line: 101
    -- upvalues: u1 (copy), UserInputService (copy)
    return u1 and "TAP ANYWHERE!" or (UserInputService:GetLastInputType() == Enum.UserInputType.Gamepad1 and "PRESS Ⓐ!" or "CLICK ANYWHERE!");
end;

function u11.UpdateCameraCFrame(p17) -- Line: 107
    -- upvalues: CurrentCamera (copy)
    if not (p17.CameraHRP and p17.CameraHRP.Parent) then
        return;
    end;

    local v18 = p17.CameraHRP.Position + p17.CameraHRP.CFrame.LookVector * p17.CameraDistance + Vector3.new(0, p17.CameraHeight, 0);
    CurrentCamera.CFrame = CFrame.lookAt(v18, p17.CameraHRP.Position);
end;

function u11.Setup(u19) -- Line: 114
    -- upvalues: LocalPlayer (copy), CurrentCamera (copy), AnimationHandler (copy), Abbreviate (copy), TweenService (copy)
    local Character = LocalPlayer.Character;
    local v20;

    if Character then
        v20 = Character:FindFirstChild("HumanoidRootPart");
    else
        v20 = Character;
    end;

    if v20 then
        u19.CameraHRP = v20;
        u19.OriginalCameraType = CurrentCamera.CameraType;
        CurrentCamera.CameraType = Enum.CameraType.Scriptable;
        u19:UpdateCameraCFrame();
        u19.Trove:Add(function() -- Line: 124
            -- upvalues: CurrentCamera (ref), u19 (copy)
            CurrentCamera.CameraType = u19.OriginalCameraType or Enum.CameraType.Custom;
        end);
    end;

    local v21 = Character and Character:FindFirstChildWhichIsA("Animator", true);

    if v21 then
        local v22 = AnimationHandler.CreateAnimationById("Dance", u19.DanceAnimation);
        local u23 = v21:LoadAnimation(v22);
        u23.Priority = Enum.AnimationPriority.Action;
        u23.Looped = true;
        u23:Play(0.15, 1, 1);
        u19.Trove:Add(v22);
        u19.Trove:Add(function() -- Line: 140
            -- upvalues: u23 (copy)
            u23:Stop(0.25);
            task.delay(0.3, function() -- Line: 142
                -- upvalues: u23 (ref)
                u23:Destroy();
            end);
        end);
    end;

    local ScreenGui = Instance.new("ScreenGui");
    ScreenGui.Name = "LikesMinigame";
    ScreenGui.IgnoreGuiInset = true;
    ScreenGui.DisplayOrder = 50;
    ScreenGui.ResetOnSpawn = false;
    ScreenGui.Parent = LocalPlayer.PlayerGui;
    u19.Trove:Add(ScreenGui);
    u19.Gui = ScreenGui;
    local Frame = Instance.new("Frame");
    Frame.Size = UDim2.fromScale(0.55, 0.14);
    Frame.Position = UDim2.fromScale(0.5, 0.03);
    Frame.AnchorPoint = Vector2.new(0.5, 0);
    Frame.BackgroundTransparency = 1;
    Frame.ZIndex = 5;
    Frame.Parent = ScreenGui;
    local TextLabel = Instance.new("TextLabel");
    TextLabel.Size = UDim2.fromScale(1, 0.6);
    TextLabel.Position = UDim2.fromScale(0.5, 0);
    TextLabel.AnchorPoint = Vector2.new(0.5, 0);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy);
    TextLabel.TextScaled = true;
    TextLabel.TextColor3 = Color3.fromRGB(255, 90, 130);
    TextLabel.TextStrokeTransparency = 0;
    TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0);
    TextLabel.Text = `❤️ 0 / {Abbreviate(u19.Goal)}`;
    TextLabel.ZIndex = 5;
    TextLabel.Parent = Frame;
    u19.LikeLabel = TextLabel;
    u19.LikeBaseSize = TextLabel.Size;
    local TextLabel2 = Instance.new("TextLabel");
    TextLabel2.Size = UDim2.fromScale(1, 0.35);
    TextLabel2.Position = UDim2.fromScale(0.5, 0.62);
    TextLabel2.AnchorPoint = Vector2.new(0.5, 0);
    TextLabel2.BackgroundTransparency = 1;
    TextLabel2.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Bold);
    TextLabel2.TextScaled = true;
    TextLabel2.TextColor3 = Color3.new(1, 1, 1);
    TextLabel2.TextStrokeTransparency = 0.4;
    TextLabel2.TextStrokeColor3 = Color3.new(0, 0, 0);
    TextLabel2.Text = string.format("%d:%02d", math.floor(u19.Duration / 60), (math.floor(u19.Duration % 60)));
    TextLabel2.ZIndex = 5;
    TextLabel2.Parent = Frame;
    u19.TimerLabel = TextLabel2;
    local TextLabel3 = Instance.new("TextLabel");
    TextLabel3.Size = UDim2.fromScale(0.32, 0.1);
    TextLabel3.Position = UDim2.fromScale(0.5, 0.88);
    TextLabel3.AnchorPoint = Vector2.new(0.5, 0.5);
    TextLabel3.BackgroundTransparency = 1;
    TextLabel3.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy);
    TextLabel3.TextScaled = true;
    TextLabel3.TextColor3 = Color3.fromRGB(255, 240, 100);
    TextLabel3.TextStrokeTransparency = 0;
    TextLabel3.TextStrokeColor3 = Color3.new(0, 0, 0);
    TextLabel3.Text = u19:GetHintText();
    TextLabel3.Rotation = -3;
    TextLabel3.ZIndex = 5;
    TextLabel3.Parent = ScreenGui;
    u19.HintLabel = TextLabel3;
    u19.HintBaseSize = TextLabel3.Size;

    if u19.Music then
        local Music = u19.Music;
        local u24 = Music:Clone();
        u24.Name = "LikesMinigameMusic";
        u24.Parent = ScreenGui;
        u24.TimePosition = 0;
        u19.Music = u24;
        u19.MusicBaseVolume = Music.Volume > 0 and Music.Volume or 1;
        u24.Volume = u19.MusicBaseVolume;
        u24:Play();
        u19.Trove:Add(u24);
        u19.Trove:Add(function() -- Line: 231
            -- upvalues: u24 (copy), TweenService (ref)
            if not (u24 and u24.Parent) then
                return;
            end;

            TweenService:Create(u24, TweenInfo.new(0.4), {
                Volume = 0
            }):Play();
            task.delay(0.45, function() -- Line: 240
                -- upvalues: u24 (ref)
                if u24 and u24.Parent then
                    u24:Stop();
                    u24:Destroy();
                end;
            end);
        end);
    end;

    u19.Trove:Add(function() -- Line: 249
        -- upvalues: CurrentCamera (ref), u19 (copy)
        CurrentCamera.FieldOfView = u19.BaseFOV;
    end);
end;

function u11.BounceHint(p25) -- Line: 254
    -- upvalues: u2 (copy), TweenService (copy)
    if not p25.HintLabel then
        return;
    end;

    local HintBaseSize = p25.HintBaseSize;
    p25.HintLabel.Size = UDim2.fromScale(HintBaseSize.X.Scale * 1.3, HintBaseSize.Y.Scale * 1.3);
    p25.HintLabel.Rotation = (u2:NextNumber() - 0.5) * 14;
    p25.HintLabel.TextColor3 = Color3.fromRGB(255, 255, 220);
    TweenService:Create(p25.HintLabel, TweenInfo.new(0.35, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {
        Rotation = -3,
        Size = HintBaseSize,
        TextColor3 = Color3.fromRGB(255, 240, 100)
    }):Play();
end;

function u11.BounceCounter(p26) -- Line: 269
    -- upvalues: TweenService (copy)
    if not p26.LikeLabel then
        return;
    end;

    local LikeBaseSize = p26.LikeBaseSize;
    p26.LikeLabel.Size = UDim2.fromScale(LikeBaseSize.X.Scale * 1.12, LikeBaseSize.Y.Scale * 1.12);
    p26.LikeLabel.TextColor3 = Color3.fromRGB(255, 230, 220);
    TweenService:Create(p26.LikeLabel, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = LikeBaseSize,
        TextColor3 = Color3.fromRGB(255, 90, 130)
    }):Play();
end;

function u11.SpawnClickPopup(p27, u28, p29) -- Line: 282
    -- upvalues: Abbreviate (copy), u2 (copy), TweenService (copy)
    local TextLabel = Instance.new("TextLabel");
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5);
    TextLabel.Position = UDim2.fromOffset(u28.X, u28.Y);
    TextLabel.Size = UDim2.fromScale(0.05, 0.02);
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Heavy);
    TextLabel.TextScaled = true;
    TextLabel.TextColor3 = Color3.fromRGB(255, 215, 80);
    TextLabel.TextStrokeTransparency = 0;
    TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0);
    TextLabel.Text = `+{Abbreviate(p29)} likes`;
    TextLabel.Rotation = (u2:NextNumber() - 0.5) * 28;
    TextLabel.ZIndex = 8;
    TextLabel.Parent = p27.Gui;
    TweenService:Create(TextLabel, TweenInfo.new(0.12, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.fromScale(0.2, 0.08)
    }):Play();
    task.delay(0.12, function() -- Line: 302
        -- upvalues: TextLabel (copy), TweenService (ref), u28 (copy), u2 (ref)
        if not TextLabel.Parent then
            return;
        end;

        TweenService:Create(TextLabel, TweenInfo.new(0.85, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            TextTransparency = 1,
            TextStrokeTransparency = 1,
            Position = UDim2.fromOffset(u28.X + (u2:NextNumber() - 0.5) * 50, u28.Y - 140),
            Rotation = TextLabel.Rotation + (u2:NextNumber() - 0.5) * 24
        }):Play();
    end);
    task.delay(1.05, TextLabel.Destroy, TextLabel);
end;

function u11.SpawnFloatingComment(p30) -- Line: 316
    -- upvalues: u2 (copy), u4 (copy), u3 (copy), TweenService (copy)
    local TextLabel = Instance.new("TextLabel");
    local v31;

    if u2:NextNumber() < 0.72 then
        v31 = u4[u2:NextInteger(1, #u4)];
    else
        v31 = u3[u2:NextInteger(1, #u3)];
    end;

    local v32 = #v31 <= 4;
    TextLabel.Text = v31;
    local v33 = u2:NextNumber(0.05, 0.95);
    TextLabel.Position = UDim2.fromScale(v33, 1.05);
    TextLabel.AnchorPoint = Vector2.new(0.5, 1);
    local v34;

    if v32 then
        v34 = UDim2.fromScale(0.07, 0.07);
    else
        v34 = UDim2.fromScale(0.14, 0.055);
    end;

    TextLabel.Size = v34;
    TextLabel.BackgroundTransparency = 1;
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Bold);
    TextLabel.TextScaled = true;
    local v35;

    if v32 then
        v35 = Color3.fromRGB(255, 80, 130);
    else
        v35 = Color3.new(1, 1, 1);
    end;

    TextLabel.TextColor3 = v35;
    TextLabel.TextStrokeTransparency = 0.3;
    TextLabel.TextStrokeColor3 = Color3.new(0, 0, 0);
    TextLabel.Rotation = (u2:NextNumber() - 0.5) * 18;
    TextLabel.ZIndex = 3;
    TextLabel.Parent = p30.Gui;
    local v36 = v33 + (u2:NextNumber() - 0.5) * 0.12;
    local v37 = u2:NextNumber(0.12, 0.5);
    local v38 = u2:NextNumber(1.4, 2.6);
    TweenService:Create(TextLabel, TweenInfo.new(v38, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        TextTransparency = 1,
        TextStrokeTransparency = 1,
        Position = UDim2.fromScale(v36, v37),
        Rotation = TextLabel.Rotation + (u2:NextNumber() - 0.5) * 28
    }):Play();
    task.delay(v38 + 0.1, TextLabel.Destroy, TextLabel);
end;

function u11.OnClick(u39, p40) -- Line: 352
    -- upvalues: u2 (copy), EffectsHandler (copy)
    if u39.MinigameEnded then
        return;
    end;

    local v41 = 1 + (u2:NextNumber() - 0.5) * 2 * u39.IncrementJitter;
    local v42 = math.floor(u39.Increment * v41);
    local v43 = math.max(1, v42);
    u39.Likes = math.min(u39.Goal, u39.Likes + v43);
    u39.Clicks = u39.Clicks + 1;
    u39:SpawnClickPopup(p40, v43);
    u39:SpawnFloatingComment();

    if u2:NextNumber() < 0.35 then
        task.delay(u2:NextNumber(0.05, 0.15), function() -- Line: 365
            -- upvalues: u39 (copy)
            if not (u39.Destroyed or u39.MinigameEnded) then
                u39:SpawnFloatingComment();
            end;
        end);
    end;

    u39:BounceHint();
    u39:BounceCounter();
    task.spawn(EffectsHandler.CallEffect, "Yuki_Vignette", {
        LifeTime = 0.15,
        Transparency = 0.6,
        TweenIn = { 0.05, Enum.EasingStyle.Sine, Enum.EasingDirection.In },
        TweenOut = { 0.22, Enum.EasingStyle.Sine, Enum.EasingDirection.Out },
        Size = UDim2.fromScale(1.25, 1.25),
        Color = Color3.fromRGB(255, 100, 160)
    });
    u39.Liked:Fire(u39.Likes, u39.Clicks);
end;

function u11.UpdateUI(p44) -- Line: 387
    -- upvalues: Abbreviate (copy)
    local v45 = p44.Duration - (os.clock() - p44.StartTime);
    local v46 = math.max(0, v45);
    p44.TimerLabel.Text = string.format("%d:%02d", math.floor(v46 / 60), (math.floor(v46 % 60)));
    p44.LikeLabel.Text = `❤️ {Abbreviate(p44.Likes)} / {Abbreviate(p44.Goal)}`;

    if v46 < 5 then
        p44.TimerLabel.TextColor3 = Color3.fromRGB(255, 100, 100);

        return;
    end;

    p44.TimerLabel.TextColor3 = Color3.new(1, 1, 1);
end;

function u11.CheckEnd(p47) -- Line: 400
    return os.clock() - p47.StartTime >= p47.Duration and true or p47.Likes >= p47.Goal;
end;

function u11.Run(u48) -- Line: 406
    -- upvalues: UserInputService (copy), u5 (copy), CurrentCamera (copy), u2 (copy), RunService (copy)
    u48:Setup();
    u48.StartTime = os.clock();
    u48.NextPassiveComment = os.clock() + 0.2;
    u48.Trove:Connect(UserInputService.InputBegan, function(p49) -- Line: 412
        -- upvalues: u48 (copy), u5 (ref), CurrentCamera (ref), u2 (ref)
        if u48.MinigameEnded then
            return;
        end;

        local v50;

        if p49.UserInputType == Enum.UserInputType.MouseButton1 or p49.UserInputType == Enum.UserInputType.Touch then
            v50 = Vector2.new(p49.Position.X, p49.Position.Y);
        else
            if p49.UserInputType ~= Enum.UserInputType.Gamepad1 or not u5[p49.KeyCode] then
                return;
            end;

            local ViewportSize = CurrentCamera.ViewportSize;
            v50 = Vector2.new(ViewportSize.X / 2 + (u2:NextNumber() - 0.5) * 220, ViewportSize.Y / 2 + (u2:NextNumber() - 0.5) * 220);
        end;

        u48:OnClick(v50);
    end);
    u48.Trove:Connect(UserInputService.LastInputTypeChanged, function() -- Line: 433
        -- upvalues: u48 (copy)
        if u48.HintLabel then
            u48.HintLabel.Text = u48:GetHintText();
        end;
    end);
    u48.Trove:Connect(RunService.RenderStepped, function(p51) -- Line: 439
        -- upvalues: u48 (copy), u2 (ref), CurrentCamera (ref)
        if u48.MinigameEnded then
            return;
        end;

        u48:UpdateUI();
        u48:UpdateCameraCFrame();

        if os.clock() >= u48.NextPassiveComment then
            u48:SpawnFloatingComment();
            u48.NextPassiveComment = os.clock() + u2:NextNumber(0.18, 0.45);
        end;

        if u48.Music and u48.Music.IsPlaying then
            local v52 = math.clamp((u48.Music.PlaybackLoudness or 0) / 400, 0, 1);
            CurrentCamera.FieldOfView = CurrentCamera.FieldOfView + (u48.BaseFOV + v52 * 10 - CurrentCamera.FieldOfView) * math.min(p51 * 10, 1);
        end;

        if u48:CheckEnd() then
            u48.MinigameEnded = true;
            u48.Ended:Fire({
                Likes = u48.Likes,
                Clicks = u48.Clicks,
                Goal = u48.Goal,
                GoalMet = u48.Likes >= u48.Goal,
                Duration = u48.Duration
            });
        end;
    end);
end;

function u11.Destroy(u53) -- Line: 471
    -- upvalues: CurrentCamera (copy)
    if u53.Destroyed then
        return;
    end;

    u53.Destroyed = true;
    CurrentCamera.FieldOfView = u53.BaseFOV;
    u53.Trove:Destroy();
    task.defer(function() -- Line: 478
        -- upvalues: u53 (copy)
        table.clear(u53);
        table.freeze(u53);
    end);
end;

local function CreateMinigame(u54, p55) -- Line: 484
    -- upvalues: Trove (copy), u11 (copy)
    local u56 = Trove.new();
    u56:AttachToInstance(u54);
    local u57 = u11.new(p55);
    u56:Add(function() -- Line: 490
        -- upvalues: u57 (copy)
        u57:Destroy();
    end);
    u56:Connect(u57.Ended, function(p58) -- Line: 494
        -- upvalues: u54 (copy), u56 (copy)
        u54:FireServer(p58);
        task.delay(0.6, u56.Destroy, u56);
    end);
    task.spawn(u57.Run, u57);
end;

return function(p59, p60) -- Line: 502
    -- upvalues: LocalPlayer (copy), CreateMinigame (copy)
    local Character = LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if Character and Character:FindFirstChild("DanceWaypoint") then
        Character:FindFirstChild("DanceWaypoint"):Destroy();
    end;

    CreateMinigame(p59, p60);
end;
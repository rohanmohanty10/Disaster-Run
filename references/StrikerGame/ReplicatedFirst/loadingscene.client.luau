 

 

local UserInputService = game:GetService("UserInputService");
local TweenService = game:GetService("TweenService");
local ReplicatedFirst = game:GetService("ReplicatedFirst");
local ContentProvider = game:GetService("ContentProvider");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local SoundService = game:GetService("SoundService");
game:GetService("UserInputService");
local RunService = game:GetService("RunService");
ReplicatedFirst:RemoveDefaultLoadingScreen();

repeat
    task.wait();
until game:IsLoaded();

ReplicatedStorage:WaitForChild("Resources");
local Descendants = ReplicatedStorage.Resources:GetDescendants();
local u1 = {};

for _, v in ipairs(Descendants) do
    if v:IsA("Animation") then
        table.insert(u1, v);
    end;
end;

local LocalPlayer = Players.LocalPlayer;
local soundUtil = require(ReplicatedStorage.util.soundUtil);
local u2 = nil;
local u3 = nil;
local u4 = script.loadingui:Clone();
u4.Parent = LocalPlayer.PlayerGui;
local Frame = u4.Frame;
local VideoFrame = Frame.VideoFrame;
local v5 = math.random(2) == 1 and 99159135270424 or 96311774944804;
VideoFrame.Video = `rbxassetid://{tostring(v5)}`;
Frame.VideoFrame:Play();
Frame.VideoFrame.Loaded:Connect(function(p6: string) -- Line: 28
    -- upvalues: u3 (ref), soundUtil (copy), SoundService (copy)
    u3 = soundUtil:play(script["opening theme"], SoundService);
end);
task.spawn(function() -- Line: 29
    -- upvalues: u4 (copy), LocalPlayer (copy), Frame (copy), u3 (ref)
    while task.wait(0.1) and u4.Parent == LocalPlayer.PlayerGui do
        local TimePosition = Frame.VideoFrame.TimePosition;

        if u3 then
            if TimePosition < u3.TimeLength then
                u3:Resume();

                if math.abs(u3.TimePosition - TimePosition) > 0.15 then
                    u3.TimePosition = TimePosition;
                end;
            else
                u3:Pause();
            end;
        end;
    end;
end);
local u7 = SoundService:WaitForChild("football-crowd-3-69245");
local Volume = u7.Volume;
u7.Volume = 0;
local TweenInfo_new_ret = TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, false, 0);
local u8 = TweenService:Create(Frame.football, TweenInfo_new_ret, {
    Rotation = 360
});
u8:Play();
local u9 = nil;
local u10 = nil;

local function skip() -- Line: 65
    -- upvalues: u2 (ref), u8 (copy), u9 (ref), u10 (ref), u7 (copy), Volume (copy), Frame (copy), u3 (ref), TweenService (copy), soundUtil (copy), SoundService (copy), u4 (copy), UserInputService (copy), ContentProvider (copy), u1 (copy)
    if u2 then
        return;
    end;

    u2 = true;

    if u8 then
        u8:Pause();
        u8:Destroy();
    end;

    if u9 then
        u9:Disconnect();
    end;

    if u10 then
        pcall(function(...) -- Line: 74
            -- upvalues: u10 (ref)
            task.cancel(u10);
        end);
    end;

    u7.Volume = Volume;
    Frame.VideoFrame:Pause();

    if u3 then
        TweenService:Create(u3, TweenInfo.new(1), {
            PlaybackSpeed = 0
        }):Play();
    end;

    Frame.flash.BackgroundTransparency = 0;
    TweenService:Create(Frame.flash, TweenInfo.new(0.5), {
        BackgroundTransparency = 1
    }):Play();
    soundUtil:play(script.skip, SoundService);
    soundUtil:play(script.loaded, SoundService);
    task.wait(1);
    TweenService:Create(Frame, TweenInfo.new(1), {
        GroupTransparency = 1
    }):Play();
    task.delay(1, u4.Destroy, u4);

    if u3 then
        task.delay(1, u3.Destroy, u3);
    end;

    if not (UserInputService.TouchEnabled or UserInputService.GamepadEnabled) then
        ContentProvider:PreloadAsync(u1);
    end;
end;

u10 = task.delay(3, function() -- Line: 108
    -- upvalues: Frame (copy), u9 (ref), skip (copy)
    Frame.skiptext.Visible = true;
    u9 = Frame.nodonttouch.MouseButton1Up:Connect(skip);
end);
RunService.Heartbeat:Wait();
task.wait(5);
print("this is stupid, right?");

function dumb_mode()
    -- upvalues: u1 (copy), ContentProvider (copy)
    for _, v in u1 do
        ContentProvider:PreloadAsync({ v });
        task.wait(0.2);
    end;
end;

if not (UserInputService.TouchEnabled or UserInputService.GamepadEnabled) then
    local v11 = #u1;

    for i = 1, v11 do
        if u2 then
            break;
        end;

        if UserInputService.GamepadEnabled then
            coroutine.wrap(dumb_mode)();
            break;
        end;

        local table_remove_ret = table.remove(u1, 1);
        Frame.TextLabel.Text = `{i}/{v11}x - {table_remove_ret.Name}`;
        ContentProvider:PreloadAsync({ table_remove_ret });

        if RunService:IsStudio() then
            warn((`{table_remove_ret.Name} preload!`));
        end;

        Frame.bar.bar.Size = UDim2.fromScale(math.min(i / v11, 1), 1);
        local _ = i;
    end;
end;

task.spawn(skip);
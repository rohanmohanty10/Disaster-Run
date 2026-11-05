  

 

local u1 = game.ReplicatedStorage["Client Assets"];
local LocalPlayer = game.Players.LocalPlayer;
local v2 = require;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v3 = v2(ReplicatedStorage:WaitForChild("ReplicatedModules"):WaitForChild("Petal"));
v3("New");
v3("Util");
local Debris = game:GetService("Debris");
local _ = math.random;
local RunService = game:GetService("RunService");
local SoundGroups = require(ReplicatedStorage.ReplicatedModules:WaitForChild("SoundGroups"));
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);

return function(p4) -- Line: 15
    -- upvalues: u1 (copy), LocalPlayer (copy), Debris (copy), SoundGroups (copy), RunService (copy), EffectsHandler (copy)
    local v5 = u1.Umbra.Mayhem.Message:Clone();
    v5.Enabled = true;
    local Content = v5.Content;
    local Speaker = v5.Speaker;
    v5.Parent = LocalPlayer.PlayerGui;
    Content.TextStrokeColor3 = p4.StrokeColor;
    Speaker.TextStrokeColor3 = p4.StrokeColor;
    Content.TextColor3 = p4.TextColor;
    Speaker.TextColor3 = p4.TextColor;
    Speaker.Text = p4.Speaker .. ":";
    Debris:AddItem(v5, p4.Time + 10);
    local v6 = Instance.fromExisting(script.Sound);
    v6.Parent = workspace.Effects;
    SoundGroups:AssignSoundTag(v6);
    v6:Play();
    local v7 = 1.75;
    local v8 = 1.6;

    for _ = 0, 9 do
        RunService.Heartbeat:Wait();
        v7 = v7 - 0.1;
        v8 = v8 - 0.1;
        Content.Text = "";
        Content.Position = UDim2.new(0, 0, v7, 0);
        Speaker.Position = UDim2.new(0, 0, v8, 0);
    end;

    if p4.TextAppear then
        for i = 1, #p4.Message do
            Content.Text = string.sub(p4.Message, 1, i);
            EffectsHandler.Wait(p4.AppearWait);
        end;
    else
        Content.Text = p4.Message;
    end;

    EffectsHandler.Wait(p4.Time);
    local v9 = 0;

    for _ = 0, 105 do
        RunService.Heartbeat:Wait();
        v9 = v9 + 0.0001;
        v7 = v7 + v9;
        v8 = v8 + v9;
        Content.Rotation = Content.Rotation + v9 * 20;
        Speaker.Rotation = Speaker.Rotation - v9 * 50;
        Content.Position = UDim2.new(0, 0, v7, 0);
        Speaker.Position = UDim2.new(0, 0, v8, 0);
        Content.TextStrokeTransparency = Content.TextStrokeTransparency + 0.01;
        Content.TextTransparency = Content.TextTransparency + 0.01;
        Speaker.TextStrokeTransparency = 0.01;
        Speaker.TextTransparency = Speaker.TextTransparency + 0.01;
        Content.BackgroundTransparency = Content.BackgroundTransparency + 0.0025;
    end;

    v5:Destroy();
    v6:Destroy();
end;
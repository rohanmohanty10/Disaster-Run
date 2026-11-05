  

 

local PlayerGui = game.Players.LocalPlayer.PlayerGui;
local Output = game.ReplicatedStorage.Remotes.Output;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
game:GetService("Debris");
game:GetService("CollectionService");
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);

local function createWhiteScreen() -- Line: 13
    -- upvalues: PlayerGui (copy)
    local ScreenGui = Instance.new("ScreenGui", PlayerGui);
    ScreenGui.Name = "WhiteScreen";
    ScreenGui.IgnoreGuiInset = true;
    local Frame = Instance.new("Frame", ScreenGui);
    Frame.BackgroundColor3 = Color3.new(1, 1, 1);
    Frame.Size = UDim2.new(1, 0, 1, 0);
    Frame.BackgroundTransparency = 1;
    Frame.ZIndex = 10000;

    return ScreenGui, Frame;
end;

local function audio(p1, p2, p3, p4, p5) -- Line: 25
    local Sound = Instance.new("Sound", p5);
    Sound.SoundId = "rbxassetid://" .. p1;
    Sound.Volume = p2 or 0.5;
    Sound.TimePosition = p3 or 0;
    Sound.Looped = p4 or false;
    Sound.RollOffMaxDistance = 60;
    Sound.RollOffMinDistance = 5;
    Sound.RollOffMode = Enum.RollOffMode.InverseTapered;

    return Sound;
end;

return function() -- Line: 37
    -- upvalues: createWhiteScreen (copy), Output (copy), TweenService (copy), EffectsHandler (copy), ReplicatedStorage (copy)
    local v6 = Random.new();
    local u7, v8 = createWhiteScreen();
    local u9 = {};
    local u10 = nil;
    u10 = Output.OnClientEvent:Connect(function(p11, p12, p13) -- Line: 42
        -- upvalues: u9 (copy), u7 (copy), u10 (ref)
        if p11 == "FX" and (p12 == "CameraShake" and p13 == "Explosion2") then
            for i, _ in pairs(u9) do
                i:Destroy();
            end;

            u7:Destroy();
            u10:Disconnect();
            u10 = nil;
        end;
    end);
    v8.BackgroundTransparency = 1;
    local Sound = Instance.new("Sound", workspace.Effects);
    Sound.SoundId = "rbxassetid://9062183597";
    Sound.Volume = 1;
    Sound.TimePosition = 0;
    Sound.Looped = false;
    Sound.RollOffMaxDistance = 60;
    Sound.RollOffMinDistance = 5;
    Sound.RollOffMode = Enum.RollOffMode.InverseTapered;
    Sound:Play();
    Sound.Ended:Connect(function() -- Line: 55
        -- upvalues: Sound (copy)
        Sound:Destroy();
    end);
    wait(2);
    TweenService:Create(v8, TweenInfo.new(3, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {
        BackgroundTransparency = 0
    }):Play();
    wait(2);
    task.spawn(EffectsHandler.CallEffect, "CameraShake", "Vibration");

    for _ = 0, 8 do
        local v14 = ReplicatedStorage["Client Assets"].Gojo.DomainExpansionCutscene.ScreenCrack:Clone();
        v14.Parent = workspace.Effects;
        TweenService:Create(v14, TweenInfo.new(0.3), {
            Transparency = 0.6
        }):Play();
        local v15 = CFrame.new(v6:NextNumber(-3, 3), v6:NextNumber(-3, 3), v6:NextNumber(-1, -3));
        local Angles = CFrame.Angles;
        local v16 = v6:NextNumber(0, 360);
        local v17 = math.rad(v16);
        local v18 = v6:NextNumber(0, 360);
        local v19 = math.rad(v18);
        local v20 = v6:NextNumber(0, 360);
        u9[v14] = v15 * Angles(v17, v19, (math.rad(v20)));
        local Part = Instance.new("Part");
        Part.Transparency = 0.7;
        Part.Material = Enum.Material.Glass;
        Part.Size = Vector3.new(5, 3, 3);
        Part.Parent = workspace.Effects;
        local v21 = CFrame.new(0, 0, -4);
        local Angles2 = CFrame.Angles;
        local v22 = v6:NextNumber(-360, 360);
        local v23 = math.rad(v22);
        local v24 = v6:NextNumber(-360, 360);
        local v25 = math.rad(v24);
        local v26 = v6:NextNumber(-360, 360);
        u9[Part] = v21 * Angles2(v23, v25, (math.rad(v26)));
    end;

    local u28 = game:GetService("RunService").RenderStepped:Connect(function(p27) -- Line: 75
        -- upvalues: u9 (copy)
        for i, v in pairs(u9) do
            i.CFrame = workspace.CurrentCamera.CFrame * v;
        end;
    end);
    task.delay(3, function() -- Line: 80
        -- upvalues: u7 (copy), u10 (ref), u9 (copy), u28 (copy)
        if u7 ~= nil then
            u7:Destroy();
        end;

        if u10 ~= nil then
            u10:Disconnect();
        end;

        for i, _ in pairs(u9) do
            i:Destroy();
        end;

        u28:Disconnect();
    end);
end;
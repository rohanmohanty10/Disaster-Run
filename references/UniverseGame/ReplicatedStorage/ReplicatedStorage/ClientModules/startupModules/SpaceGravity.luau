  

 

local UserInputService = game:GetService("UserInputService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local Players = game:GetService("Players");
local SoundService = game:GetService("SoundService");
local LocalPlayer = Players.LocalPlayer;
local u1 = ReplicatedStorage["Client Assets"];
local v2 = {};
local u3 = {};
local u4 = { "rbxassetid://7146792142" };
local CurrentCamera = workspace.CurrentCamera;
local u5;

if CurrentCamera:FindFirstChild("Skybox") then
    u5 = nil;
else
    u5 = u1["Planet Shaper"].Skybox:Clone();
    u5.Parent = CurrentCamera;
end;

coroutine.wrap(function() -- Line: 43
    -- upvalues: LocalPlayer (copy), u5 (ref), CurrentCamera (copy), SoundService (copy), u4 (copy)
    while true do
        repeat
            wait();
        until LocalPlayer.Character and (LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and not game.CollectionService:HasTag(LocalPlayer.Character, "Piloting"));

        workspace.Gravity = math.clamp(196.2 - (LocalPlayer.Character.HumanoidRootPart.CFrame.Position.Y - 0) / 5, 0, 196.2);
        u5.CFrame = CurrentCamera.CFrame;

        if workspace.Gravity <= 0 then
            u5.Particle1.Enabled = true;
            u5.Particle2.Enabled = true;
            SoundService.Music.Volume = 0;
            LocalPlayer.Character.HumanoidRootPart.Velocity = LocalPlayer.Character.HumanoidRootPart.Velocity:Lerp(Vector3.new(), wait() / 4);

            if not SoundService:FindFirstChild("PlayingMusic") then
                coroutine.wrap(function() -- Line: 64
                    -- upvalues: u4 (ref), LocalPlayer (ref), SoundService (ref)
                    local Sound = Instance.new("Sound");
                    Sound.SoundId = u4[math.random(1, #u4)];
                    Sound.Volume = LocalPlayer.Settings.MusicVolume.Value / 100 * LocalPlayer.Settings.MasterVolume.Value / 100;
                    Sound.Name = "PlayingMusic";
                    Sound.Parent = SoundService;
                    Sound.Ended:Connect(function() -- Line: 72
                        -- upvalues: Sound (copy)
                        Sound:Destroy();
                    end);
                    Sound:Play();
                end)();
            end;
        elseif workspace.Gravity < 100 then
            u5.Transparency = workspace.Gravity / 100;
        else
            u5.Particle1.Enabled = false;
            u5.Particle2.Enabled = false;

            if SoundService:FindFirstChild("PlayingMusic") then
                SoundService.PlayingMusic:Destroy();
            end;

            SoundService.Music.Volume = LocalPlayer.Settings.MusicVolume.Value / 100 * LocalPlayer.Settings.MasterVolume.Value / 100;
        end;
    end;
end)();
workspace.Changed:Connect(function(p6) -- Line: 96
    -- upvalues: u1 (copy)
    if p6 == "Gravity" then
        if workspace.Gravity <= 0 then
            if game.Lighting:FindFirstChild("DefaultSky") then
                game.Lighting.DefaultSky:Destroy();
                u1.PlanetSky:Clone().Parent = game.Lighting;
                game.Lighting.DefaultSunRays.Intensity = 0.07;
            end;
        elseif game.Lighting:FindFirstChild("PlanetSky") then
            game.Lighting.PlanetSky:Destroy();
            u1.DefaultSky:Clone().Parent = game.Lighting;
            game.Lighting.DefaultSunRays.Intensity = 0.25;
        end;
    end;
end);
UserInputService.InputBegan:Connect(function(u7, p8) -- Line: 119
    -- upvalues: LocalPlayer (copy), u3 (copy), u5 (ref), CurrentCamera (copy)
    if p8 then
        return;
    end;

    if not (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) then
        return;
    end;

    u3[u7.KeyCode] = true;
    coroutine.wrap(function() -- Line: 123
        -- upvalues: u5 (ref), CurrentCamera (ref), u3 (ref), LocalPlayer (ref), u7 (copy)
        while true do
            wait();

            if workspace.Gravity <= 0 then
                u5.CFrame = CurrentCamera.CFrame;
                local HumanoidRootPart = LocalPlayer.Character.HumanoidRootPart;
                local _ = LocalPlayer.Data.Ability.Value == 658;
                HumanoidRootPart.Velocity = HumanoidRootPart.Velocity + 5 * (CurrentCamera.CFrame.LookVector * ((u3[Enum.KeyCode.W] and 1 or 0) - (u3[Enum.KeyCode.S] and 1 or 0)) + CurrentCamera.CFrame.RightVector * ((u3[Enum.KeyCode.D] and 1 or 0) - (u3[Enum.KeyCode.A] and 1 or 0)) + CurrentCamera.CFrame.UpVector * ((u3[Enum.KeyCode.Space] and 1 or 0) - (u3[Enum.KeyCode.LeftShift] and 1 or 0)));
                local HumanoidRootPart2 = LocalPlayer.Character.HumanoidRootPart;
                local v9 = math.clamp(LocalPlayer.Character.HumanoidRootPart.Velocity.X, -40, 40);
                local v10 = math.clamp(LocalPlayer.Character.HumanoidRootPart.Velocity.Y, -40, 40);
                local v11 = math.clamp(LocalPlayer.Character.HumanoidRootPart.Velocity.Z, -40, 40);
                HumanoidRootPart2.Velocity = Vector3.new(v9, v10, v11);
            end;

            if u3[u7.KeyCode] == false or not LocalPlayer.Character then
                return;
            end;
        end;
    end)();
end);
UserInputService.InputEnded:Connect(function(u12, p13) -- Line: 146
    -- upvalues: LocalPlayer (copy), u5 (ref), CurrentCamera (copy), u3 (copy)
    if p13 then
        return;
    end;

    if not (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")) then
        return;
    end;

    coroutine.wrap(function() -- Line: 150
        -- upvalues: u5 (ref), CurrentCamera (ref), LocalPlayer (ref), u3 (ref), u12 (copy)
        while true do
            wait();

            if workspace.Gravity <= 0 then
                u5.CFrame = CurrentCamera.CFrame;
                LocalPlayer.Character.HumanoidRootPart.Velocity = LocalPlayer.Character.HumanoidRootPart.Velocity:Lerp(Vector3.new(), wait() / 4);
            end;

            if not LocalPlayer.Character or (not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") or LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Velocity.X < 0.009999999776482582 and (LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Velocity.Y < 0.009999999776482582 and LocalPlayer.Character.HumanoidRootPart.Velocity.Z < 0.009999999776482582)) or u3[u12.KeyCode] == true then
                return;
            end;
        end;
    end)();
    u3[u12.KeyCode] = false;
end);

return v2;
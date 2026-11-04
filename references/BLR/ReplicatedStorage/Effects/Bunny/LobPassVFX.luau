  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
local Players = game:GetService("Players");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.CameraController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local _ = require(ReplicatedStorage.Shared.AbilityUtils).createAfterImage;
require(ReplicatedStorage.AbilityBalancing);
local LocalPlayer = Players.LocalPlayer;

return function(p1) -- Line: 19
    -- upvalues: SpectatorController (copy), LocalPlayer (copy), TweenService (copy), Lighting (copy), SoundManager (copy), VfxManager (copy), Debris (copy)
    local Char = p1.Char;

    if not Char then
        return;
    end;

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local function ScreenEffect() -- Line: 32
        -- upvalues: Char (copy), LocalPlayer (ref), TweenService (ref), Lighting (ref)
        if (Char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
            TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.1), {
                TintColor = Color3.fromRGB(255, 235, 83)
            }):Play();
            task.delay(0.1, function() -- Line: 36
                -- upvalues: TweenService (ref), Lighting (ref)
                TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.6), {
                    TintColor = Color3.new(1, 1, 1)
                }):Play();
            end);
        end;
    end;

    SoundManager.SpawnSound("BunnyKick", 0.9, Char.HumanoidRootPart, 130, false);
    local v2 = script.StartupEmit:Clone();
    v2.CFrame = HumanoidRootPart.CFrame * CFrame.new(-1.14444065, -2.64949751, 0.0819473267, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    v2.Parent = workspace.Debris;
    VfxManager.Emit(v2);
    Debris:AddItem(v2, 2);
    task.wait(0.5);
    ScreenEffect();
    local v3 = script.ShootEmit:Clone();
    v3.CFrame = HumanoidRootPart.CFrame * CFrame.new(-1.14444065, -2.64949751, -3.25805283, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    v3.Parent = HumanoidRootPart;
    VfxManager.Emit(v3);
    Debris:AddItem(v3, 2);
    local v4 = script.Distal:Clone();
    v4.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.644471645, -0.149497032, -1.95805168, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    v4.Parent = HumanoidRootPart;
    VfxManager.Emit(v4);
    Debris:AddItem(v4, 2);
end;
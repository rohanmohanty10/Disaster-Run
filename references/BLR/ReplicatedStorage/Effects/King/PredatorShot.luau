  

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
local CameraController = require(ReplicatedStorage.Controllers.CameraController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local LocalPlayer = Players.LocalPlayer;

return function(p1) -- Line: 17
    -- upvalues: SpectatorController (copy), Debris (copy), LocalPlayer (copy), TweenService (copy), Lighting (copy), CameraController (copy), SoundManager (copy), VfxManager (copy)
    local Char = p1.Char;

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    for _, child in pairs(Char:GetChildren()) do
        if child:IsA("BasePart") and child.Transparency == 0 then
            local v2 = child;

            for _, child2 in pairs(script.Aura:GetChildren()) do
                local v3 = child2:Clone();
                v3.Parent = v2;
                Debris:AddItem(v3, 0.7);
            end;
        end;
    end;

    if (Char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
        TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.7), {
            TintColor = Color3.new(1, 0.411765, 0.411765)
        }):Play();
        task.delay(0.7, function() -- Line: 35
            -- upvalues: CameraController (ref), TweenService (ref), Lighting (ref)
            CameraController:Shake("Hit");
            TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.1), {
                TintColor = Color3.new(1, 1, 1)
            }):Play();
        end);
    end;

    task.wait(0.7);
    SoundManager.SpawnSound("Predator Shot", 0.7, Char.Torso, 150);
    local v4 = script.Shoot:Clone();
    v4.CFrame = Char.HumanoidRootPart.CFrame;
    v4.Parent = workspace.Debris;
    local v5 = script.KingFloor:Clone();
    v5.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(0, -2, 0);
    v5.Parent = workspace.Debris;
    VfxManager.Emit(v5);
    VfxManager.Emit(v4);
    task.wait(2);
    v4:Destroy();
    v5:Destroy();
end;
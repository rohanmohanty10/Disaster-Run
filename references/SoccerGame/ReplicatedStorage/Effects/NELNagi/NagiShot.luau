  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
game:GetService("Debris");
local Lighting = game:GetService("Lighting");
local LocalPlayer = game:GetService("Players").LocalPlayer;
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local CameraController = require(ReplicatedStorage.Controllers.CameraController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 17
    -- upvalues: SpectatorController (copy), LocalPlayer (copy), CameraController (copy), TweenService (copy), Lighting (copy), VfxManager (copy)
    local Char = p1.Char;

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    if (Char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
        CameraController:Shake("Hit");
        TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.1), {
            TintColor = Color3.new(0.403922, 0.611765, 1)
        }):Play();
        task.delay(0.1, function() -- Line: 25
            -- upvalues: TweenService (ref), Lighting (ref)
            TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.6), {
                TintColor = Color3.new(1, 1, 1)
            }):Play();
        end);
    end;

    local v2 = script.Shot:Clone();
    v2.CFrame = Char.Torso.CFrame;
    v2.Parent = workspace.Debris;
    VfxManager.Emit(v2);
    task.wait(2);
    v2:Destroy();
end;
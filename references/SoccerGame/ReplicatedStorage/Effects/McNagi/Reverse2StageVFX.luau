  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
game:GetService("Debris");
local Lighting = game:GetService("Lighting");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local CameraController = require(ReplicatedStorage.Controllers.CameraController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 17
    -- upvalues: SpectatorController (copy), SoundManager (copy), Essentials (copy), VfxManager (copy), LocalPlayer (copy), CameraController (copy), TweenService (copy), Lighting (copy)
    local Char = p1.Char;

    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    SoundManager.SpawnSound("reverse 2 stage", 0.7, Char.HumanoidRootPart, 130, false);
    local v2 = script.Speed:Clone();
    v2:PivotTo(Char.HumanoidRootPart.CFrame);
    v2.Parent = workspace.Debris;
    Essentials:Weld(v2, Char.HumanoidRootPart);
    VfxManager.Enable(v2, true);

    if (Char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
        CameraController:Shake("Hit");
        TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.1), {
            TintColor = Color3.new(0.403922, 0.611765, 1)
        }):Play();
        task.delay(0.1, function() -- Line: 35
            -- upvalues: TweenService (ref), Lighting (ref)
            TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.6), {
                TintColor = Color3.new(1, 1, 1)
            }):Play();
        end);
    end;

    local CFrame2 = Char.HumanoidRootPart.CFrame;
    local v3 = script.Dash:Clone();
    v3.CFrame = CFrame2 * CFrame.new(0, 1, -10);
    v3.Parent = workspace.Debris;
    VfxManager.Emit(v3);
    task.wait(0.9);
    VfxManager.Enable(v2, false);
    task.wait(1);
    v3:Destroy();
    v2:Destroy();
end;
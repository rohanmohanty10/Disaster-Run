  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("ContentProvider");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
game:GetService("Debris");
local Players = game:GetService("Players");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
require(ReplicatedStorage2.Shared.MoonCutsceneStreamer);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local CameraController = require(ReplicatedStorage.Controllers.CameraController);
require(ReplicatedStorage.Shared.Moonlite);

return function(p1) -- Line: 21
    -- upvalues: SpectatorController (copy), VfxManager (copy), Players (copy), CameraController (copy), TweenService (copy), Lighting (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;

    if not Char then
        return;
    end;

    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    if not Char:FindFirstChild("Humanoid") then
        return;
    end;

    task.delay(0.05, function() -- Line: 36
        -- upvalues: HumanoidRootPart (copy), VfxManager (ref)
        local v2 = script.reochememit2:Clone();
        v2.CFrame = HumanoidRootPart.CFrame * CFrame.new(1.229, 2, -1.564);
        v2.Parent = workspace.Debris;
        VfxManager.Emit(v2);
        task.wait(2);
        v2:Destroy();
    end);
    task.delay(0.383, function() -- Line: 48
        -- upvalues: HumanoidRootPart (copy), VfxManager (ref)
        local v3 = script.reochememit05:Clone();
        v3.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.72, -3, -0.5);
        v3.Parent = workspace.Debris;
        VfxManager.Emit(v3);
        task.wait(2);
        v3:Destroy();
    end);
    task.delay(0.383, function() -- Line: 60
        -- upvalues: HumanoidRootPart (copy), VfxManager (ref), Char (copy), Players (ref), CameraController (ref), TweenService (ref), Lighting (ref)
        local v4 = script.reochememit1:Clone();
        v4.CFrame = HumanoidRootPart.CFrame * CFrame.new(-1.8, 0.525, -3);
        v4.Parent = workspace.Debris;
        VfxManager.Emit(v4);

        if game.Players.LocalPlayer.Team ~= game.Teams.Visitor and (Char.HumanoidRootPart.Position - Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
            CameraController:Shake("Hit");
            TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.1), {
                TintColor = Color3.new(0.403922, 0.611765, 1)
            }):Play();
            task.delay(0.1, function() -- Line: 72
                -- upvalues: TweenService (ref), Lighting (ref)
                TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.6), {
                    TintColor = Color3.new(1, 1, 1)
                }):Play();
            end);
        end;

        task.wait(2);
        v4:Destroy();
    end);
end;
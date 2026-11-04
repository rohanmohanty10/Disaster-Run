  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
local Players = game:GetService("Players");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.CameraController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local _ = require(ReplicatedStorage.Shared.AbilityUtils).createAfterImage;
local LocalPlayer = Players.LocalPlayer;

return function(p1) -- Line: 18
    -- upvalues: SpectatorController (copy), VfxManager (copy), Debris (copy), LocalPlayer (copy), TweenService (copy), Lighting (copy)
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

    local v2 = script.New.Jump:Clone();
    v2.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 4, 0);
    v2.Parent = workspace.Debris;
    VfxManager.Emit(v2);
    Debris:AddItem(v2, 2);

    if LocalPlayer.Character == LocalPlayer then
        TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.1), {
            TintColor = Color3.new(0.584314, 0.419608, 1)
        }):Play();
        task.delay(0.2, function() -- Line: 41
            -- upvalues: TweenService (ref), Lighting (ref)
            TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.8), {
                TintColor = Color3.new(1, 1, 1)
            }):Play();
        end);
    end;

    task.wait(0.5);
    local v3 = script.New.Header:Clone();
    v3:PivotTo(HumanoidRootPart.CFrame);
    v3.Parent = workspace.Debris;
    VfxManager.Emit(v3);
    Debris:AddItem(v3, 2);
end;
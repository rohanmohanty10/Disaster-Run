  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.CameraController);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 12
    -- upvalues: SpectatorController (copy), SoundManager (copy), VfxManager (copy), Debris (copy), TweenService (copy), Lighting (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Char = p1.Char;
    SoundManager.SpawnSound("Kablamo", 0.7, Char.HumanoidRootPart, 130, false);
    local LocalPlayer = game.Players.LocalPlayer;
    task.wait(0.23);
    local v2 = script.kablamoemit1:Clone();
    v2.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(0.100453377, -2.68983674, -0.285772324, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    v2.Parent = workspace.Debris;
    VfxManager.Emit(v2);
    Debris:AddItem(v2, 12);
    task.wait(0.44000000000000006);
    local v3 = script.kablamoemit2:Clone();
    v3.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(2.7154274, 0.440598726, 0.707945824, 1, 0, 0, 0, 0, 1, 0, -1, 0);
    v3.Parent = workspace.Debris;
    VfxManager.Emit(v3);
    Debris:AddItem(v3, 12);

    if (Char.HumanoidRootPart.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 100 then
        TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.1), {
            TintColor = Color3.new(0.823529, 0.113725, 1)
        }):Play();
        task.delay(0.1, function() -- Line: 39
            -- upvalues: TweenService (ref), Lighting (ref)
            TweenService:Create(Lighting.ColorCorrection, TweenInfo.new(0.4), {
                TintColor = Color3.new(1, 1, 1)
            }):Play();
        end);
    end;

    task.wait(0.18);
    local v4 = script.kablamoemit3:Clone();
    v4.CFrame = Char.HumanoidRootPart.CFrame * CFrame.new(0.100453377, -2.68983674, -1.79457808, 1, 0, 0, 0, 1, 0, 0, 0, 1);
    v4.Parent = workspace.Debris;
    VfxManager.Emit(v4);
    Debris:AddItem(v4, 12);
end;
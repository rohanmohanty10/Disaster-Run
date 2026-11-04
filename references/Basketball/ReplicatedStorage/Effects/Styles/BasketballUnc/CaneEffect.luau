 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.Essentials);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local Trove = require(ReplicatedStorage.Shared.Utility.Trove);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");
Trove.new();

return function(p1, p2) -- Line: 18
    -- upvalues: Players (copy), SfxManager (copy), VfxManager (copy), LocalPlayer (copy), CameraShaker (copy), Debris (copy), Effects (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local CameraController = p1.CameraController;
    local Character = p2.Character;
    local v4 = Players:FindFirstChild(Character.Name);
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local Cane = Character:FindFirstChild("Cane");

    if p2.Task == "Start" then
        if Cane then
            SfxManager:playSound({
                Sound = "BBZ Basketball Unc Cane Effect Start",
                Parent = HumanoidRootPart
            });
            VfxManager.Emit(Cane.Emit);
            task.delay(0.05128205128205128 - v3, function() -- Line: 36
                -- upvalues: VfxManager (ref), Cane (copy)
                VfxManager.Enable(Cane.Enable, true);
            end);
            task.delay(0.23076923076923075 - v3, function() -- Line: 40
                -- upvalues: VfxManager (ref), Cane (copy)
                VfxManager.Enable(Cane.Enable, false);
            end);
            task.delay(0.3589743589743589, function() -- Line: 44
                -- upvalues: LocalPlayer (ref), HumanoidRootPart (copy), CameraController (copy), CameraShaker (ref), SfxManager (ref), Debris (ref), VfxManager (ref)
                if LocalPlayer.Character and (LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (LocalPlayer.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude <= 30) then
                    CameraController.CamShake:Shake(CameraShaker.Presets.Dunk);
                end;

                SfxManager:playSound({
                    Sound = "BBZ Basketball Unc Cane Effect Ground",
                    Parent = HumanoidRootPart
                });
                local v5 = script.Ground:Clone();
                v5.Parent = Debris;
                v5.CFrame = HumanoidRootPart.CFrame + Vector3.new(0, -2.865, 0);
                VfxManager.Emit(v5);
                VfxManager.DestroyEffect(v5, 2);
            end);
        end;
    elseif p2.Task == "Stun" then
        Effects:SubtitleV2({
            { v4, "Sit down, youngster!", 1 }
        });
        SfxManager:playSound({
            Sound = "BBZ Basketball Unc Cane Effect Voice",
            Parent = HumanoidRootPart
        });
    end;
end;
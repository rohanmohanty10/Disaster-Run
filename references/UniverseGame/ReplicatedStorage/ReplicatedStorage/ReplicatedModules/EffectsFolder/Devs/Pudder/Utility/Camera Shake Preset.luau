  

 

game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local CameraShaker = require(ReplicatedStorage.ClientModules.CameraShaker);
local LocalPlayer = game.Players.LocalPlayer;
local CurrentCamera = workspace.CurrentCamera;
local u2 = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(p1) -- Line: 9
    -- upvalues: CurrentCamera (copy)
    CurrentCamera.CFrame = CurrentCamera.CFrame * p1;
end);
u2:Start();

return function(p3) -- Line: 15
    -- upvalues: LocalPlayer (copy), u2 (copy), CameraShaker (copy)
    if not LocalPlayer.Settings.CameraShake.Value then
        return;
    end;

    u2:Shake(CameraShaker.Presets[p3]);
end;
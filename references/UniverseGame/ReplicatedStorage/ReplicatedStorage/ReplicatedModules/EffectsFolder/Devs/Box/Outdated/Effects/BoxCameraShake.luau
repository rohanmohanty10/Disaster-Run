  

 

local LocalPlayer = game.Players.LocalPlayer;
local CameraShaker = require(game:GetService("ReplicatedStorage").ClientModules:WaitForChild("CameraShaker"));
local CurrentCamera = workspace.CurrentCamera;
local u2 = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(p1) -- Line: 5
    -- upvalues: CurrentCamera (copy)
    CurrentCamera.CFrame = CurrentCamera.CFrame * p1;
end);
u2:Start();

return function(p3, p4) -- Line: 11
    -- upvalues: LocalPlayer (copy), u2 (copy), CameraShaker (copy)
    local v5 = p4 or p3;
    local v6 = typeof(v5) ~= "string" and "Vibration" or v5;

    if LocalPlayer.Settings.CameraShake.Value == false then
        return;
    end;

    u2:Shake(CameraShaker.Presets[v6]);
end;
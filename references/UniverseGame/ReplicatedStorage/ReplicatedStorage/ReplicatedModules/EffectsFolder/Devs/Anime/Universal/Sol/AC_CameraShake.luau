  

 

local Players = game:GetService("Players");
local ClientModules = game:GetService("ReplicatedStorage"):FindFirstChild("ClientModules");
local CameraShaker = require(ClientModules.CameraShaker);
local LocalPlayer = Players.LocalPlayer;
local CurrentCamera = workspace.CurrentCamera;
local u3 = CameraShaker.new(Enum.RenderPriority.Camera.Value, function(p1) -- Line: 10
    -- upvalues: CurrentCamera (copy)
    local v2 = CurrentCamera;
    v2.CFrame = v2.CFrame * p1;
end);
u3:Start();

return function(p4, p5, p6) -- Line: 15
    -- upvalues: LocalPlayer (copy), u3 (copy), CameraShaker (copy)
    local v7 = LocalPlayer and (LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait());
    local v8;

    if v7 then
        v8 = v7:FindFirstChildOfClass("Humanoid");
    else
        v8 = v7;
    end;

    local v9;

    if v8 then
        v9 = v8.RootPart;
    else
        v9 = v8;
    end;

    if v7 and (v8 and v9) then
        if not LocalPlayer.Settings.CameraShake.Value or typeof(p5) == "number" and (typeof(p6) == "Vector3" and p5 <= (v9.Position - p6).Magnitude) then
            return;
        end;

        u3:Shake(CameraShaker.Presets[(not p4 or (typeof(p4) ~= "string" or not p4)) and "Explosion" or p4]);
    end;
end;
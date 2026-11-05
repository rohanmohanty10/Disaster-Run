  

 

local LocalPlayer = game.Players.LocalPlayer;
local _ = Random.new;
local random = math.random;
local _ = math.abs;
local _ = math.cos;
local _ = math.sin;
local _ = math.min;
local _ = math.max;
local _ = math.floor;
local _ = math.pow;
local _ = math.ceil;
local rad = math.rad;
local _ = math.clamp;
local wait = task.wait;
local CurrentCamera = workspace.CurrentCamera;
local new = Vector3.new;
local new2 = CFrame.new;

return function(u1) -- Line: 10
    -- upvalues: LocalPlayer (copy), wait (copy), random (copy), rad (copy), new (copy), CurrentCamera (copy), new2 (copy)
    if LocalPlayer.Character and (LocalPlayer.Character:IsDescendantOf(workspace) and LocalPlayer.Settings.CameraShake.Value == true) then
        local u2 = LocalPlayer.Character:FindFirstChildOfClass("Humanoid");

        if not u2 then
            return;
        end;

        if u1.Origin and (u1.Distance or (1 / 0)) <= (u2.RootPart.Position - u1.Origin).Magnitude then
            return;
        end;

        task.spawn(function() -- Line: 16
            -- upvalues: u1 (copy), wait (ref), u2 (copy), random (ref), rad (ref), new (ref), CurrentCamera (ref), new2 (ref)
            local v3 = 1 * u1.Intensity;
            local v4 = 0.01 * u1.Intensity;

            for _ = 0, u1.Length, 0.1 do
                wait();
                v3 = v3 - 0.05 * u1.Intensity / u1.Length;
                v4 = v4 - 0.0005 * u1.Intensity / u1.Length;
                u2.CameraOffset = new(rad((random(-v3, v3))), rad((random(-v3, v3))), (rad((random(-v3, v3)))));
                local v5 = CurrentCamera;
                v5.CFrame = v5.CFrame * (new2(rad((random(-v3, v3))), rad((random(-v3, v3))), (rad((random(-v3, v3))))) * CFrame.fromEulerAnglesXYZ(rad((random(-v3, v3))) * v4, rad((random(-v3, v3))) * v4, rad((random(-v3, v3))) * v4));

                if not u2 then
                    break;
                end;
            end;

            if u2 then
                u2.CameraOffset = Vector3.new(0, 0, 0);
            end;
        end);
    end;
end;
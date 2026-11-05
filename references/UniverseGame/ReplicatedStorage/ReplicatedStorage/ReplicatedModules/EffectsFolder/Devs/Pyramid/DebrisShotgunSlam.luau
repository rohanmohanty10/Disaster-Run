  

 

local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
local u1 = EffectsHandler.GetEffect("debrisSlamFunction");
local u2 = EffectsHandler.GetEffect("camShake");
local CameraShaker = require(game.ReplicatedStorage.ClientModules:WaitForChild("CameraShaker"));
local u3 = EffectsHandler.GetEffect("RayCastOnMap");
local LocalPlayer = game.Players.LocalPlayer;

return function(p4, p5) -- Line: 7
    -- upvalues: u1 (copy), LocalPlayer (copy), u2 (copy), CameraShaker (copy), u3 (copy)
    coroutine.wrap(u1)(p4, p5, true);

    if (LocalPlayer.Character.PrimaryPart.Position - (p5 or p4.PrimaryPart.CFrame).p).Magnitude < 15 then
        if LocalPlayer.Settings.CameraShake.Value == false then
            return;
        end;

        u2:Shake(CameraShaker.Presets.Explosion2);
    end;

    local v6 = game.ReplicatedStorage["Client Assets"]["C-Moon"].groundSlam:Clone();
    v6.Parent = game.Workspace.Effects;

    if not p5 then
        local v7 = p4.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5);
        local Angles = CFrame.Angles;
        local v8 = math.random(-360, 360);
        p5 = v7 * Angles(0, math.rad(v8), 0);
    end;

    v6.CFrame = p5;
    local v9 = u3(v6.Position, Vector3.new(0, -10, 0), true);

    if not v9 then
        v6:Destroy();

        return;
    end;

    local v10 = v6.CFrame - v6.Position;
    v6.CFrame = CFrame.new(v9.Position + Vector3.new(0, 3, 0)) * v10;
    local v11 = 0;

    for _, descendant in ipairs(v6:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            descendant:Emit(4);

            if v11 < descendant.Lifetime.Max then
                v11 = descendant.Lifetime.Max or v11;
            end;
        end;
    end;

    task.delay(v11 + 0.2, v6.Destroy, v6);
end;
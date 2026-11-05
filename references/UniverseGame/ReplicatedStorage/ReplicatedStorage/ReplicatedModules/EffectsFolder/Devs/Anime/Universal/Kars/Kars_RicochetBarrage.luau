  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
require(PathShortcuts.KnitPath.Knit);
game:GetService("RunService");
local Players = game:GetService("Players");
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local LocalPlayer = Players.LocalPlayer;

return function(p1) -- Line: 13
    -- upvalues: Players (copy), LocalPlayer (copy), EffectsHandler (copy)
    local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v2 = Players:GetPlayerFromCharacter(p1);

    while p1.Parent and p1:GetAttribute("RicochetBarrage") do
        if v2 == LocalPlayer then
            task.spawn(EffectsHandler.CallEffect, "Camera Shake Preset", "Ride");
        end;

        for _ = 1, math.random(2, 3) do
            task.delay(math.random(1, 10) / 100, function() -- Line: 28
                -- upvalues: EffectsHandler (ref), HumanoidRootPart (copy)
                local v3 = math.random(95, 110) / 100;
                local spawn = task.spawn;
                local CallEffect = EffectsHandler.CallEffect;
                local v4 = {
                    Time = 0.2,
                    SurfaceDirection = "Bottom"
                };
                local v5 = HumanoidRootPart.CFrame * CFrame.new(0, 0, -1);
                local Angles = CFrame.Angles;
                local v6 = math.random(-35, 35);
                local v7 = math.rad(v6);
                local v8 = math.random(-120, 120);
                v4.Origin = v5 * Angles(v7, 0, (math.rad(v8)));
                v4.EndCFrame = CFrame.Angles(0, -1.3089969389957472, 0);
                v4.Size = Vector3.new(1, 0, 1) * (math.random(45, 62) / 10) + Vector3.new(0, 7.2, 0);
                v4.Color = Color3.fromRGB(680 * v3, 340 * v3, 680 * v3);
                spawn(CallEffect, "FlipbookSlash", v4);
            end);
        end;

        task.wait(0.1);
    end;
end;
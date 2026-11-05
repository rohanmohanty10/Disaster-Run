  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
require(PathShortcuts.KnitPath.Knit);
game:GetService("RunService");
game:GetService("Players");
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1, p2) -- Line: 13
    -- upvalues: EffectsHandler (copy)
    local u3 = p1:IsA("Model") and p1 and p1 or p1.Character;
    local u4;

    if u3 then
        u4 = u3:FindFirstChild("HumanoidRootPart");
    else
        u4 = u3;
    end;

    if not u4 then
        return;
    end;

    local u5 = p2.Color or Color3.fromRGB(182, 139, 255);
    local u6 = p2.Size or Vector3.new(6.5, 20, 6.5);
    local v7 = p2.Duration or 0.5;
    local v8 = os.clock();

    while u3.Parent and v7 > os.clock() - v8 do
        for _ = 1, math.random(2, 3) do
            task.spawn(function() -- Line: 30
                -- upvalues: EffectsHandler (ref), u4 (copy), u6 (copy), u5 (copy), u3 (copy)
                local v9, v10, v11;

                if math.random(1, 2) == 1 then
                    local Angles = CFrame.Angles;
                    local v12 = math.random(-40, 40);
                    v9 = Angles(0, 1.5707963267948966, (math.rad(v12)));

                    if not v9 then
                        v10 = CFrame.Angles;
                        v11 = math.random(-40, 40);
                        v9 = v10(math.rad(v11), -1.5707963267948966, 3.141592653589793);
                    end;
                else
                    v10 = CFrame.Angles;
                    v11 = math.random(-40, 40);
                    v9 = v10(math.rad(v11), -1.5707963267948966, 3.141592653589793);
                end;

                task.spawn(EffectsHandler.CallEffect, "Anubis_Slash", {
                    Time = 0.25,
                    SurfaceDirection = "Bottom",
                    Origin = u4,
                    Offset = v9,
                    EndCFrame = CFrame.Angles(0, -2.6179938779914944, 0),
                    Size = u6,
                    Color = u5,
                    Character = u3
                });
                task.wait(math.random(0, 10) / 100);
            end);
        end;

        local CallEffect = EffectsHandler.CallEffect;
        local v13 = {
            Path = "Particles/Slash",
            AutoSerialize = true,
            Scale = 0.75
        };
        local v14 = u4.CFrame * CFrame.new(math.random(-5, 5), math.random(-2, 2), -6.5);
        local Angles = CFrame.Angles;
        local v15 = math.random(-40, 40);
        v13.Origin = v14 * Angles(0, 0, (math.rad(v15)));
        v13.Player = p1;
        v13.Character = u3;
        CallEffect("Emit Particle V3", v13);
        task.wait(0.05);
    end;
end;
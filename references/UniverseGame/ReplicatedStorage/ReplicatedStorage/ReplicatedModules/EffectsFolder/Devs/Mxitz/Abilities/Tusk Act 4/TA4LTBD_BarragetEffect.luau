  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 5
    -- upvalues: EffectsHandler (copy)
    local v2 = typeof(p1) == "table";
    assert(v2, "data must be a table");

    if not p1.Reference then
        return;
    end;

    local HumanoidRootPart = p1.Attacker:FindFirstChild("HumanoidRootPart");

    while p1.Reference ~= nil and (p1.Attacker and (p1.Target and p1.Reference:IsDescendantOf(p1.Attacker))) do
        EffectsHandler.CallEffect("Q_RADIAL", {
            Distance = 100,
            Origin = HumanoidRootPart.CFrame,
            Effect = {
                {
                    Effect = "HitEffect V3",
                    Arguments = {
                        {
                            Path = "Particles/Legacy/Light",
                            AutoSerialize = true,
                            Attacker = p1.Attacker,
                            Target = p1.Target
                        }
                    }
                }
            }
        });

        if Random.new():NextInteger(1, 30) == 1 then
            EffectsHandler.CallEffect("Slam Effect", {
                DebrisSize = 1.25,
                Character = p1.Attacker,
                Origin = HumanoidRootPart.CFrame * CFrame.new(0, 0, -14.5),
                Radius = Random.new():NextInteger(3, 5),
                Disable = {
                    FlyingDebris = true
                }
            });
        end;

        task.wait(Random.new():NextInteger(5, 10) / 60);
    end;
end;
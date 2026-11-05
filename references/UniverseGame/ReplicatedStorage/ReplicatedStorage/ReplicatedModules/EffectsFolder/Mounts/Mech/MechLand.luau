  

 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = ReplicatedStorage["Client Assets"];
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
Random.new();
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };

return function(p2, p3, p4, p5, p6, p7, p8) -- Line: 15
    -- upvalues: u1 (copy), EffectsHandler (copy), Players (copy)
    if not p2 then
        return;
    end;

    local v9 = p3 or CFrame.identity;

    if p8 then
        task.wait(p8);
    end;

    local v10 = os.clock();
    local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v11;

    repeat
        v11 = workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -(p7 or 4), 0), u1);
        task.wait();
    until (p4 or 7.5) < os.clock() - v10 or (not p2:IsDescendantOf(game) or v11 ~= nil);

    if v11 then
        if p5 and not p2:GetAttribute(p5) then
            return;
        end;

        local v12 = CFrame.new(v11.Position, v11.Position + v11.Normal) * v9;
        EffectsHandler.CallEffect("Emit Particle V3", {
            RawPath = true,
            Path = "Universal/Mounts/Khronos Walker/Land",
            AutoSerialize = true,
            PlaySounds = true,
            Origin = v12,
            Player = Players:GetPlayerFromCharacter(p2),
            IgnoreUnusuals = p6
        });
        EffectsHandler.CallEffects({
            {
                Name = "Q_RADIAL",
                Data = {
                    {
                        Distance = 20,
                        Origin = v12,
                        Effect = { {
                                Effect = "Camera Shake",
                                Arguments = { { 4, 10, 0, 0.45, Vector3.new(0.4, 0.4, 0.4), Vector3.new(4, 1, 1), true } }
                            }, {
                                Effect = "InvertedLighting",
                                Arguments = { 0.2, 0.5 }
                            } }
                    }
                }
            }
        });
    end;
end;
  

 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = ReplicatedStorage["Client Assets"];
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
Random.new();
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };

return function(p2, p3, p4, p5, p6, p7, p8, p9) -- Line: 15
    -- upvalues: u1 (copy), EffectsHandler (copy), Players (copy)
    if not (p2 and p3) then
        return;
    end;

    local v10 = p4 or CFrame.identity;
    local v11 = os.clock();
    local HumanoidRootPart = p2:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v12;

    repeat
        v12 = workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -(p8 or 4), 0), u1);
        task.wait();
    until (p5 or 7.5) < os.clock() - v11 or (not p2:IsDescendantOf(game) or v12 ~= nil);

    if v12 then
        if p6 and not p2:GetAttribute(p6) then
            return;
        end;

        if p9 then
            EffectsHandler.CallEffect("Play Sound At", {
                Object = p9,
                Origin = HumanoidRootPart.CFrame
            });
        end;

        EffectsHandler.CallEffect("Emit Particle V3", {
            AutoSerialize = true,
            PlaySounds = true,
            Origin = CFrame.new(v12.Position, v12.Position + v12.Normal) * v10,
            Particle = p3,
            Player = Players:GetPlayerFromCharacter(p2),
            IgnoreUnusuals = p7
        });
    end;
end;
  

 

game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ReplicatedModules = ReplicatedStorage:FindFirstChild("ReplicatedModules");
local PathShortcuts = require(ReplicatedModules:FindFirstChild("PathShortcuts"));
require(PathShortcuts.KnitPath.Trove);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };
ReplicatedStorage:FindFirstChild("Client Assets");

return function(p2) -- Line: 18
    -- upvalues: u1 (copy), ParticleHandler (copy)
    local Batbike = p2:WaitForChild("Batbike", 5);

    if not Batbike then
        return;
    end;

    while true do
        local v3 = workspace:Raycast(p2.HumanoidRootPart.Position, Vector3.new(0, -7.5, 0), u1);
        local v4 = (p2.HumanoidRootPart.Velocity * Vector3.new(1, 0, 1)).Magnitude > 5;

        if v3 == nil then
            v4 = false;
        end;

        ParticleHandler.EnableAllParticles(Batbike.Trails, v4);
        task.wait(0.1);

        if not (p2:IsDescendantOf(game) and p2:GetAttribute("Mount")) then
            return;
        end;
    end;
end;
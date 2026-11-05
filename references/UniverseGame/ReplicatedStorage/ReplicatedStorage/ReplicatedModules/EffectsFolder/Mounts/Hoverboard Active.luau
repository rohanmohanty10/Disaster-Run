  

 

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
local u2 = ReplicatedStorage:FindFirstChild("Client Assets");

return function(p3) -- Line: 18
    -- upvalues: u2 (copy), u1 (copy), ParticleHandler (copy)
    local Hoverboard = p3:WaitForChild("Hoverboard", 5);

    if not Hoverboard then
        return;
    end;

    local v4 = u2.Misc.GroundHover:Clone();
    v4.Position = Hoverboard.PrimaryPart.Position;
    v4.Parent = Hoverboard;

    while true do
        local v5 = workspace:Raycast(p3.HumanoidRootPart.Position, Vector3.new(0, -15, 0), u1);

        if v5 then
            v4.Position = v5.Position + Vector3.new(0, 0.5, 0);
        end;

        ParticleHandler.EnableAllParticles(v4, v5 ~= nil);
        task.wait();

        if not (p3:IsDescendantOf(game) and p3:GetAttribute("Mount")) then
            v4:Destroy();

            return;
        end;
    end;
end;
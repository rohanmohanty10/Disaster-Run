  

 

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
    local v3 = p2:WaitForChild("Buggy Kart", 5);

    if not v3 then
        return;
    end;

    while true do
        local v4 = workspace:Raycast(p2.HumanoidRootPart.Position, Vector3.new(0, -5, 0), u1);

        if v4 then
            local v5, v6, v7 = v4.Instance.Color:ToHSV();
            ParticleHandler.HSVShiftParticles(v3, {
                Hue = v5,
                Saturation = v6,
                Value = v7
            });
        end;

        local v8 = (p2.HumanoidRootPart.Velocity * Vector3.new(1, 0, 1)).Magnitude > 5;

        if v4 == nil then
            v8 = false;
        end;

        ParticleHandler.EnableAllParticles(v3, v8);
        task.wait(0.1);

        if not (p2:IsDescendantOf(game) and p2:GetAttribute("Mount")) then
            return;
        end;
    end;
end;
  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
require(PathShortcuts.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };

return function(p2) -- Line: 12
    -- upvalues: PathShortcuts (copy), u1 (copy), ParticleHandler (copy)
    local v3 = p2:WaitForChild("Oppressor MKII", 5);

    if not v3 then
        return;
    end;

    local v4 = PathShortcuts.ClientAssets.Mounts.Effects.Oppressor.Hover:Clone();
    v4.Position = v3.PrimaryPart.Position;
    v4.Parent = v3;

    while true do
        local v5 = workspace:Raycast(p2.HumanoidRootPart.Position, Vector3.new(0, -15, 0), u1);

        if v5 then
            v4.Position = v5.Position + Vector3.new(0, 0.5, 0);
        end;

        ParticleHandler.EnableAllParticles(v4, v5 ~= nil);

        if v5 and v5.Instance then
            local v6, v7, v8 = v5.Instance.Color:ToHSV();

            for _, descendant in v4:GetDescendants() do
                if descendant:GetAttribute("UseGroundColor") then
                    descendant.Color = ParticleHandler.HSVShift(descendant.Color, {
                        Hue = v6,
                        Saturation = v7,
                        Value = v8
                    });
                end;
            end;
        end;

        task.wait();

        if not (p2:IsDescendantOf(game) and p2:GetAttribute("Mount")) then
            v4:Destroy();

            return;
        end;
    end;
end;
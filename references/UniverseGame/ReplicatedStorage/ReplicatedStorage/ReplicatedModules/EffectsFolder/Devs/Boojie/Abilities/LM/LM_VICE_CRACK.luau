  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local GenericModule = require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
Random.new();
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local EffectsHandler = require(ReplicatedModules.EffectsHandler);
require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = EffectsHandler.GetEffect("Emit Particle V3");

return function(p2, p3, p4) -- Line: 14
    -- upvalues: AssetHandler (copy), u1 (copy), GenericModule (copy)
    if p2 == nil then
        return;
    end;

    if typeof(p2) == "Instance" and p2:IsA("BasePart") then
        p2 = p2.Position + Vector3.new(0, 2, 0);
    end;

    local v5 = RaycastParams.new();
    v5.FilterType = Enum.RaycastFilterType.Include;
    v5.FilterDescendantsInstances = { game.Workspace.Map };
    local v6 = workspace:Raycast(p2, p3 or Vector3.new(0, -12, 0), v5);

    if not v6 then
        return;
    end;

    local u7 = AssetHandler.CloneAsset("Particles/ViceGrip/Slam", p4);
    u7.CFrame = CFrame.lookAt(v6.Position + Vector3.new(0, 0.2, 0), v6.Position - v6.Normal) * CFrame.Angles(1.5707963267948966, 0, 0);
    u7.Parent = workspace;
    u1({
        Enabled = false,
        Clone = false,
        Destroy = false,
        Parent = false,
        Particle = u7,
        AbilityName = p4.AbilityName,
        SkinName = p4.SkinName,
        Player = p4.Player,
        Character = p4.Character
    });

    for _, descendant in pairs(u7:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            GenericModule.Emit(descendant);
        end;
    end;

    task.delay(3, function() -- Line: 51
        -- upvalues: u7 (copy)
        u7:Destroy();
    end);
end;
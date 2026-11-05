  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local GenericModule = require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
Random.new();
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local EffectsHandler = require(ReplicatedModules.EffectsHandler);
require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = EffectsHandler.GetEffect("Emit Particle V3");

return function(p2, p3) -- Line: 14
    -- upvalues: AssetHandler (copy), u1 (copy), GenericModule (copy)
    local v4 = RaycastParams.new();
    v4.FilterType = Enum.RaycastFilterType.Include;
    v4.FilterDescendantsInstances = { game.Workspace.Map };

    if p2 == nil then
        return;
    end;

    local v5 = workspace:Raycast(p2.Position, Vector3.new(0, -12, 0), v4);

    if not v5 then
        return;
    end;

    local u6 = AssetHandler.CloneAsset("Particles/ViceGrip/Drag", p3);
    local v7 = v5.Position + Vector3.new(0, 0.05, 0);
    u6.CFrame = CFrame.lookAt(v7, v7 + p2.CFrame.LookVector) * CFrame.Angles(0, 3.141592653589793, 0);
    u6.Parent = workspace;
    u1({
        Enabled = false,
        Clone = false,
        Destroy = false,
        Parent = false,
        Particle = u6,
        AbilityName = p3.AbilityName,
        SkinName = p3.SkinName,
        Player = p3.Player,
        Character = p3.Character
    });

    for _, descendant in pairs(u6:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            GenericModule.Emit(descendant);
        end;
    end;

    task.delay(1, function() -- Line: 48
        -- upvalues: u6 (copy)
        u6:Destroy();
    end);
end;
  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local GenericModule = require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
Random.new();
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local EffectsHandler = require(ReplicatedModules.EffectsHandler);
require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = EffectsHandler.GetEffect("Emit Particle V3");

return function(p2, p3, p4, p5) -- Line: 14
    -- upvalues: AssetHandler (copy), u1 (copy), GenericModule (copy)
    if typeof(p2) == "Instance" and p2:IsA("BasePart") then
        p2 = p2.Position + Vector3.new(0, 2, 0);
    end;

    local v6 = RaycastParams.new();
    v6.FilterType = Enum.RaycastFilterType.Include;
    v6.FilterDescendantsInstances = { game.Workspace.Map };
    local v7 = workspace:Raycast(p2, p3 or Vector3.new(0, -12, 0), v6);

    if not v7 then
        return;
    end;

    local u8 = AssetHandler.CloneAsset("Particles/LapseBlue/CollapseGround", p5);
    u8.CFrame = CFrame.lookAt(v7.Position + Vector3.new(0, 0.05, 0), v7.Position - v7.Normal) * CFrame.Angles(1.5707963267948966, 0, 0);
    u8.Parent = workspace;
    u1({
        Enabled = false,
        Clone = false,
        Destroy = false,
        Parent = false,
        Particle = u8,
        AbilityName = p5.AbilityName,
        SkinName = p5.SkinName,
        Player = p5.Player,
        Character = p5.Character
    });

    for _, descendant in pairs(u8:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") and (descendant.Name ~= "Blood" or p4) then
            GenericModule.Emit(descendant);
        end;
    end;

    task.delay(3, function() -- Line: 53
        -- upvalues: u8 (copy)
        u8:Destroy();
    end);
end;
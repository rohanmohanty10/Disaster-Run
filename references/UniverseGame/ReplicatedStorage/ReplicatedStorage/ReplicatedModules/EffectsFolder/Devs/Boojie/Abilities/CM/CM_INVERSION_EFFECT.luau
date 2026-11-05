  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local _ = PathShortcuts.ClientAssets;
Random.new();
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local EffectsHandler = require(ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = EffectsHandler.GetEffect("Emit Particle V3");

return function(p2, p3, p4, p5) -- Line: 14
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), u1 (copy)
    local v6 = p5 or {};
    local v7 = RaycastParams.new();
    v7.FilterType = Enum.RaycastFilterType.Whitelist;
    v7.FilterDescendantsInstances = { game.Workspace.Map };
    local v8 = workspace:Raycast(p2, p3, v7);

    if not v8 then
        return;
    end;

    local u9 = AssetHandler.GetAsset("Particles/InversionEffect", v6):Clone();
    u9.CFrame = CFrame.lookAt(v8.Position, v8.Position - v8.Normal) * CFrame.Angles(0, 0, 1.5707963267948966);
    ParticleHandler.Unusualify(u9, {
        Character = v6.Character
    });
    u9.Parent = workspace.Effects;
    u1({
        Enabled = true,
        Clone = false,
        Destroy = false,
        Parent = false,
        Particle = u9,
        SkinName = v6.SkinName
    });
    task.delay(p4, function() -- Line: 38
        -- upvalues: u9 (copy)
        for _, descendant in pairs(u9:GetDescendants()) do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = false;
            end;
        end;

        task.wait(3);
        u9:Destroy();
    end);
end;
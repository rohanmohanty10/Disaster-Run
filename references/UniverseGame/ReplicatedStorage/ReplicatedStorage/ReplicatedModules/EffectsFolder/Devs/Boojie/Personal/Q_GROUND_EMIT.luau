  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local _ = PathShortcuts.ClientAssets;
Random.new();
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local EffectsHandler = require(ReplicatedModules.EffectsHandler);
require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
EffectsHandler.GetEffect("Emit Particle V3");

return function(p1) -- Line: 17
    -- upvalues: EffectsHandler (copy), TableUtil (copy)
    local v2 = p1 or {};
    local v3 = v2.Effect or "Emit Particle V3";
    local Origin = v2.Origin;
    local Offset = v2.Offset;
    local GroundOffset = v2.GroundOffset;

    if typeof(Origin) == "Vector3" then
        Origin = CFrame.new(Origin);
    elseif typeof(Origin) == "Instance" and Origin:IsA("BasePart") then
        Origin = Origin.CFrame;
    end;

    if not Origin then
        return;
    end;

    if Offset then
        Origin = Origin * Offset;
    end;

    local v4 = v2.Direction or Vector3.new(0, -8, 0);
    local v5 = RaycastParams.new();
    v5.FilterType = Enum.RaycastFilterType.Include;
    v5.FilterDescendantsInstances = { game.Workspace.Map };
    local v6 = workspace:Raycast(Origin.Position, v4, v5);

    if not v6 then
        return;
    end;

    EffectsHandler.CallEffect(v3, TableUtil.Reconcile({
        Origin = v6.Position + v6.Normal * 0.125,
        Offset = GroundOffset or CFrame.identity
    }, v2));
end;
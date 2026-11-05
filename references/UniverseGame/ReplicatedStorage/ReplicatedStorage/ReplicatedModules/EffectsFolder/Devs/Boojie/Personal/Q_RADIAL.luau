  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Promise);
require(Knit.Util.Trove);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 7
    -- upvalues: EffectsHandler (copy)
    local Origin = p1.Origin;

    if typeof(Origin) == "CFrame" then
        Origin = Origin.Position;
    end;

    local Distance = p1.Distance;
    local Effect = p1.Effect;
    local v2 = p1.Arguments or {};
    local Character = game.Players.LocalPlayer.Character;

    if Character then
        Character = Character:FindFirstChild("HumanoidRootPart");
    end;

    if not Character then
        return;
    end;

    if (Origin - Character.Position).Magnitude <= Distance then
        if typeof(p1.Effect) == "table" then
            for _, v in p1.Effect do
                EffectsHandler.CallEffect("Q_RADIAL", {
                    Origin = Origin,
                    Distance = Distance,
                    Effect = v.Effect,
                    Arguments = v.Arguments
                });
            end;

            return;
        end;

        if p1.Yield then
            EffectsHandler.CallEffect(Effect, unpack(v2));

            return;
        end;

        task.spawn(EffectsHandler.CallEffect, Effect, unpack(v2));
    end;
end;
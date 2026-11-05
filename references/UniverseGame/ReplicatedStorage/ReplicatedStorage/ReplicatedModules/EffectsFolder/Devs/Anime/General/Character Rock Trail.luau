  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };

return function(p2) -- Line: 12
    -- upvalues: u1 (copy), EffectsHandler (copy), TableUtil (copy)
    local Character = p2.Character;
    local u3 = p2.Attribute or "RockTrailAttribute";
    local v4 = p2.Properties or {};
    local Interval = p2.Interval;
    local Duration = p2.Duration;
    local RelativePart = p2.RelativePart;
    local v5 = p2.TorsoName or "Torso";

    if not Character then
        return;
    end;

    if p2.State then
        if Character:GetAttribute(u3) then
            return;
        end;

        Character:SetAttribute(u3, true);

        if Duration then
            task.delay(Duration, function() -- Line: 33
                -- upvalues: Character (copy), u3 (copy)
                if Character:IsDescendantOf(game) then
                    Character:SetAttribute(u3, nil);
                end;
            end);
        end;

        local v6 = RelativePart or Character:FindFirstChild("Torso");

        if not v6 then
            return;
        end;

        local Position = v6.Position;
        local v7 = p2.MinDistance or 1;

        while Character and (Character:IsDescendantOf(game) and (Character:GetAttribute(u3) and Character:FindFirstChild(v5))) do
            if v7 < (v6.Position * Vector3.new(1, 0, 1) - Position).Magnitude and workspace:Raycast(v6.Position, Vector3.new(0, -6.5, 0), u1) then
                local v8 = CFrame.new(v6.Position, v6.Position + v6.Velocity.Unit);
                EffectsHandler.CallEffect("Rock Trail", TableUtil.Reconcile(v4, {
                    Offset = 2.5,
                    Distance = 3,
                    Amount = 1,
                    Duration = 3,
                    DurationOffset = 0.1,
                    Down = true,
                    Origin = v8,
                    LookVector = v8.LookVector,
                    Size = Vector2.new(0.63, 0.95) * (p2.Scale or 1)
                }));
                Position = v6.Position * Vector3.new(1, 0, 1);
            end;

            EffectsHandler.Wait(Interval);
        end;
    else
        if not Character:GetAttribute(u3) then
            return;
        end;

        Character:SetAttribute(u3, nil);
    end;
end;
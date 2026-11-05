  

 

local XenoFunctions = require(game.ReplicatedStorage.ReplicatedModules.XenoFunctions);
local u1 = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler).GetEffect("RayCastOnMap");

return function(u2, p3) -- Line: 5
    -- upvalues: u1 (copy), XenoFunctions (copy)
    local v4 = p3 or {};
    local v5 = v4.Offset or 1;
    local u6 = v4.Range or 3;
    local u7 = v4.Speed or 0.1;
    local u8 = v4.Duration or 0.3;
    local u9 = v4.Size or Vector3.new(1, 1, 1);
    local u10 = v4.NewSize or u9;
    local Position = u2:ToWorldSpace(CFrame.new(-v5, 0, 0)).Position;
    local Position2 = u2:ToWorldSpace(CFrame.new(v5, 0, 0)).Position;
    local v11 = u1(Position, Vector3.new(0, -10, 0), true);
    local v12 = u1(Position2, Vector3.new(0, -10, 0), true);

    for i = 1, 2 do
        local u13;

        if i == 1 then
            u13 = v11;
        else
            u13 = v12;
        end;

        pcall(function() -- Line: 26
            -- upvalues: XenoFunctions (ref), u13 (ref), u2 (copy), u6 (copy), u8 (copy), u7 (copy), u9 (copy), u10 (copy)
            XenoFunctions.spawnRubble(u13.Instance, u13.Position, {
                origPos = u2.Position,
                Range = u6,
                Duration = u8,
                Speed = u7,
                Size = u9,
                newSize = u10
            });
        end);
    end;
end;
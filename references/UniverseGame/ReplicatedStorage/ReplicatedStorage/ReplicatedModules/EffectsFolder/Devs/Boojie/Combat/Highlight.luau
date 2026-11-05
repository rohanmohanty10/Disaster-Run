  

 

local HighlightController = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules").Independent.HighlightController);

return function(p1, u2, ...) -- Line: 3
    -- upvalues: HighlightController (copy)
    if p1 == "Add" then
        local u3, _, v4 = ...;

        if HighlightController:Get(u2, u3) then
            HighlightController:Remove(u2, u3);
        end;

        HighlightController:Add(u2, ...);

        if v4.Time then
            local u5 = HighlightController:Get(u2, u3);

            if v4.Time > 0 then
                task.delay(v4.Time, function() -- Line: 14
                    -- upvalues: HighlightController (ref), u2 (copy), u3 (copy), u5 (copy)
                    if HighlightController:Get(u2, u3) == u5 then
                        HighlightController:Remove(u2, u3);
                    end;
                end);

                return;
            end;

            task.defer(function() -- Line: 20
                -- upvalues: HighlightController (ref), u2 (copy), u3 (copy)
                HighlightController:Remove(u2, u3);
            end);
        end;
    elseif p1 == "Remove" then
        HighlightController:Remove(u2, ...);
    end;
end;
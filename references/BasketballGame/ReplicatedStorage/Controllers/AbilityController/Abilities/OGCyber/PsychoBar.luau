 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Packages.Knit);

return function(u1, u2, p3) -- Line: 7
    local MovementController = u1.MovementController;
    MovementController.Boost = MovementController.Boost + 15;
    u2:Add(function() -- Line: 10
        -- upvalues: u1 (copy)
        u1.MovementController.Boost = math.max(u1.MovementController.Boost - 15, 0);
    end);
    u2:Add(task.delay(p3.Time, function() -- Line: 14
        -- upvalues: u1 (copy), u2 (copy)
        if not u1.IndependantAbilityCleanup:Remove(u2) then
            u2:Destroy();
        end;
    end));
end;
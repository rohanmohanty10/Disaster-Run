  

 

return function(p1) -- Line: 1
    local Stands = require(game.ReplicatedStorage:WaitForChild("ReplicatedModules"):WaitForChild("Stands"));
    p1:RegisterHook("BeforeRun", function(p2) -- Line: 4
        -- upvalues: Stands (copy)
        if p2.Name ~= "setability" then
            return;
        end;

        local v3 = p2:GetArgument(2):GetValue();

        if v3 < 1 then
            return "Ability Id cannot be lower than 1";
        end;

        if not Stands[v3] then
            return "Ability Id does not exist";
        end;
    end);
end;
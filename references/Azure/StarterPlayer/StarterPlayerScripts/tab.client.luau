 

 

shared.TabbedIn = true;
local u1 = tick();
game:GetService("RunService").Stepped:Connect(function(p2) -- Line: 12
    -- upvalues: u1 (ref)
    if tick() - u1 >= 0.25 then
        shared.TabbedIn = false;
    else
        shared.TabbedIn = true;
    end;

    u1 = tick();
end);
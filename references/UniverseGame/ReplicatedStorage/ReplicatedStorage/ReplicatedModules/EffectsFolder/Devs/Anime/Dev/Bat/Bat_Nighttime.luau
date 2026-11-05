  

 

local Rain = require(script.Rain);
Rain:SetColor(Color3.fromRGB(151, 191, 255));

return function(p1) -- Line: 4
    -- upvalues: Rain (copy)
    Rain:Enable();

    while p1 and p1:IsDescendantOf(game) do
        game.Lighting.ClockTime = 4.5;
        task.wait(0.1);
    end;

    game.Lighting.ClockTime = 12;
    Rain:Disable();
end;
  

 

return function(p1) -- Line: 1
    local _ = game:GetService("Players").LocalPlayer;
    p1.Knit.OnStart():await();
    local u2 = require(script.CraftingUI).new(script.Parent, p1);

    function p1.ShowCraftingMenu(p3) -- Line: 11
        -- upvalues: u2 (copy)
        u2:Load();
    end;
end;
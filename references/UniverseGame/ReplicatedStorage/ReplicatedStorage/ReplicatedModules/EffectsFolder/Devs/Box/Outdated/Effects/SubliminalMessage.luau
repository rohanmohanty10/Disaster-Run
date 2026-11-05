  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;

return function(p1) -- Line: 3
    -- upvalues: LocalPlayer (copy)
    local Subliminal = LocalPlayer.PlayerGui.Extra.Subliminal;
    tick();

    for _ = 1, 3 do
        local v2 = math.random(1, 5);
        Subliminal[v2].Visible = true;
        wait();
        Subliminal[v2].Visible = false;
    end;
end;
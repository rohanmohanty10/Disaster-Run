 

 

game:GetService("Lighting");
game:GetService("TweenService");
game:GetService("ReplicatedStorage");

return {
    [0] = function(p1, p2, p3) -- Line: 6
        local _ = p1.Character;
        local _ = p1.Meshes;
        local _ = p1.Cache;

        for _, v in p3.All do
            if v.Name == "Aura" then
                v.Enabled = true;
            end;
        end;
    end,

    [1.133] = function(p4, p5, p6) -- Line: 16
        local _ = p4.Character;
        local _ = p4.Meshes;
        local _ = p4.Cache;

        for _, v in p6.All do
            if v.Name == "Aura" then
                v.Enabled = false;
            end;
        end;
    end,

    [2.133] = function() -- Line: 26
    end
};
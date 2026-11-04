 
 

return {
    [0] = function(p1, p2, p3) -- Line: 2
        local Character = p1.Character;
        local _ = p1.Meshes;
        local _ = p1.Cache;

        for _, child in p2.LeftHand:GetChildren() do
            child.Color = Character["Left Arm"].Color;
        end;

        for _, child in p2.RightHand:GetChildren() do
            child.Color = Character["Right Arm"].Color;
        end;
    end,

    [9000000000] = function() -- Line: 15
    end
};
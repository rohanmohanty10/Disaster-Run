 
 

local u1 = { "Sides", "Top" };

return {
    hideMap = function(p2: userdata) -- Line: 5, Name: hideMap
        -- upvalues: u1 (copy)
        for _, v in u1 do
            local v3 = p2:FindFirstChild(v);

            if not v3 then
                error((`failed to find {v} for diavolo MVP`));
            end;

            for _, v2 in v3:QueryDescendants("BasePart") do
                v2.Transparency = 1;
            end;

            for _, v2 in v3:QueryDescendants("Texture") do
                v2.Transparency = 1;
            end;
        end;
    end,

    showMap = function(p4: userdata) -- Line: 20, Name: showMap
        -- upvalues: u1 (copy)
        for _, v in u1 do
            local v5 = p4:FindFirstChild(v);

            if not v5 then
                error((`failed to find {v} for diavolo MVP`));
            end;

            for _, v2 in v5:QueryDescendants("BasePart") do
                v2.Transparency = 0;
            end;

            for _, v2 in v5:QueryDescendants("Texture") do
                v2.Transparency = 0;
            end;
        end;
    end
};
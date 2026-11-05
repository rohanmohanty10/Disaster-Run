  

 

local u1 = {};

return function(p2, ...) -- Line: 2
    -- upvalues: u1 (copy)
    ({
        Universal = function(p3, p4) -- Line: 4
            -- upvalues: u1 (ref)
            for _, v in ipairs(p3) do
                if p4 then
                    if u1[v] then
                        repeat
                            wait(0.1);
                        until not u1[v];
                    end;

                    u1[v] = true;
                else
                    if not u1[v] then
                        repeat
                            wait(0.1);
                        until u1[v];
                    end;

                    u1[v] = nil;
                end;

                for _, descendant in ipairs(v:GetDescendants()) do
                    if descendant.ClassName == "Trail" then
                        descendant.Enabled = p4;
                    end;
                end;
            end;
        end,

        Yone = function(p5, p6) -- Line: 20
            for _, v in ipairs(p5) do
                for _, descendant in ipairs(v:GetDescendants()) do
                    if descendant.Name:find("NewTrail") then
                        descendant.Enabled = p6;
                    end;
                end;
            end;
        end,

        Yasuo = function(p7, p8) -- Line: 29
            for _, descendant in ipairs(p7:GetDescendants()) do
                if descendant.Name:find("NewTrail") then
                    descendant.Enabled = p8;
                end;
            end;
        end
    })[p2](...);
end;
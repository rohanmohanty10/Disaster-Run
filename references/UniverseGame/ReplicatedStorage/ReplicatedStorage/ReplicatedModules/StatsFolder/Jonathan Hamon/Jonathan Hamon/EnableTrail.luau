  

 

local CollectionService = game:GetService("CollectionService");

return function(u1, u2) -- Line: 3
    -- upvalues: CollectionService (copy)
    if not CollectionService:HasTag(u1, "PluckToggled") then
        local v6 = {
            Left = function() -- Line: 17
                -- upvalues: u2 (copy), u1 (copy)
                local v3 = u2[2];

                for _, child in pairs(u1["Left Arm"]:GetChildren()) do
                    if child:IsA("Trail") then
                        child.Enabled = v3;
                    end;
                end;
            end,

            Right = function() -- Line: 26
                -- upvalues: u2 (copy), u1 (copy)
                local v4 = u2[2];

                for _, child in pairs(u1["Right Arm"]:GetChildren()) do
                    if child:IsA("Trail") then
                        child.Enabled = v4;
                    end;
                end;
            end,

            Both = function() -- Line: 35
                -- upvalues: u2 (copy), u1 (copy)
                local v5 = u2[2];

                for _, child in pairs(u1["Left Arm"]:GetChildren()) do
                    if child:IsA("Trail") then
                        child.Enabled = v5;
                    end;
                end;

                for _, child in pairs(u1["Right Arm"]:GetChildren()) do
                    if child:IsA("Trail") then
                        child.Enabled = v5;
                    end;
                end;
            end
        };

        if v6[u2[1]] then
            v6[u2[1]]();
        end;

        return;
    end;

    local Pluck = u1:FindFirstChild("Pluck");

    if not Pluck then
        return;
    end;

    local v7 = u2[2];

    for _, child in pairs(Pluck.Blade:GetChildren()) do
        if child:IsA("Trail") then
            child.Enabled = v7;
        end;
    end;
end;
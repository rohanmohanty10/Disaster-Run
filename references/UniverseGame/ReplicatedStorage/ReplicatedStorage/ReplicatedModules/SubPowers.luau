  

 

local v1 = {};

for _, descendant in pairs(script:GetDescendants()) do
    if descendant:IsA("ModuleScript") then
        for i, v in require(descendant) do
            if i and v then
                v1[i] = v;
            end;
        end;
    end;
end;

return v1;
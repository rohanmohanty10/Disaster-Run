  

 

local v1 = {};

for _, child in ipairs(script:GetChildren()) do
    local v2 = require(child);

    for i, v in pairs(v2) do
        if v1[i] then
            warn((`{i} Achievement already exists`));
        else
            v1[i] = v;
        end;
    end;
end;

return v1;
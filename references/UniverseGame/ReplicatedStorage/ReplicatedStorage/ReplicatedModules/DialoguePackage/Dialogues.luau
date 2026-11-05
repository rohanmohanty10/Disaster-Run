  

 

local v1 = {};

for _, descendant in ipairs(script:GetDescendants()) do
    if descendant:IsA("ModuleScript") then
        v1[descendant.Name] = require(descendant);
    end;
end;

return v1;
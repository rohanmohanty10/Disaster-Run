  

 

local v1 = {};

for _, child in script:GetChildren() do
    v1[child.Name] = require(child);
end;

return v1;
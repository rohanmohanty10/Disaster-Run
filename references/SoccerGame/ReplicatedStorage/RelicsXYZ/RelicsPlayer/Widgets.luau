  

require(script.Parent.State);
local v1 = {};

for _, child in ipairs(script:GetChildren()) do
    v1[child.Name] = require(child);
end;

return v1;
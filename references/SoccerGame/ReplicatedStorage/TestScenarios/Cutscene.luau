  

local v1 = {};

for _, v in game:GetService("ReplicatedStorage").Effects:QueryDescendants("ModuleScript:has([Name = \".ctest\"])") do
    table.insert(v1, v.Name);
end;

return v1;
  

 

local v1 = {};

for _, v in script:QueryDescendants("ModuleScript") do
    for i, v2 in require(v) do
        v1[i] = v2;
    end;
end;

return v1;
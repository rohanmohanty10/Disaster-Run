 

local v1 = {}
for _, v2 in pairs(script:GetChildren()) do
    for v3, v4 in pairs(require(v2)) do
        v1[v3] = v4
        v1[v3].Type = v2.Name
    end
end
return v1
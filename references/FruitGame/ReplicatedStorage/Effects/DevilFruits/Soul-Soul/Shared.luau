 

local v1 = {
    ["camShake"] = _G.camShake
}
local v2 = next
local v3, v4 = script:GetChildren()
for _, v5 in v2, v3, v4 do
    if v5:IsA("ModuleScript") and not v1[v5.Name] then
        v1[v5.Name] = require(v5)
    end
end
return v1
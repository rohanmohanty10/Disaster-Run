  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = {};

for i, v in require(ReplicatedStorage.Shared.PlrStyles) do
    local v2 = v;
    local v3 = i;

    for i2, v4 in v.Skins or {} do
        local v5 = v4.Rarity or v2.Rarity;
        v1[`{v3}.-.-.-.{i2}`] = v5;
    end;
end;

return v1;
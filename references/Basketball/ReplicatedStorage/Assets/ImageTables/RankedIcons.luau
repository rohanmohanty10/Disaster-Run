 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = {};

for _, v in require(ReplicatedStorage.Shared.Tables.RankingBrackets).Icons do
    if typeof(v) == "string" then
        table.insert(v1, v);
    else
        for _, v2 in v do
            table.insert(v1, v2);
        end;
    end;
end;

return v1;
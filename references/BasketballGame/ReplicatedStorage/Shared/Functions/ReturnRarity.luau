 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Tables.Rarities);

return function(p1: any, p2: table?) -- Line: 5
    local Random_new_ret = Random.new(os.clock() * 1000);
    local table_clone_ret = table.clone(p1);

    if p2 ~= nil then
        table_clone_ret = {};

        for _, v in table_clone_ret do
            if table.find(p2, v[1]) == nil then
                table.insert(table_clone_ret, v);
            end;
        end;
    end;

    table.sort(table_clone_ret, function(p3, p4) -- Line: 35
        return p3[2] < p3[2];
    end);
    local v5 = 0;

    for _, v in table_clone_ret do
        v5 = v5 + v[2];
    end;

    local v6 = Random_new_ret:NextNumber(0, v5);
    local v7 = 0;

    for _, v in table_clone_ret do
        v7 = v7 + v[2];

        if v6 <= v7 then
            return v[1];
        end;
    end;
end;
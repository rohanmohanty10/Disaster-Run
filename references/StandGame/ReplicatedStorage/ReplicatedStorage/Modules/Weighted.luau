 

 

local l__random__1 = math.random;
local u1 = {};
u1.__index = u1;
function u1.new() --[[ Line: 8 ]]
    -- upvalues: u1 (copy)
    local v2 = {
        Items = {},
        Tick = tick()
    };
    return setmetatable(v2, u1);
end;
function u1.AddItem(p3, p4, p5) --[[ Line: 12 ]]
    p3.Items[p4] = p5;
end;
function u1.GetTotalWeight(p6) --[[ Line: 16 ]]
    local v7 = 0;
    for _, v8 in pairs(p6.Items) do
        v7 = v7 + v8 * 1000000000;
    end;
    return v7;
end;
function u1.GetRandomItem(p9) --[[ Line: 26 ]]
    -- upvalues: l__random__1 (copy)
    local v10 = p9:GetTotalWeight();
    if v10 < 0 then
        return;
    end;
    local v11 = l__random__1(0, 1000000000);
    local v12 = {};
    local v13 = 0;
    local v14 = nil;
    for v15, v16 in pairs(p9.Items) do
        table.insert(v12, {
            Item = v15,
            Chance = v16
        });
    end;
    local v17 = { unpack(v12) };
    local v18 = { unpack(v12) };
    for v19 = 1, #v17 do
        v17[v19] = table.remove(v18, math.random(#v18));
    end;
    local v20 = 0;
    while true do
        for _, v21 in pairs(v17) do
            local l__Chance__2 = v21.Chance;
            local l__Item__3 = v21.Item;
            v13 = v13 + l__Chance__2 * 1000000000;
            if v11 <= v13 then
                v14 = l__Item__3;
                break;
            end;
        end;
        if v10 <= v13 then
            break;
        end;
        v20 = v20 + 1;
        task.wait();
        if v20 > 3 or v14 then
            break;
        end;
    end;
    setmetatable(p9, nil);
    return v14;
end;
return u1;
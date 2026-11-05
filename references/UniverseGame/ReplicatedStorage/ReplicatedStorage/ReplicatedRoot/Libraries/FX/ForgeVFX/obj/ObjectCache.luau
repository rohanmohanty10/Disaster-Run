  

 

local u1 = require("../mod/utility");
local u2 = {};
u2.__index = u2;

local function reconcile(p3, p4) -- Line: 39
    for i, v in p4 do
        if p3[i] == nil then
            p3[i] = v;
        end;
    end;

    return p3;
end;

local u5 = table.create(10000);
local u6 = table.create(10000);
local u7 = false;
local u8 = coroutine.create(function() -- Line: 54
    -- upvalues: u5 (copy), u6 (copy), u7 (ref)
    while true do
        workspace:BulkMoveTo(u5, u6, Enum.BulkMoveMode.FireCFrameChanged);
        table.clear(u5);
        table.clear(u6);
        u7 = false;
        coroutine.yield();
    end;
end);

function u2.new(p9, p10, p11) -- Line: 67
    -- upvalues: u2 (copy)
    local u12 = setmetatable({}, u2);
    u12.ref = p9;
    u12.parent = p10;
    u12.amount = 0;
    u12.restore_amount = 0;
    local v13 = p11 or {};

    for i, v in {
        size = 100,
        excess_lifetime = 30
    } do
        if v13[i] == nil then
            v13[i] = v;
        end;
    end;

    u12.params = v13;
    u12.scope = { p9, p10 };
    u12.unused = table.create(u12.params.size);
    u12.item_map = {};
    u12.part_mode = p9:IsA("BasePart");

    for _ = 1, u12.params.size do
        u12:_add();
    end;

    table.insert(u12.scope, task.spawn(function() -- Line: 93
        -- upvalues: u12 (copy)
        while true do
            repeat
                if not task.wait(15) then
                    return;
                end;

                if u12.restore_amount > 0 then
                    for _ = 1, u12.restore_amount do
                        u12:_add();
                        local v14 = u12;
                        v14.restore_amount = v14.restore_amount - 1;
                    end;
                end;
            until u12.amount > u12.params.size;

            local v15 = 0;

            for i = 1, #u12.unused do
                if u12.amount <= u12.params.size then
                    break;
                end;

                local v16 = i - v15;
                local v17 = u12.unused[v16];

                if v17.dependents == 0 and os.clock() - v17.added <= u12.params.excess_lifetime then
                    v17:destroy();
                    table.remove(u12.unused, v16);
                    u12.item_map[v17.key] = nil;
                    local v18 = u12;
                    v18.amount = v18.amount - 1;
                    v15 = v15 + 1;
                end;
            end;
        end;
    end));

    return u12;
end;

function u2._add(u19, p20, p21) -- Line: 137
    local u22 = u19.ref:Clone();
    u22.Archivable = false;
    u22.Parent = u19.parent;
    local u23 = {
        dependents = 1,
        key = p20,
        value = u22,
        added = os.clock()
    };
    local u24 = false;

    function u23.destroy(p25) -- Line: 152
        -- upvalues: u24 (ref), u22 (copy)
        u24 = true;
        u22:Destroy();
    end;

    u19.amount = u19.amount + 1;
    u22.Destroying:Connect(function() -- Line: 159
        -- upvalues: u24 (ref), u19 (copy), u23 (copy)
        if u24 then
            return;
        end;

        local v26 = table.find(u19.unused, u23);

        if v26 then
            table.remove(u19.unused, v26);
        end;

        if u23.key then
            u19.item_map[u23.key] = nil;
        end;

        local v27 = u19;
        v27.amount = v27.amount - 1;
        local v28 = u19;
        v28.restore_amount = v28.restore_amount + 1;
    end);

    if p20 then
        u19.item_map[p20] = u23;
    end;

    if not p21 then
        table.insert(u19.unused, u23);
    end;

    return u23;
end;

function u2.has(p29, p30) -- Line: 189
    return p29.item_map[p30] and true or false;
end;

function u2.peek(p31, p32) -- Line: 193
    return p31.item_map[p32];
end;

function u2.get(p33, p34) -- Line: 197
    -- upvalues: u5 (copy), u6 (copy), u7 (ref), u8 (copy)
    if p33:has(p34) then
        local v35 = p33:peek(p34);

        if v35 then
            v35.dependents = v35.dependents + 1;
        end;

        return v35.value;
    end;

    local u36 = table.remove(p33.unused);

    if u36 then
        u36.key = p34;
        u36.added = os.clock();
        p33.item_map[p34] = u36;
    else
        u36 = p33:_add(p34, true);
    end;

    if p33.part_mode then
        return setmetatable({
            _getReal = function() -- Line: 249, Name: _getReal
                -- upvalues: u36 (ref)
                return u36.value;
            end
        }, {
            __newindex = function(p37, p38, p39) -- Line: 222, Name: __newindex
                -- upvalues: u5 (ref), u36 (ref), u6 (ref), u7 (ref), u8 (ref)
                if p38 == "CFrame" then
                    table.insert(u5, u36.value);
                    table.insert(u6, p39);

                    if not u7 then
                        u7 = true;
                        task.defer(u8);
                    end;
                else
                    u36.value[p38] = p39;
                end;
            end,

            __index = function(p40, p41) -- Line: 236, Name: __index
                -- upvalues: u36 (ref)
                local u42 = u36.value[p41];

                return typeof(u42) == "function" and function(p43, ...) -- Line: 240
                    -- upvalues: u42 (copy), u36 (ref)
                    return u42(u36.value, ...);
                end or u42;
            end
        });
    end;

    return u36.value;
end;

function u2.free(p44, p45) -- Line: 258
    local v46 = p44.item_map[p45];

    if not v46 then
        return;
    end;

    v46.dependents = math.max(v46.dependents - 1, 0);

    if v46.dependents == 0 then
        v46.added = os.clock();

        if p44.params.on_free then
            p44.params.on_free(v46);
        end;

        table.insert(p44.unused, v46);
    end;
end;

function u2.destroy(p47) -- Line: 278
    -- upvalues: u1 (copy)
    u1.cleanupScope(p47.scope);

    for _, v in p47.item_map do
        v.value:Destroy();
    end;

    table.clear(p47.unused);
    table.clear(p47.item_map);
end;

return u2;
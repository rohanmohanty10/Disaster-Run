  

 

local u1 = {};
u1.__index = u1;

function u1.new() -- Line: 22
    -- upvalues: u1 (copy)
    return setmetatable({
        Comparator = nil,
        PriorityFn = nil,
        Query = "",
        ItemsById = {},
        ViewIds = {},
        IndexOf = {},
        Filters = {},
        _Listeners = {}
    }, u1);
end;

function u1.GetCount(p2) -- Line: 37
    return #p2.ViewIds;
end;

function u1.GetIdAt(p3, p4) -- Line: 41
    return p3.ViewIds[p4];
end;

function u1.GetItem(p5, p6) -- Line: 45
    return p5.ItemsById[p6];
end;

function u1.IndexOfId(p7, p8) -- Line: 49
    return p7.IndexOf[p8];
end;

function u1.SetItems(p9, p10) -- Line: 55
    p9.ItemsById = {};

    for _, v in p10 do
        v._lcName = v._lcName or string.lower(v.Name or "");
        v._lcTags = v._lcTags or string.lower(table.concat(v.Tags or {}, " "));

        if p9.PriorityFn then
            v._SortPriority = p9.PriorityFn(v);
        end;

        p9.ItemsById[v.Identifier] = v;
    end;

    p9:Compile();
end;

function u1.RemoveByIndex(p11, p12) -- Line: 72
    local v13 = p11:GetIdAt(p12);

    if not v13 then
        return;
    end;

    p11.ItemsById[v13] = nil;
    p11:Compile();
end;

function u1.SetSearch(p14, p15) -- Line: 80
    p14.Query = string.lower(p15 or "");
    p14:Compile();
end;

function u1.SetFilters(p16, p17) -- Line: 85
    p16.Filters = p17 or {};
    p16:Compile();
end;

function u1.SetPriorityFn(p18, p19) -- Line: 91
    p18.PriorityFn = p19;

    for _, v in p18.ItemsById do
        v._SortPriority = p19(v);
    end;
end;

function u1.SetSort(p20, p21) -- Line: 99
    p20.Comparator = p21;
    p20:Compile();
end;

function u1.Subscribe(u22, u23) -- Line: 104
    table.insert(u22._Listeners, u23);

    return function() -- Line: 106
        -- upvalues: u22 (copy), u23 (copy)
        for i, v in ipairs(u22._Listeners) do
            if v == u23 then
                table.remove(u22._Listeners, i);

                return;
            end;
        end;
    end;
end;

function u1.Compile(u24) -- Line: 111
    local Query = u24.Query;
    local Filters = u24.Filters;
    local v25 = {};

    for i, v in u24.ItemsById do
        local v26 = true;

        for _, v2 in Filters do
            if not v2(v) then
                v26 = false;
                break;
            end;
        end;

        if v26 and (Query == "" or v._lcName and v._lcName:find(Query, 1, true) or v._lcTags and v._lcTags:find(Query, 1, true)) then
            table.insert(v25, i);
        end;
    end;

    if u24.Comparator then
        table.sort(v25, function(p27, p28) -- Line: 125
            -- upvalues: u24 (copy)
            return u24.Comparator(u24.ItemsById[p27], u24.ItemsById[p28]);
        end);
    end;

    u24.ViewIds = v25;
    u24.IndexOf = {};

    for i, v in v25 do
        u24.IndexOf[v] = i;
    end;

    for _, v in u24._Listeners do
        v("rebuild");
    end;
end;

return u1;
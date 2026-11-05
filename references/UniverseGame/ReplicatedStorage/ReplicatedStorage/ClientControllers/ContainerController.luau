  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Signal = require(PathShortcuts.KnitPath.Signal);
local u1 = Knit.CreateController({
    Name = "ContainerController",
    Containers = {}
});
u1.__index = u1;

function u1.new(p2) -- Line: 13
    -- upvalues: Signal (copy), u1 (copy)
    local v3 = {
        Items = {},
        Signal = Signal.new()
    };

    if type(p2) == "table" then
        for i, v in pairs(p2) do
            v3.Items[i] = v;
        end;
    end;

    setmetatable(v3, u1);

    return v3;
end;

function u1.AddContainer(p4, p5, p6) -- Line: 28
    -- upvalues: u1 (copy)
    if type(p6) ~= "table" then
        warn(debug.traceback("Invalid container given"));

        return;
    end;

    if not (rawget(p6, "__Key") or rawget(p6, "__Name")) then
        p6.__Key = p4;
        p6.__Name = p5;

        if not u1.Containers[p4] then
            u1.Containers[p4] = {};
        end;

        u1.Containers[p4][p5] = p6;

        return p6;
    end;

    warn(debug.traceback("Container already has a key or name"));
end;

function u1.GetContainer(p7, p8) -- Line: 47
    -- upvalues: u1 (copy)
    return u1.Containers[p7] and u1.Containers[p7][p8];
end;

function u1.RemoveContainer(p9, p10) -- Line: 51
    -- upvalues: u1 (copy)
    if u1.Containers[p9] and u1.Containers[p9][p10] then
        u1.Containers[p9][p10] = nil;
    end;
end;

function u1.RemoveContainers(p11) -- Line: 57
    -- upvalues: u1 (copy)
    if u1.Containers[p11] then
        table.clear(u1.Containers[p11]);
        u1.Containers[p11] = nil;
    end;
end;

function u1.GetSignal(p12) -- Line: 65
    return p12.Signal;
end;

function u1.Get(p13, p14) -- Line: 69
    return p13.Items[p14];
end;

function u1.GetAll(p15) -- Line: 73
    return p15.Items;
end;

function u1.Add(p16, p17, p18) -- Line: 77
    if p16.Items[p17] then
        warn(debug.traceback(p17 .. " already exists inside container"));

        return;
    end;

    p16.Items[p17] = p18;
    p16.Signal:Fire("ItemAdded", {
        Name = p17,
        Object = p18
    });
end;

function u1.Remove(p19, p20) -- Line: 89
    if p19.Items[p20] then
        p19.Items[p20] = nil;
        p19.Signal:Fire("ItemRemoved", {
            Name = p20
        });
    end;
end;

function u1.RemoveAll(p21) -- Line: 98
    table.clear(p21.Items);
end;

function u1.Overwrite(p22, p23, p24) -- Line: 102
    if not p22.Items[p23] then
        warn(debug.traceback(p23 .. " doesn\'t exist inside container"));

        return;
    end;

    p22.Items[p23] = p24;
    p22.Signal:Fire("ItemOverwritten", {
        Name = p23,
        Object = p24
    });
end;

function u1.Destroy(p25) -- Line: 114
    -- upvalues: u1 (copy), PathShortcuts (copy)
    local v26 = rawget(p25, "__Key");
    local v27 = rawget(p25, "__Name");

    if v26 and (v27 and u1.Containers[v26][v27]) then
        u1.Containers[v26][v27] = nil;
    end;

    rawset(p25, "__Key", nil);
    rawset(p25, "__Name", nil);
    PathShortcuts.DestroyFunction(p25);
    table.clear(p25);
end;

function u1.KnitStart(p28) -- Line: 125
end;

return u1;
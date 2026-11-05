  

 

local u1 = {};
local LibraryManager = require(script:WaitForChild("LibraryManager"));

function u1.__index(u2, p3) -- Line: 4
    -- upvalues: u1 (copy)
    if p3 == "new" and rawget(u2, "Classes") then
        return function(...) -- Line: 7
            -- upvalues: u2 (copy)
            return u2:Class(...);
        end;
    end;

    if u1[p3] then
        return u1[p3];
    end;

    local v4 = rawget(u2, p3);

    if v4 then
        return v4;
    end;

    local v5 = rawget(u2, "Parent");

    if v5 then
        return rawget(v5, p3);
    end;

    local v6 = rawget(u2, "Directory");

    if v6 then
        return rawget(v6, p3);
    end;

    return rawget(u1, p3);
end;

function u1.__call(p7, ...) -- Line: 35
    return p7:Require(...);
end;

function u1.newRaw(p8) -- Line: 39
    -- upvalues: u1 (copy)
    local u9 = setmetatable({}, u1);
    u9.Parent = p8;
    u9.Libraries = setmetatable({}, {
        __index = function(p10, p11) -- Line: 44, Name: __index
            -- upvalues: u9 (copy)
            local v12 = rawget(p10, p11);

            if v12 then
                return v12;
            end;

            if u9.Linked_Libraries then
                for _, v in pairs(u9.Linked_Libraries) do
                    local v13 = rawget(v, p11);

                    if v13 then
                        return v13;
                    end;
                end;
            end;

            if u9.Parent and u9.Parent.Libraries then
                return u9.Parent.Libraries[p11];
            end;
        end
    });
    u9.Classes = setmetatable({}, {
        __index = function(p14, p15) -- Line: 65, Name: __index
            -- upvalues: u9 (copy)
            local v16 = rawget(p14, p15);

            if v16 then
                return v16;
            end;

            if u9.Linked_Classes then
                for _, v in pairs(u9.Linked_Classes) do
                    local v17 = rawget(v, p15);

                    if v17 then
                        return v17;
                    end;
                end;
            end;

            if u9.Parent and u9.Parent.Classes then
                return u9.Parent.Classes[p15];
            end;
        end
    });
    u9.Scopes = {};

    return u9;
end;

function u1.new(p18, p19) -- Line: 91
    -- upvalues: u1 (copy)
    local v20 = u1.newRaw(p19);
    v20.Name = p18;

    if p19 and p19.Scopes then
        p19.Scopes[p18] = v20;
    end;

    return v20;
end;

function u1.Require(p21, ...) -- Line: 100
    -- upvalues: LibraryManager (copy)
    return LibraryManager.Require(p21, ...);
end;

function u1.Class(p22, ...) -- Line: 104
    -- upvalues: LibraryManager (copy)
    return LibraryManager.Class(p22, ...);
end;

function u1.AddLibrary(p23, ...) -- Line: 108
    -- upvalues: LibraryManager (copy)
    return LibraryManager.AddLibrary(p23, ...);
end;

function u1.AddClass(p24, ...) -- Line: 112
    -- upvalues: LibraryManager (copy)
    return LibraryManager.AddClass(p24, ...);
end;

function u1.LinkLibraries(p25, p26) -- Line: 116
    if not p25.Linked_Libraries then
        p25.Linked_Libraries = {};
    end;

    if not table.find(p25.Linked_Libraries, p26.Libraries) then
        table.insert(p25.Linked_Libraries, p26.Libraries);
    end;
end;

function u1.LinkClasses(p27, p28) -- Line: 125
    if not p27.Linked_Classes then
        p27.Linked_Classes = {};
    end;

    if not table.find(p27.Linked_Classes, p28.Classes) then
        table.insert(p27.Linked_Classes, p28.Classes);
    end;
end;

function u1.Link(p29, p30) -- Line: 134
    p29:LinkLibraries(p30);
    p29:LinkClasses(p30);
end;

function u1.GetScope(p31, p32) -- Line: 139
    -- upvalues: u1 (copy)
    if not p31.Scopes[p32] then
        p31.Scopes[p32] = u1.new(p32, p31);
    end;

    return p31.Scopes[p32];
end;

function u1.WaitForScope(p33, p34, p35) -- Line: 147
    local v36 = os.clock();
    local v37 = false;

    while not p35 or v36 >= os.clock() + p35 do
        if os.clock() > v36 + 5 and not v37 then
            debug.traceback();
            warn("Infinite yield possible on Scope:WaitForScope(\"" .. p34 .. "\")");
            v37 = true;
        end;

        task.wait();

        if p33.Scopes[p34] then
            break;
        end;
    end;

    return p33.Scopes[p34];
end;

return u1;
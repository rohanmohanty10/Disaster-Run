  

 

local u1 = {};
u1.__index = u1;
local Core = require(game.ReplicatedStorage.ReplicatedRoot.Core);
local Trove = require(Core.ReplicatedLibraries.Classes.Trove);
local Promise = require(Core.ReplicatedLibraries.Classes.Promise);

function u1.new() -- Line: 9
    -- upvalues: u1 (copy), Trove (copy)
    local v2 = setmetatable({}, u1);
    v2.Collector = Trove.new();
    v2._Modules = {};
    v2._Started = false;

    return v2;
end;

function u1.Get(p3, p4) -- Line: 19
    return p3._Modules[p4];
end;

function u1.Add(u5, u6, p7) -- Line: 23
    -- upvalues: Promise (copy)
    local u8 = p7 or {};

    if not u8.Name then
        u8.Name = u6:GetAttribute("Name") or u6.Name;
    end;

    if not u6:IsA("ModuleScript") then
        for _, child in pairs(u6:GetChildren()) do
            u5:Add(child);
        end;

        return;
    end;

    local v11 = Promise.try(function() -- Line: 36
        -- upvalues: u8 (copy), u6 (copy), u5 (copy)
        local u9 = {
            Name = u8.Name,
            Module = u6
        };
        local v10 = require(u6);

        if typeof(v10) == "table" then
            u9.Init = v10.Init;
            u9.Start = v10.Start;
        elseif typeof(v10) == "function" then
            u9.Start = v10;
        end;

        u9.Collector = u5.Collector:Extend();
        u9.Collector:Add(function() -- Line: 50
            -- upvalues: u5 (ref), u9 (copy)
            if u5._Modules[u9.Name] == u9 then
                u5._Modules[u9.Name] = nil;
            end;
        end);

        if u9.Init then
            u9.Init(u5, u9);
        end;

        if typeof(v10) == "table" and v10.Modules then
            for _, v in ipairs(v10.Modules) do
                if v:IsA("ModuleScript") then
                    u5:Add(v, {
                        Name = u8.Name .. "_" .. v.Name
                    });
                else
                    u5:Add(v);
                end;
            end;
        end;

        if u9.Start and u5._Started then
            u9.Start(u5, u9);
        end;

        return u9;
    end):catch(warn):expect();

    if v11 then
        u5._Modules[v11.Name] = v11;
    end;
end;

function u1.Remove(p12, p13) -- Line: 86
    local v14 = p12:Get(p13);

    if v14 then
        v14.Collector:Destroy();
        p12._Modules[v14.Name] = nil;
    end;
end;

function u1.Start(p15) -- Line: 94
    if p15._Started then
        return;
    end;

    p15._Started = true;

    for _, v in pairs(p15._Modules) do
        if v.Start then
            v.Start(p15, v);
        end;
    end;
end;

function u1.Destroy(p16) -- Line: 108
    p16.Collector:Destroy();
    setmetatable(p16, nil);
end;

return u1;
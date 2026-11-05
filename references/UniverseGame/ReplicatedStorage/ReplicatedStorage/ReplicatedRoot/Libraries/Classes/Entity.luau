  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
local Core = require(ReplicatedRoot.Core);
local Trove = require(ReplicatedRoot.Libraries.Classes.Trove);
local Replica = require(ReplicatedRoot.Libraries.Networking.Replica);
local u1;

if Core.Context == "Server" then
    u1 = Replica.Token("Entity") or nil;
else
    u1 = nil;
end;

game:GetService("RunService");
local HttpService = game:GetService("HttpService");
local u2 = {};
u2.__index = u2;

function u2.new(p3) -- Line: 41
    -- upvalues: u2 (copy), HttpService (copy), Trove (copy)
    local v4 = p3 or {};
    local v5 = setmetatable({}, u2);
    v5._Classes = {};
    v5.Name = "Entity";
    v5.Id = v4.Id or HttpService:GenerateGUID(false);
    v5.Object = nil;
    v5.Collector = Trove.new();
    v5.Replica = v4.Replica;

    if v4 ~= nil then
        if typeof(v4.Name) == "string" then
            v5.Name = v4.Name;
        end;

        if typeof(v4.Object) == "Instance" then
            v5.Object = v4.Object;
        end;

        if typeof(v4.Classes) == "table" then
            for _, v in pairs(v4.Classes) do
                v5:_AddClass(v, v4);
            end;
        end;
    end;

    for _, v in pairs(v5._Classes) do
        if v.EntityInit then
            v.EntityInit(v5, v4);
        end;
    end;

    return v5;
end;

function u2._AddClass(u6, u7, u8) -- Line: 76
    -- upvalues: Core (copy), Replica (copy), u1 (copy)
    local v9 = nil;
    local v10 = "Unknown";

    if typeof(u7) == "Instance" and u7:IsA("ModuleScript") then
        local v11 = require(u7);
        v10 = u7.Name;
        u7 = v11;
    elseif typeof(u7) == "string" then
        local v12 = Core.Get(u7);

        if v12 == nil then
            u7 = v9;
        else
            u7 = require(v12);
            v10 = v12.Name;
        end;
    elseif typeof(u7) ~= "table" then
        u7 = v9;
    end;

    if u7 ~= nil then
        local v13 = u7.ClassName or v10;

        if u7.Replication ~= nil and Core.Context == "Server" and ((typeof(u7.IsReplicated) ~= "function" or u7.IsReplicated(u6, u8)) and u6.Replica == nil) then
            u6.Replica = Replica.New({
                Token = u1,
                Tags = {
                    Id = u6.Id,
                    Name = u6.Name,
                    Object = u6.Object,
                    Classes = u7.Replication.Classes or {}
                },
                Data = {}
            });
        end;

        if u7.ClassInit ~= nil then
            u7.ClassInit(u6, u8);
        end;

        if u7.EntityDestroyed ~= nil then
            u6.Collector:Add(function() -- Line: 121
                -- upvalues: u7 (ref), u6 (copy), u8 (copy)
                u7.EntityDestroyed(u6, u8);
            end);
        end;

        if v13 ~= nil then
            u6._Classes[v13] = u7;
        end;
    end;
end;

function u2.IsClass(p14, p15) -- Line: 132
    return p14._Classes[p15] ~= nil;
end;

function u2.Destroy(p16) -- Line: 136
    if table.isfrozen(p16) then
        return;
    end;

    p16.Collector:Destroy();
    table.clear(p16);
    table.freeze(p16);
end;

return u2;
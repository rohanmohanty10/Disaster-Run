  

 

local Core = require(game.ReplicatedStorage.ReplicatedRoot.Core);
local Comm = require(Core.ReplicatedLibraries.Classes.Comm);
local _ = Comm.ClientComm;
local Parent = script.Parent;

if not Parent:IsA("ModuleScript") then
    return;
end;

local u1 = require(Parent);
local v2 = u1.Name or Parent.Name;
local u3 = false;
local u4 = false;

function script.Function.OnInvoke(p5) -- Line: 17
    -- upvalues: u3 (ref), u1 (copy), u4 (ref)
    if p5 == "Init" and not u3 then
        u3 = true;

        return not u1._Init and true or u1._Init();
    end;

    if p5 == "Start" and not u4 then
        u4 = true;

        return not u1._Start and true or u1._Start();
    end;
end;

if not Core.ReplicatedEvents.Services:WaitForChild(v2, 5) then
    return;
end;

local v6 = u1.Middleware or {};
local Middleware = require(Core.ReplicatedRoot.Middleware);

if not v6.Inbound then
    local _ = Middleware.Inbound;
end;

if not v6.Outbound then
    local _ = Middleware.Outbound;
end;

u1.ClientComm = Comm.ClientComm.new(Core.ReplicatedEvents.Services, true, v2);
local v7 = u1.ClientComm:BuildObject(v6.Inbound, v6.Outbound);
Core.ClientServices[v2] = v7;

for i, v in pairs(v7) do
    u1[i] = v;
end;
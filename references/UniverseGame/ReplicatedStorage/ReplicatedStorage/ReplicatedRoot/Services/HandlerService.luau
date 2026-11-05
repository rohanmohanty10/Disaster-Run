  

 

local Core = require(game.ReplicatedStorage.ReplicatedRoot.Core);
local CommonUtil = require(Core.ReplicatedLibraries.Utility.CommonUtil);
local u1 = {
    Name = "HandlerService",
    Handlers = {}
};
local u2 = {
    Base = "Handlers/CoreHandler"
};

function u1.LoadHandler(p3, p4) -- Line: 13
    -- upvalues: u2 (copy), Core (copy), u1 (copy)
    local v5 = p4 or {};
    local v6 = typeof(v5) == "Instance" and {
        Modules = { v5 }
    } or v5;
    local v7 = v6.Name or (v6.HandlerObject and (v6.HandlerObject.Name or "Handler") or "Handler");
    local v8 = nil;
    local u9 = nil;

    if p3:IsA("Model") then
        u9 = p3;
    elseif p3:IsA("Tool") then
        if p3.Parent:IsA("Model") then
            u9 = p3.Parent;
        elseif p3.Parent:IsA("Backpack") then
            v8 = p3.Parent.Parent;
        end;
    end;

    if u9 and not v8 then
        v8 = game.Players:GetPlayerFromCharacter(u9);
    end;

    if v8 and not u9 then
        u9 = v8.Character;
    end;

    local u10 = {
        Server = {},
        Client = {},
        Shared = {}
    };

    local function Import(p11, p12) -- Line: 45
        -- upvalues: Import (copy), u10 (copy)
        local v13 = (not p12 or p12 == true) and {
            Server = true,
            Client = true,
            Shared = true
        } or p12;

        if p11.Import and v13.Import then
            for i, v in pairs(p11.Import) do
                Import(require(i), v);
            end;
        end;

        if p11.Server and v13.Server then
            local Server = u10.Server;
            local v14 = {};
            local v15;

            if p11.Name then
                v15 = string.format("%s_%s", p11.Name, p11.Server.Name);
            else
                v15 = p11.Server.Name;
            end;

            v14.Name = v15;
            v14.Module = p11.Server;
            table.insert(Server, v14);
        end;

        if p11.Client and v13.Client then
            local Client = u10.Client;
            local v16 = {};
            local v17;

            if p11.Name then
                v17 = string.format("%s_%s", p11.Name, p11.Client.Name);
            else
                v17 = p11.Client.Name;
            end;

            v16.Name = v17;
            v16.Module = p11.Client;
            table.insert(Client, v16);
        end;

        if p11.Shared and v13.Shared then
            local Shared = u10.Shared;
            local v18 = {};
            local v19;

            if p11.Name then
                v19 = string.format("%s_%s", p11.Name, p11.Shared.Name);
            else
                v19 = p11.Shared.Name;
            end;

            v18.Name = v19;
            v18.Module = p11.Shared;
            table.insert(Shared, v18);
        end;
    end;

    for _, v in pairs(v6.Modules) do
        local v20 = u2[v.Name];
        local v21;

        if v20 then
            v21 = Core.Get({
                Path = v20
            });

            if v21 == nil then
                v21 = v;
            end;
        else
            v21 = v;
        end;

        Import(require(v21), true);
    end;

    local v22 = u1.GetHandler(p3, v7);

    if not v22 then
        v22 = (v6.HandlerObject or script.HandlerObject):Clone();
        v22.Name = v7;
        v22.Archivable = false;
        v22.Parent = p3;
    end;

    local Server = v22:FindFirstChild("Server");
    local Client = v22:FindFirstChild("Client");

    if Server then
        Server.Disabled = false;
    end;

    if Client then
        Client.Disabled = false;
    end;

    local u23 = require(v22);

    for _, v in pairs(u10.Shared) do
        u23:Add(v.Module, {
            Name = v.Name
        });
        u23:AddClient(v.Module, {
            Name = v.Name
        });
    end;

    for _, v in pairs(u10.Server) do
        u23:Add(v.Module, {
            Name = v.Name
        });
    end;

    if v8 then
        for _, v in pairs(u10.Client) do
            u23:AddClient(v.Module, {
                Name = v.Name
            });
        end;
    end;

    u23:Start();
    task.defer(function() -- Line: 136
        -- upvalues: u23 (copy)
        if u23.InitClient then
            u23:InitClient();
        end;

        if u23.StartClient then
            u23:StartClient();
        end;
    end);
    u1.Handlers[u9] = u23;
    u23.Collector:Add(function() -- Line: 146
        -- upvalues: u1 (ref), u9 (ref)
        u1.Handlers[u9] = nil;
    end);

    return u23, v22;
end;

u1.Load = u1.LoadHandler;

function u1.GetHandler(p24, p25) -- Line: 154
    for _, child in pairs(p24:GetChildren()) do
        if child:IsA("ModuleScript") and child.Name == (p25 or "Handler") then
            return child;
        end;
    end;
end;

function u1.GetData(p26) -- Line: 162
    -- upvalues: u1 (copy)
    return u1.Handlers[p26];
end;

CommonUtil.WrapServiceMethods(u1);

return u1;
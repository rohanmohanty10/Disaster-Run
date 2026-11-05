  

 

local HttpService = game:GetService("HttpService");
local RunService = game:GetService("RunService");
local JointsService = game:GetService("JointsService");

if RunService:IsServer() then
    if _G.serverSockets == nil then
        _G.serverSockets = {};
    end;
elseif RunService:IsClient() and _G.clientSockets == nil then
    _G.clientSockets = {};
end;

local petalSocketEvents = JointsService:FindFirstChild("petalSocketEvents");

if petalSocketEvents == nil and RunService:IsServer() then
    petalSocketEvents = Instance.new("Folder");
    petalSocketEvents.Parent = JointsService;
    petalSocketEvents.Name = "petalSocketEvents";
    local RemoteEvent = Instance.new("RemoteEvent");
    RemoteEvent.Name = "_CoreRemote";
    RemoteEvent.Parent = petalSocketEvents;
    RemoteEvent.OnServerEvent:Connect(function(p1, p2, p3) -- Line: 33
        -- upvalues: petalSocketEvents (copy)
        if p2 == "CONNECT" then
            local RemoteEvent2 = Instance.new("RemoteEvent");
            RemoteEvent2.Name = tostring(p3);
            local ObjectValue = Instance.new("ObjectValue");
            ObjectValue.Name = "Owner";
            ObjectValue.Value = p1;
            ObjectValue.Parent = RemoteEvent2;
            RemoteEvent2.Parent = petalSocketEvents;
            RemoteEvent2:FireClient(p1, "connected");
        end;
    end);
end;

return function(p4) -- Line: 54
    -- upvalues: RunService (copy), HttpService (copy), petalSocketEvents (ref)
    local u5 = {};
    u5.__index = u5;
    p4("New");
    local u6, u7 = unpack(p4("Wrapper"));
    local u8 = RunService:IsServer() and "Server" or "Client";

    function u5.new() -- Line: 62
        -- upvalues: u5 (copy)
        return setmetatable({
            Event = "",
            Callbacks = {},
            Connections = {},
            connected_Sockets = {}
        }, u5);
    end;

    function u5.Listen(u9, p10) -- Line: 73
        -- upvalues: u8 (copy), HttpService (ref), petalSocketEvents (ref), u6 (copy), u7 (copy)
        if u8 ~= "Client" then
            local v26 = petalSocketEvents.ChildAdded:Connect(function(p11) -- Line: 109
                -- upvalues: u6 (ref), u9 (copy), u7 (ref)
                local u12 = u6(p11);
                u12.Id = tostring(u12.Name);
                u12.Player = u12.Owner.Value;
                u12.Callbacks = {};
                u12.Connections = {};

                function u12.Disconnect(p13, p14) -- Line: 115
                    -- upvalues: u12 (copy), u9 (ref), u7 (ref)
                    u12:Broadcast("disconnected");

                    for i = 1, #u12.Connections do
                        u12.Connections[i]:Disconnect();
                    end;

                    if u9.connected_Sockets[u12.Id] then
                        u9.connected_Sockets[u12.Id] = nil;
                    end;

                    table.clear(u12.Connections);
                    table.clear(u12.Callbacks);
                    u7(u12):Destroy();
                end;

                function u12.Broadcast(p15, p16, p17, ...) -- Line: 128
                    -- upvalues: u12 (copy)
                    u12:FireClient(u12.Player, p17, { ... });
                end;

                function u12.On(p18, p19, p20, p21) -- Line: 131
                    -- upvalues: u12 (copy)
                    if u12.Callbacks[p20] == nil then
                        u12.Callbacks[p20] = p21;
                    end;
                end;

                local v25 = u12.OnServerEvent:Connect(function(p22, p23) -- Line: 136
                    -- upvalues: u12 (copy)
                    local v24 = p23[1];

                    if u12.Callbacks[v24] then
                        u12.Callbacks[v24](select(2, unpack(p23)));
                    end;
                end);

                if u9.connected_Sockets[u12.Id] == nil then
                    u9.connected_Sockets[u12.Id] = u12;
                else
                    warn("Socket/ID:", u12.Id, "already connected.");
                end;

                u9.Callbacks.connection(u12);
                table.insert(u12.Connections, v25);
            end);
            local v29 = petalSocketEvents.ChildRemoved:Connect(function(p27) -- Line: 150
                -- upvalues: u6 (ref), u9 (copy)
                local v28 = u6(p27);
                v28.Id = tostring(v28.Name);
                v28.Player = v28.Owner.Value;
                v28.Callbacks = {};
                v28.Connections = {};
                u9.Callbacks.disconnected(v28);
            end);
            table.insert(u9.Connections, v26);
            table.insert(u9.Connections, v29);

            return u9;
        end;

        local v30 = HttpService:GenerateGUID(false);
        petalSocketEvents._CoreRemote:FireServer("CONNECT", v30);
        local v31 = petalSocketEvents:WaitForChild(v30);
        local u32 = u6(v31);
        u9.Event = u32;

        function u32.Broadcast(p33, p34, ...) -- Line: 82
            -- upvalues: u9 (copy)
            u9.Event:FireServer({ p34, ... });
        end;

        function u32.Disconnect(p35) -- Line: 85
            -- upvalues: u9 (copy), u7 (ref), u32 (copy)
            for i = 1, #u9.Connections do
                u9.Connections[i]:Disconnect();
            end;

            table.clear(u9.Connections);
            table.clear(u9.Callbacks);
            u7(u32):Destroy();
        end;

        local v38 = v31.OnClientEvent:Connect(function(...) -- Line: 95
            -- upvalues: u9 (copy)
            local v36 = ({ ... })[1];

            if u9.Callbacks[v36] then
                local v37 = select(2, ...);

                if v37 ~= nil then
                    u9.Callbacks[v36](unpack(v37));

                    return;
                end;

                u9.Callbacks[v36]();
            end;
        end);
        table.insert(u9.Connections, v38);

        return u9;
    end;

    function u5.On(p39, p40, p41) -- Line: 167
        if p39.Callbacks[p40] == nil then
            p39.Callbacks[p40] = p41;
        end;
    end;

    function u5.Broadcast(p42, p43, ...) -- Line: 173
        -- upvalues: u8 (copy)
        if u8 == "Client" then
            p42.Event.Broadcast(p43, ...);

            return;
        end;

        for _, v in pairs(p42.connected_Sockets) do
            v:Broadcast(p43, ...);
        end;
    end;

    function u5.Disconnect(p44) -- Line: 183
        -- upvalues: u8 (copy), u7 (copy)
        for i = 1, #p44.Connections do
            p44.Connections[i]:Disconnect();
        end;

        if u8 == "Server" then
            for _, v in pairs(p44.connected_Sockets) do
                v:Disconnect();
            end;
        end;

        table.clear(p44.Connections);
        table.clear(p44.Callbacks);
        u7(p44.Event):Destroy();
    end;

    return u5;
end;
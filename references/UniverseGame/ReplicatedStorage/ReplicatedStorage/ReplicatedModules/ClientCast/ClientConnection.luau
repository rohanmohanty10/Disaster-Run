  

 

return function() -- Line: 1
    local StarterPlayer = game:GetService("StarterPlayer");
    local ReplicatedStorage = game:GetService("ReplicatedStorage");
    local Players = game:GetService("Players");

    local function InitRemote(p1, p2) -- Line: 6
        -- upvalues: ReplicatedStorage (copy)
        local v3 = Instance.new(p1);
        v3.Name = "ClientCast-" .. p2;
        v3.Parent = ReplicatedStorage;
    end;

    local RemoteEvent = Instance.new("RemoteEvent");
    RemoteEvent.Name = "ClientCast-Replication";
    RemoteEvent.Parent = ReplicatedStorage;
    local RemoteFunction = Instance.new("RemoteFunction");
    RemoteFunction.Name = "ClientCast-Ping";
    RemoteFunction.Parent = ReplicatedStorage;
    local Parent = script.Parent;
    local ClientHandler = Parent.ClientHandler;

    local function CloneHandler(p4) -- Line: 17
        -- upvalues: ClientHandler (copy), Parent (copy)
        local v5 = ClientHandler:Clone();
        Parent.Signal:Clone().Parent = v5;
        v5.Parent = p4;
    end;

    local v6 = StarterPlayer:FindFirstChildOfClass("StarterPlayerScripts");
    local v7 = ClientHandler:Clone();
    Parent.Signal:Clone().Parent = v7;
    v7.Parent = v6;
    local v8 = next;
    local v9, v10 = Players:GetPlayers();

    for _, v in v8, v9, v10 do
        local v11 = v:FindFirstChildOfClass("PlayerGui");
        local v12 = ClientHandler:Clone();
        Parent.Signal:Clone().Parent = v12;
        v12.Parent = v11;
    end;
end;
  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
local v1 = game:GetService("RunService"):IsServer() and game.ServerStorage.ServerRoot or nil;
local Core = require(ReplicatedRoot.Core);
require(ReplicatedRoot.Libraries.Classes.Comm);
require(ReplicatedRoot.Libraries.Classes.Promise);
require(ReplicatedRoot.Libraries.Utility.DirectoryUtil);
local u2 = {};

local function AddService(p3) -- Line: 13
    -- upvalues: u2 (copy), Core (copy)
    require(p3);

    if u2[p3.Name] then
        return;
    end;

    u2[p3.Name] = p3;
    local v4 = script.Executors[Core.Context .. "Executor"]:Clone();
    v4.Enabled = true;
    v4.Parent = p3;
end;

local function AddServices(p5) -- Line: 27
    -- upvalues: u2 (copy), Core (copy), AddServices (copy)
    for _, child in pairs(p5:GetChildren()) do
        if child:IsA("ModuleScript") then
            require(child);

            if not u2[child.Name] then
                u2[child.Name] = child;
                local v6 = script.Executors[Core.Context .. "Executor"]:Clone();
                v6.Enabled = true;
                v6.Parent = child;
            end;
        elseif child:IsA("Folder") then
            AddServices(child);
        end;
    end;
end;

if Core.Context == "Client" then
    local function GetClientService(p7) -- Line: 37
        -- upvalues: ReplicatedRoot (copy)
        local _ = ReplicatedRoot.Events.Services[p7];
        local v8 = ReplicatedRoot.Services:FindFirstChild(p7, true);

        if v8 then
            require(v8);
        end;

        if not v8 then
            v8 = script.ClientService:Clone();
            v8.Name = p7;
            v8.Parent = ReplicatedRoot.Services;
            require(v8).Name = p7;
        end;

        return v8;
    end;

    while not Core.Script:GetAttribute("ClientReady") do
        task.wait();
    end;

    for _, child in pairs(ReplicatedRoot.Events.Services:GetChildren()) do
        GetClientService(child.Name);
    end;
end;

if v1 ~= nil then
    AddServices(v1.Services);
end;

AddServices(ReplicatedRoot.Services);
task.defer(function() -- Line: 68
    -- upvalues: Core (copy)
    if Core.Context == "Server" then
        Core.Script:SetAttribute("ClientReady", true);
    end;
end);
require(Core.LegacyPath.KnitPath.Knit).OnStart():await();

for _, v in pairs(u2) do
    v[Core.Context .. "Executor"].Function:Invoke("Init");
end;

for _, v in pairs(u2) do
    task.spawn(function() -- Line: 83
        -- upvalues: v (copy), Core (copy)
        v[Core.Context .. "Executor"].Function:Invoke("Start");
    end);
end;

Core.Start();

return true;
  

 

local RunService = game:GetService("RunService");
local Remotes = game:GetService("ReplicatedStorage"):WaitForChild("Remotes");
local Promise = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("KnitPackage"):WaitForChild("Promise"));
local Compatibility = require(game.ReplicatedStorage:WaitForChild("ReplicatedRoot").Core.Compatibility);
local u1 = {};
local u2 = {};

function u2.CreateMiddleware(p3, p4) -- Line: 11
    -- upvalues: u2 (copy)
    local v5 = {
        Name = p3,
        RemoteFunctions = {},
        RemoteEvents = {},
        CreatedRemotes = {}
    };

    for i, v in pairs(p4 or {}) do
        v5[i] = v;
    end;

    for i, v in pairs(u2) do
        v5[i] = v;
    end;

    return v5;
end;

function u2.GetMiddleware(p6, p7) -- Line: 30
    -- upvalues: Compatibility (copy), u1 (copy), RunService (copy), Remotes (copy), Promise (copy), u2 (copy)
    if Compatibility.Middleware.Services[p6] then
        return require(Compatibility.Middleware.Services[p6]);
    end;

    if Compatibility.Middleware.Controllers[p6] then
        return require(Compatibility.Middleware.Controllers[p6]);
    end;

    if u1[p6] then
        return u1[p6];
    end;

    if RunService:IsClient() then
        local v8 = Remotes:WaitForChild(p6);
        local v9 = {
            CreatedRemotes = {}
        };

        for _, child in ipairs(v8:GetChildren()) do
            v9.CreatedRemotes[child.Name] = child;

            if child:IsA("BaseRemoteEvent") then
                v9[child.Name] = function(...) -- Line: 50
                    -- upvalues: child (copy)
                    child:FireServer(...);
                end;
            elseif child:IsA("RemoteFunction") then
                v9[child.Name] = function(...) -- Line: 54
                    -- upvalues: Promise (ref), child (copy)
                    return Promise.try(child.InvokeServer, child, ...);
                end;
            end;
        end;

        v9.GetRemote = u2.GetRemote;
        u1[p6] = v9;

        return v9;
    end;

    local v10 = os.clock();
    local v11 = 0;
    local v12 = false;

    while not u1[p6] and p7 ~= 0 do
        v11 = v11 + task.wait(0.1);

        if p7 and p7 <= os.clock() - v10 then
            break;
        end;

        if not v12 and v11 >= 10 then
            warn(string.format("Infinite yield possible on GetMiddleware(\"%s\")\n%s", p6, debug.traceback()));
            v12 = true;
        end;
    end;

    return u1[p6];
end;

function u2.GetMiddlewares() -- Line: 84
    -- upvalues: u1 (copy)
    return u1;
end;

function u2.CreateRemoteEvent(p13, p14) -- Line: 88
    local RemoteEvent = Instance.new("RemoteEvent");
    RemoteEvent.Name = p14;
    p13.CreatedRemotes[p14] = RemoteEvent;
end;

function u2.CreateRemoteFunction(p15, p16) -- Line: 94
    local RemoteFunction = Instance.new("RemoteFunction");
    RemoteFunction.Name = p16;
    p15.CreatedRemotes[p16] = RemoteFunction;
end;

function u2.GetRemote(p17, p18) -- Line: 100
    return p17.CreatedRemotes[p18];
end;

function u2.Init(u19) -- Line: 104
    -- upvalues: RunService (copy), Remotes (copy), u1 (copy)
    if not RunService:IsServer() then
        return;
    end;

    if u19.Inited then
        warn(u19.Name, "already initialized");

        return;
    end;

    if Remotes:FindFirstChild(u19.Name) then
        warn(u19.Name, "already found");

        return;
    end;

    u19.Inited = true;
    local Folder = Instance.new("Folder");
    Folder.Name = u19.Name;

    for _, v in pairs(u19.CreatedRemotes) do
        v.Parent = Folder;
    end;

    local function CreateRemotes(p20, p21) -- Line: 117
        -- upvalues: Folder (copy), u19 (copy)
        for i, v in pairs(p21) do
            local v22 = Instance.new(p20);
            v22.Name = i;
            v22.Parent = Folder;
            u19.CreatedRemotes[i] = v22;

            if type(v) == "function" then
                if p20 == "RemoteEvent" or p20 == "UnreliableRemoteEvent" then
                    v22.OnServerEvent:Connect(v);
                elseif p20 == "RemoteFunction" then
                    v22.OnServerInvoke = v;
                end;
            end;
        end;
    end;

    CreateRemotes("RemoteFunction", u19.RemoteFunctions);
    CreateRemotes("RemoteEvent", u19.RemoteEvents);

    if u19.OnInit then
        u19:OnInit();
    end;

    u1[u19.Name] = u19;
    Folder.Parent = Remotes;
end;

return u2;
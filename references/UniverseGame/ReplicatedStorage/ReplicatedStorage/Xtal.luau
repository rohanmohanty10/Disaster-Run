  

 

script:WaitForChild("Classes");
script:WaitForChild("Core");
script:WaitForChild("Libraries");
script:WaitForChild("Headers");
local Xtal = require(script.Classes:WaitForChild("Scope")).new("Xtal");
Xtal:AddLibrary(script.Libraries);
Xtal:AddClass(script.Classes);
local u1 = workspace:GetAttribute("Persistent") or false;

local function GetExtension(p2) -- Line: 29
    if typeof(p2) == "Instance" then
        p2 = p2.Name;
    end;

    if type(p2) ~= "string" or not p2:find(".", nil, true) then
        return;
    end;

    local v3 = p2:split(".");

    if v3 then
        local v4 = v3[#v3];

        if v4 then
            return v4, string.sub(p2, 0, #p2 - #v4 - 1);
        end;

        return p2;
    end;
end;

local u5 = {};

local function GetContainer(p6) -- Line: 49
    -- upvalues: u5 (copy)
    if not u5[p6] then
        local Folder = Instance.new("Folder");
        Folder.Name = "_xtal";
        Folder.Parent = p6;
        Folder.Archivable = false;
        u5[p6] = Folder;
    end;

    return u5[p6];
end;

local u7 = Xtal("Thread");

local function LoadAsset(p8) -- Line: 62
    if game:GetService("RunService"):IsStudio() then
        return game:GetService("InsertService"):LoadAsset(p8);
    end;

    return game:GetService("InsertService"):LoadAssetVersion(game:GetService("InsertService"):GetLatestAssetVersionAsync(p8));
end;

local function Compile(p9, p10) -- Line: 70
    -- upvalues: GetExtension (copy), GetContainer (copy), u1 (copy)
    if not typeof(p9) == "Instance" then
        return;
    end;

    if game:GetService("RunService"):IsClient() then
        return;
    end;

    if p9:FindFirstChild("_Compiled") then
        return;
    end;

    local v11, v12 = GetExtension(p9);
    local v13 = v12 or p9.Name;
    local v14 = p9:GetAttribute("Scope") or (v12 or p9.Name);

    if v11 ~= "xtal" and not p10 then
        return;
    end;

    local Client = p9:FindFirstChild("Client");
    local Server = p9:FindFirstChild("Server");
    local Shared = p9:FindFirstChild("Shared");

    if not (Client or (Server or Shared)) then
        return;
    end;

    if not script.Headers:FindFirstChild(v13) then
        local Configuration = Instance.new("Configuration");
        Configuration.Name = v13;
        Configuration:SetAttribute("Scope", p9:GetAttribute("Scope") or nil);
        Configuration.Archivable = false;
        local Dependencies = p9:FindFirstChild("Dependencies");

        if Dependencies then
            Dependencies:Clone().Parent = Configuration;
        end;

        local v15 = GetContainer(game.ReplicatedStorage):FindFirstChild(v14 .. "_Client");
        local v16 = GetContainer(game.ServerStorage):FindFirstChild(v14 .. "_Server");
        local v17 = GetContainer(game.ServerScriptService):FindFirstChild(v14 .. "_Scripts");
        local v18 = GetContainer(game.ReplicatedStorage):FindFirstChild(v14 .. "_Shared");

        if Client then
            if u1 then
                Client = Client:Clone();
            end;

            if not v15 then
                v15 = Instance.new("Folder");
                v15.Name = v14 .. "_Client";
                v15.Parent = GetContainer(game.ReplicatedStorage);
                v15.Archivable = false;
            end;

            for _, child in pairs(Client:GetChildren()) do
                local v19 = v15:FindFirstChild(child.Name);

                if v19 then
                    for _, child2 in pairs(child:GetChildren()) do
                        child2.Parent = v19;
                    end;

                    child.Parent = nil;
                else
                    child.Parent = v15;
                end;
            end;

            local ObjectValue = Instance.new("ObjectValue");
            ObjectValue.Name = "Client";
            ObjectValue.Value = v15;
            ObjectValue.Parent = Configuration;
        end;

        if Server then
            if u1 then
                Server = Server:Clone();
            end;

            if not v16 then
                v16 = Instance.new("Folder");
                v16.Name = v14 .. "_Server";
                v16.Parent = GetContainer(game.ServerStorage);
                v16.Archivable = false;
            end;

            if not v17 then
                v17 = Instance.new("Folder");
                v17.Name = v14 .. "_Scripts";
                v17.Parent = GetContainer(game.ServerScriptService);
                v17.Archivable = false;
            end;

            for _, child in pairs(Server:GetChildren()) do
                if child:IsA("Configuration") or child:IsA("Script") then
                    local v20 = v17:FindFirstChild(child.Name);

                    if v20 then
                        for _, child2 in pairs(child:GetChildren()) do
                            child2.Parent = v20;
                        end;

                        child.Parent = nil;
                    else
                        child.Parent = v17;
                    end;
                else
                    local v21 = v16:FindFirstChild(child.Name);

                    if v21 then
                        for _, child2 in pairs(child:GetChildren()) do
                            child2.Parent = v21;
                        end;

                        child.Parent = nil;
                    else
                        child.Parent = v16;
                    end;
                end;
            end;

            local ObjectValue = Instance.new("ObjectValue");
            ObjectValue.Name = "Server";
            ObjectValue.Value = v16;
            ObjectValue.Parent = Configuration;
            local ObjectValue2 = Instance.new("ObjectValue");
            ObjectValue2.Name = "Scripts";
            ObjectValue2.Value = v17;
            ObjectValue2.Parent = Configuration;
        end;

        if Shared then
            if u1 then
                Shared = Shared:Clone();
            end;

            if not v18 then
                v18 = Instance.new("Folder");
                v18.Name = v14 .. "_Shared";
                v18.Parent = GetContainer(game.ReplicatedStorage);
                v18.Archivable = false;
            end;

            for _, child in pairs(Shared:GetChildren()) do
                local v22 = v18:FindFirstChild(child.Name);

                if v22 then
                    for _, child2 in pairs(child:GetChildren()) do
                        child2.Parent = v22;
                    end;

                    child.Parent = nil;
                else
                    child.Parent = v18;
                end;
            end;

            local ObjectValue = Instance.new("ObjectValue");
            ObjectValue.Name = "Shared";
            ObjectValue.Value = v18;
            ObjectValue.Parent = Configuration;
        end;

        local BoolValue = Instance.new("BoolValue");
        BoolValue.Name = "_Compiled";
        BoolValue.Parent = p9;
        BoolValue.Archivable = false;
        Configuration.Parent = script.Headers;

        return {
            Header = Configuration,
            Client = v15,
            Server = v16,
            Scripts = v17,
            Server_Scripts = v17,
            Shared = v18
        };
    end;
end;

local function ActivateHeader(p23) -- Line: 267
    -- upvalues: Xtal (copy), GetExtension (copy)
    if typeof(p23) ~= "Instance" then
        return;
    end;

    if not p23:IsDescendantOf(script.Headers) then
        return;
    end;

    if p23:GetAttribute("Client") and game:GetService("RunService"):IsClient() then
        return;
    end;

    if p23:GetAttribute("Server") and game:GetService("RunService"):IsServer() then
        return;
    end;

    local u24 = Xtal:GetScope(p23:GetAttribute("Scope") or p23.Name);
    local v25 = nil;
    local v26 = nil;
    local v27 = nil;
    local v28 = nil;

    if game:GetService("RunService"):IsClient() then
        local v29 = os.clock() + 10;

        repeat
            task.wait();
        until p23:FindFirstChildWhichIsA("Instance") or v29 <= os.clock();
    end;

    local Dependencies = p23:FindFirstChild("Dependencies");

    if Dependencies then
        local v30 = require(Dependencies);

        for _, v in pairs(v30) do
            local v31 = 0;

            while not false do
                local v32 = script.Headers:FindFirstChild(v);

                if v32 and (game:GetService("RunService"):IsServer() and v32:GetAttribute("Server") or game:GetService("RunService"):IsClient() and v32:GetAttribute("Client")) then
                    Xtal:WaitForPackage(v32:GetAttribute("Scope") or v32.Name);
                    break;
                end;

                v31 = v31 + 1;

                if v31 >= 30 then
                    return;
                end;

                task.wait(1);
            end;
        end;
    end;

    local Client = p23:FindFirstChild("Client");
    local Server = p23:FindFirstChild("Server");
    local Scripts = p23:FindFirstChild("Scripts");
    local Shared = p23:FindFirstChild("Shared");

    if Client then
        v25 = Client.Value;
    end;

    if Server then
        v26 = Server.Value;
    end;

    if Scripts then
        v27 = Scripts.Value;
    end;

    if Shared then
        v28 = Shared.Value;
    end;

    if v28 then
        u24.Shared = v28;
    end;

    if v25 then
        u24.Client = v25;
    end;

    if v26 or v27 then
        if v26 then
            u24.ServerStorage = v26;
        end;

        if v27 then
            u24.ServerScripts = v27;
        end;

        u24.Server = setmetatable({}, {
            __index = function(p33, p34) -- Line: 355, Name: __index
                -- upvalues: u24 (copy)
                if not rawget(p33, p34) then
                    local v35 = u24.ServerStorage and u24.ServerStorage:FindFirstChild(p34) or u24.ServerScripts and u24.ServerScripts:FindFirstChild(p34);

                    if v35 then
                        rawset(p33, p34, v35);

                        return v35;
                    end;
                end;

                return rawget(p33, p34);
            end
        });

        for _, child in pairs(v26:GetChildren()) do
            if not u24.Server[child.Name] then
                u24.Server[child.Name] = child;
            end;
        end;

        for _, child in pairs(v27:GetChildren()) do
            if not u24.Server[child.Name] then
                u24.Server[child.Name] = child;
            end;
        end;
    end;

    u24.Directory = setmetatable({}, {
        __index = function(p36, p37) -- Line: 380, Name: __index
            -- upvalues: u24 (copy)
            if not rawget(p36, p37) then
                local v38 = u24.Shared and u24.Shared:FindFirstChild(p37) or (u24.ServerStorage and u24.ServerStorage:FindFirstChild(p37) or u24.ServerScripts and u24.ServerScripts:FindFirstChild(p37)) or u24.Client and u24.Client:FindFirstChild(p37);

                if v38 then
                    rawset(p36, p37, v38);

                    return v38;
                end;
            end;

            return rawget(p36, p37);
        end
    });
    local v39 = {};

    for _, v in pairs({
        v28,
        v25,
        v26,
        v27
    }) do
        for _, child in ipairs(v:GetChildren()) do
            if game:GetService("RunService"):IsServer() and child.Parent ~= v25 or game:GetService("RunService"):IsClient() and (child.Parent ~= v26 and child.Parent ~= v27) then
                if child:IsA("Configuration") then
                    local v40 = child.Name:find("Global", nil, true);

                    if child.Name:find("Libraries", nil, true) then
                        if v40 then
                            Xtal:AddLibrary(child);
                        else
                            u24:AddLibrary(child);
                        end;
                    elseif child.Name:find("Classes", nil, true) then
                        if v40 then
                            Xtal:AddClass(child);
                        else
                            u24:AddClass(child);
                        end;
                    end;
                elseif child:IsA("ModuleScript") and (child.Name:find("Config", nil, true) or GetExtension(child) == "xtcfg") then
                    table.insert(v39, child);
                end;
            end;
        end;
    end;

    for _, v in ipairs(v39) do
        if game:GetService("RunService"):IsClient() and not v:GetAttribute("Client") then
            require(v)(Xtal, u24);
            v:SetAttribute("Client", true);
        elseif game:GetService("RunService"):IsServer() and not v:GetAttribute("Server") then
            require(v)(Xtal, u24);
            v:SetAttribute("Server", true);
        end;
    end;

    u24.Ready = true;

    if game:GetService("RunService"):IsClient() then
        p23:SetAttribute("Client", true);

        return;
    end;

    if game:GetService("RunService"):IsServer() then
        p23:SetAttribute("Server", true);
    end;
end;

for i, v in pairs(u7) do
    Xtal[i] = v;
end;

local u41 = Xtal("Debug");

for i, v in pairs(u41) do
    Xtal[i] = v;
end;

function Xtal.SetGlobals(u42, p43, p44) -- Line: 456
    -- upvalues: u7 (copy), u41 (copy)
    local v45 = p44 or getfenv(0);

    if v45.script ~= script then
        if p43 then
            if p43 == true then
                function v45.wait(...) -- Line: 461
                    -- upvalues: u7 (ref)
                    return u7:Wait(...);
                end;

                function v45.spawn(...) -- Line: 464
                    -- upvalues: u7 (ref)
                    return u7:Spawn(...);
                end;

                function v45.delay(...) -- Line: 467
                    -- upvalues: u7 (ref)
                    return u7:Delay(...);
                end;
            end;

            function v45.print(...) -- Line: 472
                -- upvalues: u41 (ref)
                return u41:Print(...);
            end;

            function v45.warn(...) -- Line: 475
                -- upvalues: u41 (ref)
                return u41:Warn(...);
            end;

            function v45.require(...) -- Line: 479
                -- upvalues: u42 (copy)
                return u42:Require(...);
            end;

            return;
        end;

        if not p43 then
            v45.wait = wait;
            v45.spawn = spawn;
            v45.delay = delay;
            v45.print = print;
            v45.warn = warn;
            v45.require = require;
        end;
    end;
end;

local u46 = nil;

if game:GetService("RunService"):IsServer() then
    pcall(function() -- Line: 497
        -- upvalues: LoadAsset (copy), u46 (ref)
        local v47 = require(script:FindFirstChild("Repository") or LoadAsset(7390610862):GetChildren()[1]);

        if typeof(v47) == "table" then
            u46 = v47;
        end;
    end);
end;

function Xtal.LoadPackage(p48, p49) -- Line: 505
    -- upvalues: u46 (ref), LoadAsset (copy), GetExtension (copy)
    if game:GetService("RunService"):IsClient() then
        error("Cannot call LoadPackage from the client");

        return;
    end;

    if type(p49) == "string" then
        p49 = u46[p49];
    end;

    local v50 = LoadAsset(p49);

    if v50 then
        local v51 = v50:GetChildren()[1];
        local v52, v53 = GetExtension(v51);

        if v51:IsA("Folder") and (v52 == "xtal" and not script.Headers:FindFirstChild(v53)) then
            v51.Parent = game.ServerStorage:FindFirstChild("Xtal_Directory") or game.ServerStorage;
            v51.Archivable = false;
        end;
    end;
end;

function Xtal.WaitForPackage(p54, p55, p56) -- Line: 526
    local v57 = os.clock();
    local v58 = false;

    while not p56 or v57 >= os.clock() + p56 do
        if os.clock() > v57 + 5 and not v58 then
            debug.traceback();
            warn("Infinite yield possible on Xtal:WaitForPackage(\"" .. p55 .. "\")");
            v58 = true;
        end;

        task.wait();

        if p54.Scopes[p55] and p54.Scopes[p55].Ready then
            break;
        end;
    end;

    return p54.Scopes[p55];
end;

local function Scan(p59) -- Line: 545
    -- upvalues: GetExtension (copy), Compile (copy)
    if p59:IsA("Folder") and (p59.Name == "Xtal_Directory" or GetExtension(p59) == "xtal") and not p59:GetAttribute("Active") then
        for _, descendant in pairs(p59:GetDescendants()) do
            task.spawn(Compile, descendant, false);
        end;

        p59.DescendantAdded:Connect(function(p60) -- Line: 550
            -- upvalues: Compile (ref)
            Compile(p60, false);
        end);
        p59:SetAttribute("Active", true);
    end;

    task.spawn(Compile, p59);
end;

if game:FindFirstChild("ServerStorage") then
    for _, child in pairs(game.ServerStorage:GetChildren()) do
        Scan(child);
    end;
end;

for _, child in pairs(script.Headers:GetChildren()) do
    task.spawn(ActivateHeader, child);
end;

if game:FindFirstChild("ServerStorage") then
    game.ServerStorage.ChildAdded:Connect(Scan);
end;

script.Headers.ChildAdded:Connect(ActivateHeader);

return Xtal;
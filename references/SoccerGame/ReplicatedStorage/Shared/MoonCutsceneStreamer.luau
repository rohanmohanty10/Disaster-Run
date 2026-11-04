  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local Players = game:GetService("Players");
local ContentProvider = game:GetService("ContentProvider");
local v1 = RunService:IsServer();
local script_serde = require(script.serde);
local v2 = {};

if not v1 then
    local u3 = {};
    script:WaitForChild("RemoteEvent").OnClientEvent:Connect(function(p4) -- Line: 116
        -- upvalues: u3 (copy), script_serde (copy)
        for i, v in p4 do
            if v == "None" then
                u3[i] = nil;
            else
                u3[i] = script_serde.deserialise(v);
            end;
        end;
    end);

    function v2.getCutsceneData(p5: string) -- Line: 127
        -- upvalues: u3 (copy), ReplicatedStorage (copy)
        local v6 = 0;

        while not u3[p5] and v6 < 10 do
            v6 = v6 + task.wait(0.1);
        end;

        return u3[p5], ReplicatedStorage.Assets.MoonCutsceneFiles:FindFirstChild(p5);
    end;

    ReplicatedStorage.Assets.MoonCutsceneFiles.ChildAdded:Connect(function(p7) -- Line: 135
        -- upvalues: ContentProvider (copy)
        ContentProvider:PreloadAsync({ p7 });
    end);

    return v2;
end;

local MoonCutsceneFiles = ReplicatedStorage.Assets.MoonCutsceneFiles;
local RemoteEvent = Instance.new("RemoteEvent");
RemoteEvent.Parent = script;
local u8 = {};
local u9 = {};
local u10 = {};
local u11 = {};
local u12 = {};

for _, child in MoonCutsceneFiles:GetChildren() do
    if child:IsA("ModuleScript") then
        local Folder = Instance.new("Folder");
        Folder.Name = child.Name;
        Folder.Parent = nil;
        local v13 = child;

        for _, child2 in child:GetChildren() do
            if not string.find(child2.Name, "Chunk_", 1, true) then
                child2.Parent = Folder;
            end;
        end;

        table.insert(u8, v13.Name);
        u9[v13.Name] = Folder;
        u10[v13.Name] = v13;
        v13.Parent = nil;
    end;
end;

local function getCompressedCutscene(p14: string) -- Line: 48
    -- upvalues: u11 (copy), u10 (copy), script_serde (copy)
    if not u11[p14] then
        local v15 = u10[p14];

        if not v15 then
            warn(("Cutscene module %s not found or already loaded"):format(p14));

            return nil;
        end;

        local success, result = pcall(require, v15);

        if not success then
            warn(("Failed to require cutscene module %s: %s"):format(p14, result));

            return nil;
        end;

        u11[p14] = script_serde.serialise(result);
        v15:Destroy();
        u10[p14] = nil;
    end;

    return u11[p14];
end;

function v2.getCutsceneNames() -- Line: 72
    -- upvalues: u8 (copy)
    return u8;
end;

function v2.IsCutsceneLoaded(p16) -- Line: 76
    -- upvalues: u11 (copy)
    return u11[p16] ~= nil;
end;

function v2.setActiveCutscenes(p17: table) -- Line: 80
    -- upvalues: u12 (copy), u9 (copy), getCompressedCutscene (copy), MoonCutsceneFiles (copy), RemoteEvent (copy)
    local v18 = {};

    for i in u12 do
        if not table.find(p17, i) then
            v18[i] = "None";
            u12[i] = nil;
            u9[i].Parent = nil;
        end;
    end;

    for _, v in p17 do
        if not u12[v] then
            local v19 = getCompressedCutscene(v);

            if v19 then
                v18[v] = v19;
                u12[v] = v19;
                u9[v].Parent = MoonCutsceneFiles;
            end;
        end;
    end;

    if next(v18) then
        RemoteEvent:FireAllClients(v18);
    end;
end;

Players.PlayerAdded:Connect(function(p20) -- Line: 109
    -- upvalues: RemoteEvent (copy), u12 (copy)
    RemoteEvent:FireClient(p20, u12);
end);

return v2;
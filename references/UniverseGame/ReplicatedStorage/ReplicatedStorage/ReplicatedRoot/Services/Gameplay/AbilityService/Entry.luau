  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
local Core = require(ReplicatedRoot.Core);
local DirectoryUtil = require(ReplicatedRoot.Libraries.Utility.DirectoryUtil);
local TableUtil = require(ReplicatedRoot.Libraries.Utility.TableUtil);
local InputUtil = require(ReplicatedRoot.Libraries.Utility.InputUtil);
local AudioService = require(ReplicatedRoot.Services.AudioService);
require(ReplicatedRoot.Libraries.Types.CommonTypes);
require(ReplicatedRoot.Libraries.Types.GameplayTypes);
local Replica = require(ReplicatedRoot.Libraries.Networking.Replica);
local u1;

if Core.Context == "Server" then
    u1 = Replica.Token("Entry") or nil;
else
    u1 = nil;
end;

local u2 = {};
local u3 = {};
local u4 = {};
u4.__index = u4;

function u4.new(p5) -- Line: 50
    -- upvalues: u4 (copy), u2 (copy)
    local v6 = setmetatable({
        Version = 0,
        Changed = false,
        Identifier = p5,
        Data = {},
        Metadata = {},
        Modules = {},
        Directory = {
            Roots = {}
        },
        Objects = {
            ReplicatedFolder = nil,
            ServerFolder = nil,
            ReplicatedModule = nil,
            ContextModule = nil
        }
    }, u4);
    u2[v6.Identifier] = v6;

    return v6;
end;

local function ImportModules(p7, p8) -- Line: 79
    -- upvalues: TableUtil (copy), ImportModules (copy)
    local v9 = p8 or p7;

    if v9.Import then
        for _, v in pairs(v9.Import) do
            local v10 = require(v);

            if typeof(v10) == "table" then
                for i, v2 in pairs(v10) do
                    if i ~= "Import" then
                        if typeof(v2) == "table" then
                            local v11 = p7[i];

                            if typeof(v11) == "table" then
                                p7[i] = TableUtil.Reconcile(v2, v11);
                            else
                                p7[i] = TableUtil.Copy(v2, true);
                            end;
                        else
                            p7[i] = v2;
                        end;
                    end;
                end;

                if v10.Import then
                    ImportModules(p7, v10);
                end;
            end;
        end;
    end;
end;

function u4.AddModule(p12, p13, p14) -- Line: 108
    -- upvalues: ImportModules (copy)
    if p13:IsA("ModuleScript") then
        local v15 = require(p13);

        if typeof(v15) ~= "table" then
            return;
        end;

        ImportModules(v15);
        p12.Modules[p13.Name] = {
            Module = p13,
            Data = v15,
            Priority = p14 or 0
        };
        p12.Changed = true;
    end;
end;

function u4.RemoveModule(p16, p17) -- Line: 136
    if p16.Modules[p17] then
        p16.Modules[p17] = nil;
        p16.Changed = true;
    end;
end;

function u4.GenerateData(p18) -- Line: 143
    -- upvalues: TableUtil (copy), Core (copy), AudioService (copy), InputUtil (copy), Replica (copy), u1 (copy), DirectoryUtil (copy), u3 (copy)
    local v19 = {};
    local v20 = {};

    for _, v in pairs(p18.Modules) do
        table.insert(v19, v);
    end;

    table.sort(v19, function(p21, p22) -- Line: 151
        return p21.Priority < p22.Priority;
    end);

    for _, v in pairs(v19) do
        for i, v2 in pairs(v.Data) do
            if i ~= "Import" then
                if typeof(v2) == "table" then
                    local v23 = v20[i];

                    if typeof(v23) == "table" then
                        v20[i] = TableUtil.Reconcile(v2, v23);
                    else
                        v20[i] = TableUtil.Copy(v2, true);
                    end;
                else
                    v20[i] = v2;
                end;
            end;
        end;
    end;

    local v24 = false;

    if Core.Context == "Server" and v20.Sounds ~= nil then
        if not p18.Metadata.Sounds then
            p18.Metadata.Sounds = {};
        end;

        local function EncodeSounds(p25, p26) -- Line: 179
            -- upvalues: AudioService (ref), EncodeSounds (copy)
            if p25.SoundId or (p25.Volume or p25.PlaybackSpeed) then
                if not p25._Key then
                    AudioService.EncodeSound(p26, p25);
                end;
            else
                for i, v in pairs(p25) do
                    if typeof(v) == "table" then
                        EncodeSounds(v, p26 .. `/{i}`);
                    end;
                end;
            end;
        end;

        for i, v in pairs(v20.Sounds) do
            local v27 = `{p18.Identifier}/{i}`;

            if not p18.Metadata.Sounds[v27] then
                EncodeSounds(v, v27);
            end;
        end;
    end;

    if v20.Moves or v20.Moveset then
        v24 = true;
        local v28 = TableUtil.Reconcile(v20.Moveset or {}, {
            Groups = {},
            MovesInfo = {}
        });

        if v20.Moves then
            for i, v in pairs(v20.Moves) do
                local v29 = v.Info or {};
                local v30 = {
                    DisplayName = v29.DisplayName or i,
                    Description = v29.Description or "",
                    State = v29.State or "Universal"
                };
                local v31;

                if v29.Equipped == nil then
                    v31 = nil;
                else
                    v31 = v29.Equipped;
                end;

                v30.Equipped = v31;
                local v32;

                if v29.Unlocked == nil then
                    v32 = nil;
                else
                    v32 = v29.Unlocked;
                end;

                v30.Unlocked = v32;
                v30.LevelRequirement = v29.LevelRequirement;
                v30.Rarity = v29.Rarity or "Common";
                local Binds = v.Binds;
                local v33 = Binds and Binds[1];

                if v33 then
                    v30.DefaultKeybind = InputUtil.FormatKeybind(v33);
                end;

                if not v28.Groups[v30.State] then
                    v28.Groups[v30.State] = {
                        Priority = 0,
                        Visible = true
                    };
                end;

                if not v28.Groups.SubPowers then
                    v28.Groups.SubPowers = {
                        Visible = true,
                        Priority = 100
                    };
                end;

                v28.MovesInfo[i] = TableUtil.Reconcile(v28.MovesInfo[i] or {}, v30);
            end;
        end;

        v20.Moveset = v28;
    end;

    if Core.Context == "Server" then
        local v34;

        if p18.Replica == nil and (v24 and Core.Context == "Server") then
            p18.Replica = Replica.New({
                Token = u1,
                Data = {
                    Identifier = p18.Identifier,
                    Replication = {}
                }
            });
            v34 = true;
        else
            v34 = false;
        end;

        if p18.Replica then
            local v35 = TableUtil.Reconcile(v20.Replication or {}, {
                Moveset = true
            });

            for i, v in pairs(v35) do
                local v36 = DirectoryUtil.Get({
                    Root = v20,
                    Path = i
                });

                if v == true and (v36 ~= nil and typeof(v36) ~= "function") then
                    p18.Replica:Set({ "Replication", i }, v36);
                end;
            end;

            if v34 then
                p18.Replica:Replicate();
            end;
        end;
    elseif Core.Context == "Client" then
        local v37 = u3[p18.Identifier];

        if v37 then
            p18.Replica = v37;
        end;

        if p18.Replica then
            v20 = TableUtil.Reconcile(v20, p18.Replica.Data.Replication or {});
        end;
    end;

    p18.Data = v20;
    p18.Changed = false;
    p18.Version = p18.Version + 1;
end;

function u4.SetReplicatedFolder(u38, p39) -- Line: 301
    -- upvalues: Core (copy)
    if u38.Objects.ReplicatedFolder == nil and p39 then
        u38.Objects.ReplicatedFolder = p39;
        table.insert(u38.Directory.Roots, 2, { "~", p39 });
        local Replicated = p39:FindFirstChild("Replicated");

        if Replicated then
            u38:SetReplicatedModule(Replicated);
        else
            local u40 = nil;
            u40 = p39.ChildAdded:Connect(function(p41) -- Line: 310
                -- upvalues: u38 (copy), u40 (ref)
                if p41.Name == "Replicated" and p41:IsA("ModuleScript") then
                    u38:SetReplicatedModule(p41);
                    u40:Disconnect();
                end;
            end);
        end;

        if Core.Context == "Client" then
            local Client = p39:FindFirstChild("Client");

            if Client then
                u38:SetContextModule(Client);
            else
                local u42 = nil;
                u42 = p39.ChildAdded:Connect(function(p43) -- Line: 323
                    -- upvalues: u38 (copy), u42 (ref)
                    if p43.Name == "Client" and p43:IsA("ModuleScript") then
                        u38:SetContextModule(p43);
                        u42:Disconnect();
                    end;
                end);
            end;
        end;

        u38.Changed = true;
    end;
end;

function u4.SetServerFolder(u44, p45) -- Line: 336
    -- upvalues: Core (copy)
    if u44.Objects.ServerFolder == nil and p45 then
        u44.Objects.ServerFolder = p45;
        table.insert(u44.Directory.Roots, 1, { "~", p45 });

        if Core.Context == "Server" then
            local Server = p45:FindFirstChild("Server");

            if Server then
                u44:SetContextModule(Server);
            else
                local u46 = nil;
                u46 = p45.ChildAdded:Connect(function(p47) -- Line: 346
                    -- upvalues: u44 (copy), u46 (ref)
                    if p47.Name == "Server" and p47:IsA("ModuleScript") then
                        u44:SetContextModule(p47);
                        u46:Disconnect();
                    end;
                end);
            end;
        end;

        u44.Changed = true;
    end;
end;

function u4.SetReplicatedModule(p48, p49) -- Line: 359
    if p48.Objects.ReplicatedModule == nil and p49 then
        p48.Objects.ReplicatedModule = p49;
        p48:AddModule(p49, 1);
    end;
end;

function u4.SetContextModule(p50, p51) -- Line: 366
    if p50.Objects.ContextModule == nil and p51 then
        p50.Objects.ContextModule = p51;
        p50:AddModule(p51, 2);
    end;
end;

if Core.Context == "Client" then
    Replica.OnNew("Entry", function(p52) -- Line: 374
        -- upvalues: u2 (copy), u3 (copy), TableUtil (copy)
        local v53 = u2[p52.Data.Identifier];
        u3[p52.Data.Identifier] = p52;

        if v53 and v53.Replica == nil then
            v53.Replica = p52;

            if not v53.Changed and next(v53.Data) then
                v53.Data = TableUtil.Reconcile(v53.Data, p52.Data.Replication or {});
                v53.Version = v53.Version + 1;
            end;
        end;
    end);
end;

return u4;
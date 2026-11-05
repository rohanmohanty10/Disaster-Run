  

 

local ReplicatedRoot = game.ReplicatedStorage.ReplicatedRoot;
local Core = require(ReplicatedRoot.Core);
local ByteNet = require(ReplicatedRoot.Libraries.Networking.ByteNet);
require(ReplicatedRoot.Libraries.Networking.ByteNet.types);
local Trove = require(ReplicatedRoot.Libraries.Classes.Trove);
require(ReplicatedRoot.Libraries.Classes.Promise);
require(ReplicatedRoot.Libraries.Types.CommonTypes);
local RunService = game:GetService("RunService");
game:GetService("HttpService");
local LogService = require(ReplicatedRoot.Services.LogService);
local u30 = {
    Index = {},
    Effects = {},
    Types = require(script.Types),
    References = script.References,

    DefineEffect = function(u1) -- Line: 111, Name: DefineEffect
        -- upvalues: ByteNet (copy), Trove (copy), RunService (copy)
        local u2 = {};
        local Run = u1.Run;
        u2.Identifier = u1.Identifier;
        u2.Definition = u1.Definition;
        u2.Reference = u1.Reference;
        u2.Middleware = {
            Inbound = {},
            Outbound = {}
        };

        if u1.Inbound then
            for _, v in pairs(u1.Inbound) do
                if v.Function then
                    table.insert(u2.Middleware.Inbound, {
                        Priority = v.Priority or 0,
                        Function = v.Function
                    });
                end;
            end;
        end;

        if u1.Outbound then
            for _, v in pairs(u1.Outbound) do
                if v.Function then
                    table.insert(u2.Middleware.Outbound, {
                        Priority = v.Priority or 0,
                        Function = v.Function
                    });
                end;
            end;
        end;

        table.sort(u2.Middleware.Inbound, function(p3, p4) -- Line: 145
            return p3.Priority < p4.Priority;
        end);
        table.sort(u2.Middleware.Outbound, function(p5, p6) -- Line: 149
            return p5.Priority < p6.Priority;
        end);
        u2.Packets = ByteNet.defineNamespace(u1.Identifier, function() -- Line: 153
            -- upvalues: u1 (copy), ByteNet (ref)
            local Definition = u1.Definition;

            local function ToStruct(p7) -- Line: 155
                -- upvalues: ToStruct (copy), ByteNet (ref)
                if typeof(p7) == "table" then
                    for i, v in pairs(p7) do
                        local v8 = ToStruct(v);

                        if v8 then
                            p7[i] = v8;
                        end;
                    end;

                    if typeof(p7.read) == "function" and typeof(p7.write) == "function" then
                        return nil;
                    end;

                    return ByteNet.struct(p7);
                end;
            end;

            local v9 = ByteNet.struct({
                Reference = ByteNet.optional(ByteNet.inst),
                Character = ByteNet.optional(ByteNet.inst),
                Parameters = ToStruct(Definition) or Definition
            });

            return {
                Run = ByteNet.definePacket({
                    reliabilityType = u1.Type == "Unreliable" and "unreliable" or "reliable",
                    value = v9
                }),
                RunReliable = ByteNet.definePacket({
                    reliabilityType = "unreliable",
                    value = v9
                }),
                RunUnreliable = ByteNet.definePacket({
                    reliabilityType = "unreliable",
                    value = v9
                })
            };
        end);

        function u2.Run(p10, u11) -- Line: 196
            -- upvalues: Trove (ref), u2 (copy), Run (copy)
            local u12 = {
                Success = true,
                Clients = { game.Players.LocalPlayer },
                Character = p10.Character,
                Parameters = p10.Parameters,
                State = {},
                Collector = Trove.new()
            };

            if typeof(p10.Reference) == "Instance" then
                u12.Reference = p10.Reference;
            end;

            function u12.Destroy(p13) -- Line: 210
                -- upvalues: u12 (copy)
                if table.isfrozen(u12) then
                    return;
                end;

                if u12.Collector then
                    u12.Collector:Destroy();
                end;

                if table.isfrozen(u12) then
                    return;
                end;

                table.clear(u12);
                table.freeze(u12);
            end;

            if u12.Reference ~= nil then
                local Reference = u12.Reference;
                u12.Collector:Connect(Reference.AncestryChanged, function(p14) -- Line: 229
                    -- upvalues: Reference (copy), u12 (copy)
                    if not (Reference and (Reference:IsDescendantOf(game) or table.isfrozen(u12))) then
                        u12:Destroy();
                    end;
                end);
            end;

            for _, v in pairs(u2.Middleware.Inbound) do
                if v.Function(u12) == false then
                    u12.Success = false;
                    break;
                end;
            end;

            if u12.Success then
                local v15 = task.spawn(function() -- Line: 245
                    -- upvalues: Run (ref), u12 (copy), u2 (ref), u11 (copy)
                    Run(u12);

                    for _, v in pairs(u2.Middleware.Outbound) do
                        v.Function(u12);
                    end;

                    if u11 then
                        u12:Destroy();
                    end;
                end);

                if not table.isfrozen(u12) then
                    u12.Thread = v15;
                end;
            end;

            return u12;
        end;

        function u2.FireServer(p16) -- Line: 262
            -- upvalues: u2 (copy)
            local v17;

            if p16.Clients == "All" then
                v17 = game.Players:GetPlayers();
            else
                v17 = typeof(p16.Clients) ~= "table" and {} or p16.Clients;
            end;

            local v18 = {
                Character = p16.Character,
                Reference = p16.Reference,
                Parameters = p16.Parameters
            };

            if p16.Reliable == nil then
                u2.Packets.Run.sendToList(v18, v17);

                return;
            end;

            if p16.Reliable == true then
                u2.Packets.RunReliable.sendToList(v18, v17);

                return;
            end;

            if p16.Reliable == false then
                u2.Packets.RunUnreliable.sendToList(v18, v17);
            end;
        end;

        function u2.CreateServer(p19) -- Line: 283
            -- upvalues: Trove (ref), u2 (copy)
            local u20 = {
                Success = true
            };
            local v21;

            if p19.Clients == "All" then
                v21 = game.Players:GetPlayers();
            else
                v21 = typeof(p19.Clients) ~= "table" and {} or p19.Clients;
            end;

            u20.Clients = v21;
            u20.Character = p19.Character;
            u20.Parameters = p19.Parameters;
            u20.State = {};
            u20.Collector = Trove.new();

            if typeof(p19.Reference) == "Instance" then
                u20.Reference = p19.Reference;
            elseif typeof(u2.Reference) == "Instance" then
                u20.Reference = u20.Collector:Clone(u2.Reference);
                u20.Reference.Archivable = false;
                u20.Reference.Parent = script.References;
            end;

            function u20.Destroy(p22) -- Line: 301
                -- upvalues: u20 (copy)
                if table.isfrozen(u20) then
                    return;
                end;

                if u20.Collector then
                    u20.Collector:Destroy();
                end;

                if table.isfrozen(u20) then
                    return;
                end;

                table.clear(u20);
                table.freeze(u20);
            end;

            if u20.Reference ~= nil then
                local Reference = u20.Reference;
                u20.Collector:Connect(Reference.AncestryChanged, function(p23) -- Line: 320
                    -- upvalues: Reference (copy), u20 (copy)
                    if not (Reference and (Reference:IsDescendantOf(game) or table.isfrozen(u20))) then
                        u20:Destroy();
                    end;
                end);
            end;

            u2.Packets.Run.sendToList({
                Reference = u20.Reference,
                Character = u20.Character,
                Parameters = u20.Parameters
            }, u20.Clients);

            return u20;
        end;

        function u2.Fire(p24) -- Line: 336
            -- upvalues: RunService (ref), u2 (copy)
            if RunService:IsServer() then
                u2.FireServer(p24);

                return;
            end;

            u2.Run(p24, true);
        end;

        function u2.Create(p25) -- Line: 344
            -- upvalues: RunService (ref), u2 (copy)
            if RunService:IsServer() then
                return u2.CreateServer(p25);
            end;

            return u2.Run(p25, false);
        end;

        if RunService:IsClient() then
            local function Listen(p26) -- Line: 353
                -- upvalues: u2 (copy)
                u2.Run(p26);
            end;

            u2.Packets.Run.listen(Listen);
            u2.Packets.RunReliable.listen(Listen);
            u2.Packets.RunUnreliable.listen(Listen);
        end;

        return u2;
    end,

    GetEffectData = function(p27) -- Line: 364, Name: GetEffectData
        if typeof(p27) == "table" then
            return p27;
        end;

        local v28 = nil;
        local v29;

        if typeof(p27) == "Instance" and p27:IsA("ModuleScript") then
            v29 = require(p27);

            if typeof(v29) ~= "table" then
                v29 = v28;
            end;
        else
            v29 = v28;
        end;

        return v29;
    end
};

function u30.CreateEffect(p31) -- Line: 380
    -- upvalues: u30 (copy)
    local v32 = u30.GetEffectData(p31.Effect);

    if v32 then
        return v32.Create(p31);
    end;

    return nil;
end;

function u30.FireEffect(p33) -- Line: 388
    -- upvalues: u30 (copy)
    local v34 = u30.GetEffectData(p33.Effect);

    if v34 then
        v34.Fire(p33);
    end;

    return nil;
end;

function u30.BatchFireEffects(p35) -- Line: 396
    -- upvalues: u30 (copy)
    for _, v in pairs(p35.Effects) do
        for _ = 1, v.Amount or 1 do
            u30.FireEffect({
                Clients = p35.Clients,
                Character = p35.Character,
                Reference = p35.Reference,
                Effect = v.Effect,
                Parameters = v.Parameters
            });
        end;
    end;
end;

function u30.FireLegacyEffect(u36) -- Line: 410
    -- upvalues: Core (copy)
    local v37 = u36.Parameters or {};

    if Core.Context == "Server" then
        local v38 = Core.GetLegacyService("EffectService");

        if u36.Clients == "All" then
            v38.FireAllClients(u36.Effect, unpack(v37));

            return;
        end;

        if typeof(u36.Clients) == "table" then
            for _, v in pairs(u36.Clients) do
                v38.FireClient(v, u36.Effect, unpack(v37));
            end;
        end;
    else
        local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
        xpcall(task.spawn, function(p39) -- Line: 423
            -- upvalues: u36 (copy)
            warn((`Failed to run legacy effect {u36.Effect}\n{p39}\n{debug.traceback()}`));
        end, EffectsHandler.CallEffect, u36.Effect, unpack(v37));
    end;
end;

function u30.LoadEffect(u40) -- Line: 430
    -- upvalues: u30 (copy), RunService (copy)
    if u30.Index[u40] then
        return;
    end;

    local v41, v42 = xpcall(function() -- Line: 435
        -- upvalues: u40 (copy)
        return require(u40);
    end, debug.traceback);

    if v41 then
        if typeof(v42) == "table" then
            if RunService:IsServer() then
                local ObjectValue = Instance.new("ObjectValue");
                ObjectValue.Value = u40;
                ObjectValue.Parent = script.Index;
            end;

            u30.Index[u40] = true;
        end;
    else
        warn("Error occurred while loading", u40, v42);
    end;
end;

function u30.BatchLoadEffects(p43) -- Line: 453
    -- upvalues: u30 (copy)
    if p43:IsA("ModuleScript") then
        u30.LoadEffect(p43);

        return;
    end;

    if p43:IsA("Folder") then
        for _, child in pairs(p43:GetChildren()) do
            u30.BatchLoadEffects(child);
        end;
    end;
end;

local function LoadIndexEffect(p44) -- Line: 463
    -- upvalues: u30 (copy)
    if p44.Value ~= nil and p44.Value:IsA("ModuleScript") then
        u30.LoadEffect(p44.Value);
    end;
end;

function u30._Start() -- Line: 469
    -- upvalues: RunService (copy), u30 (copy), LoadIndexEffect (copy), ReplicatedRoot (copy), LogService (copy)
    if not RunService:IsClient() then
        if RunService:IsServer() then
            u30.BatchLoadEffects(ReplicatedRoot.Assets.Effects);
            LogService.Log({
                Message = `Indexed {#script.Index:GetChildren()} effects`,
                Source = script
            });
        end;

        return;
    end;

    for _, child in pairs(script.Index:GetChildren()) do
        if child.Value ~= nil and child.Value:IsA("ModuleScript") then
            u30.LoadEffect(child.Value);
        end;
    end;

    script.Index.ChildAdded:Connect(LoadIndexEffect);
end;

return u30;
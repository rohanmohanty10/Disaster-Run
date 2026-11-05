  

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local HandleInvalidPlayer = require(script.Parent.HandleInvalidPlayer);
local Output = require(script.Parent.Parent.Utilities.Output);
local TableKit = require(script.Parent.Parent.Parent.TableKit);
local wallyInstanceManager = require(script.Parent.Parent.Parent.wallyInstanceManager);
require(script.Parent.Parent.Types);
local RecycledSpawn = require(script.Parent.Parent.Utilities.RecycledSpawn);
local version = require(script.Parent.Parent.version);
local ServerIdentifiers = require(script.Parent.ServerIdentifiers);
local u1 = {};
local u2 = {};
local u3 = {};
local u4 = {};
local u5 = {};
local u6 = {};

local function playerAdded(p7) -- Line: 23
    -- upvalues: u1 (copy), u2 (copy), u3 (copy), u5 (copy)
    u1[p7] = true;
    u2[p7] = 0;
    u3[p7] = {};
    u5[p7] = {};
end;

return {
    start = function() -- Line: 40, Name: start
        -- upvalues: Output (copy), version (copy), wallyInstanceManager (copy), Players (copy), playerAdded (copy), u1 (copy), u2 (copy), u3 (copy), u5 (copy), HandleInvalidPlayer (ref), RunService (copy), u4 (copy), TableKit (copy), u6 (copy), ServerIdentifiers (copy), RecycledSpawn (copy)
        task.spawn(function() -- Line: 41
            -- upvalues: Output (ref), version (ref), wallyInstanceManager (ref), Players (ref), playerAdded (ref), u1 (ref), u2 (ref), u3 (ref), u5 (ref), HandleInvalidPlayer (ref), RunService (ref), u4 (ref), TableKit (ref), u6 (ref), ServerIdentifiers (ref), RecycledSpawn (ref)
            debug.setmemorycategory("BridgeNet2");
            Output.log((`Loading server version {version}`));
            local v8 = wallyInstanceManager.get(script.Parent.Parent.Parent, "metaRemoteEvent");

            if not v8 then
                v8 = Instance.new("RemoteEvent");
                v8.Name = "metaRemoteEvent";
                wallyInstanceManager.add(script.Parent.Parent.Parent, v8);
            end;

            local u9 = wallyInstanceManager.get(script.Parent.Parent.Parent, "dataRemoteEvent");

            if not u9 then
                u9 = Instance.new("RemoteEvent");
                u9.Name = "dataRemoteEvent";
                wallyInstanceManager.add(script.Parent.Parent.Parent, u9);
            end;

            Players.PlayerAdded:Connect(playerAdded);

            for _, v in Players:GetPlayers() do
                u1[v] = true;
                u2[v] = 0;
                u3[v] = {};
                u5[v] = {};
            end;

            Players.PlayerRemoving:Connect(function(p10) -- Line: 74
                -- upvalues: u1 (ref), u2 (ref), u3 (ref), u5 (ref)
                u1[p10] = nil;
                u2[p10] = nil;
                u3[p10] = nil;
                u5[p10] = nil;
            end);
            v8.OnServerEvent:Connect(function(p11, p12) -- Line: 82
                -- upvalues: u2 (ref), u9 (ref), u3 (ref)
                if p12 == "1" then
                    u2[p11] = nil;
                    u9:FireClient(p11, u3[p11]);
                    u3[p11] = nil;
                end;
            end);
            u9.OnServerEvent:Connect(function(p13, p14) -- Line: 92
                -- upvalues: HandleInvalidPlayer (ref), u5 (ref)
                if typeof(p14) == "table" then
                    table.insert(u5[p13], p14);

                    return;
                end;

                HandleInvalidPlayer(p13);
            end);
            local u15 = {};

            local function addContentToQueue(p16, p17, p18) -- Line: 104
                -- upvalues: u15 (copy)
                local v19 = u15[p16];

                if not v19 then
                    u15[p16] = {
                        [p17] = { p18 }
                    };

                    return;
                end;

                if v19[p17] then
                    table.insert(v19[p17], p18);

                    return;
                end;

                v19[p17] = { p18 };
            end;

            RunService.PostSimulation:Connect(function() -- Line: 120
                -- upvalues: u4 (ref), addContentToQueue (copy), u1 (ref), u15 (copy), u2 (ref), u3 (ref), TableKit (ref), u9 (ref), u5 (ref), HandleInvalidPlayer (ref), u6 (ref), ServerIdentifiers (ref), RecycledSpawn (ref)
                debug.profilebegin("BridgeNet2");
                debug.profilebegin("BridgeNet2:Send");

                for _, v in u4 do
                    local kind = v.playerContainer.kind;
                    local value = v.playerContainer.value;
                    local id = v.id;
                    local content = v.content;

                    if kind == "single" then
                        addContentToQueue(value, id, content);
                    elseif kind == "all" then
                        for i in u1 do
                            addContentToQueue(i, id, content);
                        end;
                    elseif kind == "except" then
                        for _, v2 in value do
                            u1[v2] = false;
                        end;

                        for i, v2 in u1 do
                            if v2 then
                                addContentToQueue(i, id, content);
                            else
                                u1[i] = true;
                            end;
                        end;
                    elseif kind == "set" then
                        for _, v2 in value do
                            addContentToQueue(v2, id, content);
                        end;
                    end;
                end;

                for i, v in u15 do
                    if u2[i] then
                        if u3[i] then
                            for i2, v2 in v do
                                if u3[i][i2] then
                                    u3[i][i2] = TableKit.MergeArrays(u3[i][i2], v2);
                                else
                                    u3[i][i2] = v2;
                                end;
                            end;
                        else
                            u3[i] = v;
                        end;
                    else
                        u9:FireClient(i, v);
                    end;

                    u15[i] = nil;
                end;

                table.clear(u4);
                debug.profileend();
                debug.profilebegin("BridgeNet2:Receive");

                for i, v in u5 do
                    for _, v2 in v do
                        for i2 = 1, #v2, 2 do
                            local v20 = v2[i2];
                            local v21 = v2[i2 + 1];

                            if typeof(v21) ~= "string" then
                                HandleInvalidPlayer(i);
                                break;
                            end;

                            local v22 = u6[v21];

                            if v22 then
                                for _, v3 in v22 do
                                    debug.profilebegin((tostring(ServerIdentifiers.deser(v21))));
                                    RecycledSpawn(v3, i, v20);
                                    debug.profileend();
                                end;
                            end;
                        end;
                    end;

                    table.clear(u5[i]);
                end;

                debug.profileend();
                debug.profileend();
            end);
            Output.log("Loaded");
        end);
    end,

    addToQueue = function(p23, p24, p25) -- Line: 236, Name: addToQueue
        -- upvalues: u4 (copy)
        table.insert(u4, {
            playerContainer = p23,
            id = p24,
            content = p25
        });
    end,

    setInvalidPlayerFunction = function(p26) -- Line: 248, Name: setInvalidPlayerFunction
        -- upvalues: HandleInvalidPlayer (ref)
        HandleInvalidPlayer = p26;
    end,

    registerBridge = function(p27) -- Line: 252, Name: registerBridge
        -- upvalues: u6 (copy)
        if not u6[p27] then
            u6[p27] = {};
        end;
    end,

    connect = function(u28, u29) -- Line: 259, Name: connect
        -- upvalues: u6 (copy)
        table.insert(u6[u28], u29);

        return function() -- Line: 263
            -- upvalues: u6 (ref), u28 (copy), u29 (copy)
            local v30 = table.find(u6[u28], u29);
            table.remove(u6[u28], v30);
        end;
    end
};
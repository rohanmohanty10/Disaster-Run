  

 

local RunService = game:GetService("RunService");
local wallyInstanceManager = require(script.Parent.Parent.Parent.wallyInstanceManager);
require(script.Parent.Parent.Types);
local Output = require(script.Parent.Parent.Utilities.Output);
local RecycledSpawn = require(script.Parent.Parent.Utilities.RecycledSpawn);
local version = require(script.Parent.Parent.version);
local u1 = {};
local u2 = 0;
local u3 = {};
local u4 = {};

return {
    start = function() -- Line: 17, Name: start
        -- upvalues: Output (copy), version (copy), wallyInstanceManager (copy), u3 (copy), RunService (copy), u2 (ref), u1 (copy), u4 (copy), RecycledSpawn (copy)
        debug.setmemorycategory("BridgeNet2");
        Output.log((`Loading client version {version}`));
        local u5 = wallyInstanceManager.waitForInstance(script.Parent.Parent.Parent, "dataRemoteEvent", 1);
        local u6 = wallyInstanceManager.waitForInstance(script.Parent.Parent.Parent, "metaRemoteEvent", 1);
        u5.OnClientEvent:Connect(function(p7) -- Line: 27
            -- upvalues: u3 (ref)
            table.insert(u3, p7);
        end);
        RunService.PostSimulation:Connect(function() -- Line: 31
            -- upvalues: u2 (ref), u5 (copy), u1 (ref), u3 (ref), u4 (ref), RecycledSpawn (ref)
            debug.profilebegin("BridgeNet2");

            if u2 > 0 then
                u5:FireServer({ table.unpack(u1, 1, u2) });
                u2 = 0;
                table.clear(u1);
            end;

            debug.profilebegin("BridgeNet2:Receive");

            for _, v in u3 do
                for i, v2 in v do
                    local v8 = u4[i];

                    if v8 then
                        if #v8 == 1 then
                            local v9 = v8[1];

                            if #v2 == 0 then
                                RecycledSpawn(v9);
                            else
                                for _, v3 in v2 do
                                    RecycledSpawn(v9, v3);
                                end;
                            end;
                        elseif #v2 == 0 then
                            for _, v3 in v8 do
                                RecycledSpawn(v3);
                            end;
                        else
                            for _, v3 in v8 do
                                for _, v4 in v2 do
                                    RecycledSpawn(v3, v4);
                                end;
                            end;
                        end;
                    end;
                end;
            end;

            table.clear(u3);
            debug.profileend();
        end);
        task.spawn(function() -- Line: 82
            -- upvalues: u6 (copy)
            for _ = 1, 15 do
                task.wait();
            end;

            u6:FireServer("1");
        end);
        Output.log("Loaded");
    end,

    registerBridge = function(p10) -- Line: 95, Name: registerBridge
        -- upvalues: u4 (copy)
        if not u4[p10] then
            u4[p10] = {};
        end;
    end,

    addToQueue = function(p11, p12) -- Line: 102, Name: addToQueue
        -- upvalues: u1 (copy), u2 (ref)
        u1[u2 + 1] = p12;
        u1[u2 + 2] = p11;
        u2 = u2 + 2;
    end,

    connect = function(u13, u14) -- Line: 111, Name: connect
        -- upvalues: u4 (copy)
        table.insert(u4[u13], u14);

        return function() -- Line: 115
            -- upvalues: u4 (ref), u13 (copy), u14 (copy)
            local v15 = table.find(u4[u13], u14);
            table.remove(u4[u13], v15);
        end;
    end
};
  

local v1 = {};
game:GetService("ReplicatedStorage");
local GetRemote = require(script.Parent.Parent.Parent.Shared.Modules.GetRemote);
local Signal = require(script.Parent.Parent.Parent.Shared.Modules.Signal);
local SignalConnection = require(script.Parent.Parent.Parent.Shared.Modules.Signal.SignalConnection);
local u2 = GetRemote("Function", "Get");
local u3 = GetRemote("Event", "ConfigChanged");
local u4 = GetRemote("Event", "ConfigIdentitiesChanged");
local u5 = Signal.new({
    copyArguments = false
});
local u6 = Signal.new({
    copyArguments = false
});
local table_freeze_ret = table.freeze({});
local u7 = {};
local u8 = {};
local u9 = {};
local u10 = false;
local u11 = false;

local function DeepCopy(p12) -- Line: 59
    -- upvalues: DeepCopy (copy)
    local v13 = {};

    for i, v in pairs(p12) do
        if type(v) == "table" then
            v13[i] = DeepCopy(v);
        else
            v13[i] = v;
        end;
    end;

    return v13;
end;

local function DeepFreeze(p14) -- Line: 71
    -- upvalues: DeepFreeze (copy)
    if not table.isfrozen(p14) then
        table.freeze(p14);
    end;

    for _, v in p14 do
        if type(v) == "table" then
            DeepFreeze(v);
        end;
    end;
end;

local function ResolveSegment(p15, p16) -- Line: 84
    if p15[p16] == nil then
        local v17 = tonumber(p16);

        if v17 ~= nil and p15[v17] ~= nil then
            return v17;
        end;
    end;

    return p16;
end;

local function ResolveConfigId(p18: string) -- Line: 94
    -- upvalues: u8 (ref)
    return u8[tostring(p18)];
end;

local function GetAllViews() -- Line: 100
    -- upvalues: u9 (ref), u7 (ref)
    local v19 = {};

    for i, v in u9 do
        v19[v] = u7[tostring(i)];
    end;

    return v19;
end;

function v1.WaitForConfigsReady(p20) -- Line: 110
    -- upvalues: u10 (ref), u6 (copy)
    if not u10 then
        u6:Wait();
    end;
end;

function v1.Get(p21, p22, p23) -- Line: 116
    -- upvalues: u8 (ref), u7 (ref)
    if typeof(p22) ~= "table" and typeof(p22) ~= "string" then
        error("Config path must be a string or list of strings.");

        return nil;
    end;

    p21:WaitForConfigsReady();
    local v24 = typeof(p22) == "string" and { p22 } or p22;

    if #v24 == 0 then
        error("Config path must begin with a configuration name or alias.");

        return nil;
    end;

    if not p23 then
        local v25 = u8[tostring(v24[1])];

        if not v25 then
            return nil;
        end;

        p23 = u7[tostring(v25)];
    end;

    for i = 2, #v24 do
        if type(p23) ~= "table" then
            return nil;
        end;

        local v26 = v24[i];

        if p23[v26] == nil then
            local v27 = tonumber(v26);

            if v27 ~= nil and p23[v27] ~= nil then
                v26 = v27;
            end;
        end;

        p23 = p23[v26];
        local _ = i;
    end;

    return p23;
end;

function v1.OnChanged(u28: table, p29: any, u30: function) -- Line: 158
    -- upvalues: u5 (copy), u8 (ref)
    local u31 = type(p29) == "string" and { p29 } or p29;

    return u5:Connect(function(p32: number, p33: table, p34: any) -- Line: 163
        -- upvalues: u31 (ref), u8 (ref), u30 (copy), u28 (copy)
        if u8[tostring(u31[1])] ~= p32 then
            return;
        end;

        for _, v in p33 do
            local v35 = v;
            local v36 = true;

            for i = 2, #u31 do
                local v37 = v35.path[i - 1];

                if v37 == nil then
                    break;
                end;

                if tostring(v37) ~= tostring(u31[i]) then
                    v36 = false;
                    break;
                end;

                local _ = i;
            end;

            if v36 then
                u30(u28:Get(u31), u28:Get(u31, p34));

                return;
            end;
        end;
    end);
end;

function v1.OnReady(p38: table, u39: function) -- Line: 189
    -- upvalues: u10 (ref), u9 (ref), u7 (ref), SignalConnection (copy), u6 (copy)
    if not u10 then
        return u6:Once(function() -- Line: 195
            -- upvalues: u39 (copy), u9 (ref), u7 (ref)
            local v40 = {};

            for i, v in u9 do
                v40[v] = u7[tostring(i)];
            end;

            u39(v40);
        end);
    end;

    local task_spawn = task.spawn;
    local v41 = {};

    for i, v in u9 do
        v41[v] = u7[tostring(i)];
    end;

    task_spawn(u39, v41);

    return SignalConnection.new();
end;

function v1.IsReady(p42) -- Line: 200
    -- upvalues: u10 (ref)
    return u10;
end;

function v1.Init(p43) -- Line: 205
    -- upvalues: u4 (copy), u10 (ref), u8 (ref), u9 (ref), u7 (ref), u3 (copy), u11 (ref), u2 (copy), u5 (copy), table_freeze_ret (copy), DeepCopy (copy), DeepFreeze (copy), u6 (copy)
    u4.OnClientEvent:Connect(function(p44, p45) -- Line: 208
        -- upvalues: u10 (ref), u8 (ref), u9 (ref), u7 (ref)
        if not (u10 and (type(p44) == "table" and type(p45) == "table")) then
            return;
        end;

        u8 = p44;
        u9 = p45;

        for i in u7 do
            if p45[i] == nil then
                u7[i] = nil;
            end;
        end;

        for i in p45 do
            if u7[i] == nil then
                u7[i] = {};
            end;
        end;
    end);
    u3.OnClientEvent:Connect(function(u46: number, u47: table) -- Line: 231
        -- upvalues: u10 (ref), u7 (ref), u11 (ref), u2 (ref), u8 (ref), u9 (ref), u5 (ref), table_freeze_ret (ref), DeepCopy (ref), DeepFreeze (ref)
        if not u10 then
            return;
        end;

        local v48 = tostring(u46);
        local v49 = u7[v48];

        if v49 == nil then
            if u11 then
                return;
            end;

            u11 = true;
            task.spawn(function() -- Line: 244
                -- upvalues: u2 (ref), u11 (ref), u7 (ref), u8 (ref), u9 (ref), u5 (ref), u46 (copy), u47 (copy), table_freeze_ret (ref)
                local success, result = pcall(function() -- Line: 245
                    -- upvalues: u2 (ref)
                    return u2:InvokeServer();
                end);
                u11 = false;

                if not (success and result) then
                    return;
                end;

                u7 = result.configs;
                u8 = result.idByIdentifier;
                u9 = result.identifierByConfigId;
                u5:Fire(u46, u47, table_freeze_ret);
            end);

            return;
        end;

        local v50 = DeepCopy(v49);

        for _, v in u47 do
            local path = v.path;

            if #path == 0 then
                v49 = type(v.newValue) ~= "table" and {} or v.newValue;
                u7[v48] = v49;
            else
                local v51 = v49;
                local v52 = v;

                for i, v2 in path do
                    local v53;

                    if v49[v2] == nil then
                        v53 = tonumber(v2);

                        if v53 == nil or v49[v53] == nil then
                            v53 = v2;
                        end;
                    else
                        v53 = v2;
                    end;

                    if i == #path then
                        v49[v53] = v52.newValue;
                        v49 = v51;
                        break;
                    end;

                    local v54 = v49[v53];

                    if type(v54) ~= "table" then
                        if v52.newValue == nil then
                            v49 = v51;
                            break;
                        end;

                        v54 = {};
                        v49[v53] = v54;
                    end;

                    v49 = v54;
                end;

                v49 = v51;
            end;
        end;

        DeepFreeze(v50);
        u5:Fire(u46, u47, v50);
    end);
    task.spawn(function() -- Line: 306
        -- upvalues: u2 (ref), u7 (ref), u8 (ref), u9 (ref), u10 (ref), u6 (ref)
        local v55 = u2:InvokeServer();
        u7 = v55.configs;
        u8 = v55.idByIdentifier;
        u9 = v55.identifierByConfigId;
        u10 = true;
        u6:Fire();
    end);
end;

return v1;
  

 

local u1 = require("./SpawnResuableThread");

local function disposeTable(p2) -- Line: 3
    if not table.isfrozen(p2) then
        table.clear(p2);
    end;

    if getmetatable(p2) ~= nil then
        setmetatable(p2, nil);
    end;
end;

local function disconnectConnection(p3) -- Line: 13
    if table.find({ "RBXScriptConnection", "table" }, (typeof(p3))) == nil then
        return;
    end;

    if not (p3.Connected and p3.Disconnect) then
        return;
    end;

    p3:Disconnect();
end;

local function cancelThread(p4) -- Line: 25
    if typeof(p4) ~= "thread" then
        return;
    end;

    if coroutine.status(p4) ~= "suspended" then
        return;
    end;

    coroutine.close(p4);
end;

local u11 = {
    Instance = function(p5) -- Line: 38, Name: Instance
        if p5:IsA("AnimationTrack") then
            p5:Stop(0);
        end;

        p5:Destroy();
    end,

    ["function"] = function(p6) -- Line: 46
        -- upvalues: u1 (copy)
        u1(p6);
    end,

    thread = function(p7) -- Line: 50, Name: thread
        if typeof(p7) ~= "thread" then
            return;
        end;

        if coroutine.status(p7) ~= "suspended" then
            return;
        end;

        coroutine.close(p7);
    end,

    RBXScriptConnection = function(p8) -- Line: 54, Name: RBXScriptConnection
        -- upvalues: disconnectConnection (copy)
        disconnectConnection(p8);
    end,

    Tween = function(p9) -- Line: 58, Name: Tween
        p9:Cancel();
        p9:Destroy();
    end,

    table = function(p10) -- Line: 63, Name: table
        if p10.Destroy then
            p10:Destroy();
        end;

        if p10.Disconnect then
            p10:Disconnect();
        end;

        if not table.isfrozen(p10) then
            table.clear(p10);
        end;

        if getmetatable(p10) ~= nil then
            setmetatable(p10, nil);
        end;
    end
};

return function(p12) -- Line: 76
    -- upvalues: u11 (copy), u1 (copy)
    if p12 == nil then
        return;
    end;

    local v13 = typeof(p12);
    local v14 = u11[`{v13}`];

    if v14 == nil then
        warn((`Could not get clean up method for {p12} | {v13}`));

        return;
    end;

    u1(v14, p12);
end;
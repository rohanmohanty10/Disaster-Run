 

 

local UserInputService = game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");

local function waitForDependency(p1: userdata, p2: string) -- Line: 16
    local v3 = p1:WaitForChild(p2, 30);
    local v4 = "[GA] Missing SDK dependency " .. p1:GetFullName() .. "." .. p2 .. " after 30s; install the complete GA package.";
    assert(v3, v4);

    return v3;
end;

local Parent = script.Parent.Parent;
local Shared = Parent:WaitForChild("Shared", 30);
local v5 = "[GA] Missing SDK dependency " .. Parent:GetFullName() .. ".Shared after 30s; install the complete GA package.";
assert(Shared, v5);
local l_require = require;
local Types = Shared:WaitForChild("Types", 30);
local v6 = "[GA] Missing SDK dependency " .. Shared:GetFullName() .. ".Types after 30s; install the complete GA package.";
assert(Types, v6);
local u7 = l_require(Types);
local l_require2 = require;
local Config = Shared:WaitForChild("Config", 30);
local v8 = "[GA] Missing SDK dependency " .. Shared:GetFullName() .. ".Config after 30s; install the complete GA package.";
assert(Config, v8);
local u9 = l_require2(Config);
local v10 = {};
v10.__index = v10;
local u11 = false;
local u12 = tick();
local u13 = false;
local u14 = nil;
local u15 = nil;
local u16 = nil;

local function getRemoteEvent() -- Line: 38
    -- upvalues: u16 (ref), ReplicatedStorage (copy)
    if u16 then
        return u16;
    end;

    u16 = ReplicatedStorage:WaitForChild("GAEvent", 10);

    return u16;
end;

local function sendToServer(p17: string, p18: table?) -- Line: 47
    -- upvalues: u16 (ref), ReplicatedStorage (copy)
    local v19;

    if u16 then
        v19 = u16;
    else
        u16 = ReplicatedStorage:WaitForChild("GAEvent", 10);
        v19 = u16;
    end;

    if not v19 then
        return;
    end;

    v19:FireServer({
        eventType = p17,
        properties = p18 or {},
        clientTimestamp = tick()
    });
end;

local function onUserInput(p20: userdata, p21: boolean) -- Line: 61
    -- upvalues: u12 (ref), u11 (ref), sendToServer (copy), u7 (copy)
    u12 = tick();

    if u11 then
        u11 = false;
        sendToServer(u7.EventType.CUSTOM, {
            eventName = "_sdk_afk_return"
        });
    end;
end;

function v10.start(p22) -- Line: 75
    -- upvalues: u13 (ref), u12 (ref), u11 (ref), u15 (ref), UserInputService (copy), onUserInput (copy), u14 (ref), RunService (copy), sendToServer (copy), u7 (copy), u9 (copy)
    if u13 then
        return;
    end;

    u13 = true;
    u12 = tick();
    u11 = false;
    u15 = UserInputService.InputBegan:Connect(onUserInput);
    local u23 = tick();
    u14 = RunService.Heartbeat:Connect(function() -- Line: 90
        -- upvalues: u11 (ref), u12 (ref), sendToServer (ref), u7 (ref), u23 (ref), u9 (ref)
        local v24 = tick();

        if not u11 and v24 - u12 >= 300 then
            u11 = true;
            sendToServer(u7.EventType.CUSTOM, {
                eventName = "_sdk_afk_start"
            });
        end;

        if v24 - u23 >= u9.DEFAULT.SESSION_HEARTBEAT then
            u23 = v24;
            sendToServer(u7.EventType.CUSTOM, {
                eventName = "_sdk_heartbeat",
                isAFK = u11
            });
        end;
    end);
end;

function v10.stop(p25) -- Line: 115
    -- upvalues: u13 (ref), u14 (ref), u15 (ref)
    if not u13 then
        return;
    end;

    u13 = false;

    if u14 then
        u14:Disconnect();
        u14 = nil;
    end;

    if u15 then
        u15:Disconnect();
        u15 = nil;
    end;
end;

function v10.isPlayerAFK(p26) -- Line: 136
    -- upvalues: u11 (ref)
    return u11;
end;

return v10;
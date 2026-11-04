 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local UserInputService = game:GetService("UserInputService");
local GuiService = game:GetService("GuiService");

local function waitForDependency(p1: userdata, p2: string) -- Line: 18
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
local v8 = {};
v8.__index = v8;
local u9 = nil;
local u10 = {};
local u11 = false;
local u12 = false;

local function getRemoteEvent() -- Line: 41
    -- upvalues: u9 (ref), u12 (ref), ReplicatedStorage (copy)
    if u9 then
        return u9;
    end;

    if u12 then
        u9 = ReplicatedStorage:FindFirstChild("GAEvent");

        return u9;
    end;

    u9 = ReplicatedStorage:WaitForChild("GAEvent", 10);

    if not u9 then
        u12 = true;
        warn("[GA] RemoteEvent not found — is the server SDK initialized?");
    end;

    return u9;
end;

local u13 = 0;
local u14 = (-1 / 0);

local function checkRateLimit() -- Line: 64
    -- upvalues: u10 (copy)
    local v15 = tick();

    while #u10 > 0 and u10[1] < v15 - 5 do
        table.remove(u10, 1);
    end;

    if #u10 >= 10 then
        return false;
    end;

    table.insert(u10, v15);

    return true;
end;

local function sendEvent(p16: string, p17: table?) -- Line: 80
    -- upvalues: checkRateLimit (copy), u13 (ref), u14 (ref), u9 (ref), u12 (ref), ReplicatedStorage (copy)
    if not checkRateLimit() then
        u13 = u13 + 1;

        if os.clock() - u14 >= 60 then
            warn((`[GA] Client rate limit exceeded — {u13} event(s) dropped since the last warning`));
            u14 = os.clock();
            u13 = 0;
        end;

        return;
    end;

    local v18;

    if u9 then
        v18 = u9;
    elseif u12 then
        u9 = ReplicatedStorage:FindFirstChild("GAEvent");
        v18 = u9;
    else
        u9 = ReplicatedStorage:WaitForChild("GAEvent", 10);

        if not u9 then
            u12 = true;
            warn("[GA] RemoteEvent not found — is the server SDK initialized?");
        end;

        v18 = u9;
    end;

    if not v18 then
        return;
    end;

    v18:FireServer({
        eventType = p16,
        properties = p17 or {},
        clientTimestamp = tick()
    });
end;

function v8.track(p19: table, p20: string, p21: table?) -- Line: 107
    -- upvalues: u7 (copy), sendEvent (copy)
    if u7._validEventTypes[p20] then
        sendEvent(p20, p21);

        return;
    end;

    warn((`[GA] Invalid event type: {p20}`));
end;

function v8.trackInteraction(p22: table, p23: string, p24: string?, p25: number?) -- Line: 121
    -- upvalues: sendEvent (copy), u7 (copy)
    sendEvent(u7.EventType.INTERACTION, {
        action = p23,
        target = p24,
        value = p25
    });
end;

function v8.trackProgression(p26: table, p27: string, p28: string, p29: number?) -- Line: 135
    -- upvalues: sendEvent (copy), u7 (copy)
    sendEvent(u7.EventType.PROGRESSION, {
        status = p27,
        level = p28,
        score = p29
    });
end;

function v8.trackCustom(p30: table, p31: string, p32: table?) -- Line: 148
    -- upvalues: sendEvent (copy), u7 (copy)
    local table_clone_ret = table.clone(p32 or {});
    table_clone_ret.eventName = p31;
    sendEvent(u7.EventType.CUSTOM, table_clone_ret);
end;

local function detectDevice() -- Line: 158
    -- upvalues: GuiService (copy), UserInputService (copy)
    return GuiService:IsTenFootInterface() and "Console" or (UserInputService.VREnabled and "VR" or (UserInputService.TouchEnabled and not UserInputService.MouseEnabled and "Mobile" or ((UserInputService.KeyboardEnabled or UserInputService.MouseEnabled) and "Desktop" or "Unknown")));
end;

local u33 = {
    Mobile = true,
    Desktop = true,
    Console = true,
    VR = true
};
local u34 = false;

local function reportDevice() -- Line: 183
    -- upvalues: u34 (ref), ReplicatedStorage (copy), u9 (ref), u33 (copy), detectDevice (copy)
    local v35 = os.clock() + 60;
    local v36 = nil;
    local v37 = nil;

    while not u34 and os.clock() < v35 do
        local GAEvent = ReplicatedStorage:FindFirstChild("GAEvent");

        if GAEvent and GAEvent:IsA("RemoteEvent") then
            if v37 ~= GAEvent then
                if v36 then
                    v36:Disconnect();
                end;

                u9 = GAEvent;
                v36 = GAEvent.OnClientEvent:Connect(function(p38) -- Line: 196
                    -- upvalues: u33 (ref), u34 (ref)
                    if type(p38) == "table" and (type(p38.__goatDeviceAck) == "string" and u33[p38.__goatDeviceAck]) then
                        u34 = true;
                    end;
                end);
                v37 = GAEvent;
            end;

            local success, result = pcall(detectDevice);
            GAEvent:FireServer({
                __goatDevice = not success and "Unknown" or result
            });
        end;

        if not u34 then
            task.wait(2);
        end;
    end;

    if v36 then
        v36:Disconnect();
    end;

    if not u34 then
        warn("[GA] Device metadata was not confirmed within 60s; check server SDK initialization.");
    end;
end;

function v8._init(p39) -- Line: 219
    -- upvalues: u11 (ref), reportDevice (copy)
    if u11 then
        return;
    end;

    u11 = true;
    task.spawn(reportDevice);
end;

v8:_init();

return v8;
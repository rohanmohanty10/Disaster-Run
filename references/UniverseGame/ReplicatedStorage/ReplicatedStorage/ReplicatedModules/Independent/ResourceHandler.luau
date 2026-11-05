  

 

local u1 = {};
u1.__index = u1;
u1.Data = {};
local _ = task.wait;
local _ = task.spawn;
local clamp = math.clamp;
local clear = table.clear;
local v2 = script:FindFirstAncestor("ReplicatedModules");
local RunService = game:GetService("RunService");
local Signal = require(v2.Signal);

function u1.new(p3, p4) -- Line: 54
    -- upvalues: u1 (copy), Signal (copy), RunService (copy)
    if type(p4) ~= "table" then
        error("Invalid Type Passed, Expected Table Value");
    end;

    if u1.Data[p3] then
        error("Resource Already Exists for Given Key");
    end;

    local v5 = Signal.new();
    local u6 = {
        CurrentResource = p4.CurrentResource,
        MaxResource = p4.MaxResource,
        Changed = v5,
        Signal = v5,
        Key = p3
    };

    if type(p4.RegenRate) == "number" and (type(p4.RegenTime) == "number" and (p4.RegenRate > -2 and p4.RegenTime > 0)) then
        u6.RegenRate = p4.RegenRate;
        u6.RegenTime = p4.RegenTime;
        local u7 = 0;
        u6.Heartbeat = RunService.Heartbeat:Connect(function(p8) -- Line: 76
            -- upvalues: u6 (copy), u7 (ref)
            if u6.Pause then
                return;
            end;

            u7 = u7 + p8;

            if u7 >= u6.RegenTime then
                u7 = 0;

                if not u6:IsCapped() then
                    u6:AddResource(u6.RegenRate);
                end;
            end;
        end);
    end;

    u1.Data[p3] = u6;
    setmetatable(u6, u1);

    return u6;
end;

function u1.GetResourceBar(p9) -- Line: 93
    -- upvalues: u1 (copy)
    if not u1.Data[p9] then
        error("Resource Key Does Not Exist");
    end;

    return u1.Data[p9];
end;

function u1.HasResourceBar(p10) -- Line: 100
    -- upvalues: u1 (copy)
    if u1.Data[p10] then
        return true;
    end;
end;

function u1.GetResource(p11) -- Line: 106
    return p11.CurrentResource;
end;

function u1.IsCapped(p12) -- Line: 110
    return p12.CurrentResource >= p12.MaxResource;
end;

function u1.SetResource(p13, p14) -- Line: 114
    -- upvalues: clamp (copy)
    p13.CurrentResource = clamp(p14, 0, p13.MaxResource);
    p13.Signal:Fire(p13.CurrentResource);
end;

function u1.AddResource(p15, p16) -- Line: 119
    -- upvalues: clamp (copy)
    p15.CurrentResource = clamp(p15.CurrentResource + p16, 0, p15.MaxResource);
    p15.Signal:Fire(p15.CurrentResource);
end;

function u1.RemoveResource(p17, p18) -- Line: 124
    -- upvalues: clamp (copy)
    p17.CurrentResource = clamp(p17.CurrentResource - p18, 0, p17.MaxResource);
    p17.Signal:Fire(p17.CurrentResource);
end;

function u1.AddRegenRate(p19, p20) -- Line: 129
    if p19.RegenRate then
        p19.RegenRate = p19.RegenRate + p20;

        return;
    end;

    warn(tostring(p19.Key), "does not have a regen rate defined");
end;

function u1.SetRegenRate(p21, p22) -- Line: 137
    p21.RegenTime = p22;
end;

function u1.AddRegenTime(p23, p24) -- Line: 141
    if p23.RegenTime then
        p23.RegenRate = p23.RegenRate + p24;

        return;
    end;

    warn(tostring(p23.Key), "does not have a regen time defined");
end;

function u1.SetRegenTime(p25, p26) -- Line: 149
    p25.RegenRate = p26;
end;

function u1.InitRegen(u27) -- Line: 153
    -- upvalues: RunService (copy)
    if u27.Heartbeat then
        warn("Regen already exists");

        return;
    end;

    if type(u27.RegenTime) ~= "number" or (type(u27.RegenRate) ~= "number" or (u27.RegenTime <= 0 or u27.RegenRate <= 0)) then
        string.format("Following parameters are invalid\nRegenTime: %s\nRegenRate: %s", tostring(u27.RegenTime), (tostring(u27.RegenRate)));

        return;
    end;

    local u28 = 0;
    u27.Heartbeat = RunService.Heartbeat:Connect(function(p29) -- Line: 161
        -- upvalues: u27 (copy), u28 (ref)
        if u27.Pause then
            return;
        end;

        u28 = u28 + p29;

        if u28 >= u27.RegenTime then
            u28 = 0;

            if not u27:IsCapped() then
                u27:AddResource(u27.RegenRate);
            end;
        end;
    end);
end;

function u1.SetRegenPause(p30, p31) -- Line: 175
    if type(p31) == "boolean" then
        p30.Pause = p31;

        return;
    end;

    error("Passed argument is not of type boolean");
end;

function u1.HasRegen(p32) -- Line: 183
    return p32.Heartbeat and true;
end;

function u1.Destroy(p33) -- Line: 187
    -- upvalues: u1 (copy), clear (copy)
    if p33.Heartbeat then
        p33.Heartbeat:Disconnect();
    end;

    p33.Signal:Destroy();
    u1.Data[p33.Key] = nil;
    setmetatable(p33, nil);
    clear(p33);
end;

return u1;
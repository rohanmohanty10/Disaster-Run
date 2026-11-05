  

 

local u1 = {};
local u2 = rawget;
local clear = table.clear;
local insert = table.insert;
local _ = task.wait;
local Raycast = require(script.Parent.Raycast);
local RunService = game:GetService("RunService");

local function deepCopy(p3) -- Line: 11
    -- upvalues: deepCopy (copy)
    local v4 = {};

    for i, v in pairs(p3) do
        if type(v) == "table" then
            local v = deepCopy(v) or v;
        end;

        v4[i] = v;
    end;

    if getmetatable(p3) then
        local v5 = getmetatable(p3);
        setmetatable(v4, v5);
    end;

    return v4;
end;

local function indexHandler(u6) -- Line: 22
    -- upvalues: u1 (copy), u2 (copy)
    return function(p7, p8) -- Line: 23
        -- upvalues: u1 (ref), u2 (ref), u6 (copy)
        return u2(u1, p8) or u6[p8];
    end;
end;

local function projectileSetup(p9, p10, p11, p12) -- Line: 28
    -- upvalues: Raycast (copy)
    if p12.HitboxData.Type == "Raycast" then
        local HitboxData = p12.HitboxData;
        HitboxData.Blacklisted = {
            [p10.Name] = true
        };
        p9.Hitbox = Raycast.new(HitboxData);
        p9.Hitbox:BindObject(p11, HitboxData.Attachments);
    end;

    return p9;
end;

function u1.new(p13, p14, p15) -- Line: 40
    -- upvalues: deepCopy (copy), projectileSetup (copy), u1 (copy), u2 (copy)
    local v16 = {};

    if not p15.DeepCopied then
        p15 = deepCopy(p15);
    end;

    local v17 = projectileSetup(v16, p13, p14, p15);
    v17.Object = p14;
    v17.Player = p13;
    v17.Data = p15;
    v17.Connections = {};
    local v18 = {};
    local Hitbox = v17.Hitbox;

    function v18.__index(p19, p20) -- Line: 23
        -- upvalues: u1 (ref), u2 (ref), Hitbox (copy)
        return u2(u1, p20) or Hitbox[p20];
    end;

    setmetatable(v17, v18);

    return v17;
end;

function u1.LinearTravel(u21, u22) -- Line: 56
    -- upvalues: RunService (copy), insert (copy)
    insert(u21.Connections, RunService.Heartbeat:Connect(function() -- Line: 57
        -- upvalues: u21 (copy), u22 (copy)
        local Object = u21.Object;
        Object.CFrame = Object.CFrame + u22;
        u21:CastHitbox();
    end));
end;

function u1.Destroy(p23) -- Line: 63
    -- upvalues: clear (copy)
    if p23.Connections then
        for _, v in ipairs(p23.Connections) do
            v:Disconnect();
        end;
    end;

    if p23.Hitbox then
        p23.Hitbox:Destroy();
    end;

    clear(p23);
end;

return u1;
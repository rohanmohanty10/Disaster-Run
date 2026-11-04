 

 

require(script.Parent.Types);
local Config = require(script.Parent.Config);
local Warn = require(script.Parent.Warn);
local u1 = nil;
Config._WaitForLock(function() -- Line: 15
    -- upvalues: u1 (ref), Config (copy)
    u1 = Config._GetConfig("MAX_SNAPSHOT_COUNT");
end);

local function GetBufferIndex(p2: number, p3: number) -- Line: 19
    -- upvalues: u1 (ref)
    return (p2 + p3 - 2) % u1 + 1;
end;

local function BinarySearchInsertionPoint(p4: any, p5: number) -- Line: 23
    -- upvalues: u1 (ref)
    local count = p4.count;

    if count == 0 then
        return 1;
    end;

    local cache = p4.cache;
    local head = p4.head;
    local v6 = 1;

    while v6 <= count do
        local v7 = (v6 + count) // 2;

        if cache[(head + v7 - 2) % u1 + 1].t < p5 then
            v6 = v7 + 1;
        else
            count = v7 - 1;
        end;
    end;

    return v6;
end;

local function ShiftElementsRight(p8: any, p9: number, p10: number) -- Line: 49
    -- upvalues: u1 (ref)
    local cache = p8.cache;
    local head = p8.head;

    for i = p10, p9, -1 do
        cache[(head + (i + 1) - 2) % u1 + 1] = cache[(head + i - 2) % u1 + 1];
        local _ = i;
    end;
end;

local function GetLatest(p11) -- Line: 60
    -- upvalues: u1 (ref)
    if p11.count == 0 then
        return nil;
    end;

    return p11.cache[(p11.head + p11.count - 2) % u1 + 1];
end;

local function Push(p12: any, p13: number, p14: any, p15: any) -- Line: 69
    -- upvalues: BinarySearchInsertionPoint (copy), u1 (ref), ShiftElementsRight (copy)
    local v16 = {
        t = p13,
        value = p14,
        velocity = p15
    };

    if p12.count == 0 then
        p12.cache[p12.head] = v16;
        p12.count = 1;

        return;
    end;

    local v17 = BinarySearchInsertionPoint(p12, p13);

    if p12.count < v17 then
        if p12.count < u1 then
            p12.cache[(p12.head + (p12.count + 1) - 2) % u1 + 1] = v16;
            p12.count = p12.count + 1;

            return;
        end;

        p12.cache[p12.head] = v16;
        p12.head = p12.head % u1 + 1;

        return;
    end;

    if p12.count >= u1 then
        for i = 1, v17 - 1 do
            p12.cache[(p12.head + i - 2) % u1 + 1] = p12.cache[(p12.head + (i + 1) - 2) % u1 + 1];
            local _ = i;
        end;

        p12.cache[(p12.head + v17 - 2) % u1 + 1] = v16;

        return;
    end;

    ShiftElementsRight(p12, v17, p12.count);
    p12.cache[(p12.head + v17 - 2) % u1 + 1] = v16;
    p12.count = p12.count + 1;
end;

local function PushWithCheck(p18: any, p19: number, p20: any, p21: any, p22: number) -- Line: 108
    -- upvalues: u1 (ref), Config (copy), Push (copy)
    local v23;

    if p18.count == 0 then
        v23 = nil;
    else
        v23 = p18.cache[(p18.head + p18.count - 2) % u1 + 1];
    end;

    if v23 and (p19 - v23.t > math.max(p22 * 3, 0.15) and Config.FLAGS.SNAPSHOT_INTERPOLATION_FIX) then
        Push(p18, p19 - p22, v23.value, Vector3.new(0, 0, 0));
    end;

    Push(p18, p19, p20, p21);
end;

local function GetAt(p24: any, p25: number, p26: boolean?) -- Line: 122
    -- upvalues: u1 (ref), BinarySearchInsertionPoint (copy), Warn (copy)
    local count = p24.count;

    if count == 0 then
        return nil;
    end;

    if count == 1 then
        return p24.cache[(p24.head + 1 - 2) % u1 + 1].value;
    end;

    if p25 < 0 then
        local v27;

        if p24.count == 0 then
            v27 = nil;
        else
            v27 = p24.cache[(p24.head + p24.count - 2) % u1 + 1];
        end;

        return v27 and v27.value or nil;
    end;

    local cache = p24.cache;
    local head = p24.head;
    local Lerp = p24.Lerp;
    local lockedTime = p24.lockedTime;

    if p25 < lockedTime then
        if p26 then
            lockedTime = p25;
        end;
    else
        lockedTime = p25;
    end;

    local v28 = BinarySearchInsertionPoint(p24, lockedTime);
    local v29 = v28 - 1;
    local v30 = nil;
    local v31;

    if v29 >= 1 and v29 <= count then
        v31 = cache[(head + v29 - 2) % u1 + 1];
    else
        v31 = nil;
    end;

    if v28 >= 1 and v28 <= count then
        v30 = cache[(head + v28 - 2) % u1 + 1];
    end;

    if not (v31 and v30) then
        if v31 then
            Warn.low("Tried to fetch a time that was ahead of snapshot storage!");

            return v31.value;
        end;

        if not v30 then
            return nil;
        end;

        Warn.low("Tried to fetch a time that was behind snapshot storage!");

        return v30.value;
    end;

    local v32 = v30.t - v31.t;

    if v32 == 0 then
        return v31.value;
    end;

    local v33 = (lockedTime - v31.t) / v32;
    local v34 = Lerp(v31.value.Position, v30.value.Position, v31.velocity, v30.velocity, v33, v32);
    local v35 = v31.value:Lerp(v30.value, v33);

    return CFrame.new(v34) * v35.Rotation;
end;

local function Clear(p36) -- Line: 190
    p36.head = 1;
    p36.count = 0;
    p36.lockedTime = 0;
end;

return function(p37: function) -- Line: 196, Name: New
    -- upvalues: u1 (ref), Push (copy), PushWithCheck (copy), GetLatest (copy), GetAt (copy), Clear (copy)
    local table_create_ret = table.create(u1);

    for i = 1, u1 do
        table_create_ret[i] = {
            t = 0,
            value = nil,
            velocity = nil
        };
        local _ = i;
    end;

    return {
        head = 1,
        count = 0,
        lockedTime = 0,
        cache = table_create_ret,
        Lerp = p37,
        Push = Push,
        PushWithCheck = PushWithCheck,
        GetLatest = GetLatest,
        GetAt = GetAt,
        Clear = Clear
    };
end;
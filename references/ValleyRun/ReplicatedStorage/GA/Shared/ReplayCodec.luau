 

 

local HttpService = game:GetService("HttpService");
local u14 = {
    FORMAT_VERSION = 1,

    q = function(p1: number?, p2: number?) -- Line: 52, Name: q
        if p1 == nil then
            return nil;
        end;

        return math.floor(p1 * (p2 or 100) + 0.5);
    end,

    dq = function(p3: number?, p4: number?) -- Line: 61, Name: dq
        if p3 == nil then
            return nil;
        end;

        return p3 / (p4 or 100);
    end,

    quantizeVec3 = function(p5: any, p6: number?) -- Line: 74, Name: quantizeVec3
        if p5 == nil then
            return nil;
        end;

        local v7 = p6 or 100;
        local v8;

        if typeof(p5) == "Vector3" then
            v8 = p5.X;
        else
            v8 = p5.x;
        end;

        local v9;

        if typeof(p5) == "Vector3" then
            v9 = p5.Y;
        else
            v9 = p5.y;
        end;

        local v10;

        if typeof(p5) == "Vector3" then
            v10 = p5.Z;
        else
            v10 = p5.z;
        end;

        return {
            x = math.floor(v8 * v7 + 0.5),
            y = math.floor(v9 * v7 + 0.5),
            z = math.floor(v10 * v7 + 0.5)
        };
    end,

    dequantizeVec3 = function(p11: table?, p12: number?) -- Line: 91, Name: dequantizeVec3
        if p11 == nil then
            return nil;
        end;

        local v13 = p12 or 100;

        return Vector3.new(p11.x / v13, p11.y / v13, p11.z / v13);
    end
};

function u14.quantizeAngle(p15: number?, p16: number?) -- Line: 104
    -- upvalues: u14 (copy)
    return u14.q(p15, p16 or 10);
end;

function u14.dequantizeAngle(p17: number?, p18: number?) -- Line: 108
    -- upvalues: u14 (copy)
    return u14.dq(p17, p18 or 10);
end;

local function encodedLength(u19) -- Line: 114
    -- upvalues: HttpService (copy)
    local success, result = pcall(function() -- Line: 115
        -- upvalues: HttpService (ref), u19 (copy)
        return HttpService:JSONEncode(u19);
    end);

    return success and #result or (1 / 0);
end;

function u14.encode(p20: any, p21: table?) -- Line: 139
    -- upvalues: u14 (copy), HttpService (copy)
    local v22 = type(p20) == "table";
    assert(v22, "[ReplayCodec] replay must be a table");
    local v23 = type(p20.frames) == "table";
    assert(v23, "[ReplayCodec] replay.frames must be a table");
    local v24 = {
        v = p20.v or u14.FORMAT_VERSION,
        schema = p20.schema or "raw",
        header = p20.header,
        frames = p20.frames,
        events = p20.events
    };
    local frames = p20.frames;
    local v25 = #frames;
    local maxBytes = (p21 or {}).maxBytes;

    if maxBytes then
        local v26;

        if type(maxBytes) == "number" and maxBytes >= 1 then
            v26 = maxBytes < (1 / 0);
        else
            v26 = false;
        end;

        assert(v26, "[ReplayCodec] invalid byte budget");
    end;

    local v27 = HttpService:JSONEncode(v24);
    local v28;

    if maxBytes and maxBytes < #v27 then
        v24.frames = {};
        v27 = HttpService:JSONEncode(v24);
        assert(#v27 <= maxBytes, "[ReplayCodec] header/events exceed byte budget");
        local v29 = v25;
        local v30 = 0;

        while v30 < v25 do
            local math_ceil_ret = math.ceil((v30 + v25) / 2);
            local v31 = {};

            for i = v29 - math_ceil_ret + 1, v29 do
                table.insert(v31, frames[i]);
                local _ = i;
            end;

            v24.frames = v31;
            local v32 = HttpService:JSONEncode(v24);

            if #v32 <= maxBytes then
                v27 = v32;
                v30 = math_ceil_ret;
            else
                v25 = math_ceil_ret - 1;
            end;
        end;

        v24.frames = {};

        for i = v29 - v30 + 1, v29 do
            table.insert(v24.frames, frames[i]);
            local _ = i;
        end;

        v28 = v29 - v30;
    else
        v28 = 0;
    end;

    local v33 = #v24.frames;
    local v34;

    if v33 > 0 then
        local v35 = v24.frames[1].t or 0;
        v34 = math.max(0, (v24.frames[v33].t or v35) - v35);
    else
        v34 = 0;
    end;

    return v27, {
        frameCount = v33,
        byteSize = #v27,
        durationMs = v34,
        droppedFrames = v28
    };
end;

function u14.decode(u36: string) -- Line: 210
    -- upvalues: HttpService (copy)
    if type(u36) ~= "string" or #u36 == 0 then
        return nil, "empty replay payload";
    end;

    local success, result = pcall(function() -- Line: 214
        -- upvalues: HttpService (ref), u36 (copy)
        return HttpService:JSONDecode(u36);
    end);

    if not success then
        return nil, "replay JSON decode failed: " .. tostring(result);
    end;

    if type(result) == "table" and type(result.frames) == "table" then
        return result, nil;
    end;

    return nil, "replay payload missing frames";
end;

return u14;
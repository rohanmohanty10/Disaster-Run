 

 

local RunService = game:GetService("RunService");
local u1 = {
    Frame = 0,
    TotalFrames = 0,
    FPS = 10,
    TimePosition = 0,
    TimeLength = 0,
    IsPlaying = false,
    Frames = Vector2.zero,
    Dimensions = Vector2.zero,
    ImageRectSize = Vector2.zero,
    ImageRectOffset = Vector2.zero,
    Memory = {},
    Scheduled = {}
};
local u3 = {
    TimeLength = function(p2) -- Line: 74, Name: TimeLength
        return p2.TotalFrames / p2.FPS;
    end
};
local u4 = {};

for i, v in pairs(u3) do
    local u5 = {};
    v((setmetatable({}, {
        __index = function(p6, p7) -- Line: 82, Name: __index
            -- upvalues: u5 (copy), u1 (copy)
            u5[p7] = true;

            return u1[p7];
        end
    })));
    local v8 = i;

    for i2 in pairs(u5) do
        if u4[i2] == nil then
            u4[i2] = {};
        end;

        table.insert(u4[i2], v8);
    end;
end;

local u9 = {};

local function deep_copy(p10) -- Line: 95
    -- upvalues: deep_copy (copy)
    if type(p10) ~= "table" then
        return p10;
    end;

    local v11 = {};

    for i, v in pairs(p10) do
        v11[i] = deep_copy(v);
    end;

    local v12 = getmetatable(p10);

    return setmetatable(v11, v12);
end;

local function individual_clean(p13) -- Line: 106
    -- upvalues: individual_clean (copy)
    local v14 = typeof(p13);

    if v14 == "RBXScriptConnection" then
        p13:Disconnect();

        return;
    end;

    if v14 == "Instance" then
        p13:Destroy();

        return;
    end;

    if v14 ~= "table" then
        if v14 == "thread" and coroutine.status(p13) == "suspended" then
            task.cancel(p13);

            return;
        end;

        if v14 == "function" then
            p13();
        end;

        return;
    end;

    if typeof(p13.Destroy) == "function" then
        p13.Destroy(p13);

        return;
    end;

    if typeof(p13.destroy) == "function" then
        p13.destroy(p13);

        return;
    end;

    for _, v in pairs(p13) do
        individual_clean(v);
    end;
end;

local function raw_set(p15: table, p16: string, p17: any) -- Line: 132
    -- upvalues: u4 (copy), u3 (copy)
    p15[p16] = p17;
    local v18 = u4[p16];

    if v18 == nil then
        return;
    end;

    for i = 1, #v18 do
        local v19 = v18[i];
        p15[v19] = u3[v19](p15);
        local _ = i;
    end;
end;

function u9.new() -- Line: 144
    -- upvalues: deep_copy (copy), u1 (copy), u3 (copy), u9 (copy), raw_set (copy)
    local u20 = deep_copy(u1);

    for i, v in pairs(u3) do
        u20[i] = v(u20);
    end;

    return setmetatable({}, {
        __index = function(p21: any, p22: string) -- Line: 153
            -- upvalues: u20 (copy), u9 (ref)
            local v23 = u20[p22];

            if v23 == nil then
                return u9[p22];
            end;

            return v23;
        end,

        __newindex = function(p24: any, p25: string, p26: any) -- Line: 159
            -- upvalues: raw_set (ref), u20 (copy)
            raw_set(u20, p25, p26);
        end
    });
end;

function u9.AttachToInstance(u27: any, p28: userdata) -- Line: 168
    table.insert(u27.Memory, p28.Destroying:Connect(function() -- Line: 169
        -- upvalues: u27 (copy)
        u27:Destroy();
    end));
end;

function u9.Add(p29, p30) -- Line: 174
    table.insert(p29.Scheduled, p30);

    return p30;
end;

function u9.Remove(p31, p32) -- Line: 179
    for i = #p31.Scheduled, 1, -1 do
        if p31.Scheduled[i] == p32 then
            table.remove(p31.Scheduled, i);

            return p32;
        end;

        local _ = i;
    end;

    return p32;
end;

function u9.Update(p33: any, p34: number) -- Line: 189
    p33.TimePosition = math.clamp(p33.TimePosition + p34, 0, p33.TimeLength);
    local math_floor_ret = math.floor(p33.TimePosition * p33.FPS);
    p33.Frame = math_floor_ret;
    local v35 = p33.Dimensions * Vector2.new(1 / p33.Frames.X, 1 / p33.Frames.Y);
    local Vector2_new_ret = Vector2.new(math_floor_ret % p33.Frames.X * v35.X, math.floor(math_floor_ret / p33.Frames.X) * v35.Y);
    p33.ImageRectSize = v35;
    p33.ImageRectOffset = Vector2_new_ret;

    for i = 1, #p33.Scheduled do
        local v36 = p33.Scheduled[i];
        local v37 = typeof(v36);
        local v38;

        if v37 == "Instance" then
            if v36:IsA("ImageLabel") or v36:IsA("ImageButton") then
                v36.ImageRectSize = v35;
                v36.ImageRectOffset = Vector2_new_ret;
                v38 = i;
            else
                v38 = i;
            end;
        elseif v37 == "function" then
            v36(v35, Vector2_new_ret);
            v38 = i;
        else
            v38 = i;
        end;
    end;

    if p33.TotalFrames <= math_floor_ret then
        p33:Clean();
    end;
end;

function u9.Play(u39) -- Line: 222
    -- upvalues: RunService (copy)
    if u39.IsPlaying then
        u39.TimePosition = 0;

        return;
    end;

    u39.IsPlaying = true;
    table.insert(u39.Memory, RunService.Heartbeat:Connect(function(p40) -- Line: 230
        -- upvalues: u39 (copy)
        u39:Update(p40);
    end));
end;

function u9.Pause(p41) -- Line: 235
    -- upvalues: individual_clean (copy)
    if not p41.IsPlaying then
        return;
    end;

    p41.IsPlaying = false;

    for i = #p41.Memory, 1, -1 do
        individual_clean(table.remove(p41.Memory, i));
        local _ = i;
    end;
end;

function u9.Stop(p42) -- Line: 245
    p42:Pause();
    p42.TimePosition = 0;
end;

function u9.Clean(p43) -- Line: 250
    -- upvalues: individual_clean (copy)
    p43.IsPlaying = false;

    for i = #p43.Memory, 1, -1 do
        individual_clean(table.remove(p43.Memory, i));
        local _ = i;
    end;
end;

function u9.Reset(p44) -- Line: 257
    -- upvalues: deep_copy (copy), u1 (copy)
    p44:Clean();

    for i, v in pairs((deep_copy(u1))) do
        p44[i] = v;
    end;
end;

function u9.Destroy(p45) -- Line: 264
    p45:Clean();
end;

return {
    new = u9.new
};
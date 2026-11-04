 

 

local u1 = {};
u1.__index = u1;
local u2 = { "Idle", "Walk", "Run", "Left", "Right", "Back", "Fall", "Stop", "Land", "CaughtIdle" };
local u3 = {
    Stop = true,
    Land = true
};

function u1.new(p4, p5) -- Line: 5
    -- upvalues: u1 (copy)
    return setmetatable({
        nextCheck = 0,
        animator = p4,
        assets = p5,
        tracks = {},
        entries = {}
    }, u1);
end;

function u1.load(u6, p7, u8, p9) -- Line: 8
    -- upvalues: u3 (copy)
    local v10 = u6.entries[p7];

    if v10 and (v10.track and v10.track.Length > 0) then
        return;
    end;

    local v11;

    if v10 then
        local v12 = math.max(1, v10.attempt) * 20;
        v11 = math.min(60, v12) or 0;
    else
        v11 = 0;
    end;

    if v10 and p9 - v10.at < v11 then
        return;
    end;

    local v13 = v10 and (v10.attempt + 1 or 1) or 1;

    if v10 and v10.track then
        v10.track:Destroy();
        u6.tracks[p7] = nil;
    end;

    local success, result = pcall(function() -- Line: 15
        -- upvalues: u6 (copy), u8 (copy)
        return u6.animator:LoadAnimation(u8);
    end);
    local v14 = {
        at = p9,
        attempt = v13
    };
    u6.entries[p7] = v14;

    if not success then
        if v13 == 1 then
            warn("Animation temporarily unavailable; will retry:", p7, result);
        end;

        return;
    end;

    result.Name = "CoH_" .. p7;
    result.Looped = not u3[p7];
    result.Priority = p7 == "CaughtIdle" and Enum.AnimationPriority.Action2 or (u3[p7] and Enum.AnimationPriority.Action or Enum.AnimationPriority.Movement);
    v14.track = result;
    u6.tracks[p7] = result;
end;

function u1.refresh(p15, p16) -- Line: 24
    -- upvalues: u2 (copy)
    if p16 < p15.nextCheck then
        return;
    end;

    p15.nextCheck = p16 + 1;

    for _, v in u2 do
        local v17 = p15.assets[v];

        if v17 then
            p15:load(v, v17.animation, p16);
        end;
    end;

    if p15.runAsset then
        p15:load("KnifeRun", p15.runAsset, p16);
    end;
end;

function u1.setRun(p18, p19) -- Line: 35
    if p19 == p18.runId then
        return;
    end;

    p18.runId = p19;
    local KnifeRun = p18.tracks.KnifeRun;

    if KnifeRun then
        KnifeRun:Stop(0.15);
        task.delay(0.3, function() -- Line: 42
            -- upvalues: KnifeRun (copy)
            KnifeRun:Destroy();
        end);
    end;

    p18.tracks.KnifeRun = nil;
    p18.entries.KnifeRun = nil;

    if p18.runAsset then
        p18.runAsset:Destroy();
        p18.runAsset = nil;
    end;

    if type(p19) == "string" then
        local Animation = Instance.new("Animation");
        Animation.Name = "CoH_KnifeRun";
        Animation.AnimationId = p19;
        p18.runAsset = Animation;
        p18.nextCheck = 0;
    end;
end;

function u1.ready(p20) -- Line: 51
    local v21;

    if p20 == nil then
        v21 = false;
    else
        v21 = p20.Length > 0;
    end;

    return v21;
end;

function u1.coreReady(p22) -- Line: 52
    -- upvalues: u1 (copy)
    local v23 = u1.ready(p22.tracks.Idle) and u1.ready(p22.tracks.Walk) and u1.ready(p22.tracks.Run);

    return v23;
end;

function u1.weights(p24, p25) -- Line: 55
    -- upvalues: u1 (copy)
    local v26 = {};

    for i, v in p25 do
        local v27;

        if u1.ready(p24.tracks[i]) then
            v27 = i;
        elseif i == "Left" or (i == "Right" or i == "Back") then
            v27 = u1.ready(p24.tracks.Walk) and "Walk" or "Run";
        else
            v27 = (i == "Fall" or i == "CaughtIdle") and "Idle" or i;
        end;

        if u1.ready(p24.tracks[v27]) then
            v26[v27] = (v26[v27] or 0) + v;
        end;
    end;

    return v26;
end;

function u1.destroy(p28) -- Line: 67
    for _, v in p28.tracks do
        v:Stop(0.1);
        v:Destroy();
    end;

    table.clear(p28.tracks);
    table.clear(p28.entries);

    if p28.runAsset then
        p28.runAsset:Destroy();
        p28.runAsset = nil;
    end;

    p28.runId = nil;
end;

return u1;
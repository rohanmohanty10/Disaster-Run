 

 

local AnimationConfig = require(script.Parent.AnimationConfig);
local DaggerConfig = require(script.Parent.Parent.Weapons.DaggerConfig);
local KnifeClips = require(script.Parent.Parent.Weapons.KnifeClips);
local u1 = {};
local u2 = {};

local function resolveId(p3, p4) -- Line: 12
    -- upvalues: AnimationConfig (copy), KnifeClips (copy)
    local v5 = AnimationConfig.PublishedIds[p4];
    local v6 = KnifeClips.ByClip[p4];
    local v7;

    if v6 then
        v7 = p3:FindFirstChild("EquippedDagger") or p3:FindFirstChildOfClass("Tool");
    else
        v7 = v6;
    end;

    if v7 then
        v7 = KnifeClips.custom(v7, v6);
    end;

    if v7 then
        return v7, v5;
    end;

    return v5, v5;
end;

function u1.release(p8) -- Line: 20
    -- upvalues: u2 (copy)
    local v9 = u2[p8];

    if not v9 then
        return;
    end;

    u2[p8] = nil;

    for _, v in v9.connections do
        v:Disconnect();
    end;

    for _, v in v9.tracks do
        v.track:Destroy();
        v.asset:Destroy();
    end;
end;

local function loadTrack(u10, p11, p12) -- Line: 27
    -- upvalues: AnimationConfig (copy), KnifeClips (copy), u2 (copy), u1 (copy), loadTrack (copy)
    if not AnimationConfig.Enabled then
        return;
    end;

    local v13 = u10:FindFirstChildOfClass("Humanoid");
    local u14;

    if v13 then
        u14 = v13:FindFirstChildOfClass("Animator");
    else
        u14 = v13;
    end;

    local v15 = AnimationConfig.PublishedIds[p11];
    local v16 = KnifeClips.ByClip[p11];
    local v17;

    if v16 then
        v17 = u10:FindFirstChild("EquippedDagger") or u10:FindFirstChildOfClass("Tool");
    else
        v17 = v16;
    end;

    if v17 then
        v17 = KnifeClips.custom(v17, v16);
    end;

    if p12 then
        v15 = p12;
    else
        p12 = v17 or v15;
    end;

    if not (u14 and (v13.RigType == Enum.HumanoidRigType.R6 and (p12 and p12 ~= ""))) then
        return;
    end;

    local v18 = u2[u10];

    if v18 and v18.animator ~= u14 then
        u1.release(u10);
        v18 = nil;
    end;

    if not v18 then
        v18 = {
            animator = u14,
            tracks = {},
            connections = {}
        };
        u2[u10] = v18;
        table.insert(v18.connections, u10.Destroying:Connect(function() -- Line: 39
            -- upvalues: u1 (ref), u10 (copy)
            u1.release(u10);
        end));
        table.insert(v18.connections, v13.Died:Connect(function() -- Line: 40
            -- upvalues: u1 (ref), u10 (copy)
            u1.stop(u10);
        end));
    end;

    local v19 = v18.tracks[p11];

    if v19 then
        if v19.id == p12 then
            return v19.track;
        end;

        v19.track:Stop(0);
        v19.track:Destroy();
        v19.asset:Destroy();
        v18.tracks[p11] = nil;
    end;

    local Animation = Instance.new("Animation");
    Animation.Name = "CoH_" .. p11;
    Animation.AnimationId = p12;
    local success, result = pcall(function() -- Line: 49
        -- upvalues: u14 (copy), Animation (copy)
        return u14:LoadAnimation(Animation);
    end);

    if success then
        result.Name = Animation.Name;
        result.Looped = false;
        result.Priority = Enum.AnimationPriority.Action3;
        v18.tracks[p11] = {
            track = result,
            asset = Animation,
            id = p12
        };

        return result;
    end;

    Animation:Destroy();

    if p12 ~= v15 then
        KnifeClips.fail(p12);
        warn("Chicken or Hero: custom catch animation failed, using default: " .. tostring(result));

        return loadTrack(u10, p11);
    end;

    warn("Chicken or Hero: could not load catch animation: " .. tostring(result));
end;

function u1.prepare(p20) -- Line: 64
    -- upvalues: loadTrack (copy), AnimationConfig (copy)
    return loadTrack(p20, AnimationConfig.Tackle.Clip);
end;

function u1.stop(p21) -- Line: 67
    -- upvalues: u2 (copy), AnimationConfig (copy)
    local v22 = u2[p21];

    if v22 then
        v22.token = (v22.token or 0) + 1;

        for _, v in v22.tracks do
            if v.track.IsPlaying then
                v.track:Stop(AnimationConfig.Tackle.FadeOut);
            end;
        end;
    end;
end;

local function lengthOf(p23, p24, p25, p26) -- Line: 76
    if p24 then
        p24 = p24:GetAttribute(p25 .. "Length");
    end;

    local v27 = p23.Length > 0 and p23.Length;

    if v27 then
        p26 = v27;
    elseif type(p24) == "number" and (p24 > 0 and p24) then
        p26 = p24;
    end;

    return p26;
end;

function u1.play(u28, p29, p30, p31) -- Line: 80
    -- upvalues: AnimationConfig (copy), loadTrack (copy), u1 (copy), KnifeClips (copy), DaggerConfig (copy), u2 (copy)
    local v32 = p29 or AnimationConfig.Tackle.Clip;
    local u33 = loadTrack(u28, v32);

    if not u33 then
        return false;
    end;

    u1.stop(u28);
    local EquippedDagger = u28:FindFirstChild("EquippedDagger");
    local u34;

    if EquippedDagger then
        u34 = KnifeClips.custom(EquippedDagger, "Dive");
    else
        u34 = EquippedDagger;
    end;

    local v35 = u34 and EquippedDagger;
    local ClipLength = AnimationConfig.Tackle.ClipLength;

    if v35 then
        v35 = v35:GetAttribute("DiveAnimLength");
    end;

    local v36 = u33.Length > 0 and u33.Length;

    if v36 then
        ClipLength = v36;
    elseif type(v35) == "number" and (v35 > 0 and v35) then
        ClipLength = v35;
    end;

    if v32 == "DaggerDive" then
        p30 = math.min(p30, DaggerConfig.DiveDuration) or p30;
    end;

    if v32 == "DaggerDive" then
        if u34 then
            u34 = KnifeClips.normalize(EquippedDagger:GetAttribute("DiveFollowAnim"));
        end;
    else
        u34 = false;
    end;

    if u34 then
        u34 = loadTrack(u28, "DaggerDiveFollow", u34);
    end;

    if not u34 then
        local v37 = ClipLength / math.max(p30, 0.05);
        local v38 = tonumber(p31) or 0;
        local math_max_ret = math.max(0, v38);
        u33:Play(AnimationConfig.Tackle.FadeIn, 1, v37);
        u33.TimePosition = math_max_ret > 0 and u33.Length > 0 and (math.min(math_max_ret * v37, u33.Length - 0.002) or 0) or 0;

        if v32 == "DaggerDive" then
            local u39 = u2[u28];
            local token = u39.token;
            task.delay(math.max(0.05, p30 - 0.02 - math_max_ret), function() -- Line: 132
                -- upvalues: u2 (ref), u28 (copy), u39 (copy), token (copy), u33 (copy), DaggerConfig (ref)
                if u2[u28] ~= u39 or (u39.token ~= token or not u33.IsPlaying) then
                    return;
                end;

                if u33.Length > 0 then
                    u33.TimePosition = math.max(0, u33.Length - 0.002);
                end;

                u33:AdjustSpeed(0);
                u33:Stop(DaggerConfig.DiveFadeOut);
            end);
        end;

        return true;
    end;

    local Attribute = EquippedDagger:GetAttribute("DiveSplit");
    local u40 = p30 * (type(Attribute) == "number" and (math.clamp(Attribute, 0.1, 0.9) or 0.5) or 0.5);
    local math_max_ret = math.max(0.05, p30 - u40);

    if EquippedDagger then
        EquippedDagger = EquippedDagger:GetAttribute("DiveFollowAnimLength");
    end;

    local u41 = u34.Length > 0 and u34.Length or ((type(EquippedDagger) ~= "number" or (EquippedDagger <= 0 or not EquippedDagger)) and 0.5 or EquippedDagger);
    local u42 = u2[u28];
    local token = u42.token;
    local v43 = tonumber(p31) or 0;
    local math_max_ret2 = math.max(0, v43);

    local function finish() -- Line: 100
        -- upvalues: u2 (ref), u28 (copy), u42 (copy), token (copy), u34 (copy), DaggerConfig (ref)
        if u2[u28] ~= u42 or (u42.token ~= token or not u34.IsPlaying) then
            return;
        end;

        if u34.Length > 0 then
            u34.TimePosition = math.max(0, u34.Length - 0.002);
        end;

        u34:AdjustSpeed(0);
        u34:Stop(DaggerConfig.DiveFadeOut);
    end;

    local function second_() -- Line: 105
        -- upvalues: u2 (ref), u28 (copy), u42 (copy), token (copy), u33 (copy), u41 (copy), math_max_ret (copy), u34 (copy), math_max_ret2 (ref), u40 (copy), finish (copy)
        if u2[u28] ~= u42 or u42.token ~= token then
            return;
        end;

        u33:Stop(0.05);
        local v44 = u41 / math_max_ret;
        u34:Play(0.05, 1, v44);
        local math_max_ret3 = math.max(0, math_max_ret2 - u40);

        if math_max_ret3 > 0 and u34.Length > 0 then
            u34.TimePosition = math.min(math_max_ret3 * v44, u34.Length - 0.002);
        end;

        task.delay(math.max(0.05, math_max_ret - 0.02 - math_max_ret3), finish);
    end;

    if u40 <= math_max_ret2 then
        second_();
    else
        local v45 = ClipLength / math.max(u40, 0.05);
        u33:Play(AnimationConfig.Tackle.FadeIn, 1, v45);
        u33.TimePosition = math_max_ret2 > 0 and u33.Length > 0 and (math.min(math_max_ret2 * v45, u33.Length - 0.002) or 0) or 0;
        task.delay(u40 - math_max_ret2, second_);
    end;

    return true;
end;

return u1;
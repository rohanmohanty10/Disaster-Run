 

 

local Parent = script.Parent.Parent;
local AnimationConfig = require(Parent.Animation.AnimationConfig);
local AnimationLibrary = require(Parent.Animation.AnimationLibrary);
local DashAnimation = require(Parent.Animation.DashAnimation);
local BodyFacingConfig = require(Parent.Movement.BodyFacingConfig);
local u1 = {};
u1.__index = u1;
local u2 = { "Idle", "Walk", "Run", "Left", "Right", "Back", "CaughtIdle" };
local u3 = { "Left", "Right", "Back" };
local u4 = { "Idle", "Walk", "Run" };
local u5 = nil;

local function ready(p6) -- Line: 20
    local v7;

    if p6 == nil then
        v7 = false;
    else
        v7 = p6.Length > 0;
    end;

    return v7;
end;

local function smooth(p8) -- Line: 23
    local math_clamp_ret = math.clamp(p8, 0, 1);

    return math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret);
end;

function u1.new(p9) -- Line: 28
    -- upvalues: AnimationLibrary (copy), u1 (copy), u2 (copy)
    local v10 = {
        phase = 0,
        character = p9,
        humanoid = p9:FindFirstChildOfClass("Humanoid"),
        assets = AnimationLibrary.prepare(),
        tracks = {},
        attempts = {},
        retryAt = {},
        loadedAt = {},
        weights = {}
    };
    local v11 = setmetatable(v10, u1);

    for _, v in u2 do
        v11.weights[v] = 0;
    end;

    return v11;
end;

function u1.ensure(p12, p13) -- Line: 46
    -- upvalues: u2 (copy)
    local humanoid = p12.humanoid;

    if not (humanoid and humanoid.Parent) then
        return;
    end;

    local v14 = humanoid:FindFirstChildOfClass("Animator");

    if not v14 then
        v14 = Instance.new("Animator");
        v14.Parent = humanoid;
    end;

    if v14 ~= p12.animator then
        for _, v in p12.tracks do
            v:Destroy();
        end;

        p12.animator = v14;
        table.clear(p12.tracks);
        table.clear(p12.attempts);
        table.clear(p12.retryAt);
    end;

    for _, v in u2 do
        local v15 = p12.tracks[v];

        if v15 and (v15.Length <= 0 and (p13 - (p12.loadedAt[v] or p13) > 8 and (p12.attempts[v] or 0) < 3)) then
            v15:Destroy();
            p12.tracks[v] = nil;
            p12.retryAt[v] = p13 + 2;
            v15 = nil;
        end;

        if not (v15 or ((p12.retryAt[v] or 0) > p13 or (p12.attempts[v] or 0) >= 3)) then
            local v16 = p12.assets[v];

            if v16 then
                p12.attempts[v] = (p12.attempts[v] or 0) + 1;
                p12.retryAt[v] = p13 + 2 * p12.attempts[v];
                local success, result = pcall(v14.LoadAnimation, v14, v16.animation);

                if success then
                    result.Name = "CoH_" .. v;
                    result.Looped = true;
                    result.Priority = v == "CaughtIdle" and Enum.AnimationPriority.Action2 or Enum.AnimationPriority.Movement;
                    p12.tracks[v] = result;
                    p12.loadedAt[v] = p13;
                elseif p12.attempts[v] == 1 then
                    warn("Chicken or Hero bot animation " .. v .. ": " .. tostring(result));
                end;
            end;
        end;
    end;
end;

function u1.reset(p17) -- Line: 93
    -- upvalues: DashAnimation (copy)
    DashAnimation.stop(p17.character);

    for i, v in p17.tracks do
        if i == "Idle" then
            v.Looped = true;
            v:Play(0, 1, 1);
        else
            v:Stop(0);
        end;
    end;

    p17.phase = 0;
end;

function u1.start(p18, p19) -- Line: 106
    -- upvalues: DashAnimation (copy)
    p18:ensure(p19);
    DashAnimation.prepare(p18.character);
    p18:reset();
end;

function u1.inherit(p20, p21) -- Line: 112
    if p21 then
        p21 = p21:FindFirstChildOfClass("Humanoid");
    end;

    if p21 then
        p21 = p21:FindFirstChildOfClass("Animator");
    end;

    if not p21 then
        return;
    end;

    local v22 = false;

    for _, v in p21:GetPlayingAnimationTracks() do
        local Animation = v.Animation;

        if Animation then
            local v23 = v;

            for i, v2 in p20.assets do
                local v24 = p20.tracks[i];

                if v24 and (v2.animation.AnimationId == Animation.AnimationId and v23.WeightCurrent > 0.01) then
                    local v25;

                    if v22 then
                        v25 = i;
                    else
                        v25 = i;

                        for _, v3 in p20.tracks do
                            v3:Stop(0);
                        end;

                        v22 = true;
                    end;

                    v24:Play(0, v23.WeightCurrent, v23.Speed);
                    v24.TimePosition = v23.TimePosition;

                    if (v25 == "Run" or v25 == "Walk") and v23.Length > 0 then
                        p20.phase = v23.TimePosition / v23.Length;
                    end;
                end;
            end;
        end;
    end;
end;

function u1.dash(p26, p27, p28, p29) -- Line: 142
    -- upvalues: DashAnimation (copy)
    return DashAnimation.play(p26.character, p27, p28, p29);
end;

function u1.down(p30) -- Line: 146
    -- upvalues: DashAnimation (copy)
    DashAnimation.stop(p30.character);

    for _, v in p30.tracks do
        if v.IsPlaying then
            v:Stop(0.05);
        end;
    end;

    if p30.decoyTrack and p30.decoyTrack.IsPlaying then
        p30.decoyTrack:Stop(0.05);
    end;
end;

function u1.decoy(p31) -- Line: 157
    -- upvalues: u5 (ref)
    local decoyTrack = p31.decoyTrack;

    if not decoyTrack then
        local v32 = p31.humanoid and p31.humanoid:FindFirstChildOfClass("Animator");

        if not v32 then
            return;
        end;

        if not u5 then
            u5 = Instance.new("Animation");
            u5.Name = "CoH_InflatableDecoy";
            u5.AnimationId = "rbxassetid://127439035853059";
        end;

        local v33;
        v33, decoyTrack = pcall(v32.LoadAnimation, v32, u5);

        if not v33 then
            return;
        end;

        decoyTrack.Priority = Enum.AnimationPriority.Movement;
        decoyTrack.Looped = true;
        p31.decoyTrack = decoyTrack;
    end;

    if not decoyTrack.IsPlaying then
        decoyTrack:Play(0.08);
    end;
end;

function u1.update(p34, p35, p36, p37, p38, p39, p40, p41, p42, p43, p44, p45) -- Line: 183
    -- upvalues: DashAnimation (copy), u2 (copy), BodyFacingConfig (copy), AnimationConfig (copy), u3 (copy), u4 (copy)
    p34:ensure(p35);
    local character = p34.character;
    local tracks = p34.tracks;
    local weights = p34.weights;

    if p43 or (p44 or p42 == "Catcher") then
        DashAnimation.stop(character);
    end;

    for _, v in u2 do
        weights[v] = 0;
    end;

    if p43 then
        local CaughtIdle = tracks.CaughtIdle;
        local v46;

        if CaughtIdle == nil then
            v46 = false;
        else
            v46 = CaughtIdle.Length > 0;
        end;

        if v46 then
            weights.CaughtIdle = 1;
        else
            weights.Idle = 1;
        end;
    elseif p44 or p37 < 0.5 then
        weights.Idle = 1;
    else
        local v47 = p38 * p38 + p39 * p39;
        local v48 = p40 * p40 + p41 * p41;

        if BodyFacingConfig.Enabled and p42 == "Catcher" then
            local v49;

            if v47 >= 0.0001 and v48 >= 0.0001 then
                local math_atan2_ret = math.atan2(p41 * p38 - p40 * p39, p40 * p38 + p41 * p39);
                v49 = math.deg(math_atan2_ret);
            else
                v49 = 0;
            end;

            local math_abs_ret = math.abs(v49);
            local math_clamp_ret = math.clamp((math_abs_ret - 90) / 45, 0, 1);
            local math_max_ret = math.max(0, math_abs_ret - (math_abs_ret <= 90 and math_abs_ret and math_abs_ret or 180 - math_abs_ret) * (1 - math_clamp_ret * math_clamp_ret * (3 - 2 * math_clamp_ret)));
            local math_clamp_ret2 = math.clamp((math_max_ret - 90) / 90, 0, 1);
            local v50 = math_clamp_ret2 * math_clamp_ret2 * (3 - 2 * math_clamp_ret2);
            local v51;

            if math_max_ret <= 90 then
                local math_clamp_ret3 = math.clamp(math_max_ret / 90, 0, 1);
                v51 = math_clamp_ret3 * math_clamp_ret3 * (3 - 2 * math_clamp_ret3) or 1 - v50;
            else
                v51 = 1 - v50;
            end;

            local math_max_ret2 = math.max(0, 1 - v51 - v50);
            local math_clamp_ret3 = math.clamp((p37 - 0.2) / 1.8, 0, 1);
            local v52 = math_clamp_ret3 * math_clamp_ret3 * (3 - 2 * math_clamp_ret3);
            local math_clamp_ret4 = math.clamp((p37 / p45 - AnimationConfig.RunBlendStart) / (AnimationConfig.RunBlendEnd - AnimationConfig.RunBlendStart), 0, 1);
            local v53 = math_clamp_ret4 * math_clamp_ret4 * (3 - 2 * math_clamp_ret4);
            weights.Idle = 1 - v52;
            weights.Walk = v52 * math_max_ret2 * (1 - v53);
            weights.Run = v52 * math_max_ret2 * v53;
            weights.Left = v49 >= 0 and (v52 * v51 or 0) or 0;
            weights.Right = v49 < 0 and (v52 * v51 or 0) or 0;
            weights.Back = v52 * v50;
        else
            local math_clamp_ret = math.clamp((p37 / p45 - 0.3) / 0.6, 0, 1);
            local v54, v55, v56, v57;

            if v47 > 0.0001 and v48 > 0.0001 then
                local math_atan2_ret = math.atan2(p41 * p38 - p40 * p39, p40 * p38 + p41 * p39);
                local math_deg_ret = math.deg(math_atan2_ret);
                local math_abs_ret = math.abs(math_deg_ret);

                if math_abs_ret > 90 then
                    local math_clamp_ret2 = math.clamp((math_abs_ret - 90) / 90, 0, 1);
                    v54 = math_clamp_ret2 * math_clamp_ret2 * (3 - 2 * math_clamp_ret2) or 0;
                else
                    v54 = 0;
                end;

                local v58;

                if math_abs_ret <= 90 then
                    local math_clamp_ret2 = math.clamp(math_abs_ret / 90, 0, 1);
                    v58 = math_clamp_ret2 * math_clamp_ret2 * (3 - 2 * math_clamp_ret2) or 1 - v54;
                else
                    v58 = 1 - v54;
                end;

                v55 = math.max(0, 1 - v58 - v54);
                v56 = math_deg_ret >= 0 and v58 and v58 or 0;
                v57 = math_deg_ret < 0 and v58 and v58 or 0;
            else
                v55 = 1;
                v56 = 0;
                v57 = 0;
                v54 = 0;
            end;

            weights.Walk = v55 * (1 - math_clamp_ret);
            weights.Run = v55 * math_clamp_ret;
            weights.Left = v56;
            weights.Right = v57;
            weights.Back = v54;
        end;

        local Walk = tracks.Walk;
        local v59;

        if Walk == nil then
            v59 = false;
        else
            v59 = Walk.Length > 0;
        end;

        local v60 = v59 and "Walk" or "Run";

        for _, v in u3 do
            local v61 = weights[v];

            if v61 > 0 then
                local v62 = tracks[v];
                local v63;

                if v62 == nil then
                    v63 = false;
                else
                    v63 = v62.Length > 0;
                end;

                if not v63 then
                    weights[v] = 0;
                    local v64 = tracks[v60];
                    local v65;

                    if v64 == nil then
                        v65 = false;
                    else
                        v65 = v64.Length > 0;
                    end;

                    if v65 then
                        weights[v60] = weights[v60] + v61;
                    end;
                end;
            end;
        end;

        for _, v in u4 do
            if weights[v] > 0 then
                local v66 = tracks[v];
                local v67;

                if v66 == nil then
                    v67 = false;
                else
                    v67 = v66.Length > 0;
                end;

                if not v67 then
                    weights[v] = 0;
                end;
            end;
        end;

        local v68 = 0;

        for _, v in u2 do
            v68 = v68 + weights[v];
        end;

        if v68 > 0 then
            for _, v in u2 do
                weights[v] = weights[v] / v68;
            end;
        end;
    end;

    local v69 = false;

    for _, v in u2 do
        if weights[v] > 0.06 then
            local v70 = tracks[v];
            local v71;

            if v70 == nil then
                v71 = false;
            else
                v71 = v70.Length > 0;
            end;

            if v71 then
                v69 = true;
                break;
            end;
        end;
    end;

    if not v69 then
        for _, v in u4 do
            local v72 = tracks[v];
            local v73;

            if v72 == nil then
                v73 = false;
            else
                v73 = v72.Length > 0;
            end;

            if v73 then
                for _, v2 in u2 do
                    weights[v2] = 0;
                end;

                weights[v] = 1;
                break;
            end;
        end;
    end;

    local math_clamp_ret = math.clamp((p37 / p45 - AnimationConfig.RunBlendStart) / (AnimationConfig.RunBlendEnd - AnimationConfig.RunBlendStart), 0, 1);
    local v74 = p37 / math.max(AnimationConfig.WalkReferenceSpeed * (1 - math_clamp_ret) + AnimationConfig.RunReferenceSpeed * (p34.assets.Run and p34.assets.Run.length or AnimationConfig.ClipLengths.Run) * math_clamp_ret, 1);
    local math_clamp_ret2 = math.clamp(v74, 0.25, 3);
    p34.phase = (p34.phase + math_clamp_ret2 * (p36 or 0.08)) % 1;

    for i, v in tracks do
        local v75 = weights[i] or 0;
        local v76 = v.IsPlaying and v.WeightTarget > 0.001;

        if (v76 and 0.03 or 0.06) < v75 then
            v.Looped = true;
            local v77;

            if i == "Idle" or i == "CaughtIdle" then
                v77 = 1;
            elseif i == "Walk" or i == "Run" then
                v77 = math_clamp_ret2 * math.max(v.Length, 0.1);
            else
                v77 = math.clamp(p37 / AnimationConfig.DirectionalReferenceSpeed, 0.5, 2.2);
            end;

            if v76 then
                if math.abs(v.WeightTarget - v75) > 0.05 then
                    v:AdjustWeight(v75, 0.12);
                end;

                if math.abs(v.Speed - v77) > v77 * 0.05 then
                    v:AdjustSpeed(v77);
                end;
            else
                v:Play(0.12, v75, v77);

                if i ~= "Idle" and (i ~= "CaughtIdle" and v.Length > 0) then
                    v.TimePosition = p34.phase * v.Length;
                end;
            end;
        elseif v76 then
            v:Stop(0.12);
        end;
    end;
end;

function u1.destroy(p78) -- Line: 330
    -- upvalues: DashAnimation (copy)
    DashAnimation.release(p78.character);

    for _, v in p78.tracks do
        v:Stop(0);
        v:Destroy();
    end;

    table.clear(p78.tracks);

    if p78.decoyTrack then
        p78.decoyTrack:Destroy();
        p78.decoyTrack = nil;
    end;

    p78.animator = nil;
end;

return u1;
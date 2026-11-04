 

 

local DaggerConfig = require(script.Parent.Parent.Weapons.DaggerConfig);
local KnifeClips = require(script.Parent.Parent.Weapons.KnifeClips);
local ContactCatchConfig = require(script.Parent.Parent.Game.ContactCatchConfig);
local MeleeAttackTimeline = require(script.Parent.MeleeAttackTimeline);
local Players = game:GetService("Players");
local u1 = {};
u1.__index = u1;
local u2 = {
    Equip = "DaggerEquip",
    Hold = "DaggerHold",
    Windup = "DaggerWindup",
    Stab = "DaggerStab"
};

function u1.new(p3) -- Line: 14
    -- upvalues: u1 (copy)
    local v4 = p3:FindFirstChildOfClass("Humanoid");
    local v5;

    if v4 then
        v5 = v4:FindFirstChildOfClass("Animator");
    else
        v5 = v4;
    end;

    if v4 and not v5 then
        v5 = Instance.new("Animator");
        v5.Parent = v4;
    end;

    return setmetatable({
        knife = false,
        character = p3,
        animator = v5,
        tracks = {},
        assets = {},
        attempts = {},
        retryAt = {},
        loadedIds = {},
        ids = {}
    }, u1);
end;

function u1.setDagger(p6, p7) -- Line: 34
    p6.dagger = p7;
end;

function u1.getDagger(p8) -- Line: 37
    local dagger = p8.dagger;

    if dagger and dagger.Parent then
        return dagger;
    end;

    return p8.character:FindFirstChild("EquippedDagger") or p8.character:FindFirstChildOfClass("Tool");
end;

function u1.ensure(u9, p10) -- Line: 44
    -- upvalues: u2 (copy), KnifeClips (copy)
    local Dagger = u9:getDagger();

    if Dagger ~= u9.knife then
        u9.knife = Dagger;

        for i in u2 do
            u9.ids[i] = KnifeClips.id(Dagger, i);
        end;

        u9.ids.Stow = KnifeClips.stow(Dagger);
    end;

    for i, v in u2 do
        local v11 = KnifeClips.default(i);
        local v12 = u9.ids[i];
        local v13 = u9.tracks[i];

        if v13 and u9.loadedIds[i] ~= v12 then
            v13:Stop(0);
            v13:Destroy();
            u9.tracks[i] = nil;
            v13 = nil;
            u9.attempts[i] = nil;
            u9.retryAt[i] = nil;

            if i == "Stab" then
                u9.timing = nil;
            end;
        end;

        if (not v13 or v13.Length <= 0) and p10 >= (u9.retryAt[i] or 0) then
            if v13 and v12 ~= v11 then
                KnifeClips.fail(v12);
                u9.ids[i] = v11;
                v12 = v11;
            end;

            local v14 = (u9.attempts[i] or 0) + 1;
            u9.attempts[i] = v14;
            u9.retryAt[i] = p10 + math.min(60, v14 * 15);

            if v13 then
                v13:Destroy();
            end;

            if u9.assets[i] then
                u9.assets[i]:Destroy();
            end;

            local Animation = Instance.new("Animation");
            Animation.Name = "CoH_" .. v;
            Animation.AnimationId = v12;
            u9.assets[i] = Animation;
            u9.loadedIds[i] = v12;
            local success, result = pcall(function() -- Line: 96
                -- upvalues: u9 (copy), Animation (copy)
                return u9.animator:LoadAnimation(Animation);
            end);

            if success then
                local v15 = KnifeClips.Actions[i];
                result.Name = Animation.Name;
                result.Looped = v15.looped;
                result.Priority = v15.priority;
                u9.tracks[i] = result;
            else
                u9.tracks[i] = nil;

                if v12 ~= v11 then
                    KnifeClips.fail(v12);
                    u9.ids[i] = v11;
                    u9.attempts[i] = nil;
                    u9.retryAt[i] = nil;
                end;

                warn("Dagger animation unavailable", v, result);
            end;

            if i == "Stab" then
                u9.timing = nil;
            end;
        end;
    end;

    u9:ensureStow(p10);
    local v16 = true;

    for i in u2 do
        local v17 = u9.tracks[i];

        if v16 then
            if v17 == nil then
                v16 = false;
            else
                v16 = v17.Length > 0;
            end;
        end;
    end;

    if u9.character:GetAttribute("DaggerAnimationsReady") ~= v16 then
        u9.character:SetAttribute("DaggerAnimationsReady", v16);
    end;

    return v16;
end;

function u1.ensureStow(u18, p19) -- Line: 132
    -- upvalues: KnifeClips (copy)
    local Stow = u18.ids.Stow;
    local Stow2 = u18.tracks.Stow;

    if Stow2 and u18.loadedIds.Stow ~= Stow then
        Stow2:Stop(0);
        Stow2:Destroy();
        u18.assets.Stow:Destroy();
        local assets = u18.assets;
        local loadedIds = u18.loadedIds;
        u18.tracks.Stow = nil;
        assets.Stow = nil;
        loadedIds.Stow = nil;
        Stow2 = nil;
    end;

    if not (Stow and (not Stow2 and p19 >= (u18.retryAt.Stow or 0))) then
        return;
    end;

    u18.retryAt.Stow = p19 + 15;
    local Animation = Instance.new("Animation");
    Animation.Name = "CoH_DaggerStow";
    Animation.AnimationId = Stow;
    local success, result = pcall(function() -- Line: 149
        -- upvalues: u18 (copy), Animation (copy)
        return u18.animator:LoadAnimation(Animation);
    end);

    if not success then
        Animation:Destroy();
        KnifeClips.fail(Stow);
        u18.ids.Stow = nil;

        return;
    end;

    result.Name = Animation.Name;
    result.Looped = KnifeClips.Stow.looped;
    result.Priority = KnifeClips.Stow.priority;
    local assets = u18.assets;
    local loadedIds = u18.loadedIds;
    u18.tracks.Stow = result;
    assets.Stow = Animation;
    loadedIds.Stow = Stow;
end;

function u1.stop(p20, p21, p22) -- Line: 163
    -- upvalues: DaggerConfig (copy)
    local v23 = p20.tracks[p21];

    if v23 and v23.IsPlaying then
        v23:Stop(p22 or DaggerConfig.FadeOut);
    end;
end;

function u1.play(p24, p25, p26) -- Line: 169
    -- upvalues: DaggerConfig (copy)
    local v27 = p24.tracks[p25];

    if not v27 or v27.Length <= 0 then
        return false;
    end;

    v27:Play(DaggerConfig.FadeIn, 1, p26 or 1);

    return true;
end;

function u1.stabTiming(p28) -- Line: 178
    -- upvalues: KnifeClips (copy), DaggerConfig (copy)
    local Stab = p28.tracks.Stab;

    if not (p28.timing or (not Stab or Stab.Length <= 0)) then
        local timing = KnifeClips.timing;
        local knife = p28.knife;
        local v29;

        if p28.loadedIds.Stab == KnifeClips.default("Stab") then
            v29 = nil;
        else
            v29 = Stab.Length or nil;
        end;

        p28.timing = timing(knife, v29);
    end;

    return p28.timing or DaggerConfig;
end;

function u1.reset(p30) -- Line: 185
    -- upvalues: u2 (copy)
    for i in u2 do
        p30:stop(i);
    end;

    p30.preparing = false;
    p30.attackAt = nil;
    p30.stabUntil = nil;
end;

function u1.restartStow(p31) -- Line: 195
    local Stow = p31.tracks.Stow;

    if Stow and Stow.IsPlaying then
        Stow:Stop(0);
    end;
end;

function u1.draw(p32, p33) -- Line: 201
    p32:reset();
    p32.drawingAt = p33;
    p32.drawPlayed = false;
end;

function u1.update(p34, p35, p36, p37, p38, p39) -- Line: 208
    -- upvalues: Players (copy), KnifeClips (copy), DaggerConfig (copy), MeleeAttackTimeline (copy), ContactCatchConfig (copy)
    p34:ensure(p35);
    local character = p34.character;

    if p39 and not p36 then
        p34:stop("Equip");
        p34:stop("Windup");
        p34:stop("Stab");
        p34:stop("Stow");
        p34.preparing = false;
        p34.attackAt = nil;
        p34.stabUntil = nil;
        p34.drawingAt = nil;
        local Hold = p34.tracks.Hold;

        if Hold and (Hold.Length > 0 and not Hold.IsPlaying) then
            p34:play("Hold");
        end;

        return;
    end;

    if not p36 then
        p34:reset();
        p34.drawingAt = nil;
        local Stow = p34.tracks.Stow;

        if Stow then
            local PlayerFromCharacter = Players:GetPlayerFromCharacter(character);
            local v40 = PlayerFromCharacter == nil and true or PlayerFromCharacter:GetAttribute("ClientReady") == true;

            if Stow.IsPlaying and (v40 and p34.stowReady == false) then
                Stow:Stop(0);
            end;

            if not Stow.IsPlaying and p34:play("Stow") then
                p34.stowReady = v40;
            end;
        end;

        return;
    end;

    p34:stop("Stow");
    local Hold = p34.tracks.Hold;

    if Hold and (Hold.Length > 0 and not Hold.IsPlaying) then
        p34:play("Hold");
    end;

    if p37 then
        if not p34.drawPlayed then
            local Equip = p34.tracks.Equip;
            p34.drawPlayed = p34:play("Equip", Equip and KnifeClips.fit(Equip.Length, DaggerConfig.DrawDuration) or 1);
        end;

        return;
    end;

    if p34.drawingAt then
        local Equip = p34.tracks.Equip;

        if Equip then
            Equip:Stop(DaggerConfig.FadeOut);
        end;

        p34.drawingAt = nil;
    end;

    if character:GetAttribute("TackleActive") then
        p34:stop("Equip");
        p34:stop("Windup");
        p34:stop("Stab");
        p34.preparing = false;
        p34.stabUntil = nil;
        p34.attackAt = character:GetAttribute("ReachStartedAt");

        return;
    end;

    if p38 then
        return;
    end;

    if Players:GetPlayerFromCharacter(character) then
        p34:stop("Windup", 0.035);
        p34:stop("Stab", 0.035);
        p34.preparing = false;
        p34.stabUntil = nil;

        return;
    end;

    local Attribute = character:GetAttribute("ReachStartedAt");

    if type(Attribute) == "number" then
        local v41, v42, v43 = MeleeAttackTimeline.sample(p35 - Attribute, ContactCatchConfig, p34:stabTiming());

        if v41 == "Active" or v41 == "Recovery" then
            local Stab = p34.tracks.Stab;

            if Attribute == p34.attackAt then
                if p34.strikePhase ~= v41 and Stab then
                    Stab:AdjustSpeed(v43);
                end;
            elseif p34:play("Stab", v43) then
                local math_max_ret = math.max(0, Stab.Length - 0.001);
                Stab.TimePosition = math.min(v42, math_max_ret);
                p34.attackAt = Attribute;
                p34:stop("Windup", 0.035);
                p34.preparing = false;
            end;

            p34.strikePhase = v41;

            return;
        end;

        if v41 == "Complete" then
            p34.attackAt = Attribute;
        end;
    end;

    if p34.stabUntil and p35 < p34.stabUntil then
        return;
    end;

    p34.stabUntil = nil;
    local Attribute2 = character:GetAttribute("ReachPhase");
    local v44;

    if Attribute2 == "Tracking" or Attribute2 == "Windup" then
        v44 = not character:GetAttribute("MovementLocked");
    else
        v44 = false;
    end;

    if v44 then
        local Windup = p34.tracks.Windup;

        if not (p34.preparing and (not Windup or Windup.IsPlaying)) then
            p34.preparing = p34:play("Windup", DaggerConfig.WindupRate);
        end;

        if Windup and (Windup.IsPlaying and (Windup.Speed ~= 0 and Windup.TimePosition >= Windup.Length - DaggerConfig.WindupHoldTail)) then
            Windup:AdjustSpeed(0);
        end;
    else
        p34:stop("Windup");
        p34.preparing = false;
    end;
end;

function u1.destroy(p45) -- Line: 325
    for _, v in p45.tracks do
        v:Stop(0.1);
        v:Destroy();
    end;

    for _, v in p45.assets do
        v:Destroy();
    end;

    table.clear(p45.tracks);
    table.clear(p45.assets);
    table.clear(p45.loadedIds);
    table.clear(p45.ids);
    p45.knife = false;
    p45.timing = nil;
end;

return u1;
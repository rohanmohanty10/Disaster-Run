 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local Game = ChickenOrHero:WaitForChild("Game");
local HitReplayEvent = Game:WaitForChild("HitReplayEvent");
local HitReplayMath = require(Game.HitReplayMath);
local BossCombat = require(game.ReplicatedStorage:WaitForChild("ChickenOrHero"):WaitForChild("Game"):WaitForChild("BossCombat"));
local ContactCatchConfig = require(Game.ContactCatchConfig);
local DaggerConfig = require(ChickenOrHero.Weapons.DaggerConfig);
local KnifeClips = require(ChickenOrHero.Weapons.KnifeClips);
local MeleeAttackTimeline = require(ChickenOrHero.Animation.MeleeAttackTimeline);
local ParticipantDirectory = require(ChickenOrHero.Presentation.ParticipantDirectory);
local u1 = require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).ClientBots and require(ChickenOrHero:WaitForChild("Bots"):WaitForChild("BotDirectory")) or nil;
local u2 = require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).ServerHits == true;
local u3 = {};
local u4 = game.PlaceId == 130574217370467;
local u5 = {};
local u6 = {};
local u7 = {};
local u8 = {};
local u9 = false;
local u10 = nil;
local u11 = nil;
local u12 = {};
local u13 = {};
local u14 = 0;
local u15 = {};
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
RaycastParams_new_ret.RespectCanCollide = true;

local function clock() -- Line: 36
    return workspace:GetServerTimeNow();
end;

local function sample(p16) -- Line: 40
    local v17;

    if p16 then
        v17 = p16:FindFirstChild("HumanoidRootPart");
    else
        v17 = p16;
    end;

    local v18;

    if p16 then
        v18 = p16:FindFirstChildOfClass("Humanoid");
    else
        v18 = p16;
    end;

    if v17 and (v18 and (v18.Health > 0 and not v17.Anchored)) then
        return v17.Position, p16:GetAttribute("MovementReset"), p16:GetAttribute("CombatRelocation");
    end;

    return nil;
end;

local function victim(p19) -- Line: 50
    -- upvalues: u1 (copy), sample (copy)
    local v20 = nil;
    local v21;

    if type(p19) == "number" then
        v21 = u1 and u1.resolve(p19);

        if not v21 then
            return nil;
        end;

        p19 = v21.Character;

        if typeof(v21) == "Instance" then
            v21 = v20;
        end;
    else
        v21 = v20;
    end;

    if typeof(p19) ~= "Instance" or not p19.Parent then
        return nil;
    end;

    if not p19:GetAttribute("ClientBot") then
        local v22, v23, v24 = sample(p19);

        if v22 then
            return v22, v23, v24, nil, p19;
        end;

        return nil;
    end;

    if not v21 then
        v21 = u1 and u1.ofModel(p19);
    end;

    if not (v21 and (p19:GetAttribute("MovementLocked") ~= true and v21:isActive())) then
        return nil;
    end;

    local v25, _, _, v26 = v21:pose();

    if typeof(v25) == "Vector3" and type(v26) == "number" then
        return v25, p19:GetAttribute("MovementReset"), p19:GetAttribute("CombatRelocation"), v26, p19;
    end;

    return nil;
end;

local function idOf(p27, p28) -- Line: 84
    -- upvalues: Players (copy)
    if type(p27) == "number" then
        return p27;
    end;

    local PlayerFromCharacter = Players:GetPlayerFromCharacter(p28);

    if PlayerFromCharacter then
        return PlayerFromCharacter.UserId;
    end;

    local Attribute = p28:GetAttribute("BotUserId");

    return type(Attribute) == "number" and Attribute and Attribute or nil;
end;

local function validIds(p29) -- Line: 95
    if type(p29) ~= "table" then
        return nil;
    end;

    for _, v in p29 do
        if type(v) ~= "number" then
            return nil;
        end;
    end;

    return p29;
end;

local function notify(p30) -- Line: 106
    -- upvalues: u7 (copy)
    for i in u7 do
        task.spawn(i, p30);
    end;
end;

function u3.subscribe(u31) -- Line: 111
    -- upvalues: u7 (copy)
    u7[u31] = true;

    return {
        Disconnect = function() -- Line: 114, Name: Disconnect
            -- upvalues: u7 (ref), u31 (copy)
            u7[u31] = nil;
        end
    };
end;

local function stopTrack(p32, p33) -- Line: 119
    if p32 and p32.IsPlaying then
        p32:Stop(p33 or 0.06);
    end;
end;

local function clearLocal(p34) -- Line: 124
    if p34 and p34.Parent then
        for _, v in { "LocalMeleeActive", "LocalMeleeStartedAt", "LocalMeleeDirection", "LocalMeleePhase" } do
            p34:SetAttribute(v, nil);
        end;
    end;
end;

local function releaseAnimation() -- Line: 131
    -- upvalues: u10 (ref), clearLocal (copy)
    if not u10 then
        return;
    end;

    clearLocal(u10.character);

    for _, v in u10.tracks do
        v:Stop(0.06);
        v:Destroy();
    end;

    for _, v in u10.assets do
        v:Destroy();
    end;

    u10 = nil;
end;

local function prepareAnimation(p35) -- Line: 145
    -- upvalues: u10 (ref), releaseAnimation (copy)
    local v36;

    if p35 then
        v36 = p35:FindFirstChildOfClass("Humanoid");
    else
        v36 = p35;
    end;

    if v36 then
        v36 = v36:FindFirstChildOfClass("Animator");
    end;

    if not v36 then
        return nil;
    end;

    if u10 and (u10.character == p35 and u10.animator == v36) then
        return u10;
    end;

    releaseAnimation();
    local v37 = {
        retryAt = 0,
        knife = false,
        character = p35,
        animator = v36,
        tracks = {},
        assets = {},
        ids = {}
    };
    u10 = v37;

    return v37;
end;

local u38 = { "Windup", "Stab" };

local function ensureTracks(p39, p40) -- Line: 160
    -- upvalues: u38 (copy), KnifeClips (copy)
    local EquippedDagger = p39.character:FindFirstChild("EquippedDagger");

    if EquippedDagger ~= p39.knife then
        p39.knife = EquippedDagger;
        p39.retryAt = 0;
    end;

    if p40 < p39.retryAt then
        return;
    end;

    p39.retryAt = p40 + 5;

    for _, v in u38 do
        local v41 = KnifeClips.default(v);
        local v42 = KnifeClips.id(EquippedDagger, v);
        local v43 = p39.tracks[v];
        local v44, v45, v46, v47;

        if v43 and p39.ids[v] == v42 then
            if v43.Length <= 0 then
                if v42 ~= v41 then
                    KnifeClips.fail(v42);
                    v42 = v41;
                end;

                if v43 then
                    v43:Stop(0);
                    v43:Destroy();
                end;

                if p39.assets[v] then
                    p39.assets[v]:Destroy();
                end;

                v44 = Instance.new("Animation");
                v44.Name = "CoH_Predicted" .. v;
                v44.AnimationId = v42;
                p39.assets[v] = v44;
                p39.ids[v] = v42;

                if v == "Stab" then
                    p39.timing = nil;
                end;

                v45, v46 = pcall(p39.animator.LoadAnimation, p39.animator, v44);

                if v45 then
                    v47 = KnifeClips.Actions[v];
                    v46.Priority = v47.priority;
                    v46.Looped = v47.looped;
                    p39.tracks[v] = v46;
                else
                    p39.tracks[v] = nil;

                    if v42 ~= v41 then
                        KnifeClips.fail(v42);
                        p39.retryAt = 0;
                    end;
                end;
            end;
        else
            if v43 then
                v43:Stop(0);
                v43:Destroy();
            end;

            if p39.assets[v] then
                p39.assets[v]:Destroy();
            end;

            v44 = Instance.new("Animation");
            v44.Name = "CoH_Predicted" .. v;
            v44.AnimationId = v42;
            p39.assets[v] = v44;
            p39.ids[v] = v42;

            if v == "Stab" then
                p39.timing = nil;
            end;

            v45, v46 = pcall(p39.animator.LoadAnimation, p39.animator, v44);

            if v45 then
                v47 = KnifeClips.Actions[v];
                v46.Priority = v47.priority;
                v46.Looped = v47.looped;
                p39.tracks[v] = v46;
            else
                p39.tracks[v] = nil;

                if v42 ~= v41 then
                    KnifeClips.fail(v42);
                    p39.retryAt = 0;
                end;
            end;
        end;
    end;
end;

local function stabTiming(p48) -- Line: 216
    -- upvalues: KnifeClips (copy), DaggerConfig (copy)
    local Stab = p48.tracks.Stab;

    if not (p48.timing or (not Stab or Stab.Length <= 0)) then
        local timing = KnifeClips.timing;
        local knife = p48.knife;
        local v49;

        if p48.ids.Stab == KnifeClips.default("Stab") then
            v49 = nil;
        else
            v49 = Stab.Length or nil;
        end;

        p48.timing = timing(knife, v49);
    end;

    return p48.timing or DaggerConfig;
end;

local function diagnose(p50, p51) -- Line: 224
    -- upvalues: u2 (copy), u4 (copy)
    if u2 or not (u4 and (p50.kind == "Melee" and not (p50.reported or (next(p50.sent) or not p50.nearest)))) then
        return;
    end;

    p50.reported = true;

    if p50.nearest > p50.box.far + 1.5 then
        return;
    end;

    local v52 = p51 or (p50.blockedBy and "line of sight blocked by " .. p50.blockedBy or ("target outside the swing box: %.1f studs ahead, %.1f to the side (box %.2f–%.2f ahead, ±%.2f wide, overlap %.2f)"):format(p50.nearestForward, p50.nearestSide, p50.box.near, p50.box.far, p50.box.width * 0.5, p50.box.overlap or 0));
    print(("[SwingDiag] no hit sent (%s swing): nearest target %.1f studs; %s"):format(p50.confirmed and "server-confirmed" or "unconfirmed", p50.nearest, v52));
end;

local function endAttack(p53, p54, p55, p56) -- Line: 249
    -- upvalues: diagnose (copy), u5 (copy), u6 (copy), u11 (ref), clearLocal (copy), u10 (ref)
    diagnose(p53, p56);

    for i in p53.ids do
        u5[i] = nil;
        u6[i] = p54 + 5;
    end;

    if u11 == p53 then
        u11 = nil;
        clearLocal(p53.character);

        if u10 and u10.character == p53.character then
            local Windup = u10.tracks.Windup;

            if Windup and Windup.IsPlaying then
                Windup:Stop(0.06);
            end;

            if p55 then
                local Stab = u10.tracks.Stab;

                if Stab and Stab.IsPlaying then
                    Stab:Stop(0.06);
                end;
            end;

            u10.attack = nil;
        end;
    end;
end;

function u3.cancel(p57) -- Line: 267
    -- upvalues: u5 (copy), endAttack (copy)
    local v58 = u5[p57];

    if v58 then
        endAttack(v58, workspace:GetServerTimeNow(), true, "server cancelled the swing");
    end;
end;

local function updateAttack(p59, p60) -- Line: 273
    -- upvalues: HitReplayMath (copy), u1 (copy), u5 (copy)
    p59.confirmed = true;

    if type(p60.startedAt) == "number" then
        p59.startedAt = p60.startedAt;
    end;

    if type(p60.starts) == "number" then
        p59.starts = p60.starts;
    end;

    if type(p60.ends) == "number" then
        p59.ends = p60.ends;
    end;

    if HitReplayMath.vector(p60.direction) then
        if p59.direction:Dot(p60.direction) < 0.99 then
            table.clear(p59.previous);
        end;

        p59.direction = p60.direction;
    end;

    if type(p60.box) == "table" then
        p59.box = p60.box;
    end;

    if type(p60.targets) == "table" then
        p59.targets = p60.targets;
    end;

    local v61 = u1;

    if v61 then
        v61 = p60.targetIds;

        if type(v61) == "table" then
            for _, v in v61 do
                if type(v) ~= "number" then
                    v61 = nil;
                    break;
                end;
            end;
        else
            v61 = nil;
        end;
    end;

    if v61 then
        p59.targetIds = v61;
    end;

    if p60.canonicalId then
        p59.ids[p60.canonicalId] = true;
        u5[p60.canonicalId] = p59;
        p59.id = p60.canonicalId;
    end;
end;

function u3.reconcile(p62, p63, p64) -- Line: 306
    -- upvalues: u5 (copy), u2 (copy), u4 (copy), endAttack (copy), ContactCatchConfig (copy), updateAttack (copy)
    local v65 = u5[p62];

    if not v65 then
        return;
    end;

    if p63 then
        local v66 = type(p64) == "table" and p64 and p64 or {};

        if type(v66.startedAt) == "number" and v65.kind == "Melee" then
            v66.starts = v66.starts or v66.startedAt + ContactCatchConfig.Windup;
            v66.ends = v66.ends or v66.starts + ContactCatchConfig.ActiveDuration;
        end;

        updateAttack(v65, v66);

        return;
    end;

    local v67;

    if type(p64) == "table" and type(p64.reason) == "string" then
        v67 = p64.reason or nil;
    else
        v67 = nil;
    end;

    if u2 and (u4 and (v67 and v65.kind == "Melee")) then
        print("[SwingDiag] server refused the swing: " .. v67);
    end;

    endAttack(v65, workspace:GetServerTimeNow(), true, "server refused the swing" .. (not v67 and "" or ": " .. v67));
end;

function u3.begin(p68) -- Line: 326
    -- upvalues: u3 (copy), u6 (copy), LocalPlayer (copy), u5 (copy), updateAttack (copy), u11 (ref), ContactCatchConfig (copy), sample (copy), u1 (copy), endAttack (copy)
    u3.start();

    if type(p68.id) ~= "string" or (u6[p68.id] or p68.character ~= LocalPlayer.Character) then
        return nil;
    end;

    local v69 = u5[p68.id];

    if v69 then
        updateAttack(v69, p68);

        return v69;
    end;

    if p68.kind == "Melee" and not (p68.predicted or (not u11 or u11.confirmed)) and math.abs((p68.startedAt or p68.starts - ContactCatchConfig.Windup) - u11.startedAt) < ContactCatchConfig.Windup + ContactCatchConfig.ActiveDuration + ContactCatchConfig.Recovery then
        p68.canonicalId = p68.id;
        updateAttack(u11, p68);

        return u11;
    end;

    local ServerTimeNow = workspace:GetServerTimeNow();
    local v70, v71, v72 = sample(p68.character);

    if not v70 then
        return nil;
    end;

    local v73 = {
        visualElapsed = 0,
        id = p68.id,
        ids = {
            [p68.id] = true
        },
        kind = p68.kind,
        character = p68.character,
        startedAt = p68.startedAt or (p68.kind == "Melee" and p68.starts - ContactCatchConfig.Windup or p68.starts),
        starts = p68.starts,
        ends = p68.ends,
        direction = p68.direction,
        box = p68.box,
        targets = p68.targets
    };
    local v74;

    if u1 then
        v74 = p68.targetIds;

        if type(v74) == "table" then
            for _, v in v74 do
                if type(v) ~= "number" then
                    v74 = nil;
                    break;
                end;
            end;
        else
            v74 = nil;
        end;

        if not v74 then
            v74 = nil;
        end;
    else
        v74 = nil;
    end;

    v73.targetIds = v74;
    v73.previous = {};
    v73.sent = {};
    v73.confirmed = p68.predicted ~= true;
    v73.reset = v71;
    v73.relocation = v72;
    v73.createdAt = ServerTimeNow;
    u5[p68.id] = v73;

    if v73.kind == "Melee" then
        if u11 then
            endAttack(u11, ServerTimeNow, true);
        end;

        u11 = v73;
        v73.character:SetAttribute("LocalMeleeActive", true);
        v73.character:SetAttribute("LocalMeleeStartedAt", v73.startedAt);
        v73.character:SetAttribute("LocalMeleeDirection", v73.direction);
    end;

    return v73;
end;

function u3.debugAttacks() -- Line: 388
    -- upvalues: u5 (copy), LocalPlayer (copy)
    local ServerTimeNow = workspace:GetServerTimeNow();
    local v75 = {};
    local v76 = {};

    for _, v in u5 do
        if not v75[v] then
            v75[v] = true;
            local v77;

            if v.character == LocalPlayer.Character then
                v77 = v.character:FindFirstChild("HumanoidRootPart");
            else
                v77 = false;
            end;

            if v77 and (v.starts <= ServerTimeNow and ServerTimeNow <= v.ends) then
                table.insert(v76, {
                    id = v.id,
                    kind = v.kind,
                    character = v.character,
                    position = v77.Position,
                    direction = v.direction,
                    width = v.box.width,
                    height = v.box.height,
                    forwardStart = v.box.near,
                    forwardEnd = v.box.far
                });
            end;
        end;
    end;

    return v76;
end;

function u3.meleeRemaining() -- Line: 413
    -- upvalues: u11 (ref), ContactCatchConfig (copy)
    local v78;

    if u11 then
        local v79 = u11.ends + ContactCatchConfig.Recovery - workspace:GetServerTimeNow();
        v78 = math.max(0, v79) or 0;
    else
        v78 = 0;
    end;

    return v78;
end;

function u3.meleeBox(p80) -- Line: 416
    -- upvalues: HitReplayMath (copy), ContactCatchConfig (copy)
    local v81 = HitReplayMath.bounds("Melee", ContactCatchConfig);

    if p80:GetAttribute("BigDaggerActive") == true then
        v81.far = v81.far * 2;
    end;

    return v81;
end;

local function updateTargets(p82) -- Line: 423
    -- upvalues: u14 (ref), u12 (copy), u13 (copy), Game (copy), ParticipantDirectory (copy), LocalPlayer (copy), u1 (copy), RaycastParams_new_ret (copy)
    if p82 < u14 then
        return;
    end;

    u14 = p82 + 0.1;
    table.clear(u12);
    table.clear(u13);
    local v83 = Game.Session:GetAttribute("AdminMatchMode") == "FFACatchers";

    for _, v in ParticipantDirectory.list() do
        if v.Character then
            table.insert(u13, v.Character);
        end;

        if v ~= LocalPlayer and (v.Character or u1 and (type(v) == "table" and v.IsBot)) and (v:GetAttribute("RunState") == "Active" and (v:GetAttribute("GameRole") == "Runner" or v83 and v:GetAttribute("GameRole") == "Catcher") and v:GetAttribute("FFAInvincible") ~= true) then
            table.insert(u12, u1 and v.UserId or v.Character);
        end;
    end;

    local v84 = u1 and workspace:FindFirstChild("ClientBots");

    if v84 then
        table.insert(u13, v84);
    end;

    RaycastParams_new_ret.FilterDescendantsInstances = u13;
end;

local function reportContacts(p85, p86, p87, p88, p89) -- Line: 452
    -- upvalues: u12 (copy), victim (copy), u4 (copy), HitReplayMath (copy), RaycastParams_new_ret (copy), HitReplayEvent (copy), Players (copy)
    for _, v in p85.targetIds or (p85.targets or u12) do
        local v90, v91, v92, v93, v94 = victim(v);

        if v90 then
            local v95 = p85.previous[v];

            if u4 and (p85.starts <= p86 and p86 <= p85.ends) then
                local v96 = (v90 - p87) * Vector3.new(1, 0, 1);
                local Magnitude = v96.Magnitude;

                if not p85.nearest or Magnitude < p85.nearest then
                    local v97 = p85.direction:Cross(Vector3.new(0, 1, 0));
                    p85.nearest = Magnitude;
                    p85.nearestForward = v96:Dot(p85.direction);
                    local v98 = v96:Dot(v97);
                    p85.nearestSide = math.abs(v98);
                end;
            end;

            if not (p85.sent[v] or (p85.starts > p86 or p86 > p85.ends + 0.08)) then
                local math_min_ret = math.min(p86, p85.ends);
                local v99, v100, v101, v102, v103, v104;

                if v95 and (p86 - v95.at <= 0.08 and (v95.areset == p88 and (v95.arelocation == p89 and (v95.vreset == v91 and (v95.vrelocation == v92 and ((v95.ap - p87).Magnitude <= 14 and (v95.vp - v90).Magnitude <= 14)))))) then
                    v99 = math.max(v95.at, p85.starts);
                    local v105 = v95.at < p86 and ((v99 - v95.at) / (p86 - v95.at) or 1) or 1;
                    v100 = v95.ap:Lerp(p87, v105);
                    v101 = v95.vp:Lerp(v90, v105);
                    local math_clamp_ret = math.clamp(v95.at < p86 and ((math_min_ret - v95.at) / (p86 - v95.at) or 1) or 1, 0, 1);
                    v102 = v95.ap:Lerp(p87, math_clamp_ret);
                    v103 = v95.vp:Lerp(v90, math_clamp_ret);

                    if v93 and v95.vat then
                        v104 = v95.vat + (v93 - v95.vat) * math_clamp_ret;
                    else
                        v104 = v93;
                    end;
                else
                    v104 = v93;
                    v103 = v90;
                    v101 = v103;
                    v102 = p87;
                    v100 = v102;
                    v99 = p86;
                    local v106 = v103;
                    v103 = v101;
                    v106 = v101;
                    v101 = v103;
                    v106 = v102;
                    v102 = v100;
                    v106 = v100;
                    v100 = v102;
                end;

                local v107, v108, v109;

                if v99 <= math_min_ret then
                    v107, v108, v109 = HitReplayMath.sweep(v100, v102, v101, v103, p85.direction, p85.box);
                else
                    v108 = nil;
                    v109 = nil;
                    v107 = false;
                end;

                local HumanoidRootPart = p85.character:FindFirstChild("HumanoidRootPart");

                if HumanoidRootPart and HumanoidRootPart.CollisionGroup then
                    RaycastParams_new_ret.CollisionGroup = HumanoidRootPart.CollisionGroup;
                end;

                local v110 = v108 or v102;
                local v111 = v109 or v103;
                local v112;

                if v107 then
                    v112 = workspace:Raycast(v110, v111 - v110, RaycastParams_new_ret);
                else
                    v112 = v107;
                end;

                if v112 and u4 then
                    p85.blockedBy = v112.Instance:GetFullName();
                end;

                if v107 and not v112 then
                    p85.sent[v] = true;
                    local v113 = v94:GetAttribute("ClientBot") == true;
                    local v114 = {
                        id = p85.id
                    };
                    local v115;

                    if v113 or not v94 then
                        v115 = nil;
                    else
                        v115 = v94;
                    end;

                    v114.target = v115;
                    local v116;

                    if type(v) == "number" then
                        v116 = v;
                    else
                        local PlayerFromCharacter = Players:GetPlayerFromCharacter(v94);

                        if PlayerFromCharacter then
                            v116 = PlayerFromCharacter.UserId;
                        else
                            local Attribute = v94:GetAttribute("BotUserId");
                            v116 = type(Attribute) == "number" and Attribute and Attribute or nil;
                        end;
                    end;

                    v114.targetId = v116;
                    v114.targetAt = v113 and v104 and v104 or nil;
                    v114.at = math_min_ret;
                    v114.span = math.min(0.08, math_min_ret - v99);
                    v114.origin = v102;
                    v114.targetPosition = v103;
                    v114.previousOrigin = v100;
                    v114.previousTargetPosition = v101;
                    HitReplayEvent:FireServer(v114);
                end;
            end;

            if not v95 then
                v95 = {};
                p85.previous[v] = v95;
            end;

            v95.at = p86;
            v95.ap = p87;
            v95.areset = p88;
            v95.arelocation = p89;
            v95.vp = v90;
            v95.vreset = v91;
            v95.vrelocation = v92;
            v95.vat = v93;
        end;
    end;
end;

local function animate(p117) -- Line: 534
    -- upvalues: LocalPlayer (copy), prepareAnimation (copy), ensureTracks (copy), BossCombat (copy), u11 (ref), DaggerConfig (copy), MeleeAttackTimeline (copy), ContactCatchConfig (copy), stabTiming (copy)
    local Character = LocalPlayer.Character;
    local v118 = prepareAnimation(Character);

    if not v118 then
        return;
    end;

    ensureTracks(v118, p117);

    if Character:GetAttribute("TackleActive") or (Character:GetAttribute("MovementLocked") or (not BossCombat.attacker(LocalPlayer) or LocalPlayer:GetAttribute("RunState") ~= "Active")) then
        local Windup = v118.tracks.Windup;

        if Windup and Windup.IsPlaying then
            Windup:Stop(0.06);
        end;

        local Stab = v118.tracks.Stab;

        if Stab and Stab.IsPlaying then
            Stab:Stop(0.06);
        end;

        return;
    end;

    local v119 = u11;

    if not v119 then
        if Character:GetAttribute("ReachPhase") == "Tracking" and Character:GetAttribute("DaggerState") == "Held" then
            local Windup = v118.tracks.Windup;

            if Windup and Windup.Length > 0 then
                if not Windup.IsPlaying then
                    Windup:Play(DaggerConfig.FadeIn, 1, DaggerConfig.WindupRate);
                end;

                if Windup.Speed ~= 0 and Windup.TimePosition >= Windup.Length - DaggerConfig.WindupHoldTail then
                    Windup:AdjustSpeed(0);

                    return;
                end;
            end;
        else
            local Windup = v118.tracks.Windup;

            if Windup and Windup.IsPlaying then
                Windup:Stop(0.06);
            end;
        end;

        return;
    end;

    v119.visualElapsed = math.max(v119.visualElapsed, p117 - v119.startedAt);
    local v120, v121, v122 = MeleeAttackTimeline.sample(v119.visualElapsed, ContactCatchConfig, (stabTiming(v118)));
    Character:SetAttribute("LocalMeleePhase", v120);
    Character:SetAttribute("LocalMeleeDirection", v119.direction);
    local v123 = v120 == "Windup" and "Windup" or "Stab";
    local v124 = v118.tracks[v123];

    if v124 and (v124.Length > 0 and v120 ~= "Complete") then
        if v118.attack == v119 and (v118.key == v123 and v124.IsPlaying) then
            if v118.phase ~= v120 then
                v124:AdjustSpeed(v122);
            end;

            if v121 - v124.TimePosition > 0.05 then
                local math_max_ret = math.max(0, v124.Length - 0.001);
                v124.TimePosition = math.min(v121, math_max_ret);
            end;
        else
            local v125 = v118.tracks[v123 == "Stab" and "Windup" or "Stab"];

            if v125 and v125.IsPlaying then
                v125:Stop(0.035);
            end;

            v124:Play(DaggerConfig.FadeIn, 1, v122);
            local math_max_ret = math.max(0, v124.Length - 0.001);
            v124.TimePosition = math.min(v121, math_max_ret);
        end;

        if v123 == "Windup" and (v124.Speed ~= 0 and v124.TimePosition >= v124.Length - DaggerConfig.WindupHoldTail) then
            v124:AdjustSpeed(0);
        end;

        v118.attack = v119;
        v118.key = v123;
        v118.phase = v120;
    end;
end;

function u3.start() -- Line: 595
    -- upvalues: u9 (ref), u8 (copy), HitReplayEvent (copy), u3 (copy), u1 (copy), u7 (copy), RunService (copy), u2 (copy), updateTargets (copy), u15 (copy), u5 (copy), sample (copy), LocalPlayer (copy), endAttack (copy), ContactCatchConfig (copy), reportContacts (copy), u6 (copy), animate (copy), u11 (ref), releaseAnimation (copy)
    if u9 then
        return;
    end;

    u9 = true;
    table.insert(u8, HitReplayEvent.OnClientEvent:Connect(function(p126, p127) -- Line: 602
        -- upvalues: u3 (ref), u1 (ref), u7 (ref)
        if p126 == "Attack" then
            u3.begin(p127);

            return;
        end;

        if p126 == "Cancel" then
            u3.cancel(p127);

            return;
        end;

        if p126 == "Verdict" then
            if u1 and (type(p127) == "table" and (p127.target == nil and type(p127.targetId) == "number")) then
                local v128 = u1.resolve(p127.targetId);
                p127.target = v128 and v128.Character or nil;
            end;

            for i in u7 do
                task.spawn(i, p127);
            end;
        end;
    end));
    table.insert(u8, RunService.RenderStepped:Connect(function() -- Line: 619
        -- upvalues: u2 (ref), updateTargets (ref), u15 (ref), u5 (ref), sample (ref), LocalPlayer (ref), endAttack (ref), ContactCatchConfig (ref), reportContacts (ref), u6 (ref), animate (ref)
        local ServerTimeNow = workspace:GetServerTimeNow();

        if not u2 then
            updateTargets(ServerTimeNow);
        end;

        table.clear(u15);

        for _, v in u5 do
            if not u15[v] then
                u15[v] = true;
                local v129, v130, v131 = sample(v.character);

                if v129 and (v.character == LocalPlayer.Character and (v130 == v.reset and (v131 == v.relocation and (LocalPlayer:GetAttribute("RunState") == "Active" and not (v.character:GetAttribute("MovementLocked") or v.kind == "Melee" and v.character:GetAttribute("TackleActive")))))) then
                    if v.ends + (v.kind == "Melee" and (ContactCatchConfig.Recovery or 0.1) or 0.1) < ServerTimeNow then
                        endAttack(v, ServerTimeNow, false);
                    elseif not u2 then
                        reportContacts(v, ServerTimeNow, v129, v130, v131);
                    end;
                else
                    endAttack(v, ServerTimeNow, true, "swing interrupted (respawn, lock, tackle or round end)");
                end;
            end;
        end;

        for i, v in u6 do
            if v < ServerTimeNow then
                u6[i] = nil;
            end;
        end;

        animate(ServerTimeNow);
    end));
    table.insert(u8, LocalPlayer.CharacterRemoving:Connect(function() -- Line: 657
        -- upvalues: u5 (ref), u6 (ref), u11 (ref), releaseAnimation (ref)
        table.clear(u5);
        table.clear(u6);
        u11 = nil;
        releaseAnimation();
    end));
end;

function u3.destroy() -- Line: 665
    -- upvalues: u8 (copy), u5 (copy), u6 (copy), u7 (copy), u15 (copy), u11 (ref), u9 (ref), releaseAnimation (copy)
    for _, v in u8 do
        v:Disconnect();
    end;

    table.clear(u8);
    table.clear(u5);
    table.clear(u6);
    table.clear(u7);
    table.clear(u15);
    u11 = nil;
    u9 = false;
    releaseAnimation();
end;

script.Destroying:Connect(u3.destroy);

return u3;
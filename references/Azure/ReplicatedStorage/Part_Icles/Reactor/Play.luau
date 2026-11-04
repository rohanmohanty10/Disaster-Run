 

 

local Trajectory = require(script.Parent.Parent.Rocks.Trajectory);
local Driven = require(script.Parent.Driven);
local Support = require(script.Parent.Support);
local After = require(script.Parent.After);
local Crack = require(script.Parent.Crack);
local Follow = require(script.Parent.Follow);
local STATE = Driven.STATE;
local u1 = {};
u1.__index = u1;

for i, v in pairs(Follow.methods) do
    u1[i] = v;
end;

function u1.new(p2, p3, p4, p5) -- Line: 91
    -- upvalues: u1 (copy)
    local v6 = setmetatable({}, u1);
    v6.pieces = p2;
    v6.settings = p3;
    v6.display = p4;
    v6.castRay = p5;
    v6.airTime = math.max(p3.MaxAirTime, 1);
    v6.pathRules = {
        offWalls = true,
        fromRest = true,
        offEdges = true,
        airTime = v6.airTime
    };
    v6.clock = 0;
    v6.state = table.create(#p2, 0);
    v6.path = {};
    v6.pathStart = {};
    v6.pathBuilt = {};
    v6.gravity = {};
    v6.bounciness = {};
    v6.friction = {};
    v6.lastFrame = {};
    v6.landedAfter = {};
    v6.holdOf = {};
    v6.support = nil;
    v6.supportStale = false;
    v6.kicks = {};
    v6.flying = {};
    v6.driven = {};
    v6.track = {};
    v6.drivePosition = {};
    v6.driveRotation = {};
    v6.driveVelocity = {};
    v6.driveSpin = {};
    v6.pendingWake = {};
    v6.pendingPush = {};
    v6.cracked = {};
    v6.crackPower = {};
    v6.crackFrame = {};
    v6.pendingCrack = {};
    v6.recracking = {};
    v6.buildQueue = {};
    v6.moveIndices = {};
    v6.moveFrames = {};
    v6.moveCount = 0;
    v6.awake = 0;
    v6.hidden = 0;
    v6.placed = false;
    v6.phase = "live";
    v6.phaseTime = 0;
    v6.idleFor = 0;
    v6.held = false;
    v6.busy = false;
    v6.times = {};

    return v6;
end;

function u1._position(p7, p8) -- Line: 165
    if p7.state[p8] ~= 0 then
        return p7.lastFrame[p8].Position;
    end;

    local v9 = p7.pieces[p8];

    return (not v9.strike and p7.crackFrame[p8] or v9.rest).Position;
end;

local function randomAxis(p10) -- Line: 173
    local v11 = p10() * 2 - 1;
    local v12 = p10() * 2 - 1;
    local v13 = p10() * 2 - 1;
    local Vector3_new_ret = Vector3.new(v11, v12, v13);

    return Vector3_new_ret.Magnitude < 0.0001 and Vector3.new(0, 1, 0) or Vector3_new_ret.Unit;
end;

function u1._holdOf(p14, p15) -- Line: 182
    local v16 = p14.holdOf[p15];

    if v16 == nil then
        local settings = p14.settings;
        v16 = settings.Hold * (1 + settings.HoldSpread * (settings.random() * 2 - 1));
        p14.holdOf[p15] = v16;
    end;

    return v16;
end;

function u1._rolled(p17, p18) -- Line: 193
    local settings = p17.settings;

    if p17.gravity[p18] == nil then
        p17.gravity[p18] = settings.rollGravity();
        p17.bounciness[p18] = settings.rollBounciness();
        p17.friction[p18] = settings.rollFriction();
    end;

    return p17.gravity[p18];
end;

function u1._launch(p19, p20, p21, p22, p23) -- Line: 204
    -- upvalues: Trajectory (copy)
    local settings = p19.settings;
    local v24 = p19.track[p20];

    if v24 and not v24.kept then
        p19.track[p20] = nil;
    elseif v24 then
        v24.kept = nil;
    end;

    p19:_rolled(p20);

    if p23.Magnitude < 0.0001 then
        local random = settings.random;
        local v25 = random() * 2 - 1;
        local v26 = random() * 2 - 1;
        local v27 = random() * 2 - 1;
        local Vector3_new_ret = Vector3.new(v25, v26, v27);
        p23 = (Vector3_new_ret.Magnitude < 0.0001 and Vector3.new(0, 1, 0) or Vector3_new_ret.Unit) * settings.rollTumble();
    end;

    p19.path[p20] = Trajectory.ballistic(p21.Position, p22, p21.Rotation, p23);
    p19.pathStart[p20] = p19.clock;
    p19.pathBuilt[p20] = false;
    p19.lastFrame[p20] = p21;
    table.insert(p19.buildQueue, p20);

    if p19.state[p20] ~= 1 then
        p19.state[p20] = 1;
        table.insert(p19.flying, p20);
    end;
end;

function u1._surfaced(p28, p29, p30) -- Line: 234
    -- upvalues: Support (copy), Crack (copy)
    local v31 = p28.pieces[p29];
    local v32 = p30 or v31.rest;
    local v33 = Support.worldHalf(v31).Y + 0.02 + Crack.buried(v31, v32.Position) + (v31.under or 0);
    local v34 = p28.castRay(v32.Position + Vector3.new(0, 1, 0) * v33, Vector3.new(0, 1, 0) * -v33);

    if v34 then
        return v32 + Vector3.new(0, 1, 0) * (v34.Position.Y - v32.Position.Y + 0.02);
    end;

    return v32;
end;

function u1._push(p35, p36, p37) -- Line: 246
    -- upvalues: STATE (copy), Trajectory (copy)
    local v38 = p35.state[p36];

    if v38 == 3 or p35.pieces[p36].fixed then
        return;
    end;

    if v38 == 0 then
        if p35.placed then
            p35:_launch(p36, p35:_surfaced(p36, p35.crackFrame[p36]), p37, Vector3.new(0, 0, 0));
            p35.supportStale = true;

            return;
        end;

        if p35.pendingPush[p36] then
            local pendingPush = p35.pendingPush;
            pendingPush[p36] = pendingPush[p36] + p37;

            return;
        end;

        if p35.awake + #p35.pendingWake >= p35.settings.MaxPieces then
            return;
        end;

        p35.pendingPush[p36] = p37;
        table.insert(p35.pendingWake, p36);

        return;
    end;

    if v38 == STATE then
        local driveVelocity = p35.driveVelocity;
        driveVelocity[p36] = driveVelocity[p36] + p37;

        return;
    end;

    p35:_buildPath(p36);
    local v39 = p35.clock - p35.pathStart[p36];
    local v40 = p35.gravity[p36];
    local v41 = Trajectory.evaluate(p35.path[p36], v39, v40);
    local v42, v43 = Trajectory.velocity(p35.path[p36], v39, v40);
    p35:_launch(p36, v41, v42 + p37, v43);
end;

function u1._wakePending(p44) -- Line: 282
    local pendingWake = p44.pendingWake;
    local v45 = 0;
    local v46 = 0;

    while v45 < #pendingWake and v46 < p44.settings.wakeBudget do
        v45 = v45 + 1;
        local v47 = pendingWake[v45];
        local v48 = p44.pendingPush[v47];
        p44.pendingPush[v47] = nil;
        v46 = v46 + (p44.display.wake(v47) or 1);
        p44.awake = p44.awake + 1;
        p44.hidden = p44.hidden + 1;
        p44:_launch(v47, p44:_surfaced(v47, p44.crackFrame[v47]), v48, Vector3.new(0, 0, 0));
    end;

    if v45 == 0 then
        return;
    end;

    p44.supportStale = true;
    local v49 = {};

    for i = v45 + 1, #pendingWake do
        table.insert(v49, pendingWake[i]);
        local _ = i;
    end;

    p44.pendingWake = v49;
end;

function u1._collapse(u50) -- Line: 311
    -- upvalues: Support (copy)
    u50.supportStale = false;
    local settings = u50.settings;

    if not settings.Collapse then
        return;
    end;

    if not u50.support then
        u50.support = Support.build(u50.pieces, settings.isAnchored);
    end;

    local v53 = Support.unsupported(u50.support, function(p51) -- Line: 320
        -- upvalues: u50 (copy)
        local v52;

        if u50.state[p51] == 0 then
            v52 = u50.pendingPush[p51] == nil;
        else
            v52 = false;
        end;

        return v52;
    end);

    for _, v in ipairs(v53) do
        u50:_push(v, Vector3.new(0, 0, 0));
    end;
end;

function u1._buildPath(p54, p55) -- Line: 330
    -- upvalues: Trajectory (copy)
    if p54.state[p55] ~= 1 or p54.pathBuilt[p55] then
        return;
    end;

    local v56 = p54.path[p55];
    local v57 = v56.segs[#v56.segs];
    local v58 = Trajectory.build(v57.p0, v57.v0, v57.rot0, v57.w, p54.pieces[p55].halfExt, 1, p54.gravity[p55], p54.bounciness[p55], p54.friction[p55], p54.castRay, p54.pathRules);

    if v56.lead then
        v58 = Trajectory.led(v56.lead, v58);
    end;

    p54.path[p55] = v58;
    p54.pathBuilt[p55] = true;
end;

function u1._buildPaths(p59) -- Line: 347
    local buildQueue = p59.buildQueue;
    local math_min_ret = math.min(#buildQueue, p59.settings.buildBudget);

    if math_min_ret == 0 then
        return;
    end;

    for i = 1, math_min_ret do
        p59:_buildPath(buildQueue[i]);
        local _ = i;
    end;

    local v60 = {};

    for i = math_min_ret + 1, #buildQueue do
        table.insert(v60, buildQueue[i]);
        local _ = i;
    end;

    p59.buildQueue = v60;
end;

function u1._flush(p61, p62) -- Line: 366
    local moveIndices = p61.moveIndices;
    local moveFrames = p61.moveFrames;

    for i = p62 + 1, p61.moveCount do
        moveIndices[i] = nil;
        moveFrames[i] = nil;
        local _ = i;
    end;

    p61.moveCount = p62;

    if p62 > 0 then
        p61.display.move(moveIndices, moveFrames, p62);
    end;
end;

function u1._moveFlying(p63) -- Line: 380
    -- upvalues: Trajectory (copy)
    local flying = p63.flying;
    local v64 = 1;
    local v65 = 0;

    while v64 <= #flying do
        local v66 = flying[v64];

        if p63.state[v66] == 1 then
            local v67 = p63.path[v66];
            local v68 = p63.clock - p63.pathStart[v66];

            if p63.pathBuilt[v66] and (v67.restT == (1 / 0) and p63.airTime < v68) then
                local v69 = #flying;
                flying[v64] = flying[v69];
                flying[v69] = nil;
                p63.state[v66] = 3;
                p63.display.drop(v66);
                p63.awake = p63.awake - 1;
            else
                local v70 = Trajectory.evaluate(v67, v68, p63.gravity[v66]);
                p63.lastFrame[v66] = v70;
                v65 = v65 + 1;
                p63.moveIndices[v65] = v66;
                p63.moveFrames[v65] = v70;

                if p63.pathBuilt[v66] and v67.restT <= v68 then
                    local v71 = #flying;
                    flying[v64] = flying[v71];
                    flying[v71] = nil;
                    p63.state[v66] = 2;
                    p63.landedAfter[v66] = v67.restT;
                else
                    v64 = v64 + 1;
                end;
            end;
        else
            local v72 = #flying;
            flying[v64] = flying[v72];
            flying[v72] = nil;
        end;
    end;

    return v65;
end;

function u1.step(p73, p74) -- Line: 425
    -- upvalues: After (copy), Crack (copy), Driven (copy)
    p73.clock = p73.clock + p74;
    p73.busy = true;

    if p73.phase == "fading" then
        return After.fade(p73, p74);
    end;

    if p73.phase == "returning" then
        return After.back(p73, p74);
    end;

    if p73.phase == "closing" then
        return After.close(p73, p74);
    end;

    p73:_followForces();
    p73:_wakePending();

    if p73.supportStale then
        p73:_collapse();
    end;

    p73:_buildPaths();
    p73:_flush(Crack.settle(p73, Driven.step(p73, p74, p73:_moveFlying())));
    p73.busy = (#p73.flying > 0 or (#p73.driven > 0 or (#p73.pendingWake > 0 or (#p73.pendingCrack > 0 or next(p73.recracking) ~= nil)))) and true or p73.held;

    if p73.busy then
        p73.idleFor = 0;

        return "active";
    end;

    local v75 = next(p73.kicks) ~= nil;

    if p73.hidden == 0 then
        return v75 and "active" or "done";
    end;

    local After2 = p73.settings.After;
    local v76;

    if p73.awake > 0 then
        v76 = After.anyLanded(p73);
    else
        v76 = false;
    end;

    local v77 = After2 == "Return" and next(p73.crackFrame) ~= nil and true or v76;

    if After2 == "Stay" or not (p73.settings.closes and true or v77) then
        return v75 and "active" or "dormant";
    end;

    p73.idleFor = p73.idleFor + p74;

    if p73.idleFor >= p73.settings.AfterDelay then
        p73.phaseTime = 0;
        p73.phase = After.begin(p73);
    end;

    return "active";
end;

function u1.place(p78) -- Line: 479
    if p78.placed then
        return;
    end;

    p78.placed = true;

    for i in ipairs(p78.pieces) do
        p78.display.wake(i);
        p78.awake = p78.awake + 1;
        p78.hidden = p78.hidden + 1;
    end;
end;

function u1.restore(p79) -- Line: 493
    for i, v in ipairs(p79.pieces) do
        if p79.state[i] ~= 0 or (p79.placed or p79.crackFrame[i]) then
            p79.display.restore(i);
            p79.state[i] = 0;

            if v.retired then
                p79.state[i] = 3;
            end;
        end;
    end;

    p79.placed = false;
    p79.flying = {};
    p79.driven = {};
    p79.track = {};
    p79.pendingWake = {};
    p79.pendingPush = {};
    p79.cracked = {};
    p79.crackPower = {};
    p79.crackFrame = {};
    p79.pendingCrack = {};
    p79.buildQueue = {};
    p79.kicks = {};
    p79:_flush(0);
    p79.awake = 0;
    p79.hidden = 0;
    p79.phase = "live";
    p79.phaseTime = 0;
    p79.idleFor = 0;
end;

u1.RESTING = 0;
u1.FLYING = 1;
u1.LANDED = 2;
u1.GONE = 3;
u1.DRIVEN = STATE;

return u1;
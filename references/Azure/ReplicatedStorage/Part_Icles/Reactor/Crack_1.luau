 
 

local Fissure = require(script.Parent.Fissure);
local Fields = require(script.Parent.Parent.Force.Fields);
local CRATER = Fissure.CRATER;
local RIM = Fissure.RIM;
local u1 = {};

local function between(p2, p3) -- Line: 121
    local v4 = p2:Dot(p3);
    local math_clamp_ret = math.clamp(v4, -1, 1);
    local math_acos_ret = math.acos(math_clamp_ret);

    return math.deg(math_acos_ret);
end;

local function fromStrike(p5, p6) -- Line: 128
    -- upvalues: Fissure (copy)
    if p5.path then
        local v7, v8, v9 = Fissure.from(p5.path, p6);

        return v7 / (p5.reach * Fissure.leaf(v8)), v9, v8;
    end;

    local normal = p5.normal;
    local v10 = p6 - p5.origin;
    local v11 = v10 - normal * v10:Dot(normal);
    local Magnitude = v11.Magnitude;

    if Magnitude > 0.0001 then
        return Magnitude / p5.reach, v11 / Magnitude;
    end;

    local v12 = normal:Cross(Vector3.new(1, 0, 0));

    if v12.Magnitude < 0.0001 then
        v12 = normal:Cross(Vector3.new(0, 0, 1));
    end;

    return 0, v12.Unit;
end;

local function widerThanCrater(p13, p14, p15, p16) -- Line: 150
    -- upvalues: CRATER (copy), Fissure (copy)
    local v17 = p13.rest:VectorToObjectSpace(p15);
    local halfExt = p13.halfExt;
    local v18 = math.abs(v17.X) * halfExt.X + math.abs(v17.Y) * halfExt.Y + math.abs(v17.Z) * halfExt.Z;
    local v19 = p14.reach * CRATER;

    if p16 then
        v19 = v19 * Fissure.leaf(p16);
    end;

    return v19 < v18;
end;

local function fromHit(p20) -- Line: 161
    -- upvalues: fromStrike (copy), RIM (copy), widerThanCrater (copy)
    local strike = p20.strike;
    local v21, v22, v23 = fromStrike(strike, p20.rest.Position);

    if p20.joined and (v21 < RIM and widerThanCrater(p20, strike, v22, v23)) then
        v21 = RIM;
    end;

    return v21, v22, v23;
end;

function u1.share(p24) -- Line: 170
    -- upvalues: fromStrike (copy), RIM (copy), widerThanCrater (copy)
    local strike = p24.strike;
    local v25, v26, v27 = fromStrike(strike, p24.rest.Position);

    if p24.joined and (v25 < RIM and widerThanCrater(p24, strike, v26, v27)) then
        v25 = RIM;
    end;

    return v25;
end;

function u1.shareAt(p28, p29) -- Line: 175
    -- upvalues: fromStrike (copy)
    return fromStrike(p28, p29);
end;

function u1.outsizes(p30, p31) -- Line: 180
    -- upvalues: fromStrike (copy), widerThanCrater (copy)
    local _, v32, v33 = fromStrike(p31, p30.rest.Position);

    return widerThanCrater(p30, p31, v32, v33);
end;

function u1.holds(p34) -- Line: 185
    -- upvalues: u1 (copy), CRATER (copy)
    local v35;

    if p34.strike == nil then
        v35 = false;
    else
        v35 = CRATER <= u1.share(p34);
    end;

    return v35;
end;

function u1.buried(p36, p37) -- Line: 189
    local strike = p36.strike;

    if not strike or strike.normal.Y < 0.7 then
        return 0;
    end;

    local v38 = (strike.origin - (p37 or p36.rest.Position)):Dot(strike.normal);

    return math.max(v38, 0) / strike.normal.Y;
end;

function u1.reached(p39, p40, p41) -- Line: 198
    -- upvalues: fromStrike (copy), RIM (copy), widerThanCrater (copy), Fields (copy)
    local strike = p39.strike;

    if not (strike and (strike.path and strike.by == p40)) then
        return nil;
    end;

    local strike2 = p39.strike;
    local v42, v43, v44 = fromStrike(strike2, p39.rest.Position);

    if p39.joined and (v42 < RIM and widerThanCrater(p39, strike2, v43, v44)) then
        v42 = RIM;
    end;

    if v42 > 1 then
        return nil;
    end;

    local field = p40.field;
    local v45 = field.inner + v44 * (field.range - field.inner);

    return Fields.heading(field, p41), v45, v45 / field.range;
end;

function u1.power(p46, p47) -- Line: 212
    local v48 = math.abs(p47) * 0.2 / (p46.crust * 0.7);

    return math.clamp(v48, 0, 1);
end;

function u1.pose(p49, p50, p51, p52) -- Line: 216
    -- upvalues: fromStrike (copy), RIM (copy), widerThanCrater (copy), CRATER (copy)
    local strike = p49.strike;
    local normal = strike.normal;
    local strike2 = p49.strike;
    local v53, v54, v55 = fromStrike(strike2, p49.rest.Position);

    if p49.joined and (v53 < RIM and widerThanCrater(p49, strike2, v54, v55)) then
        v53 = RIM;
    end;

    local v56 = strike.crust * 0.7;
    local v57 = p52 == nil and 1 or p52;
    local v58, v59, v60;

    if v53 < CRATER then
        local v61 = 1 - v53 / CRATER;
        v58 = -v56 * (0.19 + 0.81 * v61 ^ 1.3) * (0.7 + 0.6 * p50()) * v57;
        v59 = (8 + 16 * v61) * (0.5 + p50()) * v57;
        v60 = (p50() - 0.5) * 26 * v57;
    elseif v53 < RIM then
        local v62 = 1 - (v53 - CRATER) / (RIM - CRATER);
        v58 = v56 * 0.17 * v62 * (0.5 + p50()) * v57;
        v59 = -9 * v62 * (0.4 + p50()) * v57;
        v60 = (p50() - 0.5) * 9 * v62 * v57;
    else
        v58 = v56 * 0.027 * (p50() - 0.5);
        v59 = (p50() - 0.5) * 1.2;
        v60 = 0;
    end;

    local v63 = v54:Cross(normal);
    local v64 = CFrame.fromAxisAngle(v63, (math.rad(v59))) * CFrame.fromAxisAngle(v54, (math.rad(v60)));
    local v65 = p51 or p49.rest;
    local v66 = (v65.Position - p49.rest.Position):Dot(normal);
    local Rotation = v65.Rotation;

    if v53 < CRATER then
        Rotation = p49.rest.Rotation;
        v58 = v58 + (math.min(v66, 0) - v66);
    end;

    local math_clamp_ret = math.clamp(v58, -strike.crust * 0.95 - v66, strike.crust * 0.6 - v66);
    local v67 = v64 * Rotation;
    local v68 = p49.rest:VectorToObjectSpace(normal);
    local v69 = Rotation:VectorToWorldSpace(v68):Dot(normal);
    local math_clamp_ret2 = math.clamp(v69, -1, 1);
    local math_acos_ret = math.acos(math_clamp_ret2);
    local math_deg_ret = math.deg(math_acos_ret);
    local v70 = v67:VectorToWorldSpace(v68):Dot(normal);
    local math_clamp_ret3 = math.clamp(v70, -1, 1);
    local math_acos_ret2 = math.acos(math_clamp_ret3);
    local math_deg_ret2 = math.deg(math_acos_ret2);

    if math_deg_ret2 > 40 and math_deg_ret < math_deg_ret2 then
        v67 = Rotation:Lerp(v67, (math.clamp((40 - math_deg_ret) / (math_deg_ret2 - math_deg_ret), 0, 1)));
    end;

    return CFrame.new(v65.Position + normal * math_clamp_ret) * v67;
end;

function u1.strike(p71, p72, p73) -- Line: 265
    -- upvalues: u1 (copy), RIM (copy)
    if p71.cracked[p72] or (p71.state[p72] ~= 0 or p71.pendingPush[p72]) then
        return;
    end;

    local v74 = p71.pieces[p72];

    if v74.atEdge and RIM <= u1.share(v74) then
        return;
    end;

    p71.cracked[p72] = true;
    p71.crackPower[p72] = u1.power(v74.strike, p73);
    table.insert(p71.pendingCrack, p72);
end;

function u1.settle(p75, p76) -- Line: 279
    -- upvalues: u1 (copy)
    local pendingCrack = p75.pendingCrack;

    if #pendingCrack == 0 then
        return p76;
    end;

    local v77 = 0;
    local v78 = 0;

    while v77 < #pendingCrack and v78 < p75.settings.wakeBudget do
        v77 = v77 + 1;
        local v79 = pendingCrack[v77];

        if p75.state[v79] == 0 and not p75.pendingPush[v79] then
            v78 = v78 + (p75.display.wake(v79) or 1);
            p75.hidden = p75.hidden + 1;
            local v80 = u1.pose(p75.pieces[v79], p75.settings.random, p75.crackFrame[v79], p75.crackPower[v79]);
            p75.crackFrame[v79] = v80;
            p76 = p76 + 1;
            p75.moveIndices[p76] = v79;
            p75.moveFrames[p76] = v80;
        end;
    end;

    local v81 = {};

    for i = v77 + 1, #pendingCrack do
        table.insert(v81, pendingCrack[i]);
        local _ = i;
    end;

    p75.pendingCrack = v81;

    return p76;
end;

function u1.returning(p82, p83, p84) -- Line: 309
    for i, v in pairs(p82.crackFrame) do
        if p82.state[i] == 0 then
            p84 = p84 + 1;
            p82.moveIndices[p84] = i;
            p82.moveFrames[p84] = v:Lerp(p82.pieces[i].rest, p83);
        end;
    end;

    return p84;
end;

return u1;
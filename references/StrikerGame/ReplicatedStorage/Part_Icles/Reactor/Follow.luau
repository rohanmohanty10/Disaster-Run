 

 

local Fields = require(script.Parent.Parent.Force.Fields);
local Driven = require(script.Parent.Driven);
local Crack = require(script.Parent.Crack);
local Slash = require(script.Parent.Slash);
local v1 = {};
local v2 = {};
v1.methods = v2;

function v2.watch(p3, p4) -- Line: 35
    if p3.phase ~= "live" then
        return false;
    end;

    if not p3.kicks[p4] then
        p3.kicks[p4] = {};
    end;

    return true;
end;

function v2.strike(p5, p6) -- Line: 50
    if p5.phase ~= "live" then
        return false;
    end;

    local v7 = (p6.ended or not p5:watch(p6)) and {} or p5.kicks[p6];
    p5:_applyImpulse(p6, v7);
    p5.idleFor = 0;

    return true, v7;
end;

function v2.answer(p8, p9, p10) -- Line: 67
    if p9.actsAs == "Impulse" and not p10 then
        return p8:strike(p9);
    end;

    if p9.actsAs == "Impulse" or not p9.ended then
        return p8:watch(p9), p8.kicks[p9];
    end;

    return false, nil;
end;

function v2.kickAgain(p11, p12, p13, p14) -- Line: 80
    if p11.phase ~= "live" then
        return;
    end;

    for _, v in ipairs(p14) do
        p13[v] = nil;
    end;

    p11:_applyImpulse(p12, p13);
    p11.idleFor = 0;
end;

function v2._takeTime(p15, p16) -- Line: 93
    local times = p15.times;
    local time = p16.time;

    if time and not table.find(times, time) then
        table.insert(times, time);
    end;

    local ownTime = p16.ownTime;

    if ownTime and not table.find(times, ownTime) then
        table.insert(times, ownTime);
    end;
end;

function v2._applyImpulse(p17, p18, p19) -- Line: 106
    -- upvalues: Slash (copy), Fields (copy), Crack (copy)
    local settings = p17.settings;
    local field = p18.field;
    local front = p18.front;
    local strength = p18.strength;
    local v20 = strength < 0;
    local v21 = p17.recracking[p18];
    local v22 = p18.moving == true;
    Slash.kick(p17, p18, p19);

    for i, v in ipairs(p17.pieces) do
        local v23;

        if v21 then
            if v21 == "all" then
                v23 = true;
            elseif v.strike == nil then
                v23 = false;
            else
                v23 = p17.state[i] == 0;
            end;
        else
            v23 = v21;
        end;

        if not (p19[i] or (p17.state[i] == 3 or (v.fixed or v23))) then
            local v24, v25, v26 = Fields.sample(field, p17:_position(i), v20);

            if not v24 then
                v24, v25, v26 = Crack.reached(v, p18, v20);
            end;

            if v24 and v25 <= front then
                p19[i] = true;

                if v.strike and (settings.takesAfter and p18.after) then
                    settings.After = p18.after;
                    settings.AfterDelay = p18.afterDelay or settings.AfterDelay;
                end;

                local v27 = Fields.sizeShare(v.size, p18.sizeResponse);
                local v28 = 1 + p18.variation * (settings.random() * 2 - 1);
                local v29 = strength * Fields.kept(p18.falloff, v26) * v27 * v28;

                if math.abs(v29) > p17:_holdOf(i) and not Crack.holds(v) then
                    p17:_push(i, v24 * Fields.throwSpeed(v29, p17:_rolled(i)));
                    p17:_takeTime(p18);
                elseif v.strike then
                    Crack.strike(p17, i, strength);
                end;
            elseif v24 or v22 then
                p17.held = true;
            end;
        end;
    end;
end;

function v2._followForces(p30) -- Line: 147
    -- upvalues: Driven (copy)
    p30.held = false;

    for i, v in pairs(p30.kicks) do
        if i.ended then
            p30.kicks[i] = nil;
        elseif i.actsAs == "Impulse" then
            p30:_applyImpulse(i, v);
        else
            Driven.capture(p30, i);

            if i.moving then
                p30.held = true;
            end;
        end;
    end;
end;

return v1;
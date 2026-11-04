 
 

local RunService = game:GetService("RunService");
require(script.Parent.types);
local immediate = require(script.Parent.solvers.immediate);
local linear = require(script.Parent.solvers.linear);
local spring = require(script.Parent.solvers.spring);
local tween = require(script.Parent.solvers.tween);
local intermediate = require(script.Parent.utils.intermediate);
local assign = require(script.Parent.utils.assign);
local merge = require(script.Parent.utils.merge);
local u1 = {
    start = false,
    heartbeat = RunService.Heartbeat
};

return function(p2, p3) -- Line: 17, Name: createMotion
    -- upvalues: merge (copy), u1 (copy), intermediate (copy), assign (copy), immediate (copy), linear (copy), spring (copy), tween (copy)
    local u4 = merge(u1, p3 or {});
    local u5 = typeof(p2);
    local u6 = {};
    local u7 = {};
    local u8 = {};
    local u9 = 1;
    local u10 = nil;
    local u11 = false;
    local u12 = {};
    local u13 = nil;

    for i, v in intermediate.to(p2) do
        u6[i] = {
            complete = true,
            value = v
        };
    end;

    local function stop() -- Line: 39
        -- upvalues: u10 (ref)
        if u10 then
            u10:Disconnect();
            u10 = nil;
        end;
    end;

    local v56 = {
        state = u6,

        start = function(u14) -- Line: 46, Name: start
            -- upvalues: u10 (ref), stop (copy), u4 (copy)
            if u10 then
                return stop;
            end;

            u10 = u4.heartbeat:Connect(function(p15) -- Line: 51
                -- upvalues: u14 (copy)
                u14:step(p15);
            end);

            return stop;
        end,

        stop = stop,

        get = function() -- Line: 58, Name: get
            -- upvalues: u6 (copy), intermediate (ref), u5 (copy)
            local v16 = {};

            for i, v in u6 do
                v16[i] = v.value;
            end;

            return intermediate.from(v16, u5);
        end,

        set = function(p17, p18) -- Line: 78, Name: set
            -- upvalues: intermediate (ref), u6 (copy)
            local v19 = intermediate.to(p18);

            for i, v in u6 do
                local v20 = v19[i];

                if v20 then
                    v.value = v20;
                    v.complete = false;
                end;
            end;
        end,

        getVelocity = function() -- Line: 68, Name: getVelocity
            -- upvalues: u6 (copy), intermediate (ref), u5 (copy)
            local v21 = {};

            for i, v in u6 do
                v21[i] = v.velocity or 0;
            end;

            return intermediate.from(v21, u5);
        end,

        setVelocity = function(p22, p23) -- Line: 130, Name: setVelocity
            -- upvalues: intermediate (ref), u6 (copy)
            for i, v in intermediate.to(p23) do
                local v24 = u6[i];

                if v24 and v24.velocity then
                    v24.complete = false;
                    v24.velocity = v;
                end;
            end;
        end,

        impulse = function(p25, p26) -- Line: 102, Name: impulse
            -- upvalues: u6 (copy), intermediate (ref)
            if type(p26) == "number" then
                for _, v in u6 do
                    if v.velocity then
                        v.complete = false;
                        v.velocity = v.velocity + p26;
                    end;
                end;

                return;
            end;

            for i, v in intermediate.to(p26) do
                local v27 = u6[i];

                if v27 and v27.velocity then
                    v27.complete = false;
                    v27.velocity = v27.velocity + v;
                end;
            end;
        end,

        patch = function(p28, p29) -- Line: 91, Name: patch
            -- upvalues: u6 (copy), assign (ref)
            for i, v in u6 do
                local v30 = p29[i];

                if v30 then
                    v.complete = false;
                    assign(v, v30);
                end;
            end;
        end,

        to = function(p31, p32) -- Line: 145, Name: to
            -- upvalues: u6 (copy), u7 (copy)
            if type(p32) == "function" then
                for i, v in u6 do
                    if v.destructor then
                        v.destructor();
                        v.destructor = nil;
                    end;

                    v.complete = false;

                    if p32(i, v, 0) ~= false then
                        u7[i] = p32;
                    end;
                end;

                return;
            end;

            for i, v in p32 do
                local v33 = u6[i];

                if v33 then
                    if v33.destructor then
                        v33.destructor();
                        v33.destructor = nil;
                    end;

                    v33.complete = false;

                    if v(i, v33, 0) ~= false then
                        u7[i] = v;
                    end;
                end;
            end;
        end,

        immediate = function(p34, p35) -- Line: 185, Name: immediate
            -- upvalues: immediate (ref)
            p34:to(immediate(p35));
        end,

        linear = function(p36, p37, p38) -- Line: 189, Name: linear
            -- upvalues: linear (ref)
            p36:to(linear(p37, p38));
        end,

        spring = function(p39, p40, p41) -- Line: 193, Name: spring
            -- upvalues: spring (ref)
            p39:to(spring(p40, p41));
        end,

        tween = function(p42, p43, p44) -- Line: 197, Name: tween
            -- upvalues: tween (ref)
            p42:to(tween(p43, p44));
        end,

        step = function(p45, p46) -- Line: 201, Name: step
            -- upvalues: u7 (copy), u6 (copy), u11 (ref), u12 (copy), u13 (ref), u8 (copy)
            for i, v in u7 do
                local v47 = u6[i];

                if v47 and not v47.complete then
                    v(i, v47, p46);
                end;
            end;

            local v48 = p45:get();
            local v49 = p45:isComplete();

            if not (u11 and v49) then
                for _, v in u12 do
                    task.spawn(v, v48, p46);
                end;
            end;

            if v49 and (not u11 or u13 ~= v48) then
                for _, v in u8 do
                    task.spawn(v, v48);
                end;
            end;

            u11 = v49;
            u13 = v48;

            return v48;
        end,

        isComplete = function() -- Line: 231, Name: isComplete
            -- upvalues: u6 (copy)
            for _, v in u6 do
                if not v.complete then
                    return false;
                end;
            end;

            return true;
        end,

        onComplete = function(p50, p51) -- Line: 241, Name: onComplete
            -- upvalues: u9 (ref), u8 (copy)
            local u52 = u9;
            u9 = u9 + 1;
            u8[u52] = p51;

            return function() -- Line: 246
                -- upvalues: u8 (ref), u52 (copy)
                u8[u52] = nil;
            end;
        end,

        onStep = function(p53, p54) -- Line: 251, Name: onStep
            -- upvalues: u9 (ref), u12 (copy)
            local u55 = u9;
            u9 = u9 + 1;
            u12[u55] = p54;

            return function() -- Line: 256
                -- upvalues: u12 (ref), u55 (copy)
                u12[u55] = nil;
            end;
        end,

        destroy = function() -- Line: 261, Name: destroy
            -- upvalues: u11 (ref), u9 (ref), u10 (ref), u12 (copy), u8 (copy), u7 (copy), u6 (copy)
            u11 = false;
            u9 = 1;

            if u10 then
                u10:Disconnect();
                u10 = nil;
            end;

            table.clear(u12);
            table.clear(u8);
            table.clear(u7);

            for _, v in u6 do
                if v.destructor then
                    v.destructor();
                    v.destructor = nil;
                end;
            end;
        end
    };

    if u4.start then
        v56:start();
    end;

    return v56;
end;
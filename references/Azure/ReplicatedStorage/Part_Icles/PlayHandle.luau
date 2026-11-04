 

 

local u1 = {};
local u23 = {
    Disable = function(u2) -- Line: 38, Name: Disable
        local engine = u2.engine;

        if engine._inStep then
            engine._afterStep = engine._afterStep or {};
            table.insert(engine._afterStep, function() -- Line: 43
                -- upvalues: u2 (copy)
                u2:Disable();
            end);

            return;
        end;

        local token = u2.token;
        token.Alive = false;

        for _, v in ipairs(token.Loops) do
            pcall(task.cancel, v);
        end;

        token.Loops = {};
        local ActiveEmits = engine.ActiveEmits;

        for i = #ActiveEmits, 1, -1 do
            local v3 = ActiveEmits[i];
            local v4;

            if v3 and v3._playToken == token then
                if v3.VisualPart and v3.VisualPart.Parent then
                    engine:_releaseOrDestroy(v3, v3.VisualPart);
                end;

                engine:_reclaimPData(v3);

                if ActiveEmits[i] == v3 then
                    local v5 = #ActiveEmits;

                    if i < v5 then
                        ActiveEmits[i] = ActiveEmits[v5];
                    end;

                    ActiveEmits[v5] = nil;
                    v4 = i;
                else
                    v4 = i;
                end;
            else
                v4 = i;
            end;
        end;

        engine:_endReacted(nil, token);

        for _, v in ipairs(token.Clones) do
            if v and v.Parent then
                pcall(function() -- Line: 71
                    -- upvalues: v (copy)
                    v:Destroy();
                end);
            end;
        end;

        token.Clones = {};
    end,

    SoftDisable = function(p6) -- Line: 79, Name: SoftDisable
        local token = p6.token;
        token.Alive = false;

        for _, v in ipairs(token.Loops) do
            pcall(task.cancel, v);
        end;

        token.Loops = {};
    end,

    SetTimescale = function(p7, p8, p9, p10) -- Line: 90, Name: SetTimescale
        if typeof(p8) ~= "number" then
            return;
        end;

        local engine = p7.engine;
        local token = p7.token;
        local v11;

        if p10 == true then
            v11 = (1 / 0);
        elseif typeof(p9) == "number" and p9 > 0 then
            v11 = os.clock() + p9;
        else
            token.TsOverride = nil;
            token.TsUntil = nil;
            v11 = nil;
        end;

        if v11 == nil or not p8 then
            p8 = nil;
        end;

        token.TsOverride = p8;
        token.TsUntil = v11;
        local ActiveEmits = engine.ActiveEmits;

        for i = 1, #ActiveEmits do
            local v12 = ActiveEmits[i];
            local v13;

            if v12 and v12._playToken == token then
                v12._tsOverride = token.TsOverride;
                v12._tsOverrideUntil = v11;
                v13 = i;
            else
                v13 = i;
            end;
        end;
    end,

    GetParticles = function(p14) -- Line: 117, Name: GetParticles
        local ActiveEmits = p14.engine.ActiveEmits;
        local v15 = {};

        for i = 1, #ActiveEmits do
            local v16 = ActiveEmits[i];
            local v17;

            if v16 and (v16._playToken == p14.token and v16.VisualPart) then
                v15[#v15 + 1] = v16.VisualPart;
                v17 = i;
            else
                v17 = i;
            end;
        end;

        return v15;
    end,

    GetPDatas = function(p18) -- Line: 133, Name: GetPDatas
        local ActiveEmits = p18.engine.ActiveEmits;
        local v19 = {};

        for i = 1, #ActiveEmits do
            local v20 = ActiveEmits[i];
            local v21;

            if v20 and v20._playToken == p18.token then
                v19[#v19 + 1] = v20;
                v21 = i;
            else
                v21 = i;
            end;
        end;

        return v19;
    end,

    IsAlive = function(p22) -- Line: 146, Name: IsAlive
        local ActiveEmits = p22.engine.ActiveEmits;

        for i = 1, #ActiveEmits do
            if ActiveEmits[i] and ActiveEmits[i]._playToken == p22.token then
                return true;
            end;

            local _ = i;
        end;

        for _, v in ipairs(p22.token.Loops) do
            if coroutine.status(v) ~= "dead" then
                return true;
            end;
        end;

        return false;
    end
};

function u23.Wait(p24) -- Line: 159
    -- upvalues: u23 (copy)
    local os_clock_ret = os.clock();
    local Duration = p24.Duration;

    while not (Duration ~= nil and Duration <= os.clock() - os_clock_ret or p24.token.Alive == false and not u23.IsAlive(p24)) do
        task.wait();
    end;

    return os.clock() - os_clock_ret;
end;

local u27 = {
    __index = function(p25, p26) -- Line: 172
        -- upvalues: u23 (copy)
        if p26 == "Active" then
            return u23.IsAlive(p25);
        end;

        return u23[p26];
    end
};

function u1.new(p28, p29) -- Line: 177
    -- upvalues: u27 (copy)
    return setmetatable({
        engine = p28,
        token = p29,
        Duration = p29.Duration
    }, u27);
end;

function u1.inert(p30) -- Line: 182
    -- upvalues: u1 (copy)
    return u1.new(p30, {
        Alive = false,
        Duration = 0,
        Loops = {},
        Clones = {}
    });
end;

return u1;
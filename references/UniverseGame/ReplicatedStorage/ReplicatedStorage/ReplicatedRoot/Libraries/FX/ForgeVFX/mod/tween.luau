  

 

local RunService = game:GetService("RunService");
local u1 = require("./logger");
local u2 = require("./utility");
local u3 = require("../obj/Bezier");
local u4 = {
    bezier_cache = {}
};

function u4.fromParams(u5, u6, u7, u8, u9, u10, p11) -- Line: 12
    -- upvalues: u4 (copy), u2 (copy), u1 (copy), u3 (copy), RunService (copy)
    local u12 = u4.bezier_cache[u5];

    if not u12 then
        local success, result = pcall(function() -- Line: 24
            -- upvalues: u2 (ref), u5 (copy)
            return u2.deserializePath(u5);
        end);

        if not success then
            u1.error((`failed to decode bezier path data with error: {result}`));
        end;

        u12 = u3.new(result, 0);
        u4.bezier_cache[u5] = u12;
    end;

    local u13 = 0;
    local u14 = nil;

    local function step(p15) -- Line: 41
        -- upvalues: u10 (copy), u13 (ref), u6 (copy), u12 (ref), u7 (copy), u8 (copy), u14 (ref), u9 (copy)
        if not u10 and u13 == 0 then
            local v16 = math.max(u6, 0);
            u13 = math.clamp(u13 + p15, 0, v16);
        end;

        local v17 = u7(1 - u12:getEase((math.clamp(u13 / u6, 0, 1))).y, p15, u13);

        if v17 == nil then
            if not (u8 and u8.Connected) then
                u14();

                if u9 then
                    u9(true);
                end;

                return;
            end;
        else
            local v18;

            if u6 == 0 then
                v18 = u6 < u13;
            else
                v18 = u6 <= u13;
            end;

            if v18 then
                if not (u8 and u8.Connected) then
                    u14();

                    if u9 then
                        u9(true);
                    end;

                    return;
                end;
            end;
        end;

        if v17 then
            local v19 = math.max(u6, 0.001);
            u13 = math.clamp(u13 + v17, 0, v19);
        end;
    end;

    if not p11 then
        local u20 = RunService.RenderStepped:Connect(step);

        u14 = function() -- Line: 74
            -- upvalues: u20 (ref)
            u20:Disconnect();
        end;

        return u20;
    end;

    local u21 = u2.getRandomId();
    RunService:BindToRenderStep(u21, p11, step);
    local u22 = true;

    u14 = function() -- Line: 86
        -- upvalues: u22 (ref), RunService (ref), u21 (copy)
        if not u22 then
            return;
        end;

        u22 = false;
        RunService:UnbindFromRenderStep(u21);
    end;

    return u14;
end;

function u4.timer(u23, u24, u25, p26, p27) -- Line: 100
    -- upvalues: RunService (copy), u2 (copy)
    local u28 = coroutine.running();
    local u29 = 0;
    local u30 = nil;

    local function v35(p31) -- Line: 113
        -- upvalues: u24 (copy), u29 (ref), u23 (copy), u25 (copy), u30 (ref), u28 (copy)
        local v32 = u24(p31, u29);

        if v32 == nil then
            if not (u25 and u25.Connected) then
                u30();
                task.spawn(u28);

                return;
            end;
        else
            local v33;

            if u23 == 0 then
                v33 = u23 < u29;
            else
                v33 = u23 <= u29;
            end;

            if v33 then
                if not (u25 and u25.Connected) then
                    u30();
                    task.spawn(u28);

                    return;
                end;
            end;
        end;

        if v32 then
            local v34 = math.max(u23, 0.001);
            u29 = math.clamp(u29 + v32, 0, v34);
        end;
    end;

    if p27 then
        local u36 = u2.getRandomId();
        RunService:BindToRenderStep(u36, p27, v35);
        local u37 = true;

        u30 = function() -- Line: 143
            -- upvalues: u37 (ref), RunService (ref), u36 (copy)
            if not u37 then
                return;
            end;

            u37 = false;
            RunService:UnbindFromRenderStep(u36);
        end;
    else
        local u38 = RunService.RenderStepped:Connect(v35);

        u30 = function() -- Line: 133
            -- upvalues: u38 (copy)
            u38:Disconnect();
        end;
    end;

    if p26 then
        table.insert(p26, u30);
    end;

    coroutine.yield();
end;

return u4;
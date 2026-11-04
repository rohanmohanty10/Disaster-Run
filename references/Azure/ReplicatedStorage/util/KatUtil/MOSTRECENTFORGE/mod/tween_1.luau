 
 

local RunService = game:GetService("RunService");
local u1 = require("./logger");
local u2 = require("./utility");
local u3 = require("../obj/Bezier");
local v4 = {};
local u5 = {};

function v4.fromParams(u6: string, u7: number, u8: function, u9: userdata?, u10: function?, u11: boolean?, p12: number?) -- Line: 12
    -- upvalues: u5 (copy), u2 (copy), u1 (copy), u3 (copy), RunService (copy)
    local u13 = u5[u6];

    if not u13 then
        local success, result = pcall(function() -- Line: 24
            -- upvalues: u2 (ref), u6 (copy)
            return u2.deserializePath(u6);
        end);

        if not success then
            u1.error((`failed to decode bezier path data with error: {result}`));
        end;

        u13 = u3.new(result, 0);
        u5[u6] = u13;
    end;

    local u14 = 0;
    local u15 = nil;

    local function step(p16) -- Line: 41
        -- upvalues: u11 (copy), u14 (ref), u7 (copy), u13 (ref), u8 (copy), u9 (copy), u15 (ref), u10 (copy)
        if not u11 and u14 == 0 then
            local math_max_ret = math.max(u7, 0);
            u14 = math.clamp(u14 + p16, 0, math_max_ret);
        end;

        local v17 = u8(1 - u13:getEase((math.clamp(u14 / u7, 0, 1))).y, p16, u14);

        if v17 == nil then
            if not (u9 and u9.Connected) then
                u15();

                if u10 then
                    u10(true);
                end;

                return;
            end;
        else
            local v18;

            if u7 == 0 then
                v18 = u7 < u14;
            else
                v18 = u7 <= u14;
            end;

            if v18 then
                if not (u9 and u9.Connected) then
                    u15();

                    if u10 then
                        u10(true);
                    end;

                    return;
                end;
            end;
        end;

        if v17 then
            local math_max_ret = math.max(u7, 0.001);
            u14 = math.clamp(u14 + v17, 0, math_max_ret);
        end;
    end;

    if not p12 then
        local u19 = RunService.RenderStepped:Connect(step);

        u15 = function() -- Line: 74
            -- upvalues: u19 (ref)
            u19:Disconnect();
        end;

        return u19;
    end;

    local RandomId = u2.getRandomId();
    RunService:BindToRenderStep(RandomId, p12, step);
    local u20 = true;

    u15 = function() -- Line: 86
        -- upvalues: u20 (ref), RunService (ref), RandomId (copy)
        if not u20 then
            return;
        end;

        u20 = false;
        RunService:UnbindFromRenderStep(RandomId);
    end;

    return u15;
end;

function v4.timer(u21: number, u22: function, u23: userdata?, p24: table?, p25: number?) -- Line: 100
    -- upvalues: RunService (copy), u2 (copy)
    local coroutine_running_ret = coroutine.running();
    local u26 = 0;
    local u27 = nil;

    local function v31(p28) -- Line: 113
        -- upvalues: u22 (copy), u26 (ref), u21 (copy), u23 (copy), u27 (ref), coroutine_running_ret (copy)
        local v29 = u22(p28, u26);

        if v29 == nil then
            if not (u23 and u23.Connected) then
                u27();
                task.spawn(coroutine_running_ret);

                return;
            end;
        else
            local v30;

            if u21 == 0 then
                v30 = u21 < u26;
            else
                v30 = u21 <= u26;
            end;

            if v30 then
                if not (u23 and u23.Connected) then
                    u27();
                    task.spawn(coroutine_running_ret);

                    return;
                end;
            end;
        end;

        if v29 then
            local math_max_ret = math.max(u21, 0.001);
            u26 = math.clamp(u26 + v29, 0, math_max_ret);
        end;
    end;

    if p25 then
        local RandomId = u2.getRandomId();
        RunService:BindToRenderStep(RandomId, p25, v31);
        local u32 = true;

        u27 = function() -- Line: 143
            -- upvalues: u32 (ref), RunService (ref), RandomId (copy)
            if not u32 then
                return;
            end;

            u32 = false;
            RunService:UnbindFromRenderStep(RandomId);
        end;
    else
        local u33 = RunService.RenderStepped:Connect(v31);

        u27 = function() -- Line: 133
            -- upvalues: u33 (copy)
            u33:Disconnect();
        end;
    end;

    if p24 then
        table.insert(p24, u27);
    end;

    coroutine.yield();
end;

return v4;
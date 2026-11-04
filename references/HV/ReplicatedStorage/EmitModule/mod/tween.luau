 

 

local RunService = game:GetService("RunService");
local u1 = require("./logger");
local u2 = require("./utility");
local u3 = require("../obj/Bezier");

return {
    fromParams = function(u4: string, u5: number, u6: function, u7: userdata?, u8: function?, u9: boolean?, p10: number?) -- Line: 10, Name: fromParams
        -- upvalues: u2 (copy), u1 (copy), u3 (copy), RunService (copy)
        local success, result = pcall(function() -- Line: 19
            -- upvalues: u2 (ref), u4 (copy)
            return u2.deserializePath(u4);
        end);

        if not success then
            u1.error((`failed to decode bezier path data with error: {result}`));
        end;

        local u11 = u3.new(result, 0);
        local u12 = 0;
        local u13 = nil;

        local function step(p14) -- Line: 33
            -- upvalues: u9 (copy), u12 (ref), u5 (copy), u11 (copy), u6 (copy), u7 (copy), u13 (ref), u8 (copy)
            if not u9 and u12 == 0 then
                local math_max_ret = math.max(u5, 0);
                u12 = math.clamp(u12 + p14, 0, math_max_ret);
            end;

            local v15 = u6(1 - u11:getEase((math.clamp(u12 / u5, 0, 1))).y, p14, u12);

            if v15 == nil then
                if not (u7 and u7.Connected) then
                    u13();

                    if u8 then
                        u8(true);
                    end;

                    return;
                end;
            else
                local v16;

                if u5 == 0 then
                    v16 = u5 < u12;
                else
                    v16 = u5 <= u12;
                end;

                if v16 then
                    if not (u7 and u7.Connected) then
                        u13();

                        if u8 then
                            u8(true);
                        end;

                        return;
                    end;
                end;
            end;

            if v15 then
                local math_max_ret = math.max(u5, 0.001);
                u12 = math.clamp(u12 + v15, 0, math_max_ret);
            end;
        end;

        if not p10 then
            local u17 = RunService.RenderStepped:Connect(step);

            u13 = function() -- Line: 66
                -- upvalues: u17 (ref)
                u17:Disconnect();
            end;

            return u17;
        end;

        local RandomId = u2.getRandomId();
        RunService:BindToRenderStep(RandomId, p10, step);
        local u18 = true;

        u13 = function() -- Line: 78
            -- upvalues: u18 (ref), RunService (ref), RandomId (copy)
            if not u18 then
                return;
            end;

            u18 = false;
            RunService:UnbindFromRenderStep(RandomId);
        end;

        return u13;
    end,

    timer = function(u19: number, u20: function, u21: userdata?, p22: table?, p23: number?) -- Line: 92, Name: timer
        -- upvalues: RunService (copy), u2 (copy)
        local coroutine_running_ret = coroutine.running();
        local u24 = 0;
        local u25 = nil;

        local function v29(p26) -- Line: 105
            -- upvalues: u20 (copy), u24 (ref), u19 (copy), u21 (copy), u25 (ref), coroutine_running_ret (copy)
            local v27 = u20(p26, u24);

            if v27 == nil then
                if not (u21 and u21.Connected) then
                    u25();
                    task.spawn(coroutine_running_ret);

                    return;
                end;
            else
                local v28;

                if u19 == 0 then
                    v28 = u19 < u24;
                else
                    v28 = u19 <= u24;
                end;

                if v28 then
                    if not (u21 and u21.Connected) then
                        u25();
                        task.spawn(coroutine_running_ret);

                        return;
                    end;
                end;
            end;

            if v27 then
                local math_max_ret = math.max(u19, 0.001);
                u24 = math.clamp(u24 + v27, 0, math_max_ret);
            end;
        end;

        if p23 then
            local RandomId = u2.getRandomId();
            RunService:BindToRenderStep(RandomId, p23, v29);
            local u30 = true;

            u25 = function() -- Line: 135
                -- upvalues: u30 (ref), RunService (ref), RandomId (copy)
                if not u30 then
                    return;
                end;

                u30 = false;
                RunService:UnbindFromRenderStep(RandomId);
            end;
        else
            local u31 = RunService.RenderStepped:Connect(v29);

            u25 = function() -- Line: 125
                -- upvalues: u31 (copy)
                u31:Disconnect();
            end;
        end;

        if p22 then
            table.insert(p22, u25);
        end;

        coroutine.yield();
    end
};
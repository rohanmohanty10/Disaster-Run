  

local RunService = game:GetService("RunService");
local u1 = require("./logger");
local u2 = require("./utility");
local u3 = require("../obj/Bezier");
local u4 = RunService:IsClient();

return {
    fromParams = function(u5: string, u6: number, u7: function, u8: userdata?, u9: function?, u10: boolean?, p11: number?) -- Line: 10, Name: fromParams
        -- upvalues: u2 (copy), u1 (copy), u3 (copy), u4 (copy), RunService (copy)
        local success, result = pcall(function() -- Line: 19
            -- upvalues: u2 (ref), u5 (copy)
            return u2.deserializePath(u5);
        end);

        if not success then
            u1.error((`failed to decode bezier path data with error: {result}`));
        end;

        local u12 = u3.new(result, 0);
        local u13 = 0;
        local u14 = nil;

        local function step(p15) -- Line: 29
            -- upvalues: u10 (copy), u13 (ref), u6 (copy), u12 (copy), u7 (copy), u8 (copy), u14 (ref), u9 (copy)
            if not u10 and u13 == 0 then
                local math_max_ret = math.max(u6, 0);
                u13 = math.clamp(u13 + p15, 0, math_max_ret);
            end;

            local v16 = u7(1 - u12:getEase((math.clamp(u13 / u6, 0, 1))).y, p15, u13);

            if v16 == nil then
                if not (u8 and u8.Connected) then
                    u14();

                    if u9 then
                        u9(true);
                    end;

                    return;
                end;
            else
                local v17;

                if u6 == 0 then
                    v17 = u6 < u13;
                else
                    v17 = u6 <= u13;
                end;

                if v17 then
                    if not (u8 and u8.Connected) then
                        u14();

                        if u9 then
                            u9(true);
                        end;

                        return;
                    end;
                end;
            end;

            if v16 then
                local math_max_ret = math.max(u6, 0.001);
                u13 = math.clamp(u13 + v16, 0, math_max_ret);
            end;
        end;

        if not p11 then
            local u18 = u4 and RunService.RenderStepped:Connect(step) or RunService.Heartbeat:Connect(step);

            u14 = function() -- Line: 54
                -- upvalues: u18 (ref)
                u18:Disconnect();
            end;

            return u18;
        end;

        if not u4 then
            local u19 = RunService.Heartbeat:Connect(step);
            local u20 = true;

            u14 = function() -- Line: 75
                -- upvalues: u20 (ref), u19 (ref)
                if not u20 then
                    return;
                end;

                u20 = false;
                u19:Disconnect();
            end;

            return u14;
        end;

        local RanomId = u2.getRanomId();
        RunService:BindToRenderStep(RanomId, p11, step);
        local u21 = true;

        u14 = function() -- Line: 63
            -- upvalues: u21 (ref), RunService (ref), RanomId (copy)
            if not u21 then
                return;
            end;

            u21 = false;
            RunService:UnbindFromRenderStep(RanomId);
        end;

        return u14;
    end,

    timer = function(u22: number, u23: function, u24: userdata?, p25: table?, p26: number?) -- Line: 87, Name: timer
        -- upvalues: u4 (copy), RunService (copy), u2 (copy)
        local coroutine_running_ret = coroutine.running();
        local u27 = 0;
        local u28 = nil;

        local function v32(p29) -- Line: 97
            -- upvalues: u23 (copy), u27 (ref), u22 (copy), u24 (copy), u28 (ref), coroutine_running_ret (copy)
            local v30 = u23(p29, u27);

            if v30 == nil then
                if not (u24 and u24.Connected) then
                    u28();
                    task.spawn(coroutine_running_ret);

                    return;
                end;
            else
                local v31;

                if u22 == 0 then
                    v31 = u22 < u27;
                else
                    v31 = u22 <= u27;
                end;

                if v31 then
                    if not (u24 and u24.Connected) then
                        u28();
                        task.spawn(coroutine_running_ret);

                        return;
                    end;
                end;
            end;

            if v30 then
                local math_max_ret = math.max(u22, 0.001);
                u27 = math.clamp(u27 + v30, 0, math_max_ret);
            end;
        end;

        if p26 then
            if u4 then
                local RanomId = u2.getRanomId();
                RunService:BindToRenderStep(RanomId, p26, v32);
                local u33 = true;

                u28 = function() -- Line: 121
                    -- upvalues: u33 (ref), RunService (ref), RanomId (copy)
                    if not u33 then
                        return;
                    end;

                    u33 = false;
                    RunService:UnbindFromRenderStep(RanomId);
                end;
            else
                local u34 = RunService.Heartbeat:Connect(v32);
                local u35 = true;

                u28 = function() -- Line: 131
                    -- upvalues: u35 (ref), u34 (copy)
                    if not u35 then
                        return;
                    end;

                    u35 = false;
                    u34:Disconnect();
                end;
            end;
        else
            local u36 = u4 and RunService.RenderStepped:Connect(v32) or RunService.Heartbeat:Connect(v32);

            u28 = function() -- Line: 113
                -- upvalues: u36 (copy)
                u36:Disconnect();
            end;
        end;

        if p25 then
            table.insert(p25, u28);
        end;

        coroutine.yield();
    end
};
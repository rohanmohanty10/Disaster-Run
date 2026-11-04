  

local TweenService = game:GetService("TweenService");
require(script.Parent.Parent.types);
local config = require(script.Parent.Parent.config);
local intermediate = require(script.Parent.Parent.utils.intermediate);
local merge = require(script.Parent.Parent.utils.merge);

local function createTween(p1: number, p2: number, p3: any) -- Line: 14
    -- upvalues: TweenService (copy)
    local TweenInfo_new_ret = TweenInfo.new(p3.time, p3.style, p3.direction, p3.repeatCount, p3.reverses, p3.delayTime);
    local NumberValue = Instance.new("NumberValue");
    local v4 = TweenService:Create(NumberValue, TweenInfo_new_ret, {
        Value = p2
    });
    NumberValue.Value = p1;

    return {
        complete = false,
        value = NumberValue,
        tween = v4
    };
end;

return function(p5, p6) -- Line: 36, Name: tween
    -- upvalues: merge (copy), config (copy), intermediate (copy), createTween (copy)
    local u7 = merge(config.tween.default, p6 or {});
    local u8 = intermediate.to(p5);
    local u9 = {};

    return function(u10, p11) -- Line: 41
        -- upvalues: intermediate (ref), u8 (copy), createTween (ref), u7 (copy), u9 (copy)
        local v12 = intermediate.index(u8, u10);

        if not v12 then
            return false;
        end;

        if not p11.destructor then
            local u13 = createTween(p11.value, v12, u7);
            u9[u10] = u13;
            u13.tween.Completed:Connect(function() -- Line: 53
                -- upvalues: u13 (copy)
                u13.complete = true;
                u13.value:Destroy();
                u13.tween:Destroy();
            end);
            u13.tween:Play();

            function p11.destructor() -- Line: 61
                -- upvalues: u13 (copy), u9 (ref), u10 (copy)
                u13.tween:Destroy();
                u13.value:Destroy();
                u9[u10] = nil;
            end;
        end;

        local v14 = u9[u10];

        if not v14 then
            p11.complete = true;

            return;
        end;

        if not v14.complete then
            p11.value = v14.value.Value;

            return;
        end;

        p11.complete = true;
        p11.value = v12;
    end;
end;
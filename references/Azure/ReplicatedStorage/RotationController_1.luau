 
 

local v1 = {};
local RunService = game:GetService("RunService");

local function easeOut(p2) -- Line: 8
    return 1 - (1 - p2) ^ 3;
end;

function v1.StartRotation(u3: userdata, u4: number, p5: number?) -- Line: 13
    -- upvalues: RunService (copy)
    local u6 = p5 or 1;
    local u7 = 0;
    local u8 = true;
    local u9 = nil;
    u9 = RunService.Heartbeat:Connect(function(p10) -- Line: 19
        -- upvalues: u8 (ref), u9 (ref), u7 (ref), u4 (copy), u6 (ref), u3 (copy)
        if not u8 then
            u9:Disconnect();

            return;
        end;

        u7 = u7 + p10;

        if u4 > u7 then
            u3.CFrame = u3.CFrame * CFrame.Angles(0, math.rad(360 / u4 * u6 * (1 - (1 - (1 - u7 / u4)) ^ 3) * p10), 0);

            return;
        end;

        u8 = false;
        u9:Disconnect();
    end);
end;

return v1;
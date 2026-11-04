 

 

local RunService = game:GetService("RunService");
local u1 = nil;

return {
    setFpsCap = function(p2: number?) -- Line: 9, Name: setFpsCap
        -- upvalues: u1 (ref), RunService (copy)
        local v3 = u1;

        if v3 then
            v3:Disconnect();
            u1 = nil;
        end;

        if typeof(p2) ~= "number" or (p2 ~= p2 or p2 <= 0) then
            return;
        end;

        local u4 = 1 / math.clamp(p2, 5, 240);
        local u5 = os.clock() + u4;
        u1 = RunService.PreRender:Connect(function() -- Line: 20
            -- upvalues: u5 (ref), u4 (copy)
            while os.clock() < u5 do

            end;

            u5 = math.max(u5 + u4, os.clock());
        end);
    end
};
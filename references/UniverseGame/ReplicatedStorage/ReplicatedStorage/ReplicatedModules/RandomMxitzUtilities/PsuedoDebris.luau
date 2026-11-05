  

 

local RunService = game:GetService("RunService");
local u1 = require("./SpawnResuableThread");
local u2 = require("./CleanObject");
local u3 = nil;
local u4 = {};

return function(p5, p6) -- Line: 9
    -- upvalues: u4 (copy), u3 (ref), RunService (copy), u1 (copy), u2 (copy)
    u4[p5] = os.clock() + p6;

    if typeof(u3) ~= "RBXScriptConnection" then
        u3 = RunService.PostSimulation:Connect(function() -- Line: 13
            -- upvalues: u4 (ref), u3 (ref), u1 (ref), u2 (ref)
            if next(u4) then
                for i, v in u4 do
                    if os.clock() >= v then
                        u1(u2, i);
                    end;
                end;

                return;
            end;

            u3:Disconnect();
        end);
    end;
end;
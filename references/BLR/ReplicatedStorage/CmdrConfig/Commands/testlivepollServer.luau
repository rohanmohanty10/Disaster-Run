  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local PollConfig = require(ReplicatedStorage.Shared.Configs.PollConfig);
local environment = require(ReplicatedStorage.Shared.environment);

return function(p1, p2, p3, p4) -- Line: 7
    -- upvalues: environment (copy), Knit (copy), PollConfig (copy)
    if environment.env ~= "Dev" then
        return "This command only works in the dev place.";
    end;

    local _, v5 = Knit.GetService("PollService"):StartPoll(PollConfig.LiveHeader, p2, p3, p4, p1.Executor, true);

    return v5;
end;
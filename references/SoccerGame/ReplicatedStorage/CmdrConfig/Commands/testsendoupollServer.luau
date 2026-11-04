  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local PollConfig = require(ReplicatedStorage.Shared.Configs.PollConfig);
local environment = require(ReplicatedStorage.Shared.environment);

return function(p1) -- Line: 7
    -- upvalues: environment (copy), PollConfig (copy), Knit (copy)
    if environment.env ~= "Dev" then
        return "This command only works in the dev place.";
    end;

    local SendouPoll = PollConfig.SendouPoll;
    local _, v2 = Knit.GetService("PollService"):StartPoll(SendouPoll.Header, SendouPoll.Question, SendouPoll.Option1, SendouPoll.Option2, nil, true);

    return v2;
end;
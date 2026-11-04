  

local DevCommandAccess = require(game:GetService("ServerScriptService").Modules.DevCommandAccess);
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local PollConfig = require(ReplicatedStorage.Shared.Configs.PollConfig);
local u1 = { "Holder", "Lead", "Lead Developer" };
local u2 = { 156331702 };

return function(p3) -- Line: 17
    -- upvalues: DevCommandAccess (copy), u1 (copy), u2 (copy), PollConfig (copy), Knit (copy)
    local Executor = p3.Executor;
    local success, result = pcall(function() -- Line: 19
        -- upvalues: Executor (copy)
        return Executor:GetRoleInGroup(34671275);
    end);

    if not (DevCommandAccess.has(Executor) or success and (table.find(u1, result) or table.find(u2, Executor.UserId))) then
        return "Failed";
    end;

    local SendouPoll = PollConfig.SendouPoll;
    local _, v4 = Knit.GetService("PollService"):StartPoll(SendouPoll.Header, SendouPoll.Question, SendouPoll.Option1, SendouPoll.Option2);

    return v4;
end;
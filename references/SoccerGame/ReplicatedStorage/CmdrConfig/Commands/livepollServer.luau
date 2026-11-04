  

local DevCommandAccess = require(game:GetService("ServerScriptService").Modules.DevCommandAccess);
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local PollConfig = require(ReplicatedStorage.Shared.Configs.PollConfig);
local u1 = { "Holder", "Lead", "Lead Developer" };
local u2 = { 156331702 };

return function(p3, p4, p5, p6) -- Line: 17
    -- upvalues: DevCommandAccess (copy), u1 (copy), u2 (copy), Knit (copy), PollConfig (copy)
    local Executor = p3.Executor;
    local success, result = pcall(function() -- Line: 19
        -- upvalues: Executor (copy)
        return Executor:GetRoleInGroup(34671275);
    end);

    if not (DevCommandAccess.has(Executor) or success and (table.find(u1, result) or table.find(u2, Executor.UserId))) then
        return "Failed";
    end;

    local _, v7 = Knit.GetService("PollService"):StartPoll(PollConfig.LiveHeader, p4, p5, p6, Executor);

    return v7;
end;
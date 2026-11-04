  

local DevCommandAccess = require(game:GetService("ServerScriptService").Modules.DevCommandAccess);
require(game.ServerScriptService.Profile.ProfileManager);
local ReplicatedStorage = game:GetService("ReplicatedStorage");
require(ReplicatedStorage.Shared.Configs.StyleEventData);
local Knit = require(ReplicatedStorage.Packages.Knit);
local u1 = { "Holder", "Lead", "Lead Developer" };
local u2 = { 156331702 };

return function(p3, p4) -- Line: 18
    -- upvalues: DevCommandAccess (copy), u1 (copy), u2 (copy), Knit (copy)
    local Executor = p3.Executor;
    local success, result = pcall(function() -- Line: 20
        -- upvalues: Executor (copy)
        return Executor:GetRoleInGroup(34671275);
    end);

    if not (DevCommandAccess.has(Executor) or success and (table.find(u1, result) or table.find(u2, Executor.UserId))) then
        return "Failed";
    end;

    if not p4 then
        return "Please specify an event name (e.g. EgoGames)";
    end;

    Knit.GetService("GlobalService"):ExecuteEvent(p4);

    return "Executed " .. p4;
end;
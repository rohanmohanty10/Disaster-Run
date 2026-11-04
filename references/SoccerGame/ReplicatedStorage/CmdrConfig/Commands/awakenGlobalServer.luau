  

local DevCommandAccess = require(game:GetService("ServerScriptService").Modules.DevCommandAccess);
require(game.ServerScriptService.Profile.ProfileManager);
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local u1 = { "Holder", "Lead", "Lead Developer" };

return function(p2, p3) -- Line: 13
    -- upvalues: DevCommandAccess (copy), u1 (copy), Knit (copy)
    local Executor = p2.Executor;
    local success, result = pcall(function() -- Line: 15
        -- upvalues: Executor (copy)
        return Executor:GetRoleInGroup(34671275);
    end);

    if not (DevCommandAccess.has(Executor) or success and table.find(u1, result)) then
        return "Failed";
    end;

    Knit.GetService("GlobalService"):AwakenBothTeams();
end;
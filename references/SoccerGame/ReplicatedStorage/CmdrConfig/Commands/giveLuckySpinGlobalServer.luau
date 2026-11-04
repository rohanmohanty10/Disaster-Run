  

local DevCommandAccess = require(game:GetService("ServerScriptService").Modules.DevCommandAccess);
require(game.ServerScriptService.Profile.ProfileManager);
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Knit = require(ReplicatedStorage.Packages.Knit);
local u1 = { "Holder", "Lead", "Lead Developer" };
local u2 = { 156331702 };

return function(p3, p4, p5) -- Line: 18
    -- upvalues: DevCommandAccess (copy), u1 (copy), u2 (copy), Knit (copy)
    local Executor = p3.Executor;
    local success, result = pcall(function() -- Line: 20
        -- upvalues: Executor (copy)
        return Executor:GetRoleInGroup(34671275);
    end);

    if not (DevCommandAccess.has(Executor) or success and (table.find(u1, result) or table.find(u2, Executor.UserId))) then
        return;
    end;

    Knit.GetService("GlobalService"):GiveSpins(p4, p5);
end;
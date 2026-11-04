  

local DevCommandAccess = require(game:GetService("ServerScriptService").Modules.DevCommandAccess);
require(game.ServerScriptService.Profile.ProfileManager);
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local StyleEventData = require(ReplicatedStorage.Shared.Configs.StyleEventData);
local Knit = require(ReplicatedStorage.Packages.Knit);
local u1 = { "Holder", "Lead", "Lead Developer" };

return function(p2, p3) -- Line: 14
    -- upvalues: DevCommandAccess (copy), u1 (copy), StyleEventData (copy), Knit (copy)
    local Executor = p2.Executor;
    local success, result = pcall(function() -- Line: 16
        -- upvalues: Executor (copy)
        return Executor:GetRoleInGroup(34671275);
    end);

    if not (DevCommandAccess.has(Executor) or success and table.find(u1, result)) then
        return "Failed";
    end;

    local Attribute = workspace:GetAttribute("StyleEventIndex");
    local table_find_ret = table.find(StyleEventData.Styles, p3);

    if not table_find_ret then
        return "This style doesnt exist??";
    end;

    if Attribute == table_find_ret then
        return "That is the current style";
    end;

    Knit.GetService("GlobalService"):EgoSwitch(table_find_ret);
end;
  

 

local v1 = {};
local Core = require(game.ReplicatedStorage.ReplicatedRoot.Core);
require(Core.ReplicatedLibraries.Classes.Trove);
local TagService = require(Core.ReplicatedServices.TagService);

function v1.Init(u2) -- Line: 8
    -- upvalues: TagService (copy)
    function u2.IsGrabbed(p3, p4) -- Line: 9
        -- upvalues: TagService (ref), u2 (copy)
        local v5 = TagService.GetContainer(p3);

        if v5 == nil then
            return false;
        end;

        local v6 = p4 or {};
        local v7 = v6.MinPriority or (v6.Priority or u2.Enums.Grab.Main);
        local MaxPriority = v6.MaxPriority;
        local Ignore = v6.Ignore;

        for _, v in pairs(TagService.GetTagsWithName(v5, "Grabbed")) do
            if not (Ignore and table.find(Ignore, v.Name)) and ((not v7 or v7 <= v.Value) and (not MaxPriority or v.Value <= MaxPriority)) then
                return true;
            end;
        end;

        return false;
    end;
end;

return v1;
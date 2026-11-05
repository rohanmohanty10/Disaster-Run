  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Trove);
local StoreHandler = require(PathShortcuts.ReplicatedModules.Independent.StoreHandler);

return function(p1) -- Line: 7
    -- upvalues: StoreHandler (copy)
    if type(p1) ~= "string" then
        warn("UUID NEEDED FOR HIGHLIGHT");

        return;
    end;

    local v2 = StoreHandler.GetStore("HighlightCache");

    if not v2[p1] then
        return;
    end;

    v2[p1]:Destroy();
    v2[p1] = nil;
end;
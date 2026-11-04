  

local ProfileManager = require(game.ServerScriptService.Profile.ProfileManager);
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local GoalEffects = require(ReplicatedStorage.Shared.Inventory.GoalEffects);

return function(p1, p2, p3) -- Line: 6
    -- upvalues: ProfileManager (copy), ReplicatedStorage (copy), GoalEffects (copy)
    local v4 = ProfileManager.Profiles[p2];
    ReplicatedStorage.Assets.GoalEffects:GetChildren();
    print(GoalEffects[p3]);

    if GoalEffects[p3] then
        table.insert(v4.Data.Customization.GoalEffects, p3);

        return "Gave Goal effect";
    end;
end;
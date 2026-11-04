  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
local Trove = require(ReplicatedStorage.Packages.Trove);
require(ReplicatedStorage.Shared.VfxManager);
local Essentials = require(ReplicatedStorage.Shared.Essentials);

return v1({
    animationId = "rbxassetid://82623612087401",
    meta = {
        rarity = "Limited"
    },

    effect = function(p2: any, p3: userdata, p4: any) -- Line: 11, Name: effect
        -- upvalues: Trove (copy), ReplicatedStorage (copy), Essentials (copy)
        local v5 = Trove.new();
        local v6 = ReplicatedStorage.Assets.Misc.PocketWatch.Watch:Clone();
        v6:PivotTo(p2["Right Arm"].CFrame * ReplicatedStorage.Assets.Misc.PocketWatch["Right Arm"].CFrame:ToObjectSpace(v6:GetPivot()));
        v6.Parent = p2["Right Arm"];
        Essentials:Weld(p2["Right Arm"], v6, v6);
        v5:Add(v6);

        return v5;
    end
});
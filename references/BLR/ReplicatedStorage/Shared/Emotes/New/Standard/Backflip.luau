  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
require(ReplicatedStorage.Packages.Trove);
require(ReplicatedStorage.Shared.VfxManager);

return v1({
    animationId = "rbxassetid://140552631038830",
    looped = false,
    meta = {
        rarity = "Limited"
    }
});
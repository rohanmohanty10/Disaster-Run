  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local v1 = require("../../EmoteTypes/standardEmote");
require(ReplicatedStorage.Packages.Trove);
require(ReplicatedStorage.Shared.VfxManager);

return v1({
    animationId = "rbxassetid://121627597552080",
    looped = false,
    meta = {
        rarity = "Limited"
    }
});
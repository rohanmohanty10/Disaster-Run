  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
game:GetService("RunService");
local _ = Players.LocalPlayer.PlayerGui;
local Observers = require(ReplicatedStorage.Packages.Observers);
require(ReplicatedStorage.Packages.Trove);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Tweens);

return Observers.observeTag("StadiumBanner", function(p1) -- Line: 18
    return function() -- Line: 24
    end;
end);
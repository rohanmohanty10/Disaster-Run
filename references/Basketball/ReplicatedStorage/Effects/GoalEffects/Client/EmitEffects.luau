 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local _ = game.Players.LocalPlayer;

return function(p1, p2) -- Line: 10
    -- upvalues: ReplicatedStorage (copy)
    require(ReplicatedStorage.Effects.SpawnVFX)(p1, {
        Vfx = p2.Vfx,
        CFrame = p2.CFrame
    });
end;
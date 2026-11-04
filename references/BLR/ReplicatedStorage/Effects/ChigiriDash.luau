  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);

return function(p1) -- Line: 9
    -- upvalues: ReplicatedStorage (copy), SoundManager (copy), VfxManager (copy), Debris (copy)
    local v2 = ReplicatedStorage.Assets.Vfx.ChigiriDash:Clone();
    v2.Parent = workspace;
    v2.PrimaryPart.CFrame = p1.Pos;
    v2.PrimaryPart.Anchored = true;
    SoundManager.SpawnSound("ChigiriDash", 0.5, game.SoundService, 50);
    VfxManager.Emit(v2);
    Debris:AddItem(v2, 3);
end;
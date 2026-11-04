  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);

return function(p1) -- Line: 11
    -- upvalues: SoundManager (copy), Debris (copy), VfxManager (copy)
    SoundManager.SpawnSound("ShadowShot", 0.8, workspace, 150);
    local v2 = script.ShadowShot:Clone();
    v2:PivotTo(p1.Humrp.CFrame);
    v2.Parent = workspace;
    Debris:AddItem(v2, 3);
    VfxManager.Emit(v2);
end;
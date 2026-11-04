  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);

return function(p1) -- Line: 11
    -- upvalues: SoundManager (copy), VfxManager (copy)
    local u2 = script["GoalExplosion + Kick"]:Clone();
    u2.Parent = workspace;
    u2.CFrame = p1.Humrp.CFrame * CFrame.new(0, -2, -1.5);
    SoundManager.SpawnSound("KingPredatorShot", 0.7, p1.Humrp, 150).TimePosition = 0.6;
    VfxManager.Emit(u2);
    task.delay(3, function() -- Line: 21
        -- upvalues: u2 (copy)
        u2:Destroy();
    end);
end;
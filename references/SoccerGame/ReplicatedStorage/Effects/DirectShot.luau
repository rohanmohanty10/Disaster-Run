  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);

return function(p1) -- Line: 10
    -- upvalues: SoundManager (copy), ReplicatedStorage (copy), VfxManager (copy)
    SoundManager.SpawnSound("DirectShot", 1, p1.Ball, 100);
    task.wait(0.45);
    local u2 = ReplicatedStorage.Assets.Vfx.DirectShot.warp:Clone();
    u2.Parent = workspace;
    u2.CFrame = p1.Humrp.Parent.PlrFootball.BallAnims.BALL.CFrame;
    u2.Anchored = true;
    VfxManager.Emit(u2);
    task.wait(0.42);
    local u3 = ReplicatedStorage.Assets.Vfx.DirectShotKick:Clone();
    u3.Parent = workspace;
    u3.CFrame = p1.Humrp.CFrame * CFrame.new(0, 0, -6.5);
    u3.Anchored = true;
    VfxManager.Emit(u3);
    task.delay(2, function() -- Line: 30
        -- upvalues: u2 (copy), u3 (copy)
        u2:Destroy();
        u3:Destroy();
    end);
end;
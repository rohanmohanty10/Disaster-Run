  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.SpectatorController);
Random.new(os.clock());

return function(p1) -- Line: 11
    -- upvalues: VfxManager (copy)
    local _ = game.Players.LocalPlayer;
    local u2 = script.GoalEffect:Clone();
    u2.Parent = workspace.Debris;
    u2:PivotTo(p1.Pos * CFrame.Angles(1.5707963267948966, 0, 0));
    VfxManager.Enable(u2.Inwards, true);
    VfxManager.Emit(u2.Part);
    VfxManager.Emit(u2.EndEmit);
    task.wait(1);
    VfxManager.Enable(u2.Inwards, false);
    task.delay(5, function() -- Line: 22
        -- upvalues: u2 (copy)
        u2:Destroy();
    end);
end;
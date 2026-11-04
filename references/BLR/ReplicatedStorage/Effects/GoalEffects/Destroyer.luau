  

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
    local u2 = script.GoalEffectMain:Clone();
    u2.Parent = workspace.Debris;
    u2:PivotTo(p1.Pos);
    VfxManager.Emit(u2);
    task.delay(8, function() -- Line: 18
        -- upvalues: u2 (copy)
        u2:Destroy();
    end);
end;
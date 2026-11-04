  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.SpectatorController);
Random.new(os.clock());

return function(p1) -- Line: 11
    -- upvalues: TweenService (copy), VfxManager (copy)
    local _ = game.Players.LocalPlayer;
    local u2 = script.GoalEffectMain:Clone();
    u2.Parent = workspace.Debris;
    u2:PivotTo(p1.Pos);
    u2.lavinhobeams.Position = u2.lavinhobeams.Position + Vector3.new(0, -100, 0);
    TweenService:Create(u2.lavinhobeams, TweenInfo.new(0.4, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
        Position = u2.lavinhobeams.Position + Vector3.new(0, 100, 0)
    }):Play();
    VfxManager.Emit(u2);
    task.delay(8, function() -- Line: 23
        -- upvalues: u2 (copy)
        u2:Destroy();
    end);
end;
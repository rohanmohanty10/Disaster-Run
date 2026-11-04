  

local RunService = game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local u1 = not RunService:IsRunning() and workspace.CurrentCamera or workspace.Debris;
Random.new(os.clock());

return function(p2) -- Line: 13
    -- upvalues: u1 (copy), VfxManager (copy)
    local _ = game.Players.LocalPlayer;
    local u3 = script.LorenzoGoalEffect:Clone();
    u3.Parent = u1;
    u3:PivotTo(p2.Pos * CFrame.new(0, 10, 0));
    VfxManager.Emit(u3);
    task.delay(8, function() -- Line: 20
        -- upvalues: u3 (copy)
        u3:Destroy();
    end);
end;
  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
local u1 = not RunService:IsRunning() and workspace.CurrentCamera or workspace.Debris;
Random.new(os.clock());

return function(p2) -- Line: 13
    -- upvalues: u1 (copy), VfxManager (copy)
    local _ = game.Players.LocalPlayer;
    local u3 = script.GE:Clone();
    u3.Parent = u1;
    u3:PivotTo(p2.Pos * CFrame.Angles(0, 1.5707963267948966, 0));

    for _, descendant in u3:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false;
            descendant.CanQuery = false;
            descendant.CanTouch = false;
            descendant.Anchored = true;
        end;
    end;

    VfxManager.Emit(u3);
    task.delay(8, function() -- Line: 29
        -- upvalues: u3 (copy)
        u3:Destroy();
    end);
end;
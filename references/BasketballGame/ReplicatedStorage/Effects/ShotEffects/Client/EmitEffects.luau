 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 8
    -- upvalues: Debris (copy), Essentials (copy), VfxManager (copy)
    local Ball = p2.Ball;
    local Torso = p2.Char:FindFirstChild("Torso");
    local v3 = p2.Locker and Ball.CFrame or Torso.CFrame;
    local v4 = p2.Vfx.Ball:Clone();
    v4.Parent = Debris;
    v4.CFrame = Ball.CFrame;
    Essentials:Weld(v4, Ball);
    local Emit = p2.Vfx:FindFirstChild("Emit");

    if Emit then
        local v5 = Emit:Clone();
        v5.Parent = Debris;
        v5.CFrame = v3.Position.Y < 16 and CFrame.new(v3.Position.X, 1, v3.Position.Z) * CFrame.fromOrientation(v3:ToOrientation()) or v3 + Vector3.new(0, -3, 0);
        VfxManager.BetterEmit(v5);
        VfxManager.DestroyEffect(v5, 6);
    end;

    local v6 = tick();

    if p2.Locker then
        repeat
            task.wait();
        until tick() - v6 > 5 or not (Ball and (Ball:IsDescendantOf(Debris) and Ball.Position.Y >= 4));
    else
        repeat
            task.wait();
        until tick() - v6 > 5 or (Ball.Transparency == 1 or Ball.Position.Y < 4);
    end;

    VfxManager.Enable(v4, false);
    VfxManager.DestroyEffect(v4, 6);
end;
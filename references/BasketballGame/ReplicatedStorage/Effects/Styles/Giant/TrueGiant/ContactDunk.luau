 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;

return function(p1, p2) -- Line: 14
    -- upvalues: VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local _ = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local v3 = script.Start_up:Clone();
    v3.Parent = workspace.Debris;
    v3.CFrame = HumanoidRootPart.CFrame;
    VfxManager.Emit(v3);
    task.delay(2, v3.Destroy, v3);
    task.delay(0.683, function() -- Line: 28
        -- upvalues: HumanoidRootPart (copy), VfxManager (ref)
        local v4 = script.Jump:Clone();
        v4.Parent = workspace.Debris;
        v4:PivotTo(HumanoidRootPart.CFrame);
        VfxManager.Emit(v4);
        task.delay(3, v4.Destroy, v4);
    end);
end;
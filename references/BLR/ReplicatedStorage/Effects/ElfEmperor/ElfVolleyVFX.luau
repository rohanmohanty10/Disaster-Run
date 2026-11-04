  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 12
    -- upvalues: VfxManager (copy)
    local HumanoidRootPart = p1.Char.HumanoidRootPart;
    local v2 = script.Startup:Clone();
    v2:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0));
    v2.Parent = workspace.Debris;
    VfxManager.Emit(v2);
    task.wait(0.35);
    local v3 = script.ShotEmit:Clone();
    v3:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0) * CFrame.fromOrientation(0, -1.5707963267948966, 0));
    v3.Parent = workspace.Debris;
    VfxManager.Emit(v3);
end;
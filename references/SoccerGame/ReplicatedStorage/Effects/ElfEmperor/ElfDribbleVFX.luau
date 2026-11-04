  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 12
    -- upvalues: VfxManager (copy), RunService (copy)
    local HumanoidRootPart = p1.Char.HumanoidRootPart;
    local u2 = script.Dash:Clone();
    u2.Parent = workspace.Debris;
    VfxManager.Emit(u2);
    RunService.Heartbeat:Connect(function() -- Line: 22
        -- upvalues: u2 (copy), HumanoidRootPart (copy)
        u2:PivotTo(HumanoidRootPart.CFrame);
    end);
    local v3 = script.Cane:Clone();
    v3:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0));
    v3.Parent = workspace.Debris;
    VfxManager.Emit(v3);
    task.wait(2);
    v3:Destroy();
    u2:Destroy();
end;
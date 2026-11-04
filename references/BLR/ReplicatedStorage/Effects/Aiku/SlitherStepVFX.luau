  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 13
    -- upvalues: VfxManager (copy)
    local Char = p1.Char;
    local u2 = script.SlitherStep:Clone();
    u2:PivotTo(Char.HumanoidRootPart.CFrame);
    u2.Parent = workspace.Debris;
    local v3 = game["Run Service"].Heartbeat:Connect(function() -- Line: 21
        -- upvalues: u2 (copy), Char (copy)
        u2:PivotTo(Char.HumanoidRootPart.CFrame);
    end);
    task.wait(0.65);
    VfxManager.Enable(u2, false);
    task.wait(1);
    u2:Destroy();
    v3:Disconnect();
end;
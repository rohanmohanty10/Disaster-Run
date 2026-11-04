  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
game:GetService("TweenService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);

return function(p1) -- Line: 11
    -- upvalues: RunService (copy), VfxManager (copy)
    local Char = p1.Char;
    local u2 = script.SidetoSide:Clone();
    u2:PivotTo(Char.HumanoidRootPart.CFrame);
    u2.Parent = workspace.Debris;
    local u3 = RunService.Heartbeat:Connect(function() -- Line: 18
        -- upvalues: u2 (copy), Char (copy)
        u2:PivotTo(Char.HumanoidRootPart.CFrame);
    end);
    task.delay(2, function() -- Line: 21
        -- upvalues: u2 (copy), u3 (ref)
        u2:Destroy();
        u3:Disconnect();
    end);

    for i = 1, 3 do
        VfxManager.Emit(u2);
        task.wait(0.35);
        local _ = i;
    end;
end;
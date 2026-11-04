  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);

return function(p1) -- Line: 10
    -- upvalues: VfxManager (copy), RunService (copy), Debris (copy)
    local char = p1.char;
    local v2 = script.RunEmit:Clone();
    v2:PivotTo(char.HumanoidRootPart.CFrame);
    v2.Parent = workspace.Debris;
    VfxManager.Emit(v2);
    local u3 = script.RunEmitDebree:Clone();
    u3:PivotTo(char.HumanoidRootPart.CFrame);
    u3.Parent = workspace.Debris;
    RunService.Heartbeat:Connect(function() -- Line: 22
        -- upvalues: u3 (copy), char (copy)
        u3:PivotTo(char.HumanoidRootPart.CFrame);
    end);
    coroutine.wrap(function() -- Line: 26
        -- upvalues: VfxManager (ref), u3 (copy)
        for i = 1, 8 do
            task.wait(0.2);
            VfxManager.Emit(u3);
            local _ = i;
        end;
    end)();
    task.wait(2.3);
    v2:PivotTo(char.HumanoidRootPart.CFrame);
    VfxManager.Emit(v2);
    Debris:AddItem(v2, 5);
    Debris:AddItem(u3, 5);
end;
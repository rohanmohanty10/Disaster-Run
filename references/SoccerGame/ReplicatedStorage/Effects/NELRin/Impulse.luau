  

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
    local u2 = script.RunEmit:Clone();
    u2:PivotTo(char.HumanoidRootPart.CFrame);
    u2.Parent = workspace.Debris;
    VfxManager.Emit(u2);
    local u3 = script.RunEmitDebree:Clone();
    u3:PivotTo(char.HumanoidRootPart.CFrame);
    u3.Parent = workspace.Debris;
    RunService.Heartbeat:Connect(function() -- Line: 22
        -- upvalues: u2 (copy), char (copy), u3 (copy)
        u2:PivotTo(char.HumanoidRootPart.CFrame);
        u3:PivotTo(char.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0));
    end);
    coroutine.wrap(function() -- Line: 27
        -- upvalues: VfxManager (ref), u3 (copy)
        for i = 1, 8 do
            task.wait(0.2);
            VfxManager.Emit(u3);
            local _ = i;
        end;
    end)();
    coroutine.wrap(function() -- Line: 34
        -- upvalues: VfxManager (ref), u2 (copy)
        for i = 1, 5 do
            VfxManager.Emit(u2);
            task.wait(0.4);
            local _ = i;
        end;
    end)();
    task.wait(2.3);
    Debris:AddItem(u2, 5);
    Debris:AddItem(u3, 5);
end;
  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
local RunService = game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);

return function(p1) -- Line: 10
    -- upvalues: VfxManager (copy), RunService (copy)
    local Char = p1.Char;

    if p1.Action == "Start" then
        local v2 = script.RunEmit:Clone();
        v2:PivotTo(Char.HumanoidRootPart.CFrame);
        v2.Parent = workspace.Debris;
        VfxManager.Emit(v2);
        local u3 = script.RunEmitDebree:Clone();
        u3:PivotTo(Char.HumanoidRootPart.CFrame);
        u3.Parent = workspace.Debris;
        RunService.Heartbeat:Connect(function() -- Line: 23
            -- upvalues: u3 (copy), Char (copy)
            u3:PivotTo(Char.HumanoidRootPart.CFrame);
        end);
        local os_clock_ret = os.clock();

        while Char:GetAttribute("DestructionCharging") and os.clock() - os_clock_ret < 3 do
            task.wait(0.2);
            VfxManager.Emit(u3);
        end;
    elseif p1.Action == "End" then
        local u4 = script.SidetoSide:Clone();
        u4:PivotTo(Char.HumanoidRootPart.CFrame);
        u4.Parent = workspace.Debris;
        RunService.Heartbeat:Connect(function() -- Line: 39
            -- upvalues: u4 (copy), Char (copy)
            u4:PivotTo(Char.HumanoidRootPart.CFrame);
        end);
        VfxManager.Emit(u4);
    end;
end;
  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);

return function(p1) -- Line: 10
    -- upvalues: Debris (copy), VfxManager (copy), RunService (copy)
    local Char = p1.Char;
    task.wait(0.2);
    local v2 = script.KickStartUp:Clone();
    v2:PivotTo(Char.HumanoidRootPart.CFrame);
    v2.Parent = workspace.Debris;
    Debris:AddItem(v2, 5);
    VfxManager.Emit(v2);
    task.wait(0.2);
    local v3 = script.RunEmit:Clone();
    v3:PivotTo(Char.HumanoidRootPart.CFrame);
    v3.Parent = workspace.Debris;
    VfxManager.Emit(v3);
    local u4 = script.RunEmitDebree:Clone();
    u4:PivotTo(Char.HumanoidRootPart.CFrame);
    u4.Parent = workspace.Debris;
    Debris:AddItem(u4, 3);
    VfxManager.Emit(u4);
    RunService.Heartbeat:Connect(function() -- Line: 35
        -- upvalues: u4 (copy), Char (copy)
        u4:PivotTo(Char.HumanoidRootPart.CFrame * CFrame.new(0, -3, 0));
    end);
end;
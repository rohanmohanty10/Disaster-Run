  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);

return function(p1) -- Line: 10
    -- upvalues: VfxManager (copy), Debris (copy), RunService (copy)
    local HumanoidRootPart = p1.Char:FindFirstChild("HumanoidRootPart");
    local Football = workspace:FindFirstChild("Football");
    local v2 = script.Periscope.Warning:Clone();
    v2.CFrame = Football.CFrame;
    v2.Parent = workspace.Debris;
    VfxManager.Emit(v2);
    VfxManager.Enable(v2, true);
    local v3 = script.Periscope.Jump:Clone();
    v3.CFrame = HumanoidRootPart.CFrame;
    v3.Parent = workspace.Debris;
    VfxManager.Emit(v3);
    Debris:AddItem(v3, 3);
    local u4 = script.Periscope.GoingInAir:Clone();
    u4.Parent = workspace.Debris;
    local v6 = RunService.Heartbeat:Connect(function() -- Line: 32
        -- upvalues: HumanoidRootPart (copy), u4 (copy)
        local v5 = workspace:FindFirstChild("Football") and workspace.Football.Position or HumanoidRootPart.Position;
        u4.CFrame = CFrame.new(HumanoidRootPart.Position, v5) * CFrame.Angles(-1.5707963267948966, 0, 0);
    end);
    VfxManager.Enable(u4, true);
    task.wait(0.5);
    local v7 = script.Periscope.Catch:Clone();
    v7.CFrame = HumanoidRootPart.CFrame;
    v7.Parent = workspace.Debris;
    VfxManager.Emit(v7);
    Debris:AddItem(v7, 3);
    task.wait(0.32);
    VfxManager.Enable(u4, false);
    VfxManager.Enable(v2, false);
    task.wait(0.68);
    v6:Disconnect();
    RunService.Heartbeat:Connect(function() -- Line: 57
        -- upvalues: u4 (copy), HumanoidRootPart (copy)
        u4.CFrame = HumanoidRootPart.CFrame;
    end);
    VfxManager.Enable(u4, true);
    local v8 = script.Periscope.Shoot:Clone();
    v8.CFrame = HumanoidRootPart.CFrame * CFrame.Angles(-1.5707963267948966, 0, 0);
    v8.Parent = workspace.Debris;
    VfxManager.Emit(v8);
    Debris:AddItem(v8, 3);
    task.wait(0.8);
    v2:Destroy();
    local v9 = script.Periscope.Jump:Clone();
    v9.CFrame = HumanoidRootPart.CFrame;
    v9.Parent = workspace.Debris;
    VfxManager.Emit(v9);
    Debris:AddItem(v9, 3);
    VfxManager.Enable(u4, false);
    Debris:AddItem(u4, 3);
end;
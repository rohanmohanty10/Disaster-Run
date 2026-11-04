  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("UserInputService");
local RunService = game:GetService("RunService");
local Debris = game:GetService("Debris");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Controllers.SpectatorController);

return function(p1) -- Line: 12
    -- upvalues: Debris (copy), VfxManager (copy), RunService (copy)
    local Char = p1.Char;
    local HumanoidRootPart = Char.HumanoidRootPart;
    local Folder = Instance.new("Folder");
    Folder.Name = "BachiraHighlight";
    Folder.Parent = Char;
    Debris:AddItem(Folder, 1.2);
    local v2 = script.Startup:Clone();
    v2:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0));
    v2.Parent = workspace.Debris;
    VfxManager.Emit(v2);
    local u3 = script.SideToSideDribble:Clone();
    u3.Parent = workspace.Debris;
    VfxManager.Emit(u3);
    local v4 = RunService.Heartbeat:Connect(function() -- Line: 33
        -- upvalues: u3 (copy), HumanoidRootPart (copy)
        u3:PivotTo(HumanoidRootPart.CFrame);
    end);
    task.wait(0.6);
    local v5 = script.Jump:Clone();
    v5:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0));
    v5.Parent = workspace.Debris;
    VfxManager.Emit(v5);
    task.wait(0.6);
    local v6 = script.EndEmit:Clone();
    v6:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0));
    v6.Parent = workspace.Debris;
    VfxManager.Emit(v6);
    v4:Disconnect();

    if Folder then
        Folder:Destroy();
    end;

    task.wait(1);
    v6:Destroy();
    v5:Destroy();
    u3:Destroy();
    v2:Destroy();
end;
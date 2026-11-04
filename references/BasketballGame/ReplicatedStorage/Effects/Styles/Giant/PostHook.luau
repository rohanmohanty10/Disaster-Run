 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;

return function(p1, p2) -- Line: 14
    -- upvalues: Essentials (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local _ = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local u3 = script.TorsoEnable:Clone();
    u3.Parent = workspace.Debris;
    u3.CFrame = HumanoidRootPart.CFrame;
    Essentials:Weld(u3, HumanoidRootPart);
    VfxManager.Enable(u3, true);
    local u4 = script.PostHookActivation.Spin:Clone();
    u4.Parent = workspace.Debris;
    u4.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.661, -2.847, 0.248) * CFrame.Angles(0, -3.141592653589793, 0);
    Essentials:Weld(u4, HumanoidRootPart);
    VfxManager.Emit(u4);
    task.delay(0.9, function() -- Line: 35
        -- upvalues: HumanoidRootPart (copy), Essentials (ref), VfxManager (ref), u3 (copy), u4 (copy)
        if not HumanoidRootPart then
            return;
        end;

        local v5 = script.Release:Clone();
        v5.Parent = workspace.Debris;
        v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(1.052, 6.013, -0.002) * CFrame.Angles(-0.43580871422298406, 0, 0);
        Essentials:Weld(v5, HumanoidRootPart);
        VfxManager.Enable(u3, false);
        VfxManager.Emit(v5);
        task.wait(3);

        if u4 then
            u4:Destroy();
        end;

        if u3 then
            u3:Destroy();
        end;

        if v5 then
            v5:Destroy();
        end;
    end);
end;
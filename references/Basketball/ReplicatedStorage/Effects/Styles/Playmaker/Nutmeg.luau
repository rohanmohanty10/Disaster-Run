 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;

return function(p1, p2) -- Line: 13
    -- upvalues: SfxManager (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local Torso = Char:FindFirstChild("Torso");
    Char:FindFirstChild("BALL", true);
    SfxManager:playSound({
        Sound = "NutmegPlaymaker",
        Parent = HumanoidRootPart
    });
    local v4 = script.Activate:Clone();
    v4.Parent = workspace.Debris;
    v4:PivotTo(HumanoidRootPart.CFrame);
    VfxManager.Emit(v4);
    task.delay(3, v4.Destroy, v4);
    local u5 = script.Dribble:Clone();
    u5.Parent = workspace.Debris;
    u5:PivotTo(HumanoidRootPart.CFrame);
    task.delay(3, u5.Destroy, u5);
    local u6 = script.TorsoEnable.Attachment:Clone();
    u6.Parent = Torso;
    VfxManager.Enable(u6, true);
    task.delay(0.217 - v3, function() -- Line: 40
        -- upvalues: u5 (copy), HumanoidRootPart (copy), VfxManager (ref)
        u5:PivotTo(HumanoidRootPart.CFrame);
        VfxManager.Emit(u5.Dribble);
    end);
    task.delay(0.7, function() -- Line: 45
        -- upvalues: u6 (copy), VfxManager (ref)
        if u6 then
            VfxManager.Enable(u6, false);
            task.wait(1);
            u6:Destroy();
        end;
    end);
end;
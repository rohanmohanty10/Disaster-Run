 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;

return function(p1, p2) -- Line: 14
    -- upvalues: SfxManager (copy), Essentials (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local _ = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    SfxManager:playSound({
        Sound = "SnatchBlock",
        Parent = HumanoidRootPart
    });
    task.delay(0.167, function() -- Line: 23
        -- upvalues: HumanoidRootPart (copy), Essentials (ref), VfxManager (ref)
        local v3 = script.Jump:Clone();
        v3.Parent = workspace.Debris;
        v3.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.003, -2.753, 0.152) * CFrame.Angles(-0.16458454846306528, 0, 0);
        Essentials:Weld(v3, HumanoidRootPart);
        VfxManager.Emit(v3);
        task.delay(3, v3.Destroy, v3);
    end);
    task.delay(0.467, function() -- Line: 33
        -- upvalues: HumanoidRootPart (copy), VfxManager (ref)
        local v4 = script.Grab_Emit:Clone();
        v4.Parent = workspace.Debris;
        v4.CFrame = HumanoidRootPart.CFrame * CFrame.new(-1.101, 3.784, -2.047);
        VfxManager.Emit(v4);
        task.delay(3, v4.Destroy, v4);
    end);
end;
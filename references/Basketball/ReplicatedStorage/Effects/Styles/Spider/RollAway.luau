 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;

return function(p1, p2) -- Line: 13
    -- upvalues: SfxManager (copy), VfxManager (copy), Essentials (copy)
    local Character = p2.Character;
    local v3 = workspace:GetServerTimeNow() - p2.TimeSent;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Spider Evade",
        Parent = Character
    });
    local u4 = script.spin:Clone();
    local u5 = script.jump:Clone();
    u5.Parent = HumanoidRootPart;
    u5.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -3, 0);
    VfxManager.Emit(u5);
    task.delay(0.27 - v3, function() -- Line: 30
        -- upvalues: u4 (copy), HumanoidRootPart (copy), Essentials (ref), VfxManager (ref)
        u4.Parent = HumanoidRootPart;
        u4.CFrame = HumanoidRootPart.CFrame;
        Essentials:Weld(u4, HumanoidRootPart);
        VfxManager.Emit(u4);
    end);
    task.delay(1, function() -- Line: 37
        -- upvalues: u4 (copy), u5 (copy)
        u4:Destroy();
        u5:Destroy();
    end);
end;
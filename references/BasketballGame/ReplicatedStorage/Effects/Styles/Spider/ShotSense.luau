 
 

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
    -- upvalues: SfxManager (copy), Essentials (copy), VfxManager (copy)
    local Character = p2.Character;
    local v3 = workspace:GetServerTimeNow() - p2.TimeSent;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Spider SnatchPull",
        Parent = Character
    });
    local u4 = script.WebShoot:Clone();
    u4.Parent = Character;
    local u5 = script.spin:Clone();
    u5.Parent = Character;
    Essentials:Weld(u5, Character.PlrBall.Anims.BALL);
    local u6 = script.RightWeb:Clone();
    u6.Parent = Character["Right Arm"];
    task.delay(0.2 - v3, function() -- Line: 30
        -- upvalues: u4 (copy), HumanoidRootPart (copy), VfxManager (ref), u6 (copy), Character (copy)
        u4.CFrame = HumanoidRootPart.CFrame;
        VfxManager.Emit(u4);
        u6.Beam.Attachment0 = Character.PlrBall.Anims.BALL["1"];
        u6.Beam.Enabled = true;
    end);
    task.delay(0.9333333333333333 - v3, function() -- Line: 37
        -- upvalues: u6 (copy), VfxManager (ref), u5 (copy)
        u6.Beam.Enabled = false;
        VfxManager.Emit(u5);
    end);
    task.delay(1.2666666666666666 - v3, function() -- Line: 42
        -- upvalues: u4 (copy), u5 (copy), u6 (copy)
        if u4 then
            u4:Destroy();
        end;

        if u5 then
            u5:Destroy();
        end;

        if u6 then
            u6:Destroy();
        end;
    end);
end;
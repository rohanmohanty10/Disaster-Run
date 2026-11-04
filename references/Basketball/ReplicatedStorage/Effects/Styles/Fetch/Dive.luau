 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 14
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Debris (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local _ = ReplicatedStorage.Basketball.Value;
    Char:FindFirstChild("BALL", true);

    if p2.Task == "Activate" then
        SfxManager:playSound({
            Sound = "red grabthingy sfx bbz",
            Parent = HumanoidRootPart
        });
        task.delay(0.133 - v3, function() -- Line: 28
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart then
                local v4 = script.Dash:Clone();
                v4.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.00496673583984375, -0.7060871124267578, -3.0042800903320312) * CFrame.fromEulerAnglesYXZ(-0, 1.5720877647399902, 0);
                v4.Parent = Debris;
                VfxManager.Emit(v4);
                VfxManager.DestroyEffect(v4, 2);
            end;
        end);
        task.delay(0.233 - v3, function() -- Line: 38
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart then
                local v5 = script.Catch:Clone();
                v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.08899688720703125, -0.16000008583068848, -3.8649978637695312) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
                v5.Parent = Debris;
                VfxManager.Emit(v5);
                VfxManager.DestroyEffect(v5, 2);
            end;
        end);
    end;
end;
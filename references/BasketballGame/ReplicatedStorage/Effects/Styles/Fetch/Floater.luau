 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 14
    -- upvalues: ReplicatedStorage (copy), Debris (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local _ = ReplicatedStorage.Basketball.Value;
    Char:FindFirstChild("BALL", true);

    if p2.Task == "Activate" then
        local v4 = script.StartUp:Clone();
        v4.CFrame = HumanoidRootPart.CFrame;
        v4.Parent = Debris;
        VfxManager.Emit(v4);
        VfxManager.DestroyEffect(v4, 2);
        task.delay(0.733 - v3, function() -- Line: 34
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart then
                local v5 = script.Release:Clone();
                v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.4010009765625, 4.401000022888184, -0.6599998474121094) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
                v5.Parent = Debris;
                VfxManager.Emit(v5);
                VfxManager.DestroyEffect(v5, 2);
            end;
        end);
    end;
end;
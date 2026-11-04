 
 

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
    local _ = p2.TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local _ = ReplicatedStorage.Basketball.Value;
    Char:FindFirstChild("BALL", true);
    local _ = workspace:GetServerTimeNow() - p2.previousTime + p2.passedTime;

    if p2.Task == "Activate" then
        SfxManager:playSound({
            Sound = "DioSteamRoller",
            Parent = HumanoidRootPart
        });
        task.delay(0.117, function() -- Line: 28
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart then
                local v3 = script.firstemit:Clone();
                v3.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.2872905731201172, -1.390364646911621, -0.3144073486328125) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
                v3.Parent = Debris;
                VfxManager.Emit(v3);
                VfxManager.DestroyEffect(v3, 3);
            end;
        end);
        task.delay(1.033, function() -- Line: 39
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart then
                local v4 = script.land:Clone();
                v4.CFrame = HumanoidRootPart.CFrame * CFrame.new(-2.0202102661132812, -4.332364082336426, 3.2191314697265625) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
                v4.Parent = Debris;
                VfxManager.Emit(v4);
                VfxManager.DestroyEffect(v4, 3);
            end;
        end);
        task.delay(1.167, function() -- Line: 49
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart then
                local v5 = script.hits:Clone();
                v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.17014122009277344, 2.3017234802246094, -5.1048126220703125) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
                v5.Parent = Debris;
                VfxManager.Emit(v5);
                VfxManager.DestroyEffect(v5, 3);
            end;
        end);
        task.delay(2.467, function() -- Line: 61
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart then
                local v6 = script.explosion:Clone();
                v6.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.2947883605957031, -2.765364646911621, 0.37810516357421875) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
                v6.Parent = Debris;
                VfxManager.Emit(v6);
                VfxManager.DestroyEffect(v6, 3);
            end;
        end);
    end;
end;
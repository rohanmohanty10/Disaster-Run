 
 

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

local function AttachMotor(p1, p2, p3, p4) -- Line: 14
    local Motor6D = Instance.new("Motor6D");
    Motor6D.Part0 = p1;
    Motor6D.Part1 = p2;
    Motor6D.C1 = p4;
    Motor6D.C0 = p3;
    Motor6D.Parent = p2;
end;

return function(p5, p6) -- Line: 23
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Debris (copy), VfxManager (copy)
    local TimeSent = p6.TimeSent;
    local v7 = workspace:GetServerTimeNow() - TimeSent;
    local Char = p6.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local _ = ReplicatedStorage.Basketball.Value;
    Char:FindFirstChild("BALL", true);
    local _ = Char.Name .. script.Parent.Name .. script.Name;

    if p6.Task == "Activate" then
        SfxManager:playSound({
            Sound = "BBZ UncSam CannonPass",
            Parent = HumanoidRootPart
        });
        task.delay(0.083 - v7, function() -- Line: 39
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart then
                local v8 = script.Pass:Clone();
                v8.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.27536776661872864, 0.22606849670410156, -1.8323395252227783) * CFrame.fromEulerAnglesYXZ(1.5707963705062866, 3.1415927410125732, 0);
                v8.Parent = Debris;
                VfxManager.Emit(v8);
                VfxManager.DestroyEffect(v8, 3);
            end;
        end);
        task.delay(0.15 - v7, function() -- Line: 50
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart then
                local v9 = script.Spawn:Clone();
                v9.CFrame = HumanoidRootPart.CFrame * CFrame.new(4.323796272277832, -2.878868818283081, -8.772126197814941) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
                v9.Parent = Debris;
                VfxManager.Emit(v9);
                VfxManager.DestroyEffect(v9, 3);
            end;
        end);
        task.delay(0.767 - v7, function() -- Line: 60
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart then
                local v10 = script.Jump:Clone();
                v10.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.7106322050094604, -3.015932559967041, -4.409339427947998) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
                v10.Parent = Debris;
                VfxManager.Emit(v10);
                VfxManager.DestroyEffect(v10, 3);
            end;
        end);
        task.delay(0.9 - v7, function() -- Line: 70
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart then
                local v11 = script.Push:Clone();
                v11.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.2746322453022003, 1.4200687408447266, -14.53633975982666) * CFrame.fromEulerAnglesYXZ(1.5707963705062866, 3.1415927410125732, 0);
                v11.Parent = Debris;
                VfxManager.Emit(v11);
                VfxManager.DestroyEffect(v11, 3);
            end;
        end);
        task.delay(1.717 - v7, function() -- Line: 80
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart then
                local v12 = script.Recoil:Clone();
                v12.CFrame = HumanoidRootPart.CFrame * CFrame.new(1.694796085357666, -2.878868818283081, -4.7741265296936035) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
                v12.Parent = Debris;
                VfxManager.Emit(v12);
                VfxManager.DestroyEffect(v12, 3);
                local v13 = script.Shoot:Clone();
                v13.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.04000069200992584, 1.8463859558105469, -11.568624496459961) * CFrame.fromEulerAnglesYXZ(1.4309947490692139, 3.053086996078491, 3.131796360015869);
                v13.Parent = Debris;
                VfxManager.Emit(v13);
                VfxManager.DestroyEffect(v13, 3);
            end;
        end);
    end;
end;
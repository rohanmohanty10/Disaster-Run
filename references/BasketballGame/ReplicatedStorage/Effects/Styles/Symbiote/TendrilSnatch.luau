 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local _ = game.Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 14
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Debris (copy), Essentials (copy), VfxManager (copy)
    local _ = p2.TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local Torso = Char:FindFirstChild("Torso");
    local Value = ReplicatedStorage.Basketball.Value;
    Char:FindFirstChild("BALL", true);
    local _ = workspace:GetServerTimeNow() - p2.previousTime + p2.passedTime;

    if p2.Task ~= "OnBall" then
        if p2.Task == "OffBall" then
            SfxManager:playSound({
                Sound = "BBZ Symbiote Tendril Snatch",
                Parent = HumanoidRootPart
            });
            task.delay(0.333, function() -- Line: 113
                -- upvalues: HumanoidRootPart (copy), Value (copy), Debris (ref), VfxManager (ref)
                if HumanoidRootPart then
                    local v3 = script.OffBall.hit1:Clone();
                    v3.CFrame = Value.CFrame;
                    v3.Parent = Debris;
                    VfxManager.Emit(v3);
                    VfxManager.DestroyEffect(v3, 3);
                end;
            end);
            task.delay(0.55, function() -- Line: 123
                -- upvalues: HumanoidRootPart (copy), Torso (copy), Debris (ref), VfxManager (ref)
                if HumanoidRootPart then
                    local v4 = script.OffBall.spin:Clone();
                    v4.CFrame = Torso.CFrame;
                    v4.Parent = Debris;
                    VfxManager.Emit(v4);
                    VfxManager.DestroyEffect(v4, 3);
                end;
            end);
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Symbiote Tendril Combo",
        Parent = HumanoidRootPart
    });
    local Head = Char:FindFirstChild("Head");
    local u5 = script.OnBall.Head:Clone();
    u5.CFrame = Head.CFrame;
    u5.Parent = Debris;
    Essentials:Weld(u5, Head);
    local u6 = script.OnBall.Torso:Clone();
    u6.CFrame = Torso.CFrame;
    u6.Parent = Debris;
    Essentials:Weld(u6, Head);
    task.delay(0.567, function() -- Line: 40
        -- upvalues: HumanoidRootPart (copy), Torso (copy), Debris (ref), VfxManager (ref)
        if HumanoidRootPart then
            local v7 = script.OnBall.spin:Clone();
            v7.CFrame = Torso.CFrame;
            v7.Parent = Debris;
            VfxManager.Emit(v7);
            VfxManager.DestroyEffect(v7, 3);
        end;
    end);
    task.delay(0.85, function() -- Line: 50
        -- upvalues: HumanoidRootPart (copy), VfxManager (ref), u5 (copy), u6 (copy), Debris (ref), Essentials (ref)
        if HumanoidRootPart then
            VfxManager.Enable(u5, true);
            VfxManager.Enable(u6, true);
            local v8 = script.OnBall.auraemit:Clone();
            v8.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.13825607299804688, -0.28734898567199707, 0.0812530517578125) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
            v8.Parent = Debris;
            VfxManager.Emit(v8);
            VfxManager.DestroyEffect(v8, 3);
            local v9 = script.OnBall.run:Clone();
            v9.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.0281982421875, -0.838026762008667, 0.300933837890625) * CFrame.fromEulerAnglesYXZ(-0.01347403135150671, 3.1415927410125732, 3.1415927410125732);
            v9.Parent = Debris;
            VfxManager.Emit(v9);
            Essentials:Weld(v9, HumanoidRootPart);
            VfxManager.DestroyEffect(v9, 3);
        end;
    end);
    task.delay(0.967, function() -- Line: 71
        -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
        if HumanoidRootPart then
            local v10 = script.OnBall.dribble:Clone();
            v10.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.9542579650878906, -2.0123491287231445, -3.105743408203125) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
            v10.Parent = Debris;
            VfxManager.Emit(v10);
            VfxManager.DestroyEffect(v10, 3);
        end;
    end);
    task.delay(1.25, function() -- Line: 81
        -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
        if HumanoidRootPart then
            local v11 = script.OnBall.dribble:Clone();
            v11.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.9542579650878906, -2.0123491287231445, -3.105743408203125) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
            v11.Parent = Debris;
            VfxManager.Emit(v11);
            VfxManager.DestroyEffect(v11, 3);
        end;
    end);
    task.delay(1.767, function() -- Line: 91
        -- upvalues: HumanoidRootPart (copy), VfxManager (ref), u5 (copy), u6 (copy), Debris (ref)
        if HumanoidRootPart then
            VfxManager.Enable(u5, false);
            VfxManager.Enable(u6, false);
            VfxManager.DestroyEffect(u5, 3);
            VfxManager.DestroyEffect(u6, 3);
            local v12 = script.OnBall.auraemit:Clone();
            v12.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.13825607299804688, -0.28734898567199707, 0.0812530517578125) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
            v12.Parent = Debris;
            VfxManager.Emit(v12);
            VfxManager.DestroyEffect(v12, 3);
        end;
    end);
end;
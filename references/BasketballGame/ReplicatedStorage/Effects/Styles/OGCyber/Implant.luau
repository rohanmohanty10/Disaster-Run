 
 

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
    -- upvalues: SfxManager (copy), Debris (copy), VfxManager (copy), Essentials (copy)
    local TimeSent = p2.TimeSent;
    local _ = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    local u3 = Char:FindFirstChild("Right Arm");

    if p2.Task ~= "Activate" then
        if p2.Task ~= "Dash" then
            if p2.Task == "Projectile" then
                SfxManager:playSound({
                    Sound = "BBZ Cyber ArmCannon Shot",
                    Parent = HumanoidRootPart
                });
                task.delay(0.2, function() -- Line: 126
                    -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
                    local v4 = script.projectile.throwup:Clone();
                    v4.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.22804850339889526, 2.509000301361084, -1.457951545715332) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
                    v4.Parent = Debris;
                    VfxManager.Emit(v4);
                    VfxManager.DestroyEffect(v4, 3);
                end);
                task.delay(0.533, function() -- Line: 134
                    -- upvalues: u3 (copy), Debris (ref), VfxManager (ref), Essentials (ref)
                    local v5 = script.projectile.chargeup:Clone();
                    v5.CFrame = u3.CFrame * CFrame.new(-0.025539740920066833, -0.29237866401672363, -0.7817606925964355) * CFrame.fromEulerAnglesYXZ(-1.462031364440918, 0.03445792198181152, -0.1217828020453453);
                    v5.Parent = Debris;
                    VfxManager.Enable(v5, true);
                    Essentials:Weld(v5, u3);
                    task.wait(0.5);
                    VfxManager.Enable(v5, false);
                    VfxManager.DestroyEffect(v5, 3);
                end);
                task.delay(1, function() -- Line: 148
                    -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
                    local v6 = script.projectile.emitboom:Clone();
                    v6.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.0031189918518066406, 1.157754898071289, -1.7918696403503418) * CFrame.fromEulerAnglesYXZ(0.20289453864097595, 0, 0);
                    v6.Parent = Debris;
                    VfxManager.Emit(v6);
                    VfxManager.DestroyEffect(v6, 3);
                end);
            end;

            return;
        end;

        SfxManager:playSound({
            Sound = "BBZ DavidCharge",
            Parent = HumanoidRootPart
        });
        local u7 = script.Dash:Clone();
        u7:PivotTo(HumanoidRootPart.CFrame);
        u7.Parent = Debris;
        task.delay(0.2, function() -- Line: 109
            -- upvalues: VfxManager (ref), u7 (copy)
            VfxManager.Enable(u7.chargeup, true);
            task.wait(0.8);
            VfxManager.Enable(u7.chargeup, false);
        end);
        task.delay(0.83, function() -- Line: 117
            -- upvalues: VfxManager (ref), u7 (copy)
            VfxManager.Emit(u7.emitdash);
            VfxManager.DestroyEffect(u7, 3);
        end);

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ DavidChair",
        Parent = HumanoidRootPart
    });
    local u8 = script.VFX:Clone();
    u8:PivotTo(HumanoidRootPart.CFrame);
    u8.Parent = Debris;
    task.delay(0.717, function() -- Line: 30
        -- upvalues: VfxManager (ref), u8 (copy)
        VfxManager.Enable(u8.sparks1enabled, true);
        task.wait(0.5);
        VfxManager.Enable(u8.sparks1enabled, false);
    end);
    task.delay(1.183, function() -- Line: 38
        -- upvalues: VfxManager (ref), u8 (copy)
        VfxManager.Emit(u8.TP);
    end);
    task.delay(1.283, function() -- Line: 42
        -- upvalues: VfxManager (ref), u8 (copy)
        VfxManager.Enable(u8.sparks2enabled, true);
        task.wait(0.5);
        VfxManager.Enable(u8.sparks2enabled, false);
    end);
    task.delay(1.65, function() -- Line: 50
        -- upvalues: VfxManager (ref), u8 (copy)
        VfxManager.Emit(u8.TP2);
    end);
    task.delay(1.667, function() -- Line: 54
        -- upvalues: VfxManager (ref), u8 (copy)
        VfxManager.Enable(u8.sparks3enabled, true);
        task.wait(0.5);
        VfxManager.Enable(u8.sparks3enabled, false);
    end);
    task.delay(1.967, function() -- Line: 62
        -- upvalues: VfxManager (ref), u8 (copy)
        VfxManager.Emit(u8.TP3);
    end);
    task.delay(2.267, function() -- Line: 66
        -- upvalues: VfxManager (ref), u8 (copy)
        VfxManager.Emit(u8.TP4);
    end);
    task.delay(2.467, function() -- Line: 70
        -- upvalues: VfxManager (ref), u8 (copy)
        VfxManager.Emit(u8.TP5);
    end);
    task.delay(2.6, function() -- Line: 74
        -- upvalues: VfxManager (ref), u8 (copy)
        VfxManager.Emit(u8.TP6);
    end);
    task.delay(2.667, function() -- Line: 78
        -- upvalues: VfxManager (ref), u8 (copy)
        VfxManager.Emit(u8.TP7);
    end);
    task.delay(2.733, function() -- Line: 82
        -- upvalues: VfxManager (ref), u8 (copy)
        VfxManager.Emit(u8.TP8);
    end);
    task.delay(2.8, function() -- Line: 86
        -- upvalues: VfxManager (ref), u8 (copy)
        VfxManager.Emit(u8.TP8);
    end);
    task.delay(2.867, function() -- Line: 90
        -- upvalues: VfxManager (ref), u8 (copy)
        VfxManager.Emit(u8.TP9);
    end);
    task.delay(2.933, function() -- Line: 94
        -- upvalues: VfxManager (ref), u8 (copy)
        VfxManager.Emit(u8.TP10);
        VfxManager.DestroyEffect(u8, 3);
    end);
end;
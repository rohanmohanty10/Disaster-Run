 
 

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

return function(p1, p2) -- Line: 15
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Debris (copy), Essentials (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local speed = p2.speed;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local Value = ReplicatedStorage.Basketball.Value;
    local BALL = Char:FindFirstChild("BALL", true);

    if p2.Task == "Heat Check" then
        SfxManager:playSound({
            Sound = "Clutch heat check",
            Parent = HumanoidRootPart
        });
        local u4 = script.Weld:Clone();
        u4.CFrame = BALL.CFrame;
        u4.Parent = Debris;
        Essentials:Weld(u4, BALL);
        VfxManager.Enable(u4, true);
        task.delay(0.333 / speed - v3, function() -- Line: 36
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            local v5 = script.Jump:Clone();
            v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.22125393152236938, -2.208643913269043, -0.9433722496032715) * CFrame.fromEulerAnglesYXZ(1.5707963705062866, -1.5707963705062866, 0);
            v5.Parent = Debris;
            VfxManager.Emit(v5);
            VfxManager.DestroyEffect(v5, 2);
        end);
        task.delay(0.667 / speed - v3, function() -- Line: 44
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref), u4 (copy), Value (copy), Essentials (ref)
            local v6 = script.Release:Clone();
            v6.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.7272541522979736, 6.007096290588379, -0.03787240386009216) * CFrame.fromEulerAnglesYXZ(-0, -1.5707963705062866, 0);
            v6.Parent = Debris;
            VfxManager.Emit(v6);
            VfxManager.DestroyEffect(v6, 2);
            VfxManager.Enable(u4, false);
            VfxManager.DestroyEffect(u4, 2);
            local u7 = script.Weld:Clone();
            u7.CFrame = Value.CFrame;
            u7.Parent = Debris;
            Essentials:Weld(u7, Value);
            VfxManager.Enable(u7, true);
            task.delay(2, function() -- Line: 60
                -- upvalues: u7 (copy), VfxManager (ref)
                if u7 then
                    VfxManager.Enable(u7, false);
                    VfxManager.DestroyEffect(u7, 2);
                end;
            end);
        end);
        task.delay(1.1 / speed - v3, function() -- Line: 68
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            local v8 = script.Landing:Clone();
            v8.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.1667460799217224, -3.274643898010254, 0.6256278157234192) * CFrame.fromEulerAnglesYXZ(1.5707963705062866, -1.5707963705062866, 0);
            v8.Parent = Debris;
            VfxManager.Emit(v8);
            VfxManager.DestroyEffect(v8, 2);
        end);
        task.delay(1.3 / speed - v3, function() -- Line: 76
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            local v9 = script.Celly:Clone();
            v9.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.479736328125, 0.24082183837890625, -0.35935914516448975) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
            v9.Parent = Debris;
            VfxManager.Emit(v9);
            VfxManager.DestroyEffect(v9, 2);
        end);
    end;
end;
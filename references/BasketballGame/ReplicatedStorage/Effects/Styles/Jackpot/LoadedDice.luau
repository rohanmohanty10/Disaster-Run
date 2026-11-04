 
 

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
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Debris (copy), VfxManager (copy), Essentials (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local Value = ReplicatedStorage.Basketball.Value;
    local BALL = Char:FindFirstChild("BALL", true);

    if p2.Task ~= "Lucky_Shot" then
        if p2.Task == "Lucky_Pull" then
            local u4 = script.Weld:Clone();
            u4.CFrame = Value.CFrame;
            u4.Parent = Debris;
            Essentials:Weld(u4, Value);
            VfxManager.Enable(u4, true);
            task.delay(1, function() -- Line: 97
                -- upvalues: u4 (copy), VfxManager (ref)
                if u4 then
                    VfxManager.Enable(u4, false);
                    VfxManager.DestroyEffect(u4, 2);
                end;
            end);
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Gambler Lucky Shot",
        Parent = HumanoidRootPart
    });
    task.wait(0.317 - v3);

    if not HumanoidRootPart then
        return;
    end;

    local v5 = script.Dribble:Clone();
    v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(2.0819129943847656, -3.246119499206543, 0.2960968017578125) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
    v5.Parent = Debris;
    VfxManager.Emit(v5);
    VfxManager.DestroyEffect(v5, 3);
    local u6 = script.Weld:Clone();
    u6.CFrame = BALL.CFrame;
    u6.Parent = Debris;
    Essentials:Weld(u6, BALL);
    VfxManager.Enable(u6, true);
    task.wait(0.333);

    if not HumanoidRootPart then
        return;
    end;

    local v7 = script.Jump:Clone();
    v7.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.12859344482421875, -3.0023813247680664, 0.29918670654296875) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
    v7.Parent = Debris;
    VfxManager.Emit(v7);
    VfxManager.DestroyEffect(v7, 3);
    task.wait(0.2);

    if not HumanoidRootPart then
        return;
    end;

    local v8 = script.Ball_Emit:Clone();
    v8.CFrame = HumanoidRootPart.CFrame * CFrame.new(1.228179931640625, 8.593771934509277, -0.4153289794921875) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
    v8.Parent = Debris;
    VfxManager.Emit(v8);
    VfxManager.DestroyEffect(v8, 3);
    task.wait(0.067);

    if not HumanoidRootPart then
        return;
    end;

    task.wait(0.366);

    if not HumanoidRootPart then
        return;
    end;

    local v9 = script.Release:Clone();
    v9.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.6769676208496094, 6.766887664794922, -2.3347091674804688) * CFrame.fromEulerAnglesYXZ(0.5759586691856384, 0, 0);
    v9.Parent = Debris;
    VfxManager.Emit(v9);
    VfxManager.DestroyEffect(v9, 3);
    VfxManager.Enable(u6, false);
    u6:FindFirstChild("WeldConstraint"):Destroy();
    u6.CFrame = Value.CFrame;
    Essentials:Weld(u6, Value);
    VfxManager.Enable(u6, true);
    VfxManager.DestroyEffect(u6, 5);
    task.delay(3, function() -- Line: 86
        -- upvalues: VfxManager (ref), u6 (copy)
        VfxManager.Enable(u6, false);
    end);
end;
 
 

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
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Debris (copy), VfxManager (copy), Essentials (copy)
    local _ = p2.TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local Value = ReplicatedStorage.Basketball.Value;
    local BALL = Char:FindFirstChild("BALL", true);
    local _ = workspace:GetServerTimeNow() - p2.previousTime + p2.passedTime;

    if p2.Task == "GumBlock" then
        SfxManager:playSound({
            Sound = "BBZ Rubber Mine",
            Parent = HumanoidRootPart
        });
        task.delay(0.467, function() -- Line: 28
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart then
                local v3 = script.GumBlock.ArmStretch:Clone();
                v3.CFrame = HumanoidRootPart.CFrame;
                v3.Parent = Debris;
                VfxManager.Emit(v3);
                VfxManager.DestroyEffect(v3, 3);
            end;
        end);
        task.delay(0.583, function() -- Line: 38
            -- upvalues: BALL (copy), Debris (ref), VfxManager (ref)
            local v4 = script.GumBlock.Catch:Clone();
            v4.CFrame = BALL.CFrame;
            v4.Parent = Debris;
            VfxManager.Emit(v4);
            VfxManager.DestroyEffect(v4, 3);
        end);

        return;
    end;

    if p2.Task == "UndeterminedShot" then
        SfxManager:playSound({
            Sound = "BBZ Rubber Punch Shot",
            Parent = HumanoidRootPart
        });
        task.delay(0.417, function() -- Line: 51
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart then
                local v5 = script.UndeterminedShot.ArmStretch:Clone();
                v5.CFrame = HumanoidRootPart.CFrame;
                v5.Parent = Debris;
                VfxManager.Emit(v5);
                VfxManager.DestroyEffect(v5, 3);
            end;
        end);
        task.delay(0.9, function() -- Line: 61
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart then
                local v6 = script.GumBlock.Catch:Clone();
                v6.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.6620000004768372, 8.471583366394043, -18.969640731811523) * CFrame.fromEulerAnglesYXZ(-0, 0, 0);
                v6.Parent = Debris;
                VfxManager.Emit(v6);
                VfxManager.DestroyEffect(v6, 3);
            end;
        end);

        return;
    end;

    if p2.Task ~= "GumSteal" then
        if p2.Task == "Observe" then
            SfxManager:playSound({
                Sound = "BBZ Rubber Haki Dash",
                Parent = HumanoidRootPart
            });
            local Head = Char:FindFirstChild("Head");
            local v7 = script.Observe.Head:Clone();
            v7.CFrame = Head.CFrame;
            v7.Parent = Debris;
            Essentials:Weld(v7, Head);
            VfxManager.Enable(v7, true);
            task.delay(0.267, function() -- Line: 105
                -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
                if HumanoidRootPart then
                    local v8 = script.Observe.Dribble_1:Clone();
                    v8.CFrame = HumanoidRootPart.CFrame * CFrame.new(-1.4893698692321777, -2.999161720275879, -1.1781330108642578) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
                    v8.Parent = Debris;
                    VfxManager.Emit(v8);
                    VfxManager.DestroyEffect(v8, 3);
                end;
            end);
            task.wait(0.667);
            VfxManager.Enable(v7, false);
            VfxManager.DestroyEffect(v7, 3);
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Rubber Gut Punch",
        Parent = HumanoidRootPart
    });
    task.delay(0.3, function() -- Line: 74
        -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
        if HumanoidRootPart then
            local v9 = script.GumSteal.ArmStretch:Clone();
            v9.CFrame = HumanoidRootPart.CFrame;
            v9.Parent = Debris;
            VfxManager.Emit(v9);
            VfxManager.DestroyEffect(v9, 3);
        end;
    end);
    task.delay(0.367, function() -- Line: 84
        -- upvalues: HumanoidRootPart (copy), Value (copy), Debris (ref), VfxManager (ref)
        if HumanoidRootPart then
            local v10 = script.GumBlock.Catch:Clone();
            v10.CFrame = Value.CFrame;
            v10.Parent = Debris;
            VfxManager.Emit(v10);
            VfxManager.DestroyEffect(v10, 3);
        end;
    end);
end;
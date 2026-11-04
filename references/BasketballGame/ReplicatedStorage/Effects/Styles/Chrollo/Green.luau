 
 

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
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local Value = ReplicatedStorage.Basketball.Value;
    local BALL = Char:FindFirstChild("BALL", true);

    if p2.Task == "Fadeaway" then
        SfxManager:playSound({
            Sound = "BBZ Chrollos Fadeaway",
            Parent = HumanoidRootPart
        });
        local u4 = script.Fadeaway.BallFX:Clone();
        u4.CFrame = BALL.CFrame;
        u4.Parent = Debris;
        Essentials:Weld(u4, BALL);
        VfxManager.Enable(u4, true);
        task.delay(0.283 - v3, function() -- Line: 34
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart then
                local v5 = script.Fadeaway.Dribble_0:Clone();
                v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.4439115524291992, -3.0881261825561523, -1.2218551635742188) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
                v5.Parent = Debris;
                VfxManager.Emit(v5);
                VfxManager.DestroyEffect(v5, 3);
            end;
        end);
        task.delay(0.883 - v3, function() -- Line: 44
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if HumanoidRootPart then
                local v6 = script.Fadeaway.Jump:Clone();
                v6.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.4439115524291992, -3.0881261825561523, 0.34214019775390625) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
                v6.Parent = Debris;
                VfxManager.Emit(v6);
                VfxManager.DestroyEffect(v6, 3);
            end;
        end);
        task.delay(1.25 - v3, function() -- Line: 54
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref), u4 (copy), Value (copy), Essentials (ref)
            if HumanoidRootPart then
                local v7 = script.Fadeaway.Shoot:Clone();
                v7.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.6160885095596313, 4.429873943328857, -0.8088531494140625) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
                v7.Parent = Debris;
                VfxManager.Emit(v7);
                VfxManager.DestroyEffect(v7, 3);
                VfxManager.Enable(u4, false);
                u4:FindFirstChild("WeldConstraint"):Destroy();
                u4.CFrame = Value.CFrame;
                Essentials:Weld(u4, Value);
                VfxManager.Enable(u4, true);
                VfxManager.DestroyEffect(u4, 5);
            end;
        end);
        task.delay(4, function() -- Line: 71
            -- upvalues: u4 (copy), VfxManager (ref)
            if u4 then
                VfxManager.Enable(u4, false);
            end;
        end);

        return;
    end;

    if p2.Task ~= "Half-Court" then
        if p2.Task == "Full-Court" then
            SfxManager:playSound({
                Sound = "BBZ Chrollos Full Court",
                Parent = HumanoidRootPart
            });
            local u8 = script["Half-Full-Court"].BallFX:Clone();
            u8.CFrame = BALL.CFrame;
            u8.Parent = Debris;
            Essentials:Weld(u8, BALL);
            VfxManager.Enable(u8, true);
            task.delay(0.7 - v3, function() -- Line: 131
                -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref), u8 (copy), Value (copy), Essentials (ref)
                if HumanoidRootPart then
                    local v9 = script.Shoot:Clone();
                    v9.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.6160885095596313, 2.4278736114501953, -3.7758560180664062) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
                    v9.Parent = Debris;
                    VfxManager.Emit(v9);
                    VfxManager.DestroyEffect(v9, 3);
                    VfxManager.Enable(u8, false);
                    u8:FindFirstChild("WeldConstraint"):Destroy();
                    u8.CFrame = Value.CFrame;
                    Essentials:Weld(u8, Value);
                    VfxManager.Enable(u8, true);
                    VfxManager.DestroyEffect(u8, 5);
                end;
            end);
            task.delay(4, function() -- Line: 148
                -- upvalues: u8 (copy), VfxManager (ref)
                if u8 then
                    VfxManager.Enable(u8, false);
                end;
            end);
        end;

        return;
    end;

    task.wait(0.117);
    SfxManager:playSound({
        Sound = "BBZ Chrollos Half Court",
        Parent = HumanoidRootPart
    });
    local u10 = script["Half-Full-Court"].BallFX:Clone();
    u10.CFrame = BALL.CFrame;
    u10.Parent = Debris;
    Essentials:Weld(u10, BALL);
    VfxManager.Enable(u10, true);
    task.delay(0.217 - v3, function() -- Line: 88
        -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
        if HumanoidRootPart then
            local v11 = script["Half-Full-Court"].Jump:Clone();
            v11.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.4439115524291992, -3.0881261825561523, 0.34214019775390625) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
            v11.Parent = Debris;
            VfxManager.Emit(v11);
            VfxManager.DestroyEffect(v11, 3);
        end;
    end);
    task.delay(0.3 - v3, function() -- Line: 98
        -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref), u10 (copy), Value (copy), Essentials (ref)
        if HumanoidRootPart then
            local v12 = script["Half-Full-Court"].Shoot:Clone();
            v12.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.6160885095596313, 4.429873943328857, -0.8088531494140625) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
            v12.Parent = Debris;
            VfxManager.Emit(v12);
            VfxManager.DestroyEffect(v12, 3);
            VfxManager.Enable(u10, false);
            u10:FindFirstChild("WeldConstraint"):Destroy();
            u10.CFrame = Value.CFrame;
            Essentials:Weld(u10, Value);
            VfxManager.Enable(u10, true);
            VfxManager.DestroyEffect(u10, 5);
        end;
    end);
    task.delay(3, function() -- Line: 115
        -- upvalues: u10 (copy), VfxManager (ref)
        if u10 then
            VfxManager.Enable(u10, false);
        end;
    end);
end;
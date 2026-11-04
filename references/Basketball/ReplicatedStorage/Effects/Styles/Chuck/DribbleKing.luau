 
 

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
    local _ = ReplicatedStorage.Basketball.Value;
    Char:FindFirstChild("BALL", true);

    if p2.Task == "Success" then
        SfxManager:playSound({
            Sound = "Clutch dribble king win",
            Parent = HumanoidRootPart
        });
        local u4 = nil;
        task.delay(0.117 - TimeSent, function() -- Line: 31
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if not HumanoidRootPart then
                return;
            end;

            local v5 = script.Dribble_Sucess.Dribble_0:Clone();
            v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.3009999990463257, -2.874000072479248, 0.7099999785423279) * CFrame.fromEulerAnglesYXZ(-0, -3.141592502593994, 0);
            v5.Parent = Debris;
            VfxManager.Emit(v5);
            VfxManager.DestroyEffect(v5, 1);
        end);
        task.delay(0.383 - TimeSent, function() -- Line: 41
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if not HumanoidRootPart then
                return;
            end;

            local v6 = script.Dribble_Sucess.Dribble_1:Clone();
            v6.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.3009999990463257, -2.874000072479248, 0.7099999785423279) * CFrame.fromEulerAnglesYXZ(-0, -3.141592502593994, 0);
            v6.Parent = Debris;
            VfxManager.Emit(v6);
            VfxManager.DestroyEffect(v6, 1);
        end);
        task.delay(0.667 - TimeSent, function() -- Line: 51
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if not HumanoidRootPart then
                return;
            end;

            local v7 = script.Dribble_Sucess.Dribble_2:Clone();
            v7.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.3009999990463257, -2.874000072479248, 0.7099999785423279) * CFrame.fromEulerAnglesYXZ(-0, -3.141592502593994, 0);
            v7.Parent = Debris;
            VfxManager.Emit(v7);
            VfxManager.DestroyEffect(v7, 1);
        end);
        task.delay(1.05 - TimeSent, function() -- Line: 60
            -- upvalues: HumanoidRootPart (copy), u4 (ref), Debris (ref), Essentials (ref), VfxManager (ref)
            if not HumanoidRootPart then
                return;
            end;

            u4 = script.InfDribble:Clone();
            u4.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.12966632843017578, -2.8177711963653564, -2.444450855255127) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
            u4.Parent = Debris;
            Essentials:Weld(u4, HumanoidRootPart);
            VfxManager.Enable(u4, true);
        end);
        task.delay(2.267 - TimeSent, function() -- Line: 69
            -- upvalues: HumanoidRootPart (copy), u4 (ref), VfxManager (ref)
            if not HumanoidRootPart then
                return;
            end;

            if u4 then
                VfxManager.Enable(u4, false);
                VfxManager.DestroyEffect(u4, 3);
            end;
        end);
        task.delay(2.583 - TimeSent, function() -- Line: 79
            -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            if not HumanoidRootPart then
                return;
            end;

            local v8 = script.Dribble_Sucess.Dribble_3:Clone();
            v8.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.2780000567436218, -2.874000072479248, -1.7740001678466797) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
            v8.Parent = Debris;
            VfxManager.Emit(v8);
            VfxManager.DestroyEffect(v8, 1);
        end);

        return;
    end;

    if p2.Task ~= "Fail" then
        local v9 = p2.Task == "Stun" and p2.otherRig;

        if v9 then
            local HumanoidRootPart2 = v9.HumanoidRootPart;
            task.delay(0.417 - v3, function() -- Line: 155
                -- upvalues: HumanoidRootPart2 (copy), Debris (ref), VfxManager (ref)
                if HumanoidRootPart2 then
                    local v10 = script.Impact:Clone();
                    v10.CFrame = CFrame.new(HumanoidRootPart2.Position.X, 1.1, HumanoidRootPart2.Position.Z);
                    v10.Parent = Debris;
                    VfxManager.Emit(v10);
                    VfxManager.DestroyEffect(v10, 3);
                end;
            end);
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "Clutch dribble king loss",
        Parent = HumanoidRootPart
    });
    local u11 = nil;
    task.delay(0.1 - TimeSent, function() -- Line: 95
        -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
        if not HumanoidRootPart then
            return;
        end;

        local v12 = script.Dribble_Fail.Dribble_0:Clone();
        v12.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.3009999990463257, -2.8740737438201904, 0.7100000381469727) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
        v12.Parent = Debris;
        VfxManager.Emit(v12);
        VfxManager.DestroyEffect(v12, 1);
    end);
    task.delay(0.383 - TimeSent, function() -- Line: 105
        -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
        if not HumanoidRootPart then
            return;
        end;

        local v13 = script.Dribble_Fail.Dribble_1:Clone();
        v13.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.3009999990463257, -2.8740737438201904, 0.7100000381469727) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
        v13.Parent = Debris;
        VfxManager.Emit(v13);
        VfxManager.DestroyEffect(v13, 1);
    end);
    task.delay(0.667 - TimeSent, function() -- Line: 115
        -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
        if not HumanoidRootPart then
            return;
        end;

        local v14 = script.Dribble_Fail.Dribble_2:Clone();
        v14.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.3009999990463257, -2.874000072479248, 0.7099999785423279) * CFrame.fromEulerAnglesYXZ(-0, -3.141592502593994, 0);
        v14.Parent = Debris;
        VfxManager.Emit(v14);
        VfxManager.DestroyEffect(v14, 1);
    end);
    task.delay(1.05 - TimeSent, function() -- Line: 124
        -- upvalues: HumanoidRootPart (copy), u11 (ref), Debris (ref), Essentials (ref), VfxManager (ref)
        if not HumanoidRootPart then
            return;
        end;

        u11 = script.InfDribble:Clone();
        u11.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.12966632843017578, -2.8177711963653564, -2.444450855255127) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
        u11.Parent = Debris;
        Essentials:Weld(u11, HumanoidRootPart);
        VfxManager.Enable(u11, true);
    end);
    task.delay(1.467 - TimeSent, function() -- Line: 133
        -- upvalues: HumanoidRootPart (copy), u11 (ref), VfxManager (ref), Debris (ref)
        if not HumanoidRootPart then
            return;
        end;

        if u11 then
            VfxManager.Enable(u11, false);
            VfxManager.DestroyEffect(u11, 3);
            local v15 = script.Dribble_Fail.Dribble_3:Clone();
            v15.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.7617536783218384, -3.167553424835205, -1.7313519716262817) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
            v15.Parent = Debris;
            VfxManager.Emit(v15);
            VfxManager.DestroyEffect(v15, 2);
        end;
    end);
end;
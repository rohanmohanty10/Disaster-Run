 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 15
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Debris (copy), Essentials (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);
    local Value = ReplicatedStorage.Basketball.Value;

    if p2.Task ~= "Dribble" then
        if p2.Task == "Stepback" then
            local v4 = p2.Speed or 1;
            local u5 = script.Ball:Clone();
            u5.Parent = Debris;
            u5.CFrame = BALL.CFrame;
            Essentials:Weld(u5, BALL);

            if p2.Fake then
                VfxManager.Enable(u5.EnableFirst, true);
                task.delay(0.23333333333333334 - v3, function() -- Line: 96
                    -- upvalues: VfxManager (ref), u5 (copy), Debris (ref), BALL (copy), HumanoidRootPart (copy)
                    VfxManager.Enable(u5.EnableFirst, false);
                    VfxManager.Enable(u5.Aura, true);
                    local v6 = script.Fake:Clone();
                    v6.Parent = Debris;
                    v6.CFrame = CFrame.new(BALL.Position) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()) * CFrame.Angles(-0.6981317007977318, 3.141592653589793, 3.141592653589793);
                    VfxManager.Emit(v6);
                    VfxManager.DestroyEffect(v6, 4);
                end);
                task.wait(1);
            else
                VfxManager.Enable(u5.Aura, true);
            end;

            local v7 = SfxManager:playSound({
                Sound = "BBZ LukaDoncic Angle Stepback",
                Parent = HumanoidRootPart
            });

            if v7 then
                v7.PlaybackSpeed = v4;
            end;

            task.delay(0.2833333333333333 / v4 - v3, function() -- Line: 118
                -- upvalues: Character (copy), Debris (ref), VfxManager (ref)
                local v8 = Character:FindFirstChild("Left Leg");

                if v8 then
                    local v9 = script.Jump1:Clone();
                    v9.Parent = Debris;
                    v9.CFrame = v8.CFrame * CFrame.new(0, -1, 0);
                    VfxManager.Emit(v9);
                    VfxManager.DestroyEffect(v9, 2);
                end;
            end);
            task.delay(0.6666666666666666 / v4 - v3, function() -- Line: 129
                -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
                local v10 = script.Jump2:Clone();
                v10.Parent = Debris;
                v10.CFrame = CFrame.new(HumanoidRootPart.Position.X, math.clamp(HumanoidRootPart.Position.Y - 3, 1, 1.5), HumanoidRootPart.Position.Z);
                VfxManager.Emit(v10);
                VfxManager.DestroyEffect(v10, 2);
            end);
            task.delay(1.05 / v4 - v3, function() -- Line: 137
                -- upvalues: VfxManager (ref), u5 (copy), Value (copy), Essentials (ref), BALL (copy), HumanoidRootPart (copy), Debris (ref)
                VfxManager.Enable(u5, false);
                u5:FindFirstChild("WeldConstraint"):Destroy();
                u5.CFrame = Value.CFrame;
                Essentials:Weld(u5, Value);
                VfxManager.Enable(u5, true);
                local v11 = script.Shoot:Clone();
                v11.CFrame = CFrame.new(BALL.Position) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()) * CFrame.Angles(-1.0471975511965976, 0, 0);
                v11.Parent = Debris;
                VfxManager.Emit(v11);
                VfxManager.DestroyEffect(v11, 4);
            end);
            task.delay(1.05 / v4 + 2 - v3, function() -- Line: 151
                -- upvalues: VfxManager (ref), u5 (copy)
                VfxManager.Enable(u5, false);
                VfxManager.DestroyEffect(u5, 2);
            end);
        end;

        return;
    end;

    local Torso = Character:FindFirstChild("Torso");

    if not Torso then
        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ LukaDoncic Luka Trick",
        Parent = HumanoidRootPart
    });
    local u12;

    if p2.Ball then
        u12 = script.Ball:Clone();
        u12.Parent = Debris;
        u12.CFrame = BALL.CFrame;
        Essentials:Weld(u12, BALL);
    else
        u12 = nil;
    end;

    local u13 = script.Torso:Clone();
    u13.Parent = Debris;
    u13.CFrame = Torso.CFrame;
    Essentials:Weld(u13, Torso);
    task.delay(0.45 - v3, function() -- Line: 44
        -- upvalues: VfxManager (ref), u13 (copy), Debris (ref), HumanoidRootPart (copy), Essentials (ref), Character (copy)
        VfxManager.Enable(u13, true);
        local v14 = script.Dash:Clone();
        v14.Parent = Debris;
        v14.CFrame = HumanoidRootPart.CFrame * CFrame.Angles(0, 3.9269908169872414, 0);
        VfxManager.Emit(v14);
        VfxManager.DestroyEffect(v14, 2);
        local v15 = tick();

        repeat
            task.wait(0.1);
            local v16 = Essentials:CreateClone(Character);
            VfxManager.DestroyEffect(v16, 1);
        until tick() - v15 > 0.2;
    end);
    task.delay(0.5166666666666667 - v3, function() -- Line: 60
        -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
        local v17 = script.Dash:Clone();
        v17.Parent = Debris;
        v17.CFrame = HumanoidRootPart.CFrame * CFrame.new(-8, 0, 0) * CFrame.Angles(0, 2.356194490192345, 0);
        VfxManager.Emit(v17);
        VfxManager.DestroyEffect(v17, 2);
    end);
    task.delay(0.5833333333333334 - v3, function() -- Line: 68
        -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
        local v18 = script.Dash:Clone();
        v18.Parent = Debris;
        v18.CFrame = HumanoidRootPart.CFrame * CFrame.new(16, 0, 0) * CFrame.Angles(0, 3.9269908169872414, 0);
        VfxManager.Emit(v18);
        VfxManager.DestroyEffect(v18, 2);
    end);
    task.delay(0.65 - v3, function() -- Line: 76
        -- upvalues: VfxManager (ref), u13 (copy), u12 (ref)
        VfxManager.Enable(u13, false);
        VfxManager.DestroyEffect(u13, 2);

        if u12 then
            VfxManager.Enable(u12, false);
            VfxManager.DestroyEffect(u12, 2);
        end;
    end);
end;
 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("RunService");
game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 16
    -- upvalues: SfxManager (copy), Debris (copy), Essentials (copy), VfxManager (copy)
    local TimeSent = p2.TimeSent;
    local u3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local Enemy = p2.Enemy;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    Character:FindFirstChild("Right Arm");
    Character:FindFirstChild("Left Arm");
    local BALL = Character:FindFirstChild("BALL", true);

    if p2.Task ~= "Deck Break" then
        if p2.Task == "Stun" then
            task.delay(1.45 - u3, function() -- Line: 72
                -- upvalues: Debris (ref), Enemy (copy), VfxManager (ref), SfxManager (ref)
                local v4 = script.Stun:Clone();
                v4.Parent = Debris;
                v4.CFrame = Enemy.HumanoidRootPart.CFrame;
                VfxManager.Emit(v4);
                VfxManager.DestroyEffect(v4, 4);
                SfxManager:playSound({
                    Sound = "BBZ Dealer Deck Break Enemy",
                    Parent = v4
                });
            end);

            return;
        end;

        if p2.Task ~= "Blink Deal" then
            if p2.Task == "Pass" then
                SfxManager:playSound({
                    Sound = "BBZ Dealer No Look Deal",
                    Parent = HumanoidRootPart
                });
                local v5 = script.PassPoof:Clone();
                v5.Parent = Debris;
                v5.CFrame = BALL.CFrame;
                VfxManager.Emit(v5);
                VfxManager.DestroyEffect(v5, 4);
            end;

            return;
        end;

        SfxManager:playSound({
            Sound = "BBZ Dealer Blink Deal",
            Parent = HumanoidRootPart
        });
        task.delay(0.25 - u3, function() -- Line: 84
            -- upvalues: Debris (ref), Character (copy), Essentials (ref), u3 (copy), VfxManager (ref), HumanoidRootPart (copy)
            local Model = Instance.new("Model");
            Model.Parent = Debris;

            for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
                local v6 = Character:FindFirstChild(child.Name);

                if v6 then
                    local v7 = child:Clone();
                    v7.CFrame = v6.CFrame;
                    v7.Parent = Model;
                    Essentials:Weld(v7, v6);
                end;
            end;

            task.delay(1.0833333333333333 - u3, function() -- Line: 98
                -- upvalues: VfxManager (ref), Model (copy)
                VfxManager.Enable(Model, false);
                VfxManager.DestroyEffect(Model, 2);
            end);
            local v8 = script.Dash:Clone();
            v8.Parent = Debris;
            v8.CFrame = HumanoidRootPart.CFrame * CFrame.Angles(0, -0.7853981633974483, 0) * CFrame.new(0, 0, -3);
            VfxManager.Emit(v8);
            VfxManager.DestroyEffect(v8, 4);
            local _ = { Character:FindFirstChild("BALL", true), Character:FindFirstChild("PlrBall") };
            local v9 = tick();

            repeat
                task.wait(0.1);
                local v10 = Essentials:CreateClone(Character);
                VfxManager.Enable(v10, false);
                VfxManager.DestroyEffect(v10, 1);
            until tick() - v9 > 1.0833333333333333;
        end);
        task.delay(0.6666666666666666, function() -- Line: 122
            -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
            local v11 = script.Dash:Clone();
            v11.Parent = Debris;
            v11.CFrame = HumanoidRootPart.CFrame * CFrame.Angles(0, 0.7853981633974483, 0) * CFrame.new(0, 0, -3);
            VfxManager.Emit(v11);
            VfxManager.DestroyEffect(v11, 4);
        end);
        task.delay(1.0833333333333333, function() -- Line: 130
            -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
            local v12 = script.Dash:Clone();
            v12.Parent = Debris;
            v12.CFrame = HumanoidRootPart.CFrame * CFrame.Angles(0, -0.7853981633974483, 0) * CFrame.new(0, 0, -3);
            VfxManager.Emit(v12);
            VfxManager.DestroyEffect(v12, 4);
        end);

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Dealer Deck Break",
        Parent = HumanoidRootPart
    });
    local u13 = script.Ball:Clone();
    u13.Parent = Debris;
    u13.CFrame = BALL.CFrame;
    Essentials:Weld(u13, BALL);
    local Model = Instance.new("Model");
    Model.Parent = Debris;

    for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
        local v14 = Character:FindFirstChild(child.Name);

        if v14 then
            local v15 = child:Clone();
            v15.CFrame = v14.CFrame;
            v15.Parent = Model;
            Essentials:Weld(v15, v14);
        end;
    end;

    task.delay(0.5333333333333333 - u3, function() -- Line: 49
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
        local v16 = script.Bounce:Clone();
        v16.Parent = Debris;
        v16.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.05, 1.5), BALL.Position.Z);
        VfxManager.Emit(v16);
        VfxManager.DestroyEffect(v16, 4);
    end);
    task.delay(1.7333333333333334 - u3, function() -- Line: 57
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
        local v17 = script.Bounce:Clone();
        v17.Parent = Debris;
        v17.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.05, 1.5), BALL.Position.Z);
        VfxManager.Emit(v17);
        VfxManager.DestroyEffect(v17, 4);
    end);
    task.delay(1.6166666666666667 - u3, function() -- Line: 65
        -- upvalues: VfxManager (ref), u13 (copy), Model (copy)
        VfxManager.Enable(u13, false);
        VfxManager.Enable(Model, false);
        VfxManager.DestroyEffect(u13, 2);
        VfxManager.DestroyEffect(Model, 2);
    end);
end;
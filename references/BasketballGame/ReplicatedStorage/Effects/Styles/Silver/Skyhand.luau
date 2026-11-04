 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local SilverScreenEffect = require(script.Parent.Parent.ScreenEffects.SilverScreenEffect);
local DarkScreenEffect = require(script.Parent.Parent.ScreenEffects.DarkScreenEffect);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 18
    -- upvalues: SfxManager (copy), Debris (copy), Essentials (copy), VfxManager (copy), LocalPlayer (copy), SilverScreenEffect (copy), DarkScreenEffect (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local _ = p1.BallController;
    local _ = p1.CameraController;
    local Character = p2.Character;
    local Other = p2.Other;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    Character:FindFirstChild("Right Arm");
    local BALL = Character:FindFirstChild("BALL", true);

    if p2.Task == "Push" then
        SfxManager:playSound({
            Sound = "BBZ Silver Silver Push",
            Parent = HumanoidRootPart
        });
        local Model = Instance.new("Model");
        Model.Parent = Debris;

        for _, child in pairs(script.Push.AuraBodyPartsToWeld:GetChildren()) do
            local v4 = Character:FindFirstChild(child.Name);

            if v4 then
                local v5 = child:Clone();
                v5.CFrame = v4.CFrame;
                v5.Parent = Model;
                Essentials:Weld(v5, v4);
            end;
        end;

        VfxManager.DestroyEffect(Model, 2);
        shared.vfx.emit(Model);
        task.delay(0.2 - v3, function() -- Line: 52
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v6 = script.Push.Bounce:Clone();
            v6.Parent = Debris;
            v6:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z));
            VfxManager.DestroyEffect(v6, 2);
            shared.vfx.emit(v6);
        end);

        return;
    end;

    if p2.Task == "Fade" then
        SfxManager:playSound({
            Sound = "BBZ Silver Push Fade",
            Parent = HumanoidRootPart
        });
        task.delay(0.2 - v3, function() -- Line: 63
            -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
            local v7 = script.Push.Spin:Clone();
            v7.Parent = Debris;
            v7:PivotTo(HumanoidRootPart.CFrame);
            VfxManager.DestroyEffect(v7, 2);
            shared.vfx.emit(v7);
        end);
        task.delay(0.5833333333333334 - v3, function() -- Line: 72
            -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
            local v8 = script.Push.Jump:Clone();
            v8.Parent = Debris;
            v8:PivotTo(HumanoidRootPart.CFrame);
            VfxManager.DestroyEffect(v8, 2);
            shared.vfx.emit(v8);
        end);
        task.delay(1.05 - v3, function() -- Line: 81
            -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
            local v9 = script.Push.Shoot:Clone();
            v9.Parent = Debris;
            v9:PivotTo(HumanoidRootPart.CFrame);
            VfxManager.DestroyEffect(v9, 2);
            shared.vfx.emit(v9);
        end);

        return;
    end;

    if p2.Task == "Dribble" then
        SfxManager:playSound({
            Sound = "BBZ Silver Dribble Push",
            Parent = HumanoidRootPart
        });
        local Model = Instance.new("Model");
        Model.Parent = Debris;

        for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
            local v10 = Character:FindFirstChild(child.Name);

            if v10 then
                local v11 = child:Clone();
                v11.CFrame = v10.CFrame;
                v11.Parent = Model;
                Essentials:Weld(v11, v10);
            end;
        end;

        task.delay(0.21666666666666667 - v3, function() -- Line: 105
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v12 = script.Push.Bounce:Clone();
            v12.Parent = Debris;
            v12:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z));
            VfxManager.DestroyEffect(v12, 2);
            shared.vfx.emit(v12);
        end);
        task.delay(0.5166666666666667 - v3, function() -- Line: 114
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v13 = script.Push.Bounce:Clone();
            v13.Parent = Debris;
            v13:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z));
            VfxManager.DestroyEffect(v13, 2);
            shared.vfx.emit(v13);
        end);
        task.delay(1.0333333333333334 - v3, function() -- Line: 123
            -- upvalues: LocalPlayer (ref), Character (copy), Other (copy), SilverScreenEffect (ref), Debris (ref), BALL (copy), VfxManager (ref)
            if LocalPlayer.Character == Character or LocalPlayer.Character == Other then
                SilverScreenEffect();
            end;

            local v14 = script.Push.Bounce:Clone();
            v14.Parent = Debris;
            v14:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z));
            VfxManager.DestroyEffect(v14, 2);
            shared.vfx.emit(v14);
        end);
        task.delay(1.3166666666666667 - v3, function() -- Line: 136
            -- upvalues: VfxManager (ref), Model (copy)
            VfxManager.Enable(Model, false);
            VfxManager.DestroyEffect(Model, 2);
        end);

        return;
    end;

    if p2.Task == "Jump" then
        SfxManager:playSound({
            Sound = "BBZ Silver Skyhand Jump",
            Parent = HumanoidRootPart
        });

        if LocalPlayer.Character == Character then
            DarkScreenEffect();
        end;

        local v15 = script.Skyhand.Jump:Clone();
        v15.Parent = Debris;
        v15:PivotTo(HumanoidRootPart.CFrame);
        VfxManager.DestroyEffect(v15, 2);
        shared.vfx.emit(v15);

        return;
    end;

    if p2.Task ~= "Block" then
        if p2.Task == "Juggernaut" then
            SfxManager:playSound({
                Sound = "BBZ Silver Juggernaut",
                Parent = HumanoidRootPart
            });
            local Model = Instance.new("Model");
            Model.Parent = Debris;

            for _, child in pairs(script.AuraBodyPartsToWeld:GetChildren()) do
                local v16 = Character:FindFirstChild(child.Name);

                if v16 then
                    local v17 = child:Clone();
                    v17.CFrame = v16.CFrame;
                    v17.Parent = Model;
                    Essentials:Weld(v17, v16);
                end;
            end;

            local v18 = script.Skyhand.Rush:Clone();
            v18.Parent = Debris;
            v18.Root.CFrame = HumanoidRootPart.CFrame;
            Essentials:Weld(v18.Root, HumanoidRootPart);
            VfxManager.DestroyEffect(v18, 2);
            shared.vfx.emit(v18);
            task.delay(1 - v3, function() -- Line: 190
                -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
                local v19 = script.Skyhand.Leap:Clone();
                v19.Parent = Debris;
                v19:PivotTo(HumanoidRootPart.CFrame);
                VfxManager.DestroyEffect(v19, 2);
                shared.vfx.emit(v19);
            end);
            task.delay(2 - v3, function() -- Line: 199
                -- upvalues: VfxManager (ref), Model (copy)
                VfxManager.Enable(Model, false);
                VfxManager.DestroyEffect(Model, 2);
            end);
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Silver Skyhand Block",
        Parent = HumanoidRootPart
    });

    if LocalPlayer.Character == Character or LocalPlayer.Character == Other then
        SilverScreenEffect();
    end;

    local v20 = script.Skyhand.Block:Clone();
    v20.Parent = Debris;
    v20:PivotTo(HumanoidRootPart.CFrame);
    VfxManager.DestroyEffect(v20, 2);
    shared.vfx.emit(v20);
end;
 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 16
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Debris (copy), VfxManager (copy), Essentials (copy), LocalPlayer (copy), Lighting (copy), TweenService (copy), CameraShaker (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local CameraController = p1.CameraController;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);
    local _ = ReplicatedStorage.Basketball.Value;

    if p2.Task == "Shot" then
        SfxManager:playSound({
            Sound = "BBZ Judgement Gavel Strike Shot",
            Parent = HumanoidRootPart
        });
        task.delay(0.4666666666666666 - v3, function() -- Line: 31
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref), Essentials (ref), Character (copy)
            local v4 = script.Bounce:Clone();
            v4.Parent = Debris;
            v4:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
            VfxManager.BetterEmit(v4);
            VfxManager.DestroyEffect(v4, 2);
            local v5 = Essentials:CreateClone(Character);
            VfxManager.DestroyEffect(v5, 1);
        end);
        task.delay(0.9666666666666667 - v3, function() -- Line: 42
            -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
            local v6 = script.Swing:Clone();
            v6.Parent = Debris;
            v6:PivotTo(HumanoidRootPart.CFrame * CFrame.new(-0.37, -0.905, 0.528) * CFrame.fromOrientation(-1.3313546067137947, 1.2849288486107453, -1.5128688489212048));
            VfxManager.BetterEmit(v6);
            VfxManager.DestroyEffect(v6, 2);
        end);
        task.delay(1.0444444444444445 - v3, function() -- Line: 50
            -- upvalues: BALL (copy), HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            local v7 = script.Shoot:Clone();
            v7:PivotTo(CFrame.new(BALL.Position) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()) * CFrame.Angles(-1.0471975511965976, 0, 0));
            v7.Parent = Debris;
            VfxManager.BetterEmit(v7);
            VfxManager.DestroyEffect(v7, 4);
        end);

        return;
    end;

    if p2.Task ~= "Dunk" then
        if p2.Task == "Slam" then
            SfxManager:playSound({
                Sound = "BBZ Judgement Gavel Slam",
                Parent = HumanoidRootPart
            });
            task.delay(0.8333333333333334 - v3, function() -- Line: 104
                -- upvalues: LocalPlayer (ref), HumanoidRootPart (copy), Lighting (ref), TweenService (ref), VfxManager (ref), CameraController (copy), CameraShaker (ref), Debris (ref)
                local v8 = LocalPlayer.Character and (LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (LocalPlayer.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude) or (1 / 0);

                if v8 <= 26 then
                    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
                    ColorCorrection.Enabled = false;
                    local u9 = ColorCorrection:Clone();
                    u9.Name = "CC";
                    u9.Parent = Lighting;
                    u9.Enabled = true;
                    task.delay(0.25, function() -- Line: 115
                        -- upvalues: u9 (copy), Lighting (ref), ColorCorrection (copy)
                        u9:Destroy();

                        if not Lighting:FindFirstChild("CC") then
                            ColorCorrection.Enabled = true;
                        end;
                    end);
                    local BlurEffect = Instance.new("BlurEffect", Lighting);
                    BlurEffect.Size = 12;
                    TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
                        Size = 0
                    }):Play();
                    VfxManager.DestroyEffect(BlurEffect, 0.25);
                    u9.Brightness = 0.45;
                    u9.TintColor = Color3.fromRGB(255, 170, 96);
                    TweenService:Create(u9, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
                        Brightness = ColorCorrection.Brightness,
                        TintColor = ColorCorrection.TintColor
                    }):Play();
                    CameraController.CamShake:Shake(CameraShaker.Presets.Meteor);
                elseif v8 <= 39 then
                    CameraController.CamShake:Shake(CameraShaker.Presets.Dunk);
                end;

                local v10 = script.Slam:Clone();
                v10.Parent = Debris;
                v10:PivotTo(CFrame.new(HumanoidRootPart.Position.X, 1.5, HumanoidRootPart.Position.Z) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()) * CFrame.new(0, 0, -5));
                VfxManager.BetterEmit(v10);
                VfxManager.DestroyEffect(v10, 4);
            end);
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Judgement Gavel Strike Dunk",
        Parent = HumanoidRootPart
    });
    task.delay(0.55 - v3, function() -- Line: 60
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref), Essentials (ref), Character (copy)
        local v11 = script.Bounce:Clone();
        v11.Parent = Debris;
        v11:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
        VfxManager.BetterEmit(v11);
        VfxManager.DestroyEffect(v11, 2);
        local v12 = Essentials:CreateClone(Character);
        VfxManager.DestroyEffect(v12, 1);
    end);
    task.delay(0.6333333333333333 - v3, function() -- Line: 71
        -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
        local v13 = script.Jump:Clone();
        v13.Parent = Debris;
        v13:PivotTo(CFrame.new(0, 1.785, 0) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()) * CFrame.fromOrientation(0.2617993877991494, 3.141592653589793, 0));
        VfxManager.BetterEmit(v13);
        VfxManager.DestroyEffect(v13, 4);
    end);
    task.delay(1.3166666666666667 - v3, function() -- Line: 79
        -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
        local Hoops = workspace:FindFirstChild("Hoops");
        local v14 = nil;

        if Hoops then
            local Hoop = Hoops.Home.Hoop;
            local Hoop2 = Hoops.Away.Hoop;

            if Hoop and Hoop2 then
                v14 = (HumanoidRootPart.Position - Hoop2.Position).Magnitude < (HumanoidRootPart.Position - Hoop.Position).Magnitude and Hoop2.Position or Hoop.Position;
            end;
        end;

        if v14 then
            local v15 = script.Dunk:Clone();
            v15:PivotTo(CFrame.new(v14));
            v15.Parent = Debris;
            VfxManager.BetterEmit(v15);
            VfxManager.DestroyEffect(v15, 4);
        end;
    end);
end;
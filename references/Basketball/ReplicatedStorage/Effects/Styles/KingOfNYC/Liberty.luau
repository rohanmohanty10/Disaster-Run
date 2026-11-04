 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Part_Icles = require(ReplicatedStorage.Shared.Utility.Part_Icles);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 18
    -- upvalues: SfxManager (copy), LocalPlayer (copy), Lighting (copy), TweenService (copy), VfxManager (copy), Debris (copy), Essentials (copy), Part_Icles (copy), Players (copy), Knit (copy), Effects (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local _ = p2.Other;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);

    if p2.Task ~= "Drive" then
        if p2.Task ~= "Shot" then
            if p2.Task == "Crown" then
                SfxManager:playSound({
                    Sound = "BBZ King Of NYC Liberty Crown",
                    Parent = HumanoidRootPart
                });
                task.wait(1.5 - v3);
                local u4 = script.CrownAura:Clone();
                u4.Parent = Debris;
                u4.CFrame = HumanoidRootPart.CFrame;
                Essentials:Weld(u4, HumanoidRootPart);
                task.delay(30, function() -- Line: 129
                    -- upvalues: VfxManager (ref), u4 (copy), TweenService (ref)
                    VfxManager.Enable(u4, false);
                    TweenService:Create(u4.PointLight, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                        Brightness = 0
                    }):Play();
                    VfxManager.DestroyEffect(u4, 4);
                end);
                local v5 = Players:FindFirstChild(Character.Name);

                if v5 and v5.Team == LocalPlayer.Team then
                    local Controller = Knit.GetController("AbilityController");
                    Controller.InLibertyCrown = true;
                    Effects:Popup("INCREASED SPEED.", 2, Color3.new(0, 0.6, 1));
                    task.delay(0.5, function() -- Line: 142
                        -- upvalues: Effects (ref)
                        Effects:Popup("INCREASED DRIBBLING SPEED.", 2, Color3.new(0, 0.6, 1));
                    end);
                    task.delay(1, function() -- Line: 145
                        -- upvalues: Effects (ref)
                        Effects:Popup("BOOSTS END IN 30 SECONDS.", 2, Color3.new(1, 0.2, 0.2));
                    end);
                    task.delay(25, function() -- Line: 149
                        -- upvalues: Effects (ref)
                        for i = 1, 5 do
                            Effects:Popup((`{tostring(5 - i)} SECONDS LEFT.`));
                            task.wait(1);
                            local _ = i;
                        end;

                        Effects:Popup("BOOST ENDED.");
                    end);
                    task.delay(30, function() -- Line: 157
                        -- upvalues: Controller (copy)
                        Controller.InLibertyCrown = nil;
                    end);
                    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
                    ColorCorrectionEffect.Name = "CCAddon";
                    ColorCorrectionEffect.Parent = Lighting;
                    ColorCorrectionEffect.Enabled = true;
                    task.delay(0.75, function() -- Line: 166
                        -- upvalues: ColorCorrectionEffect (copy)
                        ColorCorrectionEffect:Destroy();
                    end);
                    local BlurEffect = Instance.new("BlurEffect", Lighting);
                    BlurEffect.Size = 5;
                    TweenService:Create(BlurEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                        Size = 0
                    }):Play();
                    VfxManager.DestroyEffect(BlurEffect, 0.5);
                    ColorCorrectionEffect.Brightness = 0.45;
                    ColorCorrectionEffect.TintColor = Color3.fromRGB(55, 175, 255);
                    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.75, Enum.EasingStyle.Sine), {
                        TintColor = Color3.fromRGB(255, 255, 255)
                    }):Play();
                    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
                        Brightness = 0
                    }):Play();
                end;
            end;

            return;
        end;

        SfxManager:playSound({
            Sound = "BBZ King Of NYC Liberty Floater",
            Parent = HumanoidRootPart
        });
        local v6 = Essentials:CreateClone(Character);
        v6.PrimaryPart = v6.HumanoidRootPart;
        v6:PivotTo(p2.CFrame or HumanoidRootPart.CFrame);
        VfxManager.DestroyEffect(v6, 1);
        task.delay(0.4666666666666667 - v3, function() -- Line: 90
            -- upvalues: Debris (ref), BALL (copy), Part_Icles (ref), VfxManager (ref), LocalPlayer (ref), Character (copy), Lighting (ref), TweenService (ref)
            local v7 = script.Shot:Clone();
            v7.Parent = Debris;
            v7.CFrame = BALL.CFrame;
            Part_Icles:AbsoluteEmit(v7);
            VfxManager.DestroyEffect(v7, 2);

            if LocalPlayer.Character == Character then
                local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
                ColorCorrectionEffect.Name = "CCAddon";
                ColorCorrectionEffect.Parent = Lighting;
                ColorCorrectionEffect.Enabled = true;
                task.delay(1.5, function() -- Line: 103
                    -- upvalues: ColorCorrectionEffect (copy)
                    ColorCorrectionEffect:Destroy();
                end);
                local BlurEffect = Instance.new("BlurEffect", Lighting);
                BlurEffect.Size = 15;
                TweenService:Create(BlurEffect, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Size = 0
                }):Play();
                VfxManager.DestroyEffect(BlurEffect, 0.75);
                ColorCorrectionEffect.Brightness = 0.45;
                ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 145, 55);
                TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1.5, Enum.EasingStyle.Sine), {
                    TintColor = Color3.fromRGB(255, 255, 255)
                }):Play();
                TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.75, Enum.EasingStyle.Sine), {
                    Brightness = 0
                }):Play();
            end;
        end);

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ King Of NYC Liberty Drive",
        Parent = HumanoidRootPart
    });

    if LocalPlayer.Character == Character or p2.Stunned and table.find(p2.Stunned, LocalPlayer.Character) then
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect.Name = "CCAddon";
        ColorCorrectionEffect.Parent = Lighting;
        ColorCorrectionEffect.Enabled = true;
        task.delay(0.75, function() -- Line: 37
            -- upvalues: ColorCorrectionEffect (copy)
            ColorCorrectionEffect:Destroy();
        end);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 5;
        TweenService:Create(BlurEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.5);
        ColorCorrectionEffect.Brightness = 0.45;
        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 145, 55);
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.75, Enum.EasingStyle.Sine), {
            TintColor = Color3.fromRGB(255, 255, 255)
        }):Play();
        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
            Brightness = 0
        }):Play();
    end;

    local v8 = script.Trail:Clone();
    v8.Parent = Debris;
    v8.CFrame = HumanoidRootPart.CFrame;
    Essentials:Weld(v8, HumanoidRootPart);
    VfxManager.Enable(v8, true);
    VfxManager.DestroyEffect(v8, 2);
    local v9 = script.SpeedLines:Clone();
    v9.Parent = Debris;
    v9.CFrame = HumanoidRootPart.CFrame;
    Essentials:Weld(v9, HumanoidRootPart);
    Part_Icles:AbsoluteEmit(v9);
    VfxManager.DestroyEffect(v9, 2);
    task.delay(0.18333333333333332 - v3, function() -- Line: 67
        -- upvalues: Debris (ref), BALL (copy), Part_Icles (ref), VfxManager (ref)
        local v10 = script.Bounce:Clone();
        v10.Parent = Debris;
        v10.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z);
        Part_Icles:AbsoluteEmit(v10);
        VfxManager.DestroyEffect(v10, 2);
    end);
    local v11 = tick();

    repeat
        task.wait(0.05 * (1 + (tick() - v11) / 0.5));
        local v12 = Essentials:CreateClone(Character);
        VfxManager.DestroyEffect(v12, 1);
    until tick() - v11 > 0.5;

    VfxManager.Enable(v8, false);
end;
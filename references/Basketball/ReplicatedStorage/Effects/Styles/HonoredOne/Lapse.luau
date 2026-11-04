 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 16
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Lighting (copy), TweenService (copy), RunService (copy), LocalPlayer (copy), Debris (copy), VfxManager (copy), Essentials (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local v4 = Character:FindFirstChild("Right Arm");
    local BALL = Character:FindFirstChild("BALL", true);
    local Value = ReplicatedStorage.Basketball.Value;

    if p2.Task ~= "Dribble" then
        if p2.Task ~= "Shot" then
            if p2.Task == "Pull" then
                SfxManager:playSound({
                    Sound = "BBZ Honored One Lapse Pull",
                    Parent = HumanoidRootPart
                });
                local Other = p2.Other;

                if Other then
                    local u5 = script.Blue:Clone();
                    u5.Parent = Debris;
                    u5.CFrame = Other.HumanoidRootPart.CFrame;
                    Essentials:Weld(u5, Other.HumanoidRootPart);
                    VfxManager.Enable(u5, true);
                    task.delay(0.6666666666666666 - v3, function() -- Line: 185
                        -- upvalues: VfxManager (ref), u5 (copy)
                        VfxManager.Enable(u5, false);
                        VfxManager.DestroyEffect(u5, 8);
                    end);
                end;

                local v6 = script.Pull:Clone();
                v6.Parent = Debris;
                v6.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0.15, -6);
                VfxManager.BetterEmit(v6);
                VfxManager.DestroyEffect(v6, 4);
            end;

            return;
        end;

        SfxManager:playSound({
            Sound = "BBZ Honored One Lapse Shot",
            Parent = HumanoidRootPart
        });
        local u7 = script.Ball:Clone();
        u7.Parent = Debris;
        u7.CFrame = Value.CFrame;
        Essentials:Weld(u7, Value);
        local u8 = script["Right Arm"]:Clone();
        u8.Parent = Debris;
        u8.CFrame = v4.CFrame;
        Essentials:Weld(u8, v4);
        task.delay(0.13333333333333333 - v3, function() -- Line: 146
            -- upvalues: Debris (ref), HumanoidRootPart (copy), VfxManager (ref)
            local v9 = script.Jump:Clone();
            v9.Parent = Debris;
            v9.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.5, 0);
            VfxManager.Emit(v9);
            VfxManager.DestroyEffect(v9, 4);
        end);
        task.delay(0.7833333333333333 - v3, function() -- Line: 154
            -- upvalues: BALL (copy), HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
            local v10 = script.Shoot:Clone();
            v10.CFrame = CFrame.new(BALL.Position) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()) * CFrame.Angles(-0.5235987755982988, 0, 0);
            v10.Parent = Debris;
            VfxManager.Emit(v10);
            VfxManager.DestroyEffect(v10, 4);
        end);
        task.delay(1.0333333333333334 - v3, function() -- Line: 162
            -- upvalues: VfxManager (ref), u8 (copy), u7 (copy)
            VfxManager.Emit(u8);
            VfxManager.Emit(u7);
            VfxManager.Enable(u8, true);
            VfxManager.Enable(u7, true);
            task.delay(1, function() -- Line: 167
                -- upvalues: VfxManager (ref), u8 (ref), u7 (ref)
                VfxManager.Enable(u8, false);
                VfxManager.Enable(u7, false);
                VfxManager.DestroyEffect(u8, 4);
                VfxManager.DestroyEffect(u7, 4);
            end);
        end);

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Honored One Lapse Dribble",
        Parent = HumanoidRootPart
    });
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u11 = ColorCorrection:Clone();
    u11.Name = "CC";
    u11.Parent = Lighting;
    u11.Enabled = true;
    TweenService:Create(u11, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
        Brightness = -0.15,
        Saturation = -1
    }):Play();
    local u12 = RunService.Heartbeat:Connect(function() -- Line: 40
        -- upvalues: LocalPlayer (ref), HumanoidRootPart (copy), u11 (copy), ColorCorrection (copy)
        if LocalPlayer.Character and (LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (LocalPlayer.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude <= 25.5) then
            u11.Enabled = true;
            ColorCorrection.Enabled = false;

            return;
        end;

        u11.Enabled = false;
        ColorCorrection.Enabled = true;
    end);
    task.delay(2.405 - v3, function() -- Line: 50
        -- upvalues: u12 (copy), u11 (copy), Lighting (ref), ColorCorrection (copy)
        u12:Disconnect();
        u11:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    task.delay(0.4 - v3, function() -- Line: 58
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref), u11 (copy), Lighting (ref), TweenService (ref), ColorCorrection (copy)
        local v13 = script.Bounce:Clone();
        v13.Parent = Debris;
        v13.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z);
        VfxManager.BetterEmit(v13);
        VfxManager.DestroyEffect(v13, 4);

        if u11.Enabled then
            local BlurEffect = Instance.new("BlurEffect", Lighting);
            BlurEffect.Size = 15;
            TweenService:Create(BlurEffect, TweenInfo.new(0.455, Enum.EasingStyle.Linear), {
                Size = 0
            }):Play();
            VfxManager.DestroyEffect(BlurEffect, 0.455);
        end;

        u11.Brightness = 0.45;
        u11.TintColor = Color3.fromRGB(39, 76, 215);
        TweenService:Create(u11, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = -0.15,
            Saturation = -1,
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
    task.delay(0.8666666666666667 - v3, function() -- Line: 77
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref), u11 (copy), Lighting (ref), TweenService (ref), ColorCorrection (copy)
        local v14 = script.Bounce:Clone();
        v14.Parent = Debris;
        v14.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z);
        VfxManager.BetterEmit(v14);
        VfxManager.DestroyEffect(v14, 4);

        if u11.Enabled then
            local BlurEffect = Instance.new("BlurEffect", Lighting);
            BlurEffect.Size = 15;
            TweenService:Create(BlurEffect, TweenInfo.new(0.455, Enum.EasingStyle.Linear), {
                Size = 0
            }):Play();
            VfxManager.DestroyEffect(BlurEffect, 0.455);
        end;

        u11.Brightness = 0.45;
        u11.TintColor = Color3.fromRGB(39, 76, 215);
        TweenService:Create(u11, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = -0.15,
            Saturation = -1,
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
    task.delay(1.4166666666666667 - v3, function() -- Line: 96
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref), u11 (copy), Lighting (ref), TweenService (ref), ColorCorrection (copy)
        local v15 = script.Bounce:Clone();
        v15.Parent = Debris;
        v15.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z);
        VfxManager.BetterEmit(v15);
        VfxManager.DestroyEffect(v15, 4);

        if u11.Enabled then
            local BlurEffect = Instance.new("BlurEffect", Lighting);
            BlurEffect.Size = 15;
            TweenService:Create(BlurEffect, TweenInfo.new(0.455, Enum.EasingStyle.Linear), {
                Size = 0
            }):Play();
            VfxManager.DestroyEffect(BlurEffect, 0.455);
        end;

        u11.Brightness = 0.45;
        u11.TintColor = Color3.fromRGB(39, 76, 215);
        TweenService:Create(u11, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = -0.15,
            Saturation = -1,
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
    task.delay(1.95 - v3, function() -- Line: 115
        -- upvalues: Debris (ref), BALL (copy), VfxManager (ref), u11 (copy), Lighting (ref), TweenService (ref), ColorCorrection (copy)
        local v16 = script.Bounce:Clone();
        v16.Parent = Debris;
        v16.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z);
        VfxManager.BetterEmit(v16);
        VfxManager.DestroyEffect(v16, 4);

        if u11.Enabled then
            local BlurEffect = Instance.new("BlurEffect", Lighting);
            BlurEffect.Size = 15;
            TweenService:Create(BlurEffect, TweenInfo.new(0.455, Enum.EasingStyle.Linear), {
                Size = 0
            }):Play();
            VfxManager.DestroyEffect(BlurEffect, 0.455);
        end;

        u11.Brightness = 0.45;
        u11.TintColor = Color3.fromRGB(39, 76, 215);
        TweenService:Create(u11, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation,
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
end;
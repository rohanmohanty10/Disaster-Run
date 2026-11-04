 
 

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
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Debris (copy), VfxManager (copy), Essentials (copy), Lighting (copy), TweenService (copy), RunService (copy), LocalPlayer (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);
    local _ = ReplicatedStorage.Basketball.Value;

    if p2.Task == "Layup" then
        SfxManager:playSound({
            Sound = "BBZ Curse King Slash Layup",
            Parent = HumanoidRootPart
        });
        task.delay(0.2222222222222222 - v3, function() -- Line: 29
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref), HumanoidRootPart (copy)
            local v4 = script.Bounce:Clone();
            v4.Parent = Debris;
            v4:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
            VfxManager.BetterEmit(v4);
            VfxManager.DestroyEffect(v4, 4);
            local v5 = script.Dash:Clone();
            v5.Parent = Debris;
            v5:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, 0.5, 0));
            VfxManager.BetterEmit(v5);
            VfxManager.DestroyEffect(v5, 4);
        end);
        task.delay(0.8222222222222223 - v3, function() -- Line: 43
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref), HumanoidRootPart (copy)
            local v6 = script.Bounce:Clone();
            v6.Parent = Debris;
            v6:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
            VfxManager.BetterEmit(v6);
            VfxManager.DestroyEffect(v6, 4);
            local v7 = script.Dash:Clone();
            v7.Parent = Debris;
            v7:PivotTo(HumanoidRootPart.CFrame * CFrame.new(0, 0.5, 0) * CFrame.Angles(0.7853981633974483, 0, 0));
            VfxManager.BetterEmit(v7);
            VfxManager.DestroyEffect(v7, 4);
        end);
        task.delay(1.2277777777777779 - v3, function() -- Line: 57
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref)
            local v8 = script.Slashes:Clone();
            v8.Parent = Debris;
            v8:PivotTo(BALL.CFrame);
            task.wait(0.25);
            VfxManager.BetterEmit(v8);
            VfxManager.DestroyEffect(v8, 4);
        end);
        local v9 = tick();

        repeat
            task.wait(0.1);
            local v10 = Essentials:CreateClone(Character);
            VfxManager.DestroyEffect(v10, 1);
        until tick() - v9 > 1.4777777777777779 - v3;
    elseif p2.Task == "Dribble" then
        SfxManager:playSound({
            Sound = "BBZ Curse King World Red Slash",
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
            Saturation = -1,
            TintColor = Color3.fromRGB(155, 42, 42)
        }):Play();
        local u12 = RunService.Heartbeat:Connect(function() -- Line: 86
            -- upvalues: LocalPlayer (ref), HumanoidRootPart (copy), u11 (copy), ColorCorrection (copy)
            if LocalPlayer.Character and (LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (LocalPlayer.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude <= 55) then
                u11.Enabled = true;
                ColorCorrection.Enabled = false;

                return;
            end;

            u11.Enabled = false;
            ColorCorrection.Enabled = true;
        end);
        task.delay(2.405 - v3, function() -- Line: 96
            -- upvalues: u12 (copy), u11 (copy), Lighting (ref), ColorCorrection (copy)
            u12:Disconnect();
            u11:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end);
        task.delay(0.16666666666666666 - v3, function() -- Line: 104
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref), u11 (copy), Lighting (ref), TweenService (ref)
            local v13 = script.Bounce:Clone();
            v13.Parent = Debris;
            v13:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
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
            TweenService:Create(u11, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
                Brightness = -0.15,
                Saturation = -1
            }):Play();
        end);
        task.delay(0.48333333333333334 - v3, function() -- Line: 122
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref), u11 (copy), Lighting (ref), TweenService (ref)
            local v14 = script.Bounce:Clone();
            v14.Parent = Debris;
            v14:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
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
            TweenService:Create(u11, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
                Brightness = -0.15,
                Saturation = -1
            }):Play();
        end);
        task.delay(0.8666666666666667 - v3, function() -- Line: 140
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref), u11 (copy), Lighting (ref), TweenService (ref)
            local v15 = script.Bounce:Clone();
            v15.Parent = Debris;
            v15:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
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
            TweenService:Create(u11, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
                Brightness = -0.15,
                Saturation = -1
            }):Play();
        end);
        task.delay(1.2833333333333334 - v3, function() -- Line: 158
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref), u11 (copy), Lighting (ref), TweenService (ref)
            local v16 = script.Bounce:Clone();
            v16.Parent = Debris;
            v16:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
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
            TweenService:Create(u11, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
                Brightness = -0.15,
                Saturation = -1
            }):Play();
        end);
        task.delay(1.75 - v3, function() -- Line: 176
            -- upvalues: Debris (ref), BALL (copy), VfxManager (ref), u11 (copy), Lighting (ref), TweenService (ref), ColorCorrection (copy)
            local v17 = script.Bounce:Clone();
            v17.Parent = Debris;
            v17:PivotTo(CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y - BALL.Size.Y / 2, 1.5, 2), BALL.Position.Z));
            VfxManager.BetterEmit(v17);
            VfxManager.DestroyEffect(v17, 4);

            if u11.Enabled then
                local BlurEffect = Instance.new("BlurEffect", Lighting);
                BlurEffect.Size = 15;
                TweenService:Create(BlurEffect, TweenInfo.new(0.455, Enum.EasingStyle.Linear), {
                    Size = 0
                }):Play();
                VfxManager.DestroyEffect(BlurEffect, 0.455);
            end;

            u11.Brightness = 0.45;
            TweenService:Create(u11, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
                Brightness = ColorCorrection.Brightness,
                Saturation = ColorCorrection.Saturation,
                TintColor = ColorCorrection.TintColor
            }):Play();
        end);
        local v18 = tick();

        repeat
            task.wait(0.1);
            local v19 = Essentials:CreateClone(Character);
            VfxManager.DestroyEffect(v19, 1);
        until tick() - v18 > 1.75 - v3;
    else
        if p2.Task == "Pull" then
            SfxManager:playSound({
                Sound = "BBZ Curse King Rebound Pull",
                Parent = HumanoidRootPart
            });
            local v20 = script.Pull:Clone();
            v20.Parent = Debris;
            v20.CFrame = HumanoidRootPart.CFrame;
            Essentials:Weld(v20, HumanoidRootPart);
            VfxManager.Enable(v20, true);
            task.wait(0.75);
            VfxManager.Enable(v20, false);
            VfxManager.DestroyEffect(v20, 2);

            return;
        end;

        if p2.Task == "Grab" then
            SfxManager:playSound({
                Sound = "BBZ Curse King Rebound Grab",
                Parent = HumanoidRootPart
            });
            local v21 = script.Grab:Clone();
            v21.Parent = Debris;
            v21.CFrame = CFrame.new(BALL.Position) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation());
            VfxManager.BetterEmit(v21);
            VfxManager.DestroyEffect(v21, 4);
        end;
    end;
end;
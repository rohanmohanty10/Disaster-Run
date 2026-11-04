 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Part_Icles = require(ReplicatedStorage.Shared.Utility.Part_Icles);
require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 18
    -- upvalues: SfxManager (copy), LocalPlayer (copy), Lighting (copy), TweenService (copy), VfxManager (copy), Debris (copy), Essentials (copy), Part_Icles (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local Other = p2.Other;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);

    if p2.Task == "Clash" then
        SfxManager:playSound({
            Sound = "BBZ King Of NYC Clash",
            Parent = HumanoidRootPart
        });

        if LocalPlayer.Character == Character or LocalPlayer.Character == Other then
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

        local u4 = script.Clash:Clone();
        u4.Name = Character.Name .. script.Name;
        u4.Parent = Debris;
        u4.CFrame = HumanoidRootPart.CFrame;
        u4:SetAttribute("Active", true);
        Essentials:Weld(u4, HumanoidRootPart);
        VfxManager.DestroyEffect(u4, 4);
        task.delay(0.15 - v3, function() -- Line: 61
            -- upvalues: u4 (copy), Part_Icles (ref)
            if not (u4 and u4:GetAttribute("Active")) then
                return;
            end;

            Part_Icles:AbsoluteEmit(u4["1"]);
        end);
        task.delay(0.6333333333333333 - v3, function() -- Line: 67
            -- upvalues: u4 (copy), Part_Icles (ref)
            if not (u4 and u4:GetAttribute("Active")) then
                return;
            end;

            Part_Icles:AbsoluteEmit(u4["2"]);
        end);
        task.delay(1.2333333333333334 - v3, function() -- Line: 73
            -- upvalues: u4 (copy), Part_Icles (ref)
            if not (u4 and u4:GetAttribute("Active")) then
                return;
            end;

            Part_Icles:AbsoluteEmit(u4["3"]);
        end);
        task.delay(1.6833333333333333 - v3, function() -- Line: 79
            -- upvalues: u4 (copy), Part_Icles (ref)
            if not (u4 and u4:GetAttribute("Active")) then
                return;
            end;

            Part_Icles:AbsoluteEmit(u4["4"]);
        end);

        return;
    end;

    if p2.Task ~= "Success" then
        if p2.Task == "Fail" then
            local v5 = Debris:FindFirstChild(Character.Name .. script.Name);

            if v5 then
                v5:SetAttribute("Active", nil);

                return;
            end;
        elseif p2.Task == "Counter Step" then
            SfxManager:playSound({
                Sound = "BBZ King Of NYC Counter Step",
                Parent = HumanoidRootPart
            });

            if LocalPlayer.Character == Character or LocalPlayer.Character == Other then
                local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
                ColorCorrectionEffect.Name = "CCAddon";
                ColorCorrectionEffect.Parent = Lighting;
                ColorCorrectionEffect.Enabled = true;
                task.delay(LocalPlayer.Character == Character and (2.1666666666666665 - v3 or 0.75) or 0.75, function() -- Line: 140
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
                ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 170, 100);
                TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.75, Enum.EasingStyle.Sine), {
                    TintColor = Color3.fromRGB(255, 255, 255)
                }):Play();
                TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
                    Brightness = 0
                }):Play();

                if LocalPlayer.Character == Character then
                    task.delay(0.6666666666666666 - v3, function() -- Line: 156
                        -- upvalues: Lighting (ref), TweenService (ref), VfxManager (ref), ColorCorrectionEffect (copy)
                        local BlurEffect2 = Instance.new("BlurEffect", Lighting);
                        BlurEffect2.Size = 15;
                        TweenService:Create(BlurEffect2, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                            Size = 0
                        }):Play();
                        VfxManager.DestroyEffect(BlurEffect2, 0.75);
                        ColorCorrectionEffect.Brightness = 0.45;
                        ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 145, 55);
                        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(1.5, Enum.EasingStyle.Sine), {
                            TintColor = Color3.fromRGB(255, 255, 255)
                        }):Play();
                        TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.75, Enum.EasingStyle.Sine), {
                            Brightness = 0
                        }):Play();
                    end);
                end;
            end;

            local v6 = script.CounterStepStart:Clone();
            v6.Parent = Debris;
            v6.CFrame = HumanoidRootPart.CFrame * CFrame.fromEulerAnglesXYZ(0, 1.5707963267948966, p2.Side == "R" and 3.141592653589793 or 0);
            Essentials:Weld(v6, HumanoidRootPart);
            Part_Icles:AbsoluteEmit(v6);
            VfxManager.DestroyEffect(v6, 2);
            task.delay(0.6666666666666666 - v3, function() -- Line: 178
                -- upvalues: Debris (ref), HumanoidRootPart (copy), Essentials (ref), VfxManager (ref), Part_Icles (ref), Character (copy)
                local v7 = script.Trail:Clone();
                v7.Parent = Debris;
                v7.CFrame = HumanoidRootPart.CFrame;
                Essentials:Weld(v7, HumanoidRootPart);
                VfxManager.Enable(v7, true);
                VfxManager.DestroyEffect(v7, 2);
                local v8 = script.CounterStepEnd:Clone();
                v8.Parent = Debris;
                v8.CFrame = HumanoidRootPart.CFrame;
                Essentials:Weld(v8, HumanoidRootPart);
                Part_Icles:AbsoluteEmit(v8);
                VfxManager.DestroyEffect(v8, 2);
                local v9 = tick();

                repeat
                    task.wait(0.05 * (1 + (tick() - v9) / 0.5));
                    local v10 = Essentials:CreateClone(Character);
                    VfxManager.DestroyEffect(v10, 1);
                until tick() - v9 > 0.5;

                VfxManager.Enable(v7, false);
            end);
            task.delay(0.9666666666666667 - v3, function() -- Line: 202
                -- upvalues: Debris (ref), BALL (copy), Part_Icles (ref), VfxManager (ref)
                local v11 = script.Bounce:Clone();
                v11.Parent = Debris;
                v11.CFrame = CFrame.new(BALL.Position.X, math.clamp(BALL.Position.Y, 1, 1.5), BALL.Position.Z);
                Part_Icles:AbsoluteEmit(v11);
                VfxManager.DestroyEffect(v11, 2);
            end);
        end;

        return;
    end;

    if LocalPlayer.Character == Character then
        local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
        ColorCorrectionEffect.Name = "CCAddon";
        ColorCorrectionEffect.Parent = Lighting;
        ColorCorrectionEffect.Enabled = true;
        task.delay(1.5, function() -- Line: 91
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

    local v12 = Debris:FindFirstChild(Character.Name .. script.Name);

    if v12 then
        v12:SetAttribute("Active", nil);
    end;

    local v13 = script.Trail:Clone();
    v13.Parent = Debris;
    v13.CFrame = HumanoidRootPart.CFrame;
    Essentials:Weld(v13, HumanoidRootPart);
    VfxManager.Enable(v13, true);
    VfxManager.DestroyEffect(v13, 2);
    local v14 = tick();

    repeat
        task.wait(0.05 * (1 + (tick() - v14) / 0.3333333333333333));
        local v15 = Essentials:CreateClone(Character);
        VfxManager.DestroyEffect(v15, 1);
    until tick() - v14 > 0.3333333333333333;

    VfxManager.Enable(v13, false);
end;
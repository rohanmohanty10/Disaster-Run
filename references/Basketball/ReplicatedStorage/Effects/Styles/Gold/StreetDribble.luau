 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local Lighting = game:GetService("Lighting");
game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local LocalPlayer = game.Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 15
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), Essentials (copy), VfxManager (copy), Debris (copy), LocalPlayer (copy), Lighting (copy), TweenService (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Char = p2.Char;
    local Other = p2.Other;
    local HumanoidRootPart = Char:FindFirstChild("HumanoidRootPart");
    Char:FindFirstChild("Torso");
    local _ = ReplicatedStorage.Basketball.Value;
    local BALL = Char:FindFirstChild("BALL", true);
    local Head = Char:FindFirstChild("Head");

    if p2.Task ~= "Dribble" then
        if p2.Task == "ReturnPass" then
            if LocalPlayer.Character == Char or LocalPlayer.Character == Other then
                local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
                ColorCorrectionEffect.Name = "CC";
                ColorCorrectionEffect.Parent = Lighting;
                ColorCorrectionEffect.Enabled = true;
                task.delay(0.75, function() -- Line: 95
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
                ColorCorrectionEffect.TintColor = Color3.fromRGB(255, 231, 110);
                TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.75, Enum.EasingStyle.Sine), {
                    TintColor = Color3.fromRGB(255, 255, 255)
                }):Play();
                TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5, Enum.EasingStyle.Sine), {
                    Brightness = 0
                }):Play();

                return;
            end;
        elseif p2.Task == "Pass" then
            SfxManager:playSound({
                Sound = "BBZ Gold HandsFree Pass",
                Parent = HumanoidRootPart
            });

            if p2.Direction == "R" then
                local Highlight = Instance.new("Highlight");
                Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
                Highlight.FillColor = Color3.fromRGB(255, 255, 255);
                Highlight.FillTransparency = 0.4;
                Highlight.OutlineColor = Color3.new(255, 255, 255);
                Highlight.OutlineTransparency = 0;
                Highlight.Parent = Char;
                TweenService:Create(Highlight, TweenInfo.new(0.333 - v3, Enum.EasingStyle.Linear), {
                    FillTransparency = 1,
                    OutlineTransparency = 1
                }):Play();
                VfxManager.DestroyEffect(Highlight, 0.333);
                local Highlight2 = Instance.new("Highlight");
                Highlight2.DepthMode = Enum.HighlightDepthMode.Occluded;
                Highlight2.FillColor = Color3.fromRGB(0, 0, 0);
                Highlight2.FillTransparency = 0;
                Highlight2.OutlineColor = Color3.new(255, 255, 255);
                Highlight2.OutlineTransparency = 0;
                Highlight2.Parent = BALL;
                TweenService:Create(Highlight2, TweenInfo.new(0.233 - v3, Enum.EasingStyle.Linear), {
                    FillTransparency = 0
                }):Play();
                task.delay(0.233 - v3, function() -- Line: 135
                    -- upvalues: TweenService (ref), Highlight2 (copy), VfxManager (ref)
                    TweenService:Create(Highlight2, TweenInfo.new(0.384, Enum.EasingStyle.Linear), {
                        FillTransparency = 1,
                        OutlineTransparency = 1
                    }):Play();
                    VfxManager.DestroyEffect(Highlight2, 0.384);
                end);
                local v4 = script.RightPass:Clone();
                v4.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.027821063995361328, -2.3946046829223633, -0.8816843032836914) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
                v4.Parent = Debris;
                VfxManager.Emit(v4);
                VfxManager.DestroyEffect(v4, 3);

                return;
            end;

            if p2.Direction == "L" then
                local Highlight = Instance.new("Highlight");
                Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
                Highlight.FillColor = Color3.fromRGB(255, 255, 255);
                Highlight.FillTransparency = 0.4;
                Highlight.OutlineColor = Color3.new(255, 255, 255);
                Highlight.OutlineTransparency = 0;
                Highlight.Parent = Char;
                TweenService:Create(Highlight, TweenInfo.new(0.333 - v3, Enum.EasingStyle.Linear), {
                    FillTransparency = 1,
                    OutlineTransparency = 1
                }):Play();
                VfxManager.DestroyEffect(Highlight, 0.333);
                local Highlight2 = Instance.new("Highlight");
                Highlight2.DepthMode = Enum.HighlightDepthMode.Occluded;
                Highlight2.FillColor = Color3.fromRGB(0, 0, 0);
                Highlight2.FillTransparency = 0;
                Highlight2.OutlineColor = Color3.new(255, 255, 255);
                Highlight2.OutlineTransparency = 0;
                Highlight2.Parent = BALL;
                TweenService:Create(Highlight2, TweenInfo.new(0.233 - v3, Enum.EasingStyle.Linear), {
                    FillTransparency = 0
                }):Play();
                task.delay(0.233 - v3, function() -- Line: 167
                    -- upvalues: TweenService (ref), Highlight2 (copy), VfxManager (ref)
                    TweenService:Create(Highlight2, TweenInfo.new(0.384, Enum.EasingStyle.Linear), {
                        FillTransparency = 1,
                        OutlineTransparency = 1
                    }):Play();
                    VfxManager.DestroyEffect(Highlight2, 0.384);
                end);
                local v5 = script.LeftPass:Clone();
                v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.027821063995361328, -2.3946046829223633, -0.8816843032836914) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
                v5.Parent = Debris;
                VfxManager.Emit(v5);
                VfxManager.DestroyEffect(v5, 3);
            end;
        end;

        return;
    end;

    SfxManager:playSound({
        Sound = "BBZ Gold Golden Dribble",
        Parent = HumanoidRootPart
    });
    local u6 = script.Head:Clone();
    u6.CFrame = Head.CFrame;
    u6.Parent = Char;
    Essentials:Weld(u6, Head);
    VfxManager.Enable(u6, true);
    task.delay(1.15 - v3, function() -- Line: 36
        -- upvalues: u6 (copy), VfxManager (ref)
        if u6 then
            VfxManager.Enable(u6, false);
            VfxManager.DestroyEffect(u6);
        end;
    end);
    local v7 = script["Start Emit"]:Clone();
    v7.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.2869834899902344, 1.4639673233032227, -0.8462152481079102) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
    v7.Parent = Debris;
    VfxManager.Emit(v7);
    VfxManager.DestroyEffect(v7, 3);
    task.delay(0.217 - v3, function() -- Line: 49
        -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
        if HumanoidRootPart then
            local v8 = script.Dribble1:Clone();
            v8.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.30878448486328125, -2.813412666320801, -3.6210103034973145) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
            v8.Parent = Debris;
            VfxManager.Emit(v8);
            VfxManager.DestroyEffect(v8, 3);
        end;
    end);
    task.delay(0.517 - v3, function() -- Line: 59
        -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
        if HumanoidRootPart then
            local v9 = script.Dribble2:Clone();
            v9.CFrame = HumanoidRootPart.CFrame * CFrame.new(1.104217529296875, -2.813412666320801, -4.543510437011719) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
            v9.Parent = Debris;
            VfxManager.Emit(v9);
            VfxManager.DestroyEffect(v9, 3);
        end;
    end);
    task.delay(0.9 - v3, function() -- Line: 69
        -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
        if HumanoidRootPart then
            local v10 = script.Dribble3:Clone();
            v10.CFrame = HumanoidRootPart.CFrame * CFrame.new(1.104217529296875, -2.813412666320801, -2.964259624481201) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
            v10.Parent = Debris;
            VfxManager.Emit(v10);
            VfxManager.DestroyEffect(v10, 3);
        end;
    end);
    task.delay(0.933 - v3, function() -- Line: 79
        -- upvalues: HumanoidRootPart (copy), Debris (ref), VfxManager (ref)
        if HumanoidRootPart then
            local v11 = script["Ability Spin"]:Clone();
            v11.CFrame = HumanoidRootPart.CFrame * CFrame.new(-1.1599617004394531, -0.10608863830566406, 0.1010274887084961) * CFrame.fromEulerAnglesYXZ(-0, 3.1415927410125732, 0);
            v11.Parent = Debris;
            VfxManager.Emit(v11);
            VfxManager.DestroyEffect(v11, 3);
        end;
    end);
end;
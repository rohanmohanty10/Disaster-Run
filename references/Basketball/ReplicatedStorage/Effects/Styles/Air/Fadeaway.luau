 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.Network);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Effects = require(ReplicatedStorage.Shared.Utility.Effects);
local LocalPlayer = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 17
    -- upvalues: ReplicatedStorage (copy), SfxManager (copy), TweenService (copy), Effects (copy), Debris (copy), Essentials (copy), Lighting (copy), VfxManager (copy), LocalPlayer (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local BALL = Character:FindFirstChild("BALL", true);
    local Value = ReplicatedStorage.Basketball.Value;
    local v4 = SfxManager:playSound({
        Sound = "BBZ Air Fadeaway",
        Parent = HumanoidRootPart
    });
    v4.TimePosition = 0.8333333333333334;
    local Volume = v4.Volume;
    v4.Volume = 0;
    TweenService:Create(v4, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        Volume = Volume
    }):Play();

    if p2.Number == 1 then
        Effects:SubtitleV2({ { "Commentator", "Air sells the pass. Spins out. High fadeaway! You can\'t block that!", 5.5 } });
    elseif p2.Number == 2 then
        Effects:SubtitleV2({ { "Commentator", "Spin. Fade. Air. Money!", 5 } });
    end;

    SfxManager:playSound({
        Sound = `BBZ Air Fadeaway Voice{p2.Number}`,
        Parent = workspace
    });
    local u5 = script.Ball:Clone();
    u5.Parent = Debris;
    u5.CFrame = BALL.CFrame;
    Essentials:Weld(u5, BALL);
    local u6 = nil;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u7 = ColorCorrection:Clone();
    u7.Name = "CC";
    u7.Parent = Lighting;
    u7.Enabled = true;
    task.delay(2.6166666666666667 - v3, function() -- Line: 69
        -- upvalues: u7 (copy), Lighting (ref), ColorCorrection (copy)
        u7:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local u8 = nil;
    task.delay(0.4666666666666667 - v3, function() -- Line: 78
        -- upvalues: VfxManager (ref), u5 (copy), Debris (ref), BALL (copy), HumanoidRootPart (copy), LocalPlayer (ref), u8 (ref), Lighting (ref), TweenService (ref), u7 (copy), ColorCorrection (copy)
        VfxManager.Enable(u5, true);
        local v9 = script.Fake:Clone();
        v9.Parent = Debris;
        v9.CFrame = CFrame.new(BALL.Position) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()) * CFrame.Angles(1.5707963267948966, 0, 0);
        VfxManager.Emit(v9);
        VfxManager.DestroyEffect(v9, 6);

        if LocalPlayer.Character and (LocalPlayer.Character:FindFirstChild("HumanoidRootPart") and (LocalPlayer.Character.HumanoidRootPart.Position - HumanoidRootPart.Position).Magnitude < 80) then
            u8 = true;
            local BlurEffect = Instance.new("BlurEffect", Lighting);
            BlurEffect.Size = 15;
            TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
                Size = 0
            }):Play();
            VfxManager.DestroyEffect(BlurEffect, 0.25);
            u7.Brightness = 0.65;
            u7.TintColor = Color3.fromRGB(155, 32, 32);
            TweenService:Create(u7, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
                Brightness = ColorCorrection.Brightness,
                TintColor = ColorCorrection.TintColor
            }):Play();
        end;
    end);
    task.delay(1.7666666666666666 - v3, function() -- Line: 103
        -- upvalues: VfxManager (ref), u5 (copy), Value (copy), Essentials (ref), u6 (ref), Debris (ref), BALL (copy), HumanoidRootPart (copy), u8 (ref), Lighting (ref), TweenService (ref), u7 (copy), ColorCorrection (copy)
        VfxManager.Enable(u5, false);
        u5:FindFirstChild("WeldConstraint"):Destroy();
        u5.CFrame = Value.CFrame;
        Essentials:Weld(u5, Value);
        VfxManager.Enable(u5, true);
        u6 = script.Trail:Clone();
        u6.Parent = Debris;
        u6.CFrame = Value.CFrame;
        Essentials:Weld(u6, Value);
        VfxManager.Enable(u6, true);
        local v10 = script.Shoot:Clone();
        v10.Parent = Debris;
        v10.CFrame = CFrame.new(BALL.Position) * CFrame.fromOrientation(HumanoidRootPart.CFrame:ToOrientation()) * CFrame.Angles(1.0471975511965976, 3.141592653589793, 3.141592653589793);
        VfxManager.Emit(v10);
        VfxManager.DestroyEffect(v10, 6);

        if u8 then
            local BlurEffect = Instance.new("BlurEffect", Lighting);
            BlurEffect.Size = 35;
            TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
                Size = 0
            }):Play();
            VfxManager.DestroyEffect(BlurEffect, 0.25);
            u7.Brightness = 1;
            u7.Saturation = -1;
            u7.TintColor = Color3.fromRGB(229, 48, 48);
            TweenService:Create(u7, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
                TintColor = ColorCorrection.TintColor
            }):Play();
            TweenService:Create(u7, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
                Brightness = ColorCorrection.Brightness,
                Saturation = ColorCorrection.Saturation
            }):Play();
        end;
    end);
    task.delay(3.7666666666666666 - v3, function() -- Line: 138
        -- upvalues: VfxManager (ref), u5 (copy), u6 (ref)
        VfxManager.Enable(u5, false);
        VfxManager.DestroyEffect(u5, 2);

        if u6 then
            VfxManager.Enable(u6, false);
            VfxManager.DestroyEffect(u6, 2);
        end;
    end);
end;
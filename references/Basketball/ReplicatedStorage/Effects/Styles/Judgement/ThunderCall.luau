 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
require(ReplicatedStorage.Shared.Utility.Effects);
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 16
    -- upvalues: SfxManager (copy), Lighting (copy), TweenService (copy), VfxManager (copy), Debris (copy), RunService (copy)
    local TimeSent = p2.TimeSent;
    local v3 = workspace:GetServerTimeNow() - TimeSent;
    local Character = p2.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local Gavel = Character:FindFirstChild("Gavel");
    SfxManager:playSound({
        Sound = "BBZ Judgement Thunder Call",
        Parent = HumanoidRootPart
    });
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u4 = ColorCorrection:Clone();
    u4.Name = "CC";
    u4.Parent = Lighting;
    u4.Enabled = true;
    task.delay(3.066666666666667, function() -- Line: 35
        -- upvalues: u4 (copy), Lighting (ref), ColorCorrection (copy)
        u4:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    task.delay(1.3333333333333333 - v3, function() -- Line: 42
        -- upvalues: Gavel (copy), Lighting (ref), TweenService (ref), VfxManager (ref), u4 (copy), ColorCorrection (copy), Debris (ref), RunService (ref)
        if not Gavel then
            return;
        end;

        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 20;
        TweenService:Create(BlurEffect, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.45);
        u4.Brightness = 1;
        u4.TintColor = Color3.fromRGB(255, 170, 96);
        TweenService:Create(u4, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
            Brightness = ColorCorrection.Brightness,
            TintColor = ColorCorrection.TintColor
        }):Play();
        local u5 = script.Attachment:Clone();
        u5.Parent = Gavel;
        local u6 = script.Thunder:Clone();
        u6.Parent = Debris;
        u6.CFrame = CFrame.new(u5.WorldPosition);
        local u7 = nil;
        u7 = RunService.RenderStepped:Connect(function() -- Line: 62
            -- upvalues: u6 (copy), u7 (ref), u5 (copy)
            if u6 and u6.Parent then
                u6.CFrame = CFrame.new(u5.WorldPosition);

                return;
            end;

            u7:Disconnect();
        end);
        VfxManager.Emit(u6);
        VfxManager.Enable(u6, true);
        task.delay(1.4833333333333334, function() -- Line: 72
            -- upvalues: Lighting (ref), TweenService (ref), VfxManager (ref), u4 (ref), ColorCorrection (ref), u6 (copy)
            local BlurEffect2 = Instance.new("BlurEffect", Lighting);
            BlurEffect2.Size = 20;
            TweenService:Create(BlurEffect2, TweenInfo.new(0.45, Enum.EasingStyle.Sine), {
                Size = 0
            }):Play();
            VfxManager.DestroyEffect(BlurEffect2, 0.45);
            u4.Brightness = 1;
            u4.TintColor = Color3.fromRGB(255, 170, 96);
            TweenService:Create(u4, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
                Brightness = ColorCorrection.Brightness,
                TintColor = ColorCorrection.TintColor
            }):Play();
            VfxManager.Enable(u6, false);
            VfxManager.DestroyEffect(u6, 4);
        end);
    end);
end;
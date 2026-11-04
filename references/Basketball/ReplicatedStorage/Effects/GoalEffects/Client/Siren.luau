 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 10
    -- upvalues: Debris (copy), VfxManager (copy), TweenService (copy), SfxManager (copy), Lighting (copy)
    local u3 = script.Model:Clone();
    u3.Parent = Debris;
    u3:PivotTo(p2.CFrame * CFrame.fromOrientation(0, 1.5707963267948966, 0));
    u3.AnimationController.Animator:LoadAnimation(script.Animation):Play();
    task.delay(4.1, function() -- Line: 17
        -- upvalues: VfxManager (ref), u3 (copy), TweenService (ref)
        VfxManager.Enable(u3, false);

        for _, descendant in u3:GetDescendants() do
            if descendant:IsA("BasePart") then
                TweenService:Create(descendant, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
            elseif descendant:IsA("PointLight") then
                TweenService:Create(descendant, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                    Brightness = 0
                }):Play();
            end;
        end;
    end);
    local u4 = SfxManager:playSound({
        Sound = "SirenSFX",
        Parent = workspace
    });
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u5 = ColorCorrection:Clone();
    u5.Name = "CC";
    u5.Parent = Lighting;
    u5.Enabled = true;
    local BlurEffect = Instance.new("BlurEffect", Lighting);
    BlurEffect.Size = 15;
    TweenService:Create(BlurEffect, TweenInfo.new(0.6, Enum.EasingStyle.Linear), {
        Size = 0
    }):Play();
    VfxManager.DestroyEffect(BlurEffect, 0.6);
    u5.Brightness = 1;
    u5.TintColor = Color3.fromRGB(255, 76, 76);
    TweenService:Create(u5, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
        Brightness = ColorCorrection.Brightness
    }):Play();
    task.delay(0.455, function() -- Line: 48
        -- upvalues: u5 (copy), Lighting (ref), ColorCorrection (copy)
        u5:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    task.delay(4, function() -- Line: 55
        -- upvalues: TweenService (ref), u4 (copy), VfxManager (ref)
        TweenService:Create(u4, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            Volume = 0
        }):Play();
        VfxManager.DestroyEffect(u4, 0.25);
    end);
    VfxManager.DestroyEffect(u3, 4.35);
end;
 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 10
    -- upvalues: Debris (copy), Lighting (copy), TweenService (copy), VfxManager (copy)
    local _, v3, _ = p2.CFrame:ToOrientation();
    local u4 = script.Lotus:Clone();
    u4.Parent = Debris;
    u4:PivotTo(p2.CFrame);
    local v5 = script.Score:Clone();
    v5.Parent = Debris;
    v5.CFrame = p2.CFrame * CFrame.Angles(1.5707963267948966, 0, 0);
    local u6 = script.End:Clone();
    u6.Parent = Debris;
    u6:PivotTo(CFrame.new(p2.CFrame.Position.X, 1.5, p2.CFrame.Position.Z) * CFrame.fromOrientation(1.5707963267948966, v3 + -1.5707963267948966, 0));
    local u7 = script.RealEnd:Clone();
    u7.Parent = Debris;
    u7.CFrame = CFrame.new(p2.CFrame.Position.X, 1, p2.CFrame.Position.Z) * CFrame.fromOrientation(1.5707963267948966, v3 + -1.5707963267948966, 0);
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u8 = ColorCorrection:Clone();
    u8.Name = "CC";
    u8.Parent = Lighting;
    u8.Enabled = true;
    task.delay(5.388333333333334, function() -- Line: 37
        -- upvalues: u8 (copy), Lighting (ref), ColorCorrection (copy)
        u8:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    u8.Brightness = 1;
    u8.Contrast = 2;
    u8.TintColor = Color3.fromRGB(227, 227, 227);
    TweenService:Create(u8, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
        Brightness = ColorCorrection.Brightness,
        Contrast = ColorCorrection.Contrast
    }):Play();
    TweenService:Create(u8, TweenInfo.new(0.855, Enum.EasingStyle.Linear), {
        TintColor = ColorCorrection.TintColor
    }):Play();
    VfxManager.Emit(v5);
    task.delay(0.13333333333333333, function() -- Line: 52
        -- upvalues: TweenService (ref), u4 (copy)
        TweenService:Create(u4.Petals, TweenInfo.new(0.5), {
            CFrame = u4.Petals.CFrame + Vector3.new(0, -30, 0)
        }):Play();
    end);
    task.delay(0.5, function() -- Line: 56
        -- upvalues: VfxManager (ref), u6 (copy), u4 (copy), u8 (copy), TweenService (ref), ColorCorrection (copy)
        VfxManager.BetterEmit(u6);
        VfxManager.Enable(u4, false);
        u8.Brightness = 1;
        u8.Contrast = 2;
        u8.TintColor = Color3.fromRGB(0, 0, 0);
        TweenService:Create(u8, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast
        }):Play();
        TweenService:Create(u8, TweenInfo.new(0.855, Enum.EasingStyle.Linear), {
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
    task.delay(4.533333333333333, function() -- Line: 67
        -- upvalues: VfxManager (ref), u7 (copy), u8 (copy), TweenService (ref), ColorCorrection (copy)
        VfxManager.BetterEmit(u7);
        u8.Brightness = 1;
        u8.Contrast = 2;
        u8.TintColor = Color3.fromRGB(227, 227, 227);
        TweenService:Create(u8, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast
        }):Play();
        TweenService:Create(u8, TweenInfo.new(0.855, Enum.EasingStyle.Linear), {
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
    VfxManager.DestroyEffect(u4, 4);
    VfxManager.DestroyEffect(v5, 4);
    VfxManager.DestroyEffect(u6, 8);
    VfxManager.DestroyEffect(u7, 8);
end;
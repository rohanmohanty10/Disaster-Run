 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Lighting = game:GetService("Lighting");
local TweenService = game:GetService("TweenService");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 11
    -- upvalues: Debris (copy), VfxManager (copy), Lighting (copy), TweenService (copy)
    if p2.Preview then
        local u3 = script.Book:Clone();
        u3.Parent = Debris;
        u3:ScaleTo(0.1);
        u3:PivotTo(p2.CFrame * CFrame.fromOrientation(0, -1.5707963267948966, 0));
        local Emit = u3.Emit;
        Emit.Parent = Debris;
        local Shot = u3.Shot;
        Shot.Parent = Debris;
        local Ground = u3.Ground;
        Ground.Parent = Debris;
        Ground:PivotTo(Ground.PrimaryPart.CFrame + Vector3.new(0, -3.5, 0));
        local v4 = u3.AnimationController:LoadAnimation(script.Animation);
        v4:Play();
        VfxManager.Emit(Shot);
        VfxManager.Enable(Ground, true);
        u3:ScaleTo(0.001);
        local NumberValue = Instance.new("NumberValue", u3);
        NumberValue.Value = 0;
        NumberValue.Changed:Connect(function() -- Line: 158
            -- upvalues: NumberValue (copy), u3 (copy)
            if NumberValue.Value > 0 then
                u3:ScaleTo(NumberValue.Value);
            end;
        end);
        v4:GetMarkerReachedSignal("Scale Down"):Connect(function() -- Line: 164
            -- upvalues: u3 (copy)
            u3:ScaleTo(0.001);
        end);
        TweenService:Create(NumberValue, TweenInfo.new(0.717), {
            Value = 0.25
        }):Play();
        task.wait(0.717);
        VfxManager.Enable(u3.BookToRig, true);
        task.wait(2.963);
        VfxManager.Enable(Ground, false);
        VfxManager.Enable(u3.BookToRig, false);
        VfxManager.Emit(Emit);
        VfxManager.DestroyEffect(u3, 2);
        VfxManager.DestroyEffect(Emit, 2);
        VfxManager.DestroyEffect(Shot, 2);
        VfxManager.DestroyEffect(Ground, 2);

        return;
    end;

    local u5 = script.Book:Clone();
    u5.Parent = Debris;
    u5:PivotTo(p2.CFrame * CFrame.fromOrientation(0, 0, 0));
    local Emit = u5.Emit;
    Emit.Parent = Debris;
    local Shot = u5.Shot;
    Shot.Parent = Debris;
    local Ground = u5.Ground;
    Ground.Parent = Debris;
    local v6 = u5.AnimationController:LoadAnimation(script.Animation);
    v6:Play();
    VfxManager.Emit(Shot);
    VfxManager.Enable(Ground, true);
    u5:ScaleTo(0.001);
    local NumberValue = Instance.new("NumberValue", u5);
    NumberValue.Value = 0;
    NumberValue.Changed:Connect(function() -- Line: 36
        -- upvalues: NumberValue (copy), u5 (copy)
        if NumberValue.Value > 0 then
            u5:ScaleTo(NumberValue.Value);
        end;
    end);
    v6:GetMarkerReachedSignal("Scale Down"):Connect(function() -- Line: 42
        -- upvalues: u5 (copy)
        u5:ScaleTo(0.001);
    end);
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u7 = ColorCorrection:Clone();
    u7.Name = "CC";
    u7.Parent = Lighting;
    u7.Enabled = true;
    task.delay(4.7135, function() -- Line: 54
        -- upvalues: u7 (copy), Lighting (ref), ColorCorrection (copy)
        u7:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u8 = Bloom:Clone();
    u8.Name = "B";
    u8.Parent = Lighting;
    u8.Enabled = true;
    u8.Intensity = 2;
    u8.Threshold = 0.5;
    task.delay(2.5, function() -- Line: 71
        -- upvalues: u8 (copy), Lighting (ref), Bloom (copy)
        u8:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    local BlurEffect = Instance.new("BlurEffect", Lighting);
    BlurEffect.Size = 12;
    VfxManager.DestroyEffect(BlurEffect, 0.855);
    task.spawn(function() -- Line: 82
        -- upvalues: TweenService (ref), NumberValue (copy), u7 (copy), u8 (copy), Bloom (copy), BlurEffect (copy), ColorCorrection (copy)
        TweenService:Create(NumberValue, TweenInfo.new(0.717), {
            Value = 2.5
        }):Play();
        TweenService:Create(u7, TweenInfo.new(0.067, Enum.EasingStyle.Linear), {
            Brightness = 0.2
        }):Play();
        TweenService:Create(u8, TweenInfo.new(2.5, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        TweenService:Create(BlurEffect, TweenInfo.new(0.855, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        task.wait(0.067);
        TweenService:Create(u7, TweenInfo.new(0.055, Enum.EasingStyle.Sine), {
            Brightness = -0.5,
            Saturation = -1
        }):Play();
        task.wait(0.055);
        TweenService:Create(u7, TweenInfo.new(0.567, Enum.EasingStyle.Linear), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    task.wait(0.717);
    VfxManager.Enable(u5.BookToRig, true);
    task.wait(2.963);
    VfxManager.Enable(Ground, false);
    VfxManager.Enable(u5.BookToRig, false);
    VfxManager.Emit(Emit);
    u8.Intensity = 2;
    u8.Threshold = 0.5;
    local BlurEffect2 = Instance.new("BlurEffect", Lighting);
    BlurEffect2.Size = 12;
    VfxManager.DestroyEffect(BlurEffect2, 1.2825);
    task.spawn(function() -- Line: 114
        -- upvalues: TweenService (ref), u7 (copy), u8 (copy), BlurEffect2 (copy), ColorCorrection (copy)
        TweenService:Create(u7, TweenInfo.new(0.1005), {
            Brightness = 0.2
        }):Play();
        TweenService:Create(u8, TweenInfo.new(3.75, Enum.EasingStyle.Back), {
            Intensity = 0.25,
            Threshold = 2
        }):Play();
        TweenService:Create(BlurEffect2, TweenInfo.new(1.2825, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        task.wait(0.1005);
        TweenService:Create(u7, TweenInfo.new(0.0825, Enum.EasingStyle.Sine), {
            Brightness = -0.5,
            Saturation = -1
        }):Play();
        task.wait(0.0825);
        TweenService:Create(u7, TweenInfo.new(0.8505, Enum.EasingStyle.Linear), {
            Brightness = ColorCorrection.Brightness,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end);
    VfxManager.DestroyEffect(u5, 2);
    VfxManager.DestroyEffect(Emit, 2);
    VfxManager.DestroyEffect(Shot, 2);
    VfxManager.DestroyEffect(Ground, 2);
end;
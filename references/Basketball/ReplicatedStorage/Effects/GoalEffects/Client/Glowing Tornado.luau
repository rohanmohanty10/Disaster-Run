 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 15
    -- upvalues: SfxManager (copy), Debris (copy), VfxManager (copy), Lighting (copy), TweenService (copy), RunService (copy)
    SfxManager:playSound({
        Sound = "Glowing TornadoSFX",
        Parent = workspace
    });
    local u3 = script.Tornado:Clone();
    u3.Parent = Debris;
    u3:PivotTo(p2.CFrame);
    VfxManager.Emit(u3.Emit1.FirstEmit);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u4 = Bloom:Clone();
    u4.Name = "B";
    u4.Parent = Lighting;
    u4.Enabled = true;
    task.delay(2.3499999999999996, function() -- Line: 32
        -- upvalues: u4 (copy), Lighting (ref), Bloom (copy)
        u4:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    u4.Intensity = 15;
    u4.Threshold = 0.5;
    TweenService:Create(u4, TweenInfo.new(0.6, Enum.EasingStyle.Back), {
        Intensity = Bloom.Intensity,
        Threshold = Bloom.Threshold
    }):Play();
    local v5 = {};

    for _, child in pairs(u3:GetChildren()) do
        if child:IsA("BasePart") and child.Name == "Star" then
            VfxManager.Enable(child, true);
            child.Handle.C1 = child.Handle.C0;
            table.insert(v5, child);
        end;
    end;

    local NumberValue = Instance.new("NumberValue");
    NumberValue.Value = 1;
    TweenService:Create(NumberValue, TweenInfo.new(1.65), {
        Value = 3
    }):Play();
    local CFrameValue = Instance.new("CFrameValue");
    CFrameValue.Value = u3.CFrame;
    TweenService:Create(CFrameValue, TweenInfo.new(1.65, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {
        Value = u3.CFrame * CFrame.new(0, 30, 0)
    }):Play();
    local v8 = RunService.RenderStepped:Connect(function(p6) -- Line: 62
        -- upvalues: u3 (copy), CFrameValue (copy), NumberValue (copy)
        u3.CFrame = CFrame.new(CFrameValue.Value.Position) * CFrame.fromOrientation(u3.CFrame:ToOrientation());
        local v7 = u3;
        v7.CFrame = v7.CFrame * CFrame.fromOrientation(0, 6.283185307179586 * p6 * NumberValue.Value, 0);
    end);

    for _, v in pairs(v5) do
        TweenService:Create(v.Handle, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            C1 = CFrame.new()
        }):Play();
    end;

    task.wait(1.4);
    VfxManager.Emit(u3.Emit2);

    for _, v in pairs(v5) do
        TweenService:Create(v.Handle, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
            C1 = v.Handle.C0
        }):Play();
    end;

    task.wait(0.25);
    VfxManager.Emit(u3.Emit1);

    for _, child in pairs(u3:GetChildren()) do
        if child:IsA("BasePart") and child.Name == "Star" then
            VfxManager.Enable(child, false);
        end;
    end;

    v8:Disconnect();
    NumberValue:Destroy();
    VfxManager.DestroyEffect(u3, 2);
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u9 = ColorCorrection:Clone();
    u9.Name = "CC";
    u9.Parent = Lighting;
    u9.Enabled = true;
    task.delay(0.555, function() -- Line: 102
        -- upvalues: u9 (copy), Lighting (ref), ColorCorrection (copy)
        u9:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    u9.Brightness = -0.15;
    u9.Contrast = 10;
    u9.Saturation = -1;
    u9.TintColor = Color3.fromRGB(255, 56, 160);
    task.wait(0.05);
    u9.Contrast = -10;
    u9.TintColor = Color3.fromRGB(43, 255, 46);
    task.wait(0.05);
    u9.Contrast = 10;
    u9.TintColor = Color3.fromRGB(75, 0, 240);
    task.wait(0.05);
    u9.Contrast = ColorCorrection.Contrast;
    u9.TintColor = Color3.fromRGB(255, 255, 255);
    TweenService:Create(u9, TweenInfo.new(0.455, Enum.EasingStyle.Sine), {
        Brightness = ColorCorrection.Brightness,
        Saturation = ColorCorrection.Saturation
    }):Play();
    local BlurEffect = Instance.new("BlurEffect", Lighting);
    BlurEffect.Size = 20;
    TweenService:Create(BlurEffect, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
        Size = 0
    }):Play();
    VfxManager.DestroyEffect(BlurEffect, 0.7);
    u4.Intensity = 15;
    u4.Threshold = 0.5;
    TweenService:Create(u4, TweenInfo.new(0.6, Enum.EasingStyle.Back), {
        Intensity = Bloom.Intensity,
        Threshold = Bloom.Threshold
    }):Play();
end;
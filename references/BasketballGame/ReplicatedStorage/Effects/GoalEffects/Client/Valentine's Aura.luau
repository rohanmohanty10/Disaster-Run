 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 12
    -- upvalues: Debris (copy), TweenService (copy), VfxManager (copy), Lighting (copy)
    if p2.Preview then
        local v3 = script.Score:Clone();
        v3:PivotTo(p2.CFrame * CFrame.Angles(1.5707963267948966, 3.141592653589793, 0));
        local Model = Instance.new("Model");
        v3.Parent = Model;
        Model:ScaleTo(0.3333333333333333);
        v3.Parent = Debris;
        local Model2 = Instance.new("Model");
        Model2.Parent = Debris;
        local u4 = script.Aura:Clone();
        u4.Parent = Model2;
        u4:PivotTo(p2.CFrame);
        Model2.PrimaryPart = u4;
        Model:Destroy();
        local NumberValue = Instance.new("NumberValue");
        NumberValue.Value = 0.3333333333333333;
        Model2:ScaleTo(0.3333333333333333);
        NumberValue.Changed:Connect(function() -- Line: 90
            -- upvalues: Model2 (copy), NumberValue (copy)
            Model2:ScaleTo(NumberValue.Value);
        end);
        TweenService:Create(NumberValue, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
            Value = 3.3333333333333335
        }):Play();
        VfxManager.DestroyEffect(NumberValue, 0.355);
        task.delay(0.355, function() -- Line: 96
            -- upvalues: u4 (copy), TweenService (ref), VfxManager (ref), Model2 (copy)
            for _, descendant in u4:GetDescendants() do
                if descendant:IsA("Beam") then
                    TweenService:Create(descendant, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
                        Width0 = 0,
                        Width1 = 0
                    }):Play();
                end;
            end;

            VfxManager.DestroyEffect(Model2, 0.25);
        end);
        VfxManager.BetterEmit(v3);
        VfxManager.DestroyEffect(v3, 4);

        return;
    end;

    local v5 = script.Score:Clone();
    v5.Parent = Debris;
    v5:PivotTo(p2.CFrame * CFrame.Angles(1.5707963267948966, -1.5707963267948966, 0));
    local Model = Instance.new("Model");
    Model.Parent = Debris;
    local u6 = script.Aura:Clone();
    u6.Parent = Model;
    u6:PivotTo(p2.CFrame);
    Model.PrimaryPart = u6;
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Value = 1;
    NumberValue.Changed:Connect(function() -- Line: 29
        -- upvalues: Model (copy), NumberValue (copy)
        Model:ScaleTo(NumberValue.Value);
    end);
    TweenService:Create(NumberValue, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
        Value = 10
    }):Play();
    VfxManager.DestroyEffect(NumberValue, 0.355);
    task.delay(0.355, function() -- Line: 35
        -- upvalues: u6 (copy), TweenService (ref), VfxManager (ref), Model (copy)
        for _, descendant in u6:GetDescendants() do
            if descendant:IsA("Beam") then
                TweenService:Create(descendant, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
                    Width0 = 0,
                    Width1 = 0
                }):Play();
            end;
        end;

        VfxManager.DestroyEffect(Model, 0.25);
    end);
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u7 = ColorCorrection:Clone();
    u7.Name = "CC";
    u7.Parent = Lighting;
    u7.Enabled = true;
    task.delay(0.855, function() -- Line: 52
        -- upvalues: u7 (copy), Lighting (ref), ColorCorrection (copy)
        u7:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    u7.Brightness = 1;
    u7.Contrast = 2;
    u7.TintColor = Color3.fromRGB(237, 155, 255);
    TweenService:Create(u7, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
        Brightness = ColorCorrection.Brightness,
        Contrast = ColorCorrection.Contrast
    }):Play();
    TweenService:Create(u7, TweenInfo.new(0.855, Enum.EasingStyle.Linear), {
        TintColor = ColorCorrection.TintColor
    }):Play();
    VfxManager.BetterEmit(v5);
    VfxManager.DestroyEffect(v5, 4);
end;
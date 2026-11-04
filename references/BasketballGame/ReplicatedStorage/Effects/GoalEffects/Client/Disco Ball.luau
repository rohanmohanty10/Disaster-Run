 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 11
    -- upvalues: SfxManager (copy), Debris (copy), VfxManager (copy), TweenService (copy), Lighting (copy), RunService (copy)
    SfxManager:playSound({
        Sound = "Disco BallSFX",
        Parent = workspace
    });
    local u3 = script.Model:Clone();
    u3.Parent = Debris;
    local _, _, _ = p2.CFrame:ToOrientation();
    u3:PivotTo(p2.CFrame * CFrame.fromOrientation(0, 1.5707963267948966, 0));
    u3.AnimationController.Animator:LoadAnimation(script.Animation):Play();
    VfxManager.Emit(u3.Score);
    u3.Sphere.Size = Vector3.new(0, 0, 0);
    TweenService:Create(u3.Sphere, TweenInfo.new(1), {
        Size = Vector3.new(8.5, 8.5, 8.5)
    }):Play();
    task.delay(1, function() -- Line: 26
        -- upvalues: VfxManager (ref), u3 (copy)
        VfxManager.Enable(u3.Aura, true);
    end);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Name = "CCAddon";
    ColorCorrectionEffect.Parent = Lighting;
    ColorCorrectionEffect.Enabled = true;
    local NumberValue = Instance.new("NumberValue");
    NumberValue.Value = 0;
    TweenService:Create(NumberValue, TweenInfo.new(1), {
        Value = 0.5
    }):Play();
    local u4 = tick();
    local u5 = RunService.RenderStepped:Connect(function() -- Line: 40
        -- upvalues: ColorCorrectionEffect (copy), u4 (copy), NumberValue (copy)
        ColorCorrectionEffect.TintColor = Color3.fromHSV((tick() - u4) / 2 % 1, NumberValue.Value, 1);
    end);
    task.delay(4.5, function() -- Line: 44
        -- upvalues: ColorCorrectionEffect (copy), NumberValue (copy), u5 (copy)
        ColorCorrectionEffect:Destroy();
        NumberValue:Destroy();
        u5:Disconnect();
    end);
    task.delay(3.5, function() -- Line: 50
        -- upvalues: TweenService (ref), NumberValue (copy), VfxManager (ref), u3 (copy)
        TweenService:Create(NumberValue, TweenInfo.new(1), {
            Value = 0
        }):Play();
        VfxManager.Enable(u3.Aura, false);
        TweenService:Create(u3.Sphere, TweenInfo.new(1), {
            Size = Vector3.new(0, 0, 0)
        }):Play();
    end);
    VfxManager.DestroyEffect(u3, 8);
end;
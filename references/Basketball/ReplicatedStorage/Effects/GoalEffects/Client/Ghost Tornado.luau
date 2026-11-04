 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, u2) -- Line: 14
    -- upvalues: SfxManager (copy), Debris (copy), Essentials (copy), VfxManager (copy), RunService (copy), TweenService (copy), Lighting (copy)
    SfxManager:playSound({
        Sound = "Ghost TornadoSFX",
        Parent = workspace
    });
    local Character = u2.Player.Character;

    if not Character then
        return;
    end;

    local BALL = Character:FindFirstChild("BALL", true);

    if BALL then
        local u3 = script.Ball:Clone();
        u3.Parent = Debris;
        u3.CFrame = BALL.CFrame;
        Essentials:Weld(u3, BALL);
        VfxManager.DestroyEffect(u3, 6);
        VfxManager.Enable(u3, true);
        task.delay(3, function() -- Line: 30
            -- upvalues: VfxManager (ref), u3 (copy)
            VfxManager.Enable(u3, false);
        end);
    end;

    local u4 = script.Score:Clone();
    u4.Parent = Debris;
    u4:PivotTo(u2.CFrame * CFrame.Angles(1.5707963267948966, 0, 0));
    VfxManager.Enable(u4, true);
    VfxManager.DestroyEffect(u4, 6);

    for i = 1, 15 do
        local u5 = script.Swirl:Clone();
        u5.Parent = u4;
        local math_random_ret = math.random(-180, 180);
        task.delay((i - 1) * 0.1, function() -- Line: 49
            -- upvalues: RunService (ref), u5 (copy), u2 (copy), math_random_ret (copy), TweenService (ref), VfxManager (ref)
            local NumberValue = Instance.new("NumberValue");
            NumberValue.Value = 1;
            local NumberValue2 = Instance.new("NumberValue");
            NumberValue2.Value = 1;
            local u6 = RunService.RenderStepped:Connect(function() -- Line: 56
                -- upvalues: u5 (ref), u2 (ref), math_random_ret (ref), NumberValue (copy), NumberValue2 (copy)
                u5.CFrame = u2.CFrame * CFrame.Angles(0, math.rad(math_random_ret + NumberValue.Value * 720), 0) * CFrame.new(0, 25 * NumberValue.Value, 50 * NumberValue2.Value);
            end);
            u5.CFrame = u2.CFrame * CFrame.Angles(0, math.rad(math_random_ret + NumberValue.Value * 720), 0) * CFrame.new(0, 25 * NumberValue.Value, 50 * NumberValue2.Value);
            TweenService:Create(NumberValue, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
                Value = 0
            }):Play();
            TweenService:Create(NumberValue2, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Value = 0
            }):Play();
            VfxManager.DestroyEffect(NumberValue, 0.5);
            VfxManager.DestroyEffect(NumberValue2, 0.5);
            task.delay(0.5, function() -- Line: 66
                -- upvalues: u6 (copy)
                u6:Disconnect();
            end);
            task.wait(0.1);
            VfxManager.Enable(u5, true);
        end);
        local _ = i;
    end;

    task.delay(2, function() -- Line: 76
        -- upvalues: VfxManager (ref), u4 (copy)
        VfxManager.Enable(u4, false);
    end);
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u7 = ColorCorrection:Clone();
    u7.Name = "CC";
    u7.Parent = Lighting;
    u7.Enabled = true;
    task.delay(0.855, function() -- Line: 88
        -- upvalues: u7 (copy), Lighting (ref), ColorCorrection (copy)
        u7:Destroy();

        if not Lighting:FindFirstChild("CC") then
            ColorCorrection.Enabled = true;
        end;
    end);
    u7.Brightness = 1;
    u7.Contrast = 2;
    u7.TintColor = Color3.fromRGB(39, 255, 145);
    TweenService:Create(u7, TweenInfo.new(0.355, Enum.EasingStyle.Sine), {
        Brightness = ColorCorrection.Brightness,
        Contrast = ColorCorrection.Contrast
    }):Play();
    TweenService:Create(u7, TweenInfo.new(0.855, Enum.EasingStyle.Linear), {
        TintColor = ColorCorrection.TintColor
    }):Play();
end;
 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
local Knit = require(ReplicatedStorage.Packages.Knit);
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local LocalPlayer = Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, u2) -- Line: 14
    -- upvalues: Knit (copy), SfxManager (copy), Debris (copy), LocalPlayer (copy), ReplicatedStorage (copy), Lighting (copy), TweenService (copy), VfxManager (copy), Essentials (copy)
    local Controller = Knit.GetController("MovementController");
    SfxManager:playSound({
        Sound = "Ranked Crown",
        Parent = workspace
    });
    local u3 = script.Crown:Clone();
    u3.Parent = Debris;
    u3:PivotTo(u2.CFrame);
    local Highlight = Instance.new("Highlight", u3);
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(22, 16, 43);
    Highlight.FillTransparency = 0.9;
    Highlight.OutlineColor = Color3.fromRGB(130, 95, 255);
    Highlight.OutlineTransparency = 0;
    local NumberValue = Instance.new("NumberValue", u3);
    NumberValue.Changed:Connect(function() -- Line: 31
        -- upvalues: NumberValue (copy), u3 (copy), u2 (copy)
        if NumberValue.Value > 0 then
            u3:ScaleTo(NumberValue.Value);
            u3:PivotTo(u2.CFrame * CFrame.new(0, 0, -1.5 * NumberValue.Value));
        end;
    end);
    u3.Humanoid:LoadAnimation(script.Animation):Play();

    if LocalPlayer.Team ~= game.Teams.Visitor and LocalPlayer.Character ~= u2.Plr.Character then
        local EMPERORKNEELANIMATION = ReplicatedStorage.Assets.VFX.Emotes.EMPERORKNEELANIMATION;
        local Character = LocalPlayer.Character;

        if Character then
            local u4 = Character:FindFirstChild("Humanoid"):LoadAnimation(EMPERORKNEELANIMATION);
            u4:Play();
            Controller.States.Kneeling = true;
            task.delay(3, function() -- Line: 52
                -- upvalues: Controller (copy), u4 (copy)
                Controller.States.Kneeling = false;
                u4:Stop();
            end);
        end;
    end;

    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u5 = ColorCorrection:Clone();
    u5.Name = "CC";
    u5.Parent = Lighting;
    u5.Enabled = true;
    task.delay(0.25, function() -- Line: 68
        -- upvalues: u5 (copy), ColorCorrection (copy)
        u5:Destroy();
        ColorCorrection.Enabled = true;
    end);
    local BlurEffect = Instance.new("BlurEffect", Lighting);
    BlurEffect.Size = 15;
    TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
        Size = 0
    }):Play();
    VfxManager.DestroyEffect(BlurEffect, 0.25);
    u5.Brightness = 0.65;
    u5.TintColor = Color3.fromRGB(130, 99, 243);
    TweenService:Create(u5, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
        Brightness = ColorCorrection.Brightness,
        TintColor = ColorCorrection.TintColor
    }):Play();
    local v6 = script.Emit:Clone();
    v6.Parent = Debris;
    v6.CFrame = u3.Crown.CFrame;
    Essentials:Weld(v6, u3.Crown);
    VfxManager.Emit(v6);
    VfxManager.DestroyEffect(v6, 2);
    NumberValue.Value = 0;
    TweenService:Create(NumberValue, TweenInfo.new(0.5333333333333333), {
        Value = 1
    }):Play();
    task.delay(0.23333333333333334, function() -- Line: 92
        -- upvalues: VfxManager (ref), u3 (copy)
        VfxManager.Enable(u3, true);
    end);
    task.delay(3.65, function() -- Line: 96
        -- upvalues: VfxManager (ref), u3 (copy), TweenService (ref), NumberValue (copy)
        VfxManager.Enable(u3, false);
        TweenService:Create(NumberValue, TweenInfo.new(0.85), {
            Value = 0
        }):Play();
    end);
    VfxManager.DestroyEffect(u3, 8);
end;
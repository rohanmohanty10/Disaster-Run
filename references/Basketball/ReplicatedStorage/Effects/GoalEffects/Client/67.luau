 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);

return function(p1, p2) -- Line: 11
    -- upvalues: SfxManager (copy), VfxManager (copy), Lighting (copy), TweenService (copy)
    if p2.Preview then
        local Attachment = Instance.new("Attachment");
        Attachment.Parent = workspace.Terrain;
        Attachment.WorldPosition = p2.CFrame.Position;
        SfxManager:playSound({
            Sound = "67SFX",
            Parent = Attachment
        }).Ended:Once(function() -- Line: 18
            -- upvalues: Attachment (copy)
            Attachment:Destroy();
        end);
    else
        SfxManager:playSound({
            Sound = "67SFX",
            Parent = workspace
        });
    end;

    local v3 = script.Emit:Clone();
    v3.Parent = workspace.Debris;
    v3.CFrame = p2.CFrame;

    if p2.Preview then
        local Model = Instance.new("Model");
        Model.Parent = v3.Parent;
        v3.Parent = Model;
        Model.PrimaryPart = v3;
        Model:ScaleTo(0.3333333333333333);
        VfxManager.BetterEmit(v3);
        VfxManager.DestroyEffect(Model, 4);

        return;
    end;

    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u4 = ColorCorrection:Clone();
    u4.Name = "CC";
    u4.Parent = Lighting;
    u4.Enabled = true;
    task.delay(0.25, function() -- Line: 50
        -- upvalues: u4 (copy), ColorCorrection (copy)
        u4:Destroy();
        ColorCorrection.Enabled = true;
    end);
    local BlurEffect = Instance.new("BlurEffect", Lighting);
    BlurEffect.Size = 15;
    TweenService:Create(BlurEffect, TweenInfo.new(0.25, Enum.EasingStyle.Sine), {
        Size = 0
    }):Play();
    VfxManager.DestroyEffect(BlurEffect, 0.25);
    u4.Brightness = 0.65;
    u4.TintColor = Color3.fromRGB(87, 255, 163);
    TweenService:Create(u4, TweenInfo.new(0.25, Enum.EasingStyle.Linear), {
        Brightness = ColorCorrection.Brightness,
        TintColor = ColorCorrection.TintColor
    }):Play();
    VfxManager.BetterEmit(v3);
    VfxManager.DestroyEffect(v3, 4);
end;
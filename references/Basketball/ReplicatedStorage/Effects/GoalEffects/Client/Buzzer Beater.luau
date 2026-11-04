 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 52
    -- upvalues: SfxManager (copy), Debris (copy), TweenService (copy), VfxManager (copy)
    if p2.Preview then
        local Attachment = Instance.new("Attachment");
        Attachment.WorldCFrame = p2.CFrame;
        Attachment.Parent = workspace;
        SfxManager:playSound({
            Sound = "Buzzer BeaterSFX",
            Parent = Attachment
        }).Ended:Once(function() -- Line: 59
            -- upvalues: Attachment (copy)
            Attachment:Destroy();
        end);
    else
        SfxManager:playSound({
            Sound = "Buzzer BeaterSFX",
            Parent = workspace
        });
    end;

    local u3 = script.VFX:Clone();
    u3.Parent = Debris;
    u3:PivotTo(p2.CFrame * CFrame.Angles(0, -1.5707963267948966, 0));
    local u4 = game.Lighting.Atmosphere:Clone();
    local u5 = game.Lighting.ColorCorrection:Clone();
    TweenService:Create(game.Lighting.Atmosphere, TweenInfo.new(0.25), {
        Haze = 10,
        Color = Color3.fromRGB(255, 225, 75)
    }):Play();
    TweenService:Create(game.Lighting.ColorCorrection, TweenInfo.new(0.25), {
        Brightness = 0.2,
        TintColor = Color3.fromRGB(255, 225, 75)
    }):Play();
    local v6 = u3.Clock.AnimationController:LoadAnimation(script.Animation);
    local u7 = nil;
    u7 = v6:GetMarkerReachedSignal("Explosion"):Connect(function() -- Line: 87
        -- upvalues: u7 (ref), VfxManager (ref), u3 (copy), TweenService (ref), u4 (copy), u5 (copy)
        u7:Disconnect();
        VfxManager.Emit(u3.Explode);
        VfxManager.Enable(u3.CourtAura, false);
        VfxManager.Enable(u3.FlashingLights, false);
        TweenService:Create(game.Lighting.Atmosphere, TweenInfo.new(0.25), {
            Color = u4.Color,
            Haze = u4.Haze
        }):Play();
        TweenService:Create(game.Lighting.ColorCorrection, TweenInfo.new(0.25), {
            Brightness = u5.Brightness,
            TintColor = u5.TintColor
        }):Play();
        pcall(game.Destroy, u3:FindFirstChild("Clock"));
        task.delay(1, function() -- Line: 105
            -- upvalues: u3 (ref)
            pcall(game.Destroy, u3);
        end);
    end);
    VfxManager.Emit(u3.Score);
    VfxManager.Enable(u3.CourtAura, true);
    VfxManager.Enable(u3.FlashingLights, true);
    v6:Play();
end;
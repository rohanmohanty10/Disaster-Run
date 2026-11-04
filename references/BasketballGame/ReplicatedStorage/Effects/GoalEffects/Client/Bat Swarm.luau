 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
require(ReplicatedStorage.Packages.Knit);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 12
    -- upvalues: SfxManager (copy), Debris (copy), VfxManager (copy), TweenService (copy)
    SfxManager:playSound({
        Sound = "Bat SwarmSFX",
        Parent = workspace
    });
    local u3 = script.Model:Clone();
    u3.Parent = Debris;
    u3:PivotTo(p2.CFrame);
    VfxManager.DestroyEffect(u3, 4);
    local Highlight = Instance.new("Highlight", u3.Bat);
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.FillTransparency = 0.6;
    Highlight.OutlineColor = Color3.fromRGB(99, 0, 0);
    Highlight.OutlineTransparency = 0.3;
    u3.Bat.AnimationController:LoadAnimation(script.Animation):Play();
    shared.vfx.emit(u3.Score);
    task.delay(2.2666666666666666, function() -- Line: 31
        -- upvalues: TweenService (ref), u3 (copy), Highlight (copy)
        TweenService:Create(u3.Bat["1.006"], TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();
        TweenService:Create(Highlight, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            FillTransparency = 1,
            OutlineTransparency = 1
        }):Play();
    end);
end;
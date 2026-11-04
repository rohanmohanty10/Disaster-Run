 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Controllers.LightingController);
local CameraShaker = require(ReplicatedStorage.Shared.Utility.CameraShaker);
local Knit = require(ReplicatedStorage.Packages.Knit);
local LocalPlayer = game.Players.LocalPlayer;

return function(p1, p2) -- Line: 13
    -- upvalues: Knit (copy), TweenService (copy), LocalPlayer (copy), CameraShaker (copy)
    local Controller = Knit.GetController("CameraController");
    local Controller2 = Knit.GetController("UIController");
    local brokenPlr = p2.brokenPlr;
    local ballPlr = p2.ballPlr;
    local Character = brokenPlr.Character;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = Color3.new(1, 0, 0);
    Highlight.FillTransparency = 0.35;
    Highlight.OutlineColor = Color3.new(0, 0, 0);
    Highlight.OutlineTransparency = 1;
    Highlight.Name = "AnkleHighlight";
    Highlight.Parent = Character;
    TweenService:Create(Highlight, TweenInfo.new(1.5), {
        FillTransparency = 1
    }):Play();
    task.delay(1.5, function() -- Line: 33
        -- upvalues: Highlight (copy)
        Highlight:Destroy();
    end);

    if brokenPlr == LocalPlayer then
        local u3 = script.Blur:Clone();
        u3.Parent = game.Lighting;
        u3.Enabled = true;
        u3.Size = 13;
        TweenService:Create(u3, TweenInfo.new(1.5), {
            Size = 0
        }):Play();
        task.delay(1.5, function() -- Line: 43
            -- upvalues: u3 (copy)
            u3:Destroy();
        end);
        Controller.CamShake:Shake(CameraShaker.Presets.Ankle);
        Controller2:FrameText("AnkleBreaker");
    end;

    if ballPlr == LocalPlayer then
        Controller2:FrameText("AnkleBreaker");
    end;
end;
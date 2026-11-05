  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Petal = _G.Petal;
Petal("New");
local u1 = Petal("Util");
Petal("Extensions");
local _ = u1.Tween;
local Highlight = Instance.new("Highlight");
Highlight.FillColor = Color3.fromRGB(141, 0, 0);
Highlight.FillTransparency = 1;
Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
Highlight.OutlineTransparency = 1;
Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;

return function(p2) -- Line: 22
    -- upvalues: Highlight (copy), u1 (copy), EffectsHandler (copy)
    local TargetCharacter = p2.TargetCharacter;
    local AttachPart = p2.AttachPart;

    if not (TargetCharacter and AttachPart) then
        return;
    end;

    local HumanoidRootPart = TargetCharacter:FindFirstChild("HumanoidRootPart");
    local v3 = AttachPart:FindFirstChildOfClass("Weld");
    local v4 = Highlight:Clone();
    v4.Parent = TargetCharacter;
    u1.Tween(v4, 0.1, "Linear", "Out", {
        FillTransparency = 0.45
    });
    u1.Tween(v3, 0.8, "Cubic", "Out", {
        C1 = v3.C1 * CFrame.Angles(0, 0, -1.5707963267948966)
    });
    task.wait(1.15);
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Block Death/Ough",
        AbilityName = "KillEffects",
        Scale = 1.15,
        Origin = CFrame.new(HumanoidRootPart.Position + Vector3.new(0, 1, 0)),
        Offset = CFrame.identity
    });
    TargetCharacter:Destroy();
end;
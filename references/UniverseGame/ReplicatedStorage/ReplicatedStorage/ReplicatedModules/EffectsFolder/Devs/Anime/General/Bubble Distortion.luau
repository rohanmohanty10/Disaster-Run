  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1) -- Line: 11
    -- upvalues: ParticleHandler (copy), TweenService (copy)
    local StartSize = p1.StartSize;
    local EndSize = p1.EndSize;
    local Transparency = p1.Transparency;
    local Time = p1.Time;
    local v2 = ParticleHandler.TranslateToCFrame(p1.Origin);
    local v3 = script.Mesh:Clone();
    v3.CFrame = v2;
    v3.Anchored = true;
    v3.CanCollide = false;
    v3.Massless = true;
    v3.Parent = workspace.Effects;
    v3.Material = Enum.Material.Glass;
    v3.Size = StartSize;
    v3.Transparency = Transparency;
    local Highlight = Instance.new("Highlight");
    Highlight.Enabled = false;
    Highlight.Parent = v3;
    task.delay(Time, v3.Destroy, v3);
    TweenService:Create(v3, TweenInfo.new(Time, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        Transparency = 1,
        Size = EndSize
    }):Play();

    return v3;
end;
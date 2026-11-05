  

 

local TweenService = game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Random.new();
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 17
    -- upvalues: EffectsHandler (copy), TweenService (copy)
    local v2 = p1 or {};
    local Player = v2.Player;
    local HumanoidRootPart = v2.Character.HumanoidRootPart;
    local Origin = v2.Origin;
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Prance/Slash",
        Origin = Origin,
        Offset = CFrame.new(0, 0.6, 0),
        Player = Player
    });
    task.spawn(function() -- Line: 34
        -- upvalues: Origin (copy), EffectsHandler (ref), TweenService (ref)
        local v3 = Origin * CFrame.Angles(0, 0, -1.5707963267948966);
        local v4 = EffectsHandler.CallEffect("MeshFlipbook", script.SlashMesh1, v3 * CFrame.Angles(0, 0.5235987755982988, 0), script.Slash2, 50, workspace.Effects, Color3.fromRGB(2555, 2555, 2555), 0.6);
        v4:FindFirstChild("Mesh").Scale = Vector3.new(7, 10, 7);
        TweenService:Create(v4:FindFirstChild("Mesh"), TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
            Scale = Vector3.new(10, 20, 10)
        }):Play();
        TweenService:Create(v4, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            CFrame = v4.CFrame * CFrame.Angles(0, 10, 0)
        }):Play();
    end);
    EffectsHandler.CallEffect("Rock Trail", {
        Offset = 1.2,
        Distance = 5,
        Amount = 5,
        Size = 0.85,
        Duration = 0.65,
        DurationOffset = 0.1,
        Down = true,
        Origin = Origin * CFrame.new(0, 0, -2),
        LookVector = HumanoidRootPart.CFrame.LookVector
    });
end;
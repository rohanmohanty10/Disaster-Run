  

 

game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ReplicatedModules = ReplicatedStorage:FindFirstChild("ReplicatedModules");
local PathShortcuts = require(ReplicatedModules:FindFirstChild("PathShortcuts"));
require(PathShortcuts.KnitPath.Trove);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };
ReplicatedStorage:FindFirstChild("Client Assets");

return function(p2) -- Line: 19
    -- upvalues: u1 (copy), EffectsHandler (copy), AssetHandler (copy)
    if not p2 then
        return;
    end;

    local HumanoidRootPart = p2.HumanoidRootPart;
    local v3 = workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -18, 0), u1);

    if v3 then
        EffectsHandler.CallEffect("Emit Particle V3", {
            RawPath = true,
            Path = "Universal/Mounts/Khronos Walker/Jump",
            Scale = 1.3,
            Origin = CFrame.new(v3.Position + v3.Normal * 0.15),
            Character = p2
        });
        EffectsHandler.CallEffect("Play Sound At", {
            Object = AssetHandler.GetAsset("Universal/Mounts/Khronos Walker/JumpSound"),
            AttachTo = HumanoidRootPart
        });
        EffectsHandler.CallEffect("Q_RADIAL", {
            Distance = 7,
            Effect = "Camera Shake",
            Origin = HumanoidRootPart.CFrame,
            Arguments = { { 4, 7, 0, 0.3, Vector3.new(0.25, 0.25, 0.25), Vector3.new(2.5, 1, 1) } }
        });
    end;
end;
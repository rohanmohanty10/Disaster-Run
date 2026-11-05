  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = ReplicatedStorage:FindFirstChild("Client Assets");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u2 = Random.new();
local v3 = RaycastParams.new();
v3.FilterType = Enum.RaycastFilterType.Include;
v3.FilterDescendantsInstances = { workspace.Map };

return function(p4) -- Line: 16
    -- upvalues: u1 (copy), u2 (copy), TweenService (copy), EffectsHandler (copy)
    local Origin = p4.Origin;
    local LookVector = p4.LookVector;
    local Radius = p4.Radius;
    local v5 = CFrame.new(Origin.Position, Origin.Position + LookVector) * CFrame.Angles(1.5707963267948966, 0, 0);

    if p4.Meshes ~= false then
        local v6 = u1.Gura.QuakeMeshes:Clone();
        v6:SetPrimaryPartCFrame(v5);
        v6.Parent = workspace.Effects;
        task.delay(3, v6.Destroy, v6);

        for _, child in v6:GetChildren() do
            local v7 = u2:NextNumber(0.55, 0.7);

            if child.Name == "Crack" or child.Name == "Shock" then
                v7 = v7 - u2:NextNumber(0.25, 0.3);
            elseif child.Name == "Wave" then
                v7 = v7 + u2:NextNumber(0.45, 0.55);
            end;

            local v8 = child.Position + LookVector * child.Size[(child.Name == "Wave" or child.Name == "Crack") and "Y" or "Z"] * 2.5;
            TweenService:Create(child, TweenInfo.new(v7 * 0.66, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Transparency = 1,
                Size = child.Size * Radius * 1.3,
                Position = v8
            }):Play();
        end;
    end;

    EffectsHandler.CallEffect("Emit Particle V3", {
        Origin = Origin * CFrame.new(0, -7, 0),
        Particle = u1.Gura.HeroicSlam
    });
    EffectsHandler.CallEffect("RockRipple", {
        RadiusIncrement = 8,
        Rocks = 19,
        Origin = Origin.Position,
        StartRadius = Radius / 2.5,
        EndRadius = Radius,
        Size = NumberRange.new(1.7, 2)
    });
    EffectsHandler.CallEffect("Randomized Ground Craters", {
        Lifetime = 2,
        SizeMultiplier = 1.35,
        Origin = Origin,
        Power = Radius
    });
end;
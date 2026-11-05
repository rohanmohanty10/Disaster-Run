  

 

local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };
local u2 = Random.new();

local function RandSign() -- Line: 11
    return math.random(1, 2) == 1 and -1 or 1;
end;

local TweenService = game:GetService("TweenService");

return function(p3) -- Line: 17
    -- upvalues: u2 (copy), u1 (copy), AssetHandler (copy), TweenService (copy), EffectsHandler (copy)
    local Roof = p3:FindFirstChild("Roof", true);

    if not Roof then
        return;
    end;

    local Position = Roof.Position;
    local v4 = u2:NextNumber(20, 42) * (math.random(1, 2) == 1 and -1 or 1);
    local v5 = u2:NextNumber(20, 42);
    local v6 = math.random(1, 2) == 1 and -1 or 1;
    local v7 = Position + Vector3.new(v4, 0, v5 * v6);
    local v8 = workspace:Raycast(v7, Vector3.new(0, -100, 0), u1);

    if v8 then
        local Position2 = v8.Position;
        local v9 = (Position + Position2) / 2 + Vector3.new(0, (Position2 - Position).Magnitude * 1.25, 0);
        local v10 = u2:NextNumber(0.9, 1.1);
        NumberRange.new(1, 3);
        NumberRange.new(-50, 50);
        NumberRange.new(40, 50);
        local v11 = AssetHandler.CloneAsset("Models/ExplodedRoof", {
            AbilityName = "Suna"
        });
        v11.CFrame = Roof.CFrame;
        v11.Parent = workspace.Effects;
        local v12 = v11.CFrame - v11.Position;
        local Angles = CFrame.Angles;
        local v13 = u2:NextNumber(135, 175);
        local v14 = math.random(1, 2) == 1 and -1 or 1;
        local v15 = math.rad(v13 * v14);
        local v16 = u2:NextNumber(135, 175);
        local v17 = math.random(1, 2) == 1 and -1 or 1;
        local v18 = math.rad(v16 * v17);
        local v19 = u2:NextNumber(135, 175);
        local v20 = math.random(1, 2) == 1 and -1 or 1;
        local v21 = v12 * Angles(v15, v18, (math.rad(v19 * v20)));

        for i = 1, 15 do
            local v22 = i / 15;
            local v23 = TweenService:Create(v11, TweenInfo.new(v10 / 15, Enum.EasingStyle.Linear), {
                CFrame = CFrame.new((1 - v22) ^ 2 * Position + 2 * (1 - v22) * v22 * v9 + v22 ^ 2 * Position2) * v12:Lerp(v21, i / 15)
            });
            v23:Play();
            v23.Completed:Wait();
        end;

        EffectsHandler.CallEffect("Emit Particle V3", {
            Path = "Particles/Misc/RoofSlam",
            AbilityName = "Suna",
            AutoSerialize = true,
            MaxRenderDistance = 300,
            PlaySounds = true,
            Origin = CFrame.new(v8.Position, v8.Position + v8.Normal) * CFrame.Angles(-1.5707963267948966, 0, 0)
        });
        EffectsHandler.CallEffect("Rock Debris", {
            Lifetime = 2.5,
            Size = Vector3.new(4, 4, 4),
            Radius = 14,
            Amount = 16,
            Origin = CFrame.new(v8.Position) * CFrame.new(0, 1, 0)
        });
        v11:Destroy();
    end;
end;
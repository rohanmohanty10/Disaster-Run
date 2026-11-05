  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Players");
local RunService = game:GetService("RunService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.Types);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local u1 = RaycastParams.new();
u1.IgnoreWater = true;
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };
u1.CollisionGroup = "Map";

function RaycastMap(p2, p3)
    -- upvalues: u1 (copy)
    return workspace:Raycast(p2, p3, u1);
end;

local u4 = Random.new();

return function(p5, p6, p7) -- Line: 33
    -- upvalues: Trove (copy), EffectsHandler (copy), u4 (copy), Fusion (copy), AssetHandler (copy), ParticleHandler (copy), RunService (copy)
    if not (p5 and p6) then
        return;
    end;

    local HumanoidRootPart = p5:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v8 = Trove.new();
    v8:AttachToInstance(p6);
    local v9 = p7.Offset or CFrame.new(0, 0, -4.5);
    local v10 = HumanoidRootPart.CFrame * v9;
    local v11 = RaycastMap(v10.Position, Vector3.new(0, 1, 0) * (-12 * p5:GetScale()));
    local v12 = v11 and v11.Position + Vector3.new(0, 0.05, 0) or (v10 * CFrame.new(0, -2.95, 0)).Position;
    local v13 = CFrame.new(v12) * CFrame.new(0, 0.5, 0);
    local CallEffects = EffectsHandler.CallEffects;
    local v14 = {};
    local v15 = {
        Name = "Flying Debris"
    };
    local v16 = {};
    local v17 = {
        Lifetime = 0.7,
        Collision = true,
        Size = 0.55,
        TweenDelay = 0.3,
        Inconsistent = true,
        Origin = v13,
        Amount = math.random(4, 5)
    };
    local v18 = u4:NextNumber(0.9, 1.4);
    v17.Force = Vector3.new(1, v18, 1) * 15;
    v17.Tween = {
        Transparency = 1,
        Size = Vector3.new(0, 0, 0)
    };
    v16[1] = v17;
    v15.Data = v16;
    v14[1], v14[2], v14[3] = v15, {
    Name = "Rock Debris",
    Data = {
        {
            Lifetime = 1,
            Radius = 3.5,
            Size = Vector3.new(0.9, 0.9, 0.9),
            Amount = 9,
            Origin = v13
        }
    }
}, {
    Name = "Emit Particle V3",
    Data = {
        {
            Path = "Particles/Crystalline Volley/ChunkSummon",
            AutoSerialize = true,
            Scale = 1.1,
            Origin = CFrame.new(v12),
            Character = p5
        }
    }
};
    CallEffects(v14);
    local u19 = Fusion.Value(0);
    local v20 = Fusion.Spring(u19, p7.Speed * 15, 0.4);
    local u21 = AssetHandler.CloneAsset("Models/Chunk", AssetHandler.GetAbilityData(p5));
    u21.Size = u21.Size * (p5:GetScale() * 0.9);
    ParticleHandler.ScaleParticle(u21, p5:GetScale() * 0.85);
    ParticleHandler.Unusualify(u21, {
        IncludeParts = true,
        Character = p5
    });
    local u22 = true;
    v8:Add(function() -- Line: 104
        -- upvalues: u22 (ref)
        u22 = false;
    end);
    u21.Position = v12 - Vector3.new(0, 1, 0) * (u21.Size.Y / 1.2);
    u21.Parent = workspace.Effects;
    u19:set((math.abs(v12.Y - HumanoidRootPart.Position.Y)));
    local v23 = Random.new():NextUnitVector();
    local v24 = 0;

    while u22 and (p5.Parent and p6.Parent) do
        v24 = v24 + RunService.Heartbeat:Wait() * 90;
        u21.CFrame = CFrame.new(v12) * CFrame.new(0, v20:get(), 0) * CFrame.Angles(math.rad(v24 * v23.X), math.rad(v24 * v23.Y), (math.rad(v24 * v23.Z)));
    end;

    task.defer(function() -- Line: 126
        -- upvalues: u21 (copy), u19 (ref)
        u21:Destroy();
        u19 = nil;
    end);
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Particles/Crystalline Volley/ChunkDestroy",
        AutoSerialize = true,
        Scale = 1,
        Origin = CFrame.lookAt(u21.Position, u21.Position + HumanoidRootPart.CFrame.LookVector) * CFrame.Angles(0, 1.5707963267948966, 0),
        Character = p5
    });
end;
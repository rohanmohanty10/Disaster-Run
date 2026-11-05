  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local u1 = Random.new();
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Include;
u2.FilterDescendantsInstances = { workspace.Map };

return function(p3) -- Line: 15
    -- upvalues: ParticleHandler (copy), AssetHandler (copy), EffectsHandler (copy), u1 (copy), TweenService (copy), u2 (copy)
    local u4 = p3 or {};
    local u5 = u4.HSVData or ParticleHandler.GetUnusualHSVData({
        Player = u4.Player or u4.AttackerPlayer,
        Character = u4.Character or u4.Attacker
    });
    local Origin = u4.Origin;
    local u6 = u4.Radius or 20;
    local u7 = u4.BubbleCount or 8;
    local u8 = AssetHandler.GetAbilityData(u4.Character or u4.Player);
    EffectsHandler.CallEffect("Emit Particle V3", {
        VFXForgeEmit = true,
        Path = "Particles/DeepDive/Explode",
        Origin = Origin,
        Player = u4.Player
    });
    EffectsHandler.CallEffect("Kars_Debris", {
        RockCount = 18,
        Lifetime = 1,
        ExpandTime = 0.05,
        TweenTime = 0.3,
        Origin = Origin * CFrame.new(0, 1, 0),
        Radius = u6
    });

    for i = 1, u7 do
        task.spawn(function() -- Line: 42
            -- upvalues: i (copy), u7 (copy), u1 (ref), u6 (copy), Origin (copy), AssetHandler (ref), u8 (copy), ParticleHandler (ref), u5 (copy), TweenService (ref), u2 (ref), EffectsHandler (ref), u4 (ref)
            local v9 = (i - 1) * (6.283185307179586 / u7) + u1:NextNumber(-0.3, 0.3);
            local v10 = u1:NextNumber(u6 * 0.3, u6 * 0.9);
            local Position = Origin.Position;
            local v11 = math.cos(v9) * v10;
            local v12 = math.sin(v9) * v10;
            local v13 = Position + Vector3.new(v11, 1, v12);
            local v14 = u1:NextNumber(0.7, 1);
            local v15 = AssetHandler.CloneAsset("Particles/DeepDive/Bubble", u8);
            v15.CFrame = CFrame.new(v13);
            v15.Parent = workspace.Effects;
            ParticleHandler.Unusualify(v15, {
                HSVData = u5
            });
            ParticleHandler.EnableAllParticles(v15, true);
            AssetHandler.ScaleAsset(v15, {
                Scale = v14
            });
            local v16 = u1:NextNumber(18, 32);
            local v17 = v10 * u1:NextNumber(1.4, 1.8);
            local Position2 = Origin.Position;
            local v18 = math.cos(v9) * v17;
            local v19 = math.sin(v9) * v17;
            local v20 = Position2 + Vector3.new(v18, 0, v19);
            local v21 = v13:Lerp(v20, 0.5) + Vector3.new(0, v16, 0);
            local v22 = TweenService:Create(v15, TweenInfo.new(u1:NextNumber(0.4, 0.6), Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                CFrame = CFrame.new(v21)
            });
            v22:Play();
            v22.Completed:Wait();
            local v23 = TweenService:Create(v15, TweenInfo.new(u1:NextNumber(0.5, 0.8), Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                CFrame = CFrame.new(v20)
            });
            v23:Play();
            v23.Completed:Wait();
            local v24 = workspace:Raycast(v20 + Vector3.new(0, 10, 0), Vector3.new(0, -30, 0), u2);

            if v24 then
                v20 = v24.Position;
            end;

            EffectsHandler.CallEffect("Emit Particle V3", {
                VFXForgeEmit = true,
                Path = "Particles/DeepDive/Pop",
                Origin = CFrame.new(v20),
                Player = u4.Player,
                Scale = v14
            });
            ParticleHandler.EnableAllParticles(v15, false);
            ParticleHandler.DestroyEmit(v15);
        end);
    end;
end;
  

 

local TweenService = game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
local u1 = Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p2) -- Line: 17
    -- upvalues: ParticleHandler (copy), AssetHandler (copy), EffectsHandler (copy), TweenService (copy), u1 (copy)
    local v3 = p2 or {};
    local Character = v3.Character;
    local Delay = v3.Delay;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local u4 = ParticleHandler.GetUnusualHSVData({
        Character = Character
    });
    AssetHandler.GetAbilityData(Character);
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Particles/Icebreaker/SlashParticles",
        AutoSerialize = true,
        AbilityName = "Hie",
        AttachTo = {
            Part = HumanoidRootPart,
            Offset = CFrame.identity
        },
        HSVShift = u4
    });
    local v5 = AssetHandler.CloneAsset("Particles/Icebreaker/BeamSlash", {
        AbilityName = "Hie"
    });
    v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0, -1) * CFrame.Angles(0, -60, -10);
    ParticleHandler.Unusualify(v5, {
        HSVData = u4
    });
    v5.Parent = workspace.Effects;
    task.delay(1, v5.Destroy, v5);
    TweenService:Create(v5, TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        CFrame = v5.CFrame * CFrame.Angles(0, 3.490658503988659, 0)
    }):Play();

    for _, descendant in v5:GetDescendants() do
        if descendant:IsA("Beam") then
            TweenService:Create(descendant, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Width0 = 0,
                Width1 = 0
            }):Play();
        end;
    end;

    task.delay(Delay, function() -- Line: 59
        -- upvalues: HumanoidRootPart (copy), u1 (ref), TweenService (ref), EffectsHandler (ref), u4 (copy)
        local v6 = RaycastParams.new();
        v6.FilterType = Enum.RaycastFilterType.Include;
        v6.FilterDescendantsInstances = { workspace.Map };
        local v7 = workspace:Raycast(HumanoidRootPart.Position, Vector3.new(0, -15, 0), v6);

        if v7 then
            for _ = 1, 6 do
                local v8 = NumberRange.new(0.45, 0.7);
                local Part = Instance.new("Part");
                local v9 = CFrame.new(v7.Position);
                local Angles = CFrame.Angles;
                local v10 = u1:NextNumber(-360, 360);
                local v11 = math.rad(v10);
                local v12 = u1:NextNumber(-360, 360);
                local v13 = math.rad(v12);
                local v14 = u1:NextNumber(-360, 360);
                Part.CFrame = v9 * Angles(v11, v13, (math.rad(v14)));
                local v15 = u1:NextNumber(v8.Min, v8.Max);
                local v16 = u1:NextNumber(v8.Min, v8.Max);
                Part.Size = Vector3.new(v15, v16, u1:NextNumber(v8.Min, v8.Max));
                Part.Anchored = false;
                Part.CanCollide = true;
                Part.CollisionGroup = "Ghosted";
                Part.BottomSurface = Enum.SurfaceType.Smooth;
                Part.TopSurface = Enum.SurfaceType.Smooth;
                Part.Color = v7.Instance.Color;
                Part.Material = v7.Material;
                Part.Transparency = 0;
                local v17 = u1:NextNumber(-180, 180);
                local v18 = u1:NextNumber(-180, 180);
                Part.Orientation = Vector3.new(v17, v18, u1:NextNumber(-180, 180));
                Part.Parent = workspace.Effects;
                local v19 = Part.Size.Magnitude / 2;

                for _, child in pairs(v7.Instance:GetChildren()) do
                    if child:IsA("Decal") or child:IsA("Texture") then
                        child:Clone().Parent = Part;
                    end;
                end;

                for _, descendant in Part:GetDescendants() do
                    if descendant:IsA("Attachment") then
                        descendant.Position = Vector3.new(descendant.Position.X, descendant.Position.Y * v19, descendant.Position.Z);
                    end;
                end;

                local Attachment = Instance.new("Attachment");
                Attachment.Parent = Part;
                local LinearVelocity = Instance.new("LinearVelocity");
                LinearVelocity.MaxForce = (1 / 0);
                LinearVelocity.VectorVelocity = 50 * (HumanoidRootPart.CFrame.LookVector * u1:NextNumber(0.2, 0.5) + HumanoidRootPart.CFrame.RightVector * u1:NextNumber(-0.25, 0.25) + HumanoidRootPart.CFrame.UpVector * u1:NextNumber(0.2, 0.4));
                LinearVelocity.Attachment0 = Attachment;
                LinearVelocity.Parent = Attachment;
                task.delay(u1:NextNumber(0.8, 1.4), function() -- Line: 108
                    -- upvalues: TweenService (ref), Part (copy), u1 (ref)
                    local v20 = TweenService:Create(Part, TweenInfo.new(u1:NextNumber(1, 2)), {
                        Size = Vector3.new(0, 0, 0)
                    });
                    v20:Play();
                    v20.Completed:Connect(function() -- Line: 115
                        -- upvalues: Part (ref)
                        Part:Destroy();
                    end);
                end);
                task.delay(0.1, LinearVelocity.Destroy, LinearVelocity);
            end;
        end;

        EffectsHandler.CallEffect("Emit Particle V3", {
            Path = "Particles/Icebreaker/Impact",
            AutoSerialize = true,
            AbilityName = "Hie",
            Origin = HumanoidRootPart,
            HSVShift = u4
        });
    end);
end;
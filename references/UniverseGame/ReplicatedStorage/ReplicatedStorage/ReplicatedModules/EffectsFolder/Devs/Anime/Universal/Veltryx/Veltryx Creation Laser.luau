  

 

local TweenService = game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
local u1 = Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Include;
u2.FilterDescendantsInstances = { workspace.Map };

return function(p3) -- Line: 20
    -- upvalues: ParticleHandler (copy), AssetHandler (copy), u1 (copy), EffectsHandler (copy), u2 (copy), TweenService (copy)
    local v4 = p3 or {};
    local Model = v4.Model;
    local Impact = v4.Impact;
    local Character = v4.Character;

    if not (Model and Character) then
        return;
    end;

    local u5 = ParticleHandler.GetUnusualHSVData({
        Character = Character
    });
    local Attachment = Instance.new("Attachment");
    Attachment.Position = Vector3.new(0, -1, 0);
    Attachment.Parent = Model["Left Arm"];
    local u6;

    if Impact then
        u6 = Impact:FindFirstChildOfClass("Attachment");
    else
        u6 = Impact;
    end;

    local v7 = AssetHandler.GetAbilityData(Character);
    local v8 = AssetHandler.CloneAsset("Particles/Creation/Lightning", v7);
    ParticleHandler.Unusualify(v8, {
        Character = Character
    });
    v8.Parent = workspace.Effects;
    local v9 = AssetHandler.CloneAsset("Particles/Creation/Firing", v7);
    ParticleHandler.Unusualify(v9, {
        Character = Character
    });
    v9.CFrame = CFrame.new(Attachment.WorldPosition, Impact.Position);
    v9.Parent = workspace.Effects;
    local v10 = os.clock();

    while Model:IsDescendantOf(game) and (Impact:IsDescendantOf(game) and Impact:GetAttribute("Active")) do
        local Magnitude = (Impact.Position - Model.PrimaryPart.Position).Magnitude;
        local v11 = Model.PrimaryPart.Position:Lerp(Impact.Position, 0.5);
        v8.Size = Vector3.new(v8.Size.X, v8.Size.Y, Magnitude);
        v8.CFrame = CFrame.new(v11, Impact.Position);
        v9.CFrame = CFrame.new(Attachment.WorldPosition, Impact.Position);
        task.spawn(function() -- Line: 59
            -- upvalues: u1 (ref), ParticleHandler (ref), u5 (copy), Magnitude (copy), EffectsHandler (ref), Attachment (copy), u6 (copy)
            local v12 = u1:NextNumber(3, 6);
            local v13 = u1:NextNumber(0, 6);
            local v14 = math.random(1, 3) == 1 and 0 or v13;
            local v15 = u1:NextNumber(8, 10);
            local v16 = u1:NextNumber(1.3, 1.6);
            local v17 = { u1:NextNumber(-5, 5), u1:NextNumber(-5, 5) };
            local v18 = ParticleHandler.TryHSVShift(ColorSequence.new(Color3.fromRGB(105, 141, 192)), u5);
            local v19 = math.ceil(Magnitude * 0.25);
            local v20 = u1:NextNumber(0.05, 0.2) * 4;
            local v21 = EffectsHandler.CallEffect("Generate Quasiduck Lightning", nil, {
                Color = v18,
                Curves = v17,
                Speed = v15,
                Length = v16,
                A1 = Attachment,
                A2 = u6,
                Size = v20,
                PartCount = v19
            });
            v21.Frequency = math.random(3, 10);
            v21.MinRadius = 0.8;
            v21.MaxRadius = v12;
            v21.AnimationSpeed = v14;
            v21.MinThicknessMultiplier = 0.95;
            v21.MaxThicknessMultiplier = 1;
        end);
        local u22 = workspace:Raycast(Model.PrimaryPart.Position, (Impact.Position - Model.PrimaryPart.Position).Unit * Magnitude * 1.1, u2);
        Impact.Trail.Enabled = u22 ~= nil;

        if os.clock() - v10 >= 0.08 and u22 then
            v10 = os.clock();
            task.spawn(function() -- Line: 101
                -- upvalues: Impact (copy), u1 (ref), u22 (copy), TweenService (ref)
                local v23 = NumberRange.new(0.7, 1.6);
                local v24 = NumberRange.new(-23, 23);
                local v25 = NumberRange.new(20, 33);
                local Part = Instance.new("Part");
                local CFrame2 = Impact.CFrame;
                local Angles = CFrame.Angles;
                local v26 = u1:NextNumber(-360, 360);
                local v27 = math.rad(v26);
                local v28 = u1:NextNumber(-360, 360);
                local v29 = math.rad(v28);
                local v30 = u1:NextNumber(-360, 360);
                Part.CFrame = CFrame2 * Angles(v27, v29, (math.rad(v30)));
                local v31 = u1:NextNumber(v23.Min, v23.Max);
                local v32 = u1:NextNumber(v23.Min, v23.Max);
                Part.Size = Vector3.new(v31, v32, u1:NextNumber(v23.Min, v23.Max));
                Part.Anchored = false;
                Part.CanCollide = true;
                Part.CollisionGroup = "Ghosted";
                Part.BottomSurface = Enum.SurfaceType.Smooth;
                Part.TopSurface = Enum.SurfaceType.Smooth;
                Part.Color = u22.Instance.Color;
                Part.Material = u22.Material;
                Part.Transparency = 0;
                local v33 = u1:NextNumber(-180, 180);
                local v34 = u1:NextNumber(-180, 180);
                Part.Orientation = Vector3.new(v33, v34, u1:NextNumber(-180, 180));
                Part.Parent = workspace.Effects;
                local v35 = Part.Size.Magnitude / 2;

                for _, child in pairs(u22.Instance:GetChildren()) do
                    if child:IsA("Decal") or child:IsA("Texture") then
                        child:Clone().Parent = Part;
                    end;
                end;

                for _, descendant in Part:GetDescendants() do
                    if descendant:IsA("Attachment") then
                        descendant.Position = Vector3.new(descendant.Position.X, descendant.Position.Y * v35, descendant.Position.Z);
                    end;
                end;

                local Attachment2 = Instance.new("Attachment");
                Attachment2.Parent = Part;
                local LinearVelocity = Instance.new("LinearVelocity");
                LinearVelocity.MaxForce = (1 / 0);
                local v36 = u1:NextNumber(v24.Min, v24.Max);
                local v37 = u1:NextNumber(v25.Min, v25.Max);
                LinearVelocity.VectorVelocity = Vector3.new(v36, v37, u1:NextNumber(v24.Min, v24.Max));
                LinearVelocity.Attachment0 = Attachment2;
                LinearVelocity.Parent = Attachment2;
                task.delay(u1:NextNumber(0.8, 1.4), function() -- Line: 145
                    -- upvalues: TweenService (ref), Part (copy), u1 (ref)
                    local v38 = TweenService:Create(Part, TweenInfo.new(u1:NextNumber(1, 2)), {
                        Size = Vector3.new(0, 0, 0)
                    });
                    v38:Play();
                    v38.Completed:Connect(function() -- Line: 152
                        -- upvalues: Part (ref)
                        Part:Destroy();
                    end);
                end);
                task.delay(0.1, LinearVelocity.Destroy, LinearVelocity);
            end);
        end;

        EffectsHandler.Wait(0.04);
    end;

    ParticleHandler.EnableAllParticles(v8, false);
    ParticleHandler.DestroyEmit(v8);
    ParticleHandler.EnableAllParticles(v9, false);
    ParticleHandler.DestroyEmit(v9);
end;
  

 

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
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), u2 (copy), u1 (copy), TweenService (copy), EffectsHandler (copy)
    local v4 = p3 or {};
    local Model = v4.Model;
    local Impact = v4.Impact;
    local Character = v4.Character;

    if not (Model and Character) then
        return;
    end;

    local v5 = AssetHandler.GetAbilityData(Character);
    local v6 = v4.HSVData or ParticleHandler.GetUnusualHSVData({
        Player = v4.Player,
        Character = Character
    });
    local v7 = os.clock();
    local v8 = os.clock();
    local v9 = false;

    while Model:IsDescendantOf(game) and (Impact:IsDescendantOf(game) and Impact:GetAttribute("Active")) do
        local Magnitude = (Impact.Position - Model.PrimaryPart.Position).Magnitude;
        Model.PrimaryPart.Position:Lerp(Impact.Position, 0.5);
        local u10 = workspace:Raycast(Model.PrimaryPart.Position, (Impact.Position - Model.PrimaryPart.Position).Unit * Magnitude * 1.1, u2);
        Impact.Hit.Trail.Enabled = u10 ~= nil;

        if os.clock() - v7 >= 0.08 and u10 then
            v7 = os.clock();
            task.spawn(function() -- Line: 47
                -- upvalues: Impact (copy), u1 (ref), u10 (copy), TweenService (ref)
                local v11 = NumberRange.new(0.7, 1.6);
                local v12 = NumberRange.new(-23, 23);
                local v13 = NumberRange.new(20, 33);
                local Part = Instance.new("Part");
                local CFrame2 = Impact.CFrame;
                local Angles = CFrame.Angles;
                local v14 = u1:NextNumber(-360, 360);
                local v15 = math.rad(v14);
                local v16 = u1:NextNumber(-360, 360);
                local v17 = math.rad(v16);
                local v18 = u1:NextNumber(-360, 360);
                Part.CFrame = CFrame2 * Angles(v15, v17, (math.rad(v18)));
                local v19 = u1:NextNumber(v11.Min, v11.Max);
                local v20 = u1:NextNumber(v11.Min, v11.Max);
                Part.Size = Vector3.new(v19, v20, u1:NextNumber(v11.Min, v11.Max));
                Part.Anchored = false;
                Part.CanCollide = true;
                Part.CollisionGroup = "Ghosted";
                Part.BottomSurface = Enum.SurfaceType.Smooth;
                Part.TopSurface = Enum.SurfaceType.Smooth;
                Part.Color = u10.Instance.Color;
                Part.Material = u10.Material;
                Part.Transparency = 0;
                local v21 = u1:NextNumber(-180, 180);
                local v22 = u1:NextNumber(-180, 180);
                Part.Orientation = Vector3.new(v21, v22, u1:NextNumber(-180, 180));
                Part.Parent = workspace.Effects;
                local v23 = Part.Size.Magnitude / 2;

                for _, child in pairs(u10.Instance:GetChildren()) do
                    if child:IsA("Decal") or child:IsA("Texture") then
                        child:Clone().Parent = Part;
                    end;
                end;

                for _, descendant in Part:GetDescendants() do
                    if descendant:IsA("Attachment") then
                        descendant.Position = Vector3.new(descendant.Position.X, descendant.Position.Y * v23, descendant.Position.Z);
                    end;
                end;

                local Attachment = Instance.new("Attachment");
                Attachment.Parent = Part;
                local LinearVelocity = Instance.new("LinearVelocity");
                LinearVelocity.MaxForce = (1 / 0);
                local v24 = u1:NextNumber(v12.Min, v12.Max);
                local v25 = u1:NextNumber(v13.Min, v13.Max);
                LinearVelocity.VectorVelocity = Vector3.new(v24, v25, u1:NextNumber(v12.Min, v12.Max));
                LinearVelocity.Attachment0 = Attachment;
                LinearVelocity.Parent = Attachment;
                task.delay(u1:NextNumber(0.8, 1.4), function() -- Line: 91
                    -- upvalues: TweenService (ref), Part (copy), u1 (ref)
                    local v26 = TweenService:Create(Part, TweenInfo.new(u1:NextNumber(1, 2)), {
                        Size = Vector3.new(0, 0, 0)
                    });
                    v26:Play();
                    v26.Completed:Connect(function() -- Line: 98
                        -- upvalues: Part (ref)
                        Part:Destroy();
                    end);
                end);
                task.delay(0.1, LinearVelocity.Destroy, LinearVelocity);
            end);
        end;

        if os.clock() - v8 > 0.045 then
            v8 = os.clock();
            v9 = not v9;
            local Position = Model.PrimaryPart.Position;
            local Position2 = Impact.Position;
            local u27 = Position2 - Position;
            local Magnitude2 = u27.Magnitude;

            if Magnitude2 > 0.1 then
                local Unit = u27.Unit;
                local Unit2 = Unit:Cross(math.abs(Unit.Y) > 0.99 and Vector3.new(1, 0, 0) or Vector3.new(0, 1, 0)).Unit;
                local Unit3 = Unit2:Cross(Unit).Unit;
                local u28 = AssetHandler.CloneAsset("Particles/ScorchedEarth/Trail", v5);
                ParticleHandler.Unusualify(u28, {
                    HSVData = v6
                });
                u28.Parent = workspace.Effects;
                local u29 = math.clamp(Magnitude2 / 5, 6, 14);
                local u30 = math.random(5, 20) / 5;
                local u31 = math.random() * 3.141592653589793 * 2;
                local u32 = v9 and 1 or -1;
                local u33 = os.clock();
                task.spawn(function() -- Line: 134
                    -- upvalues: u33 (copy), Position (copy), u27 (copy), u29 (copy), u31 (copy), u32 (copy), u30 (copy), u28 (copy), Unit2 (copy), Unit3 (copy), Position2 (copy), ParticleHandler (ref)
                    while true do
                        local v34 = (os.clock() - u33) / 0.15;

                        if v34 >= 1 then
                            break;
                        end;

                        local v35 = (v34 * u29 + u31) * u32;
                        local v36 = math.sin(v34 * 3.141592653589793);
                        local v37 = math.cos(v35) * u30 * v36;
                        local v38 = math.sin(v35) * u30 * v36;
                        u28.CFrame = CFrame.new(Position + u27 * v34 + Unit2 * v37 + Unit3 * v38);
                        task.wait();
                    end;

                    u28.CFrame = CFrame.new(Position2);
                    ParticleHandler.EnableAllParticles(u28, false);
                    task.delay(1, u28.Destroy, u28);
                end);
            end;
        end;

        EffectsHandler.Wait(0.04);
    end;
end;
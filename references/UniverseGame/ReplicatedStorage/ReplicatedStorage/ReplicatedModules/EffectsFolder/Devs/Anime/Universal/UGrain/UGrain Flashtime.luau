  

 

local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local _ = Players.LocalPlayer;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
local u1 = Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.FXHandler);
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Include;
u2.FilterDescendantsInstances = { workspace.Map };
local u3 = {
    Default = Color3.fromRGB(24, 116, 255),
    ["Reverse Flash"] = Color3.fromRGB(172, 12, 12),
    ["CW Flash"] = Color3.fromRGB(221, 147, 81),
    ["Injustice Flash"] = Color3.fromRGB(234, 201, 15)
};

return function(p4) -- Line: 33
    -- upvalues: ParticleHandler (copy), Trove (copy), AssetHandler (copy), u3 (copy), u1 (copy), RunService (copy), TweenService (copy), u2 (copy), EffectsHandler (copy)
    local v5 = p4 or {};
    local Character = v5.Character;
    local Attribute = v5.Attribute;
    local u6 = v5.HSVData or ParticleHandler.GetUnusualHSVData({
        Player = v5.Player,
        Character = Character
    });
    local u7 = Trove.new();
    u7:AttachToInstance(Character);
    u7:Connect(Character:GetAttributeChangedSignal(Attribute), function() -- Line: 44
        -- upvalues: Character (copy), Attribute (copy), u7 (copy)
        if not Character:GetAttribute(Attribute) then
            u7:Destroy();
        end;
    end);
    local u8 = AssetHandler.GetAbilityData(Character);
    local u9 = AssetHandler.CloneAsset("Particles/Flashtime/Trails", u8);
    ParticleHandler.Unusualify(u9, {
        HSVData = u6
    });
    u9.Parent = workspace.Effects;

    for _, child in u9:GetChildren() do
        ParticleHandler.AttachTo(child, {
            Part = Character[child.Name]
        });
    end;

    u7:Add(function() -- Line: 62
        -- upvalues: ParticleHandler (ref), u9 (copy)
        ParticleHandler.DestroyEmit(u9);
        ParticleHandler.EnableAllParticles(u9, false);
    end);
    local u10 = ParticleHandler.TryHSVShift(u3[v5.SkinName or "Default"] or u3.Default, u6);
    local u11 = NumberRange.new(5, 12);
    local Position = Character.Torso.Position;
    local u12 = os.clock();
    local u13 = os.clock();
    local u14 = {};

    for _, descendant in AssetHandler.GetAsset("Particles/Flashtime/Crack", u8):GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            table.insert(u14, descendant);
        end;
    end;

    local u15 = {};

    local function RetireOrbit(p16) -- Line: 102
        for _, descendant in p16.Object:GetDescendants() do
            if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                descendant.Enabled = false;
            end;
        end;

        task.delay(2, p16.Object.Destroy, p16.Object);
    end;

    local function SpawnOrbit(p17) -- Line: 112
        -- upvalues: AssetHandler (ref), u8 (copy), ParticleHandler (ref), u6 (copy), u1 (ref), Character (copy), u15 (copy)
        local v18 = AssetHandler.CloneAsset("Particles/Flashtime/Orbit", u8);
        ParticleHandler.Unusualify(v18, {
            HSVData = u6
        });

        for _, descendant in v18:GetDescendants() do
            if descendant:IsA("ParticleEmitter") then
                descendant.Enabled = true;
            elseif descendant:IsA("Trail") then
                descendant.Enabled = true;
                descendant.Lifetime = u1:NextNumber(0.2, 1);
            end;
        end;

        local CFrame2 = Character.HumanoidRootPart.CFrame;
        local v19 = CFrame.new(u1:NextNumber(-10, 10), u1:NextNumber(-10, 10), u1:NextNumber(-10, 10));
        v18.CFrame = CFrame2 * v19;
        v18.Parent = workspace.Effects;
        local v20 = {
            Object = v18,
            Angle = u1:NextNumber(0, 360),
            Radius = u1:NextNumber(1, 10),
            Special = v19,
            Noise = u1:NextNumber(0, 1000),
            Origin = CFrame2,
            Expiry = os.clock() + (p17 or u1:NextNumber(2.4000000000000004, 3.5999999999999996))
        };
        table.insert(u15, v20);
    end;

    SpawnOrbit(0.375);
    SpawnOrbit(0.75);
    SpawnOrbit(1.125);
    SpawnOrbit(1.5);
    SpawnOrbit(1.875);
    SpawnOrbit(2.25);
    SpawnOrbit(2.625);
    SpawnOrbit(3);
    u7:Add(function() -- Line: 146
        -- upvalues: u15 (copy), RetireOrbit (copy)
        for _, v in u15 do
            RetireOrbit(v);
        end;
    end);
    u7:Connect(RunService.RenderStepped, function(p21) -- Line: 152
        -- upvalues: Position (ref), Character (copy), AssetHandler (ref), u8 (copy), ParticleHandler (ref), u6 (copy), TweenService (ref), u12 (ref), u2 (ref), u1 (ref), u11 (copy), u10 (copy), u14 (copy), EffectsHandler (ref), u13 (ref), u15 (copy), RetireOrbit (copy), SpawnOrbit (copy)
        if (Position - Character.Torso.Position).Magnitude > 3.5 and not Character:GetAttribute("NoAfterimages") then
            Position = Character.Torso.Position;
            local v22 = AssetHandler.CloneAsset("Particles/Flashtime/Afterimage", u8);
            ParticleHandler.Unusualify(v22, {
                IncludeParts = true,
                HSVData = u6
            });
            v22.Parent = workspace.Effects;
            task.delay(1.15, v22.Destroy, v22);

            for _, child in v22:GetChildren() do
                child.CFrame = Character[child.Name].CFrame;
                TweenService:Create(child, TweenInfo.new(1.15, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
            end;
        end;

        local v23 = os.clock();

        if v23 - u12 >= 0.25 then
            u12 = v23;
            local v24 = workspace:Raycast(Character.HumanoidRootPart.Position, Vector3.new(0, -10000, 0), u2);

            if v24 and (Character.HumanoidRootPart.Position - v24.Position).Magnitude <= 6 then
                local v25 = CFrame.new(v24.Position, v24.Position - v24.Normal) * CFrame.Angles(1.5707963267948966, 0, 0);
                local v26 = u1:NextNumber(0, 360);

                for i = 1, 1 do
                    local Angles = CFrame.Angles;
                    local v27 = v26 + (i - 1) * 360 + u1:NextNumber(-15, 15);
                    local u28 = v25 * Angles(0, math.rad(v27), 0);
                    task.spawn(function() -- Line: 201
                        -- upvalues: u28 (copy), u1 (ref), u11 (ref), u2 (ref), u10 (ref), u14 (ref), TweenService (ref), EffectsHandler (ref)
                        local v29 = u28;

                        for i2 = 1, 4 do
                            local Angles2 = CFrame.Angles;
                            local v30 = u1:NextNumber(-70, 70);
                            local v31 = v29 * Angles2(0, math.rad(v30), 0) * CFrame.new(0, 0, -u1:NextNumber(u11.Min, u11.Max));
                            local v32 = workspace:Raycast(v31.Position + Vector3.new(0, 5, 0), Vector3.new(0, -1000, 0), u2);

                            if not v32 then
                                break;
                            end;

                            local v33 = CFrame.new(0, (v32.Position - v31.Position).Y, 0) * v31;
                            local Magnitude = (v29.Position - v32.Position).Magnitude;
                            local Part = Instance.new("Part");
                            Part.Anchored = true;
                            Part.CanCollide = false;
                            Part.CanQuery = false;
                            Part.CastShadow = false;
                            Part.Material = Enum.Material.Neon;
                            Part.Color = u10;
                            Part.Transparency = 1;
                            Part.Size = Vector3.new(0.2, 0.3, Magnitude + 0.3);
                            Part.CFrame = CFrame.new(v29.Position, v32.Position) * CFrame.new(0, 0, -Magnitude / 2);
                            local SpecialMesh = Instance.new("SpecialMesh");
                            SpecialMesh.MeshType = Enum.MeshType.Sphere;
                            SpecialMesh.Parent = Part;
                            local Attachment = Instance.new("Attachment");
                            Attachment.Position = Vector3.new(0, 0, Part.Size.Z / 2);
                            Attachment.Parent = Part;
                            local Attachment2 = Instance.new("Attachment");
                            Attachment2.Position = Vector3.new(0, 0, -Part.Size.Z / 2);
                            Attachment2.Parent = Part;
                            local Attachment3 = Instance.new("Attachment");
                            Attachment3.Position = Vector3.new(0, 3, 0);
                            Attachment3.Parent = Part;
                            local Beam = Instance.new("Beam");
                            Beam.Attachment0 = Attachment;
                            Beam.Attachment1 = Attachment2;
                            Beam.Color = ColorSequence.new(u10);
                            Beam.Texture = "rbxassetid://3517446796";
                            Beam.TextureSpeed = 1;
                            Beam.TextureLength = 0.2;
                            Beam.LightEmission = 0.3;
                            Beam.LightInfluence = 0.3;
                            Beam.Transparency = NumberSequence.new(0);
                            Beam.Width0 = 0;
                            Beam.Width1 = 0;
                            Beam.Parent = Part;
                            local PointLight = Instance.new("PointLight");
                            PointLight.Color = u10;
                            PointLight.Shadows = false;
                            PointLight.Range = Part.Size.Z * 1.5;
                            PointLight.Brightness = 0;
                            PointLight.Parent = Attachment3;
                            Part.Parent = workspace.Effects;

                            for _, v in u14 do
                                local v34 = v:Clone();
                                v34.Color = ColorSequence.new(u10);
                                v34.Parent = Part;
                                v34:Emit(math.random(1, 2));
                            end;

                            TweenService:Create(Beam, TweenInfo.new(0.15, Enum.EasingStyle.Circular, Enum.EasingDirection.Out, 0, true), {
                                Width0 = 3
                            }):Play();

                            if i2 ~= 4 then
                                TweenService:Create(Beam, TweenInfo.new(0.25, Enum.EasingStyle.Circular, Enum.EasingDirection.Out, 0, true, 0.035), {
                                    Width1 = 3
                                }):Play();
                            end;

                            TweenService:Create(Part, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, 0, false, 0.3), {
                                Transparency = 1
                            }):Play();
                            TweenService:Create(PointLight, TweenInfo.new(0.45, Enum.EasingStyle.Circular, Enum.EasingDirection.Out, 0, true), {
                                Brightness = 0.3
                            }):Play();
                            task.delay(1.5, Part.Destroy, Part);
                            EffectsHandler.Wait(0.04);
                            v29 = v33;
                        end;
                    end);
                end;
            end;
        end;

        if v23 - u13 >= 0.8 then
            u13 = v23;
            local v35 = workspace:Raycast(Character.HumanoidRootPart.Position, Vector3.new(0, -10000, 0), u2);

            if v35 and (Character.HumanoidRootPart.Position - v35.Position).Magnitude <= 6 then
                local v36 = u1:NextNumber(0.2, 1);
                local v37 = u1:NextNumber(20, 95) / 2;
                local v38 = TweenInfo.new(v36, Enum.EasingStyle.Circular, Enum.EasingDirection.Out);
                local v39 = CFrame.new(v35.Position, v35.Position - v35.Normal) * CFrame.Angles(1.5707963267948966, 0, 0);
                local Part = Instance.new("Part");
                Part.Anchored = true;
                Part.CanCollide = false;
                Part.CanQuery = false;
                Part.CastShadow = false;
                Part.Massless = true;
                Part.Locked = true;
                Part.Transparency = 1;
                Part.Size = Vector3.new(0, 0, 0);
                local Angles = CFrame.Angles;
                local v40 = u1:NextNumber(0, 360);
                Part.CFrame = v39 * Angles(0, math.rad(v40), 0);
                local Attachment = Instance.new("Attachment");
                Attachment.Parent = Part;
                local Attachment2 = Instance.new("Attachment");
                Attachment2.Parent = Part;
                local v41 = {};

                for i = 1, 2 do
                    local v42 = i == 1 and 1 or -1;
                    local Beam = Instance.new("Beam");
                    Beam.Attachment0 = Attachment;
                    Beam.Attachment1 = Attachment2;
                    Beam.FaceCamera = true;
                    Beam.Segments = 2;
                    Beam.LightInfluence = 0;
                    Beam.LightEmission = 1;
                    Beam.Texture = "rbxassetid://3517446796";
                    Beam.Color = ColorSequence.new(u10);
                    Beam.Transparency = NumberSequence.new(0);
                    Beam.Width0 = 2;
                    Beam.Width1 = 2;
                    Beam.Parent = Part;
                    v41[i] = Beam;
                    TweenService:Create(Beam, v38, {
                        CurveSize0 = v42 * v37 / 0.74906367041199,
                        CurveSize1 = -v42 * v37 / 0.74906367041199
                    }):Play();
                    EffectsHandler.CallEffect("FadeBeams", Beam, {
                        Time = v36
                    });
                end;

                Part.Parent = workspace.Effects;
                TweenService:Create(Attachment, v38, {
                    Position = Vector3.new(0, 0, v37)
                }):Play();
                TweenService:Create(Attachment2, v38, {
                    Position = Vector3.new(0, 0, -v37)
                }):Play();
                local v43 = {};
                local Angles2 = CFrame.Angles;
                local v44 = u1:NextNumber(0, 360);
                v43.CFrame = v39 * Angles2(0, math.rad(v44), 0);
                TweenService:Create(Part, v38, v43):Play();
                task.delay(v36, Part.Destroy, Part);
            end;
        end;

        for i = #u15, 1, -1 do
            local v45 = u15[i];

            if v45.Expiry <= v23 then
                RetireOrbit(v45);
                table.remove(u15, i);
                SpawnOrbit();
            else
                v45.Angle = v45.Angle + 3 * p21 * 60;
                v45.Noise = v45.Noise + p21;
                local v46 = math.rad(v45.Angle);
                local v47 = math.sin(v46);
                local v48 = -math.cos(v46);
                local v49 = math.noise(v45.Noise, 0, 0);
                local v50 = math.noise(0, v45.Noise, 0);
                local v51 = Vector3.new(v49, v50, math.noise(0, 0, v45.Noise)) * 3;
                local v52 = v45.Origin * CFrame.new(v47 * v45.Radius, 0, v48 * v45.Radius) * CFrame.Angles(v47, v47, v48) * CFrame.new(v51) * v45.Special;
                v45.Object.CFrame = v45.Object.CFrame:Lerp(v52, 0.2);
            end;
        end;
    end);
end;
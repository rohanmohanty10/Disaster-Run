  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };
local u2 = Random.new();
local u3 = {
    Default = Color3.new(0.466667, 0.533333, 0.960784),
    ["Pre Timeskip"] = Color3.new(0.835294, 0.45098, 0.239216)
};

return function(u4) -- Line: 21
    -- upvalues: EffectsHandler (copy), ParticleHandler (copy), AssetHandler (copy), TweenService (copy), u1 (copy), u2 (copy), u3 (copy)
    local Origin = u4.Origin;
    local Distance = u4.Distance;
    local Duration = u4.Duration;
    local Final = u4.Final;
    local SlashOrientation = u4.SlashOrientation;
    local Sound = u4.Sound;
    local SkinName = u4.SkinName;
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Particles/SurgicalSlash/Release",
        AbilityName = "Ope",
        Character = u4.Character,
        Origin = Origin * CFrame.new(0, 0, -2) * CFrame.Angles(0, 0, 3.141592653589793),
        SkinName = SkinName,
        Scale = Final and 1.25 or 1
    });
    local v5 = ParticleHandler.GetUnusualHSVData({
        Character = u4.Character
    });
    local u6 = AssetHandler.GetAsset("Particles/SurgicalSlash/Slash", {
        AbilityName = "Ope",
        SkinName = SkinName
    }):Clone();
    ParticleHandler.Unusualify(u6, {
        IncludeParts = true,
        HSVData = v5
    });
    local Angles = CFrame.Angles;
    local v7;

    if Final then
        v7 = 0;
    else
        local v8 = math.random(45, 75) * SlashOrientation;
        v7 = math.rad(v8);
    end;

    u6.CFrame = Origin * Angles(0, 0, v7);
    u6.Parent = workspace.Effects;
    task.delay(ParticleHandler.GetMaxLifetime(u6) + Duration, u6.Destroy, u6);
    TweenService:Create(u6, TweenInfo.new(Duration, Enum.EasingStyle.Linear), {
        CFrame = u6.CFrame * CFrame.new(0, 0, -Distance)
    }):Play();
    task.delay(Duration * 0.8, function() -- Line: 52
        -- upvalues: TweenService (ref), u6 (copy), Duration (copy)
        TweenService:Create(u6.Crescent, TweenInfo.new(Duration * 0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Transparency = 1
        }):Play();

        for _, descendant in u6:GetDescendants() do
            if descendant:IsA("Trail") or (descendant:IsA("ParticleEmitter") or descendant:IsA("Beam")) then
                descendant.Enabled = false;
            end;
        end;
    end);

    if Sound then
        Sound:Clone().Parent = u6;
        u6:FindFirstChildOfClass("Sound"):Play();
    end;

    if Final then
        AssetHandler.ScaleAsset(u6, {
            Scale = 1.35
        });
        EffectsHandler.CallEffect("Emit Particle V3", {
            Path = "Particles/SurgicalSlash/CharacterSlash",
            AbilityName = "Ope",
            Character = u4.Character,
            Origin = Origin * CFrame.new(0, -3.5, 0),
            SkinName = SkinName
        });
        local v9 = AssetHandler.GetAsset("Particles/SurgicalSlash/GroundTrail", {
            AbilityName = "Ope",
            SkinName = SkinName
        }):Clone();
        ParticleHandler.Unusualify(v9, {
            HSVData = v5
        });
        v9.CFrame = Origin * CFrame.new(0, -5, 0);
        v9.Parent = workspace.Effects;
        task.delay(Duration + 2.5, v9.Destroy, v9);
        local v10 = u6.Crescent[tostring(math.random(2, 3))];
        local v11 = os.clock();
        local v12 = os.clock();
        local v13 = os.clock();

        while u6:IsDescendantOf(game) and (v9:IsDescendantOf(game) and os.clock() - v11 < Duration) do
            local v14 = workspace:Raycast(u6.Position + Vector3.new(0, 10, 0), Vector3.new(0, -27, 0), u1);

            if v14 then
                v9.CFrame = CFrame.new(v14.Position, v14.Position + Origin.LookVector) * CFrame.new(0, 0.25, 0);

                if os.clock() - v12 >= 0.01 then
                    v12 = os.clock();
                    local Instance2 = v14.Instance;
                    local v15 = math.random(-360, 360);
                    local Part = Instance.new("Part");
                    Part.Parent = workspace.Effects;
                    Part.Anchored = true;
                    Part.CanCollide = false;
                    Part.CanTouch = false;
                    Part.Material = v14.Material;
                    Part.Color = Instance2.Color;
                    Part.CFrame = CFrame.new(v14.Position) * CFrame.new(u2:NextNumber(-2, 2), 0, u2:NextNumber(-1.5, 1.5)) * CFrame.Angles(v15, v15, v15);
                    Part.Size = Vector3.new(1, 1, 1) * u2:NextNumber(1, 2);
                    Part.BottomSurface = Enum.SurfaceType.Smooth;
                    Part.TopSurface = Enum.SurfaceType.Smooth;

                    for _, child in pairs(Instance2:GetChildren()) do
                        if child:IsA("Decal") or child:IsA("Texture") then
                            child:Clone().Parent = Part;
                        end;
                    end;

                    local u16 = {
                        Size = Vector3.new(0, 0, 0),
                        Position = Part.Position + Vector3.new(0, -Part.Size.Magnitude, 0)
                    };
                    task.delay(1, function() -- Line: 132
                        -- upvalues: u4 (copy), Duration (copy), TweenService (ref), Part (copy), u16 (copy)
                        local v17 = TweenService:Create(Part, u4.Info or TweenInfo.new(Duration, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), u16);
                        v17:Play();
                        v17.Completed:Connect(function() -- Line: 136
                            -- upvalues: Part (ref)
                            task.defer(Part.Destroy, Part);
                        end);
                    end);
                end;

                v9.Rocks.Color = ColorSequence.new(v14.Instance.Color);
            end;

            v9.Trail.Enabled = v14 ~= nil;
            local EnableParticles = ParticleHandler.EnableParticles;
            local v18;

            if v14 == nil then
                v18 = false;
            else
                v18 = os.clock() - v11 < Duration;
            end;

            EnableParticles(v9, v18);

            if os.clock() - v13 > 0.04 and os.clock() - v11 < Duration * 0.8 then
                v13 = os.clock();
                local v19 = CFrame.new(u6.Position, u6.Position + Origin.LookVector);
                local Angles2 = CFrame.Angles;
                local v20 = u2:NextNumber(180, 360);
                local v21 = math.rad(v20);
                local v22 = u2:NextNumber(-125, 125);
                local LookVector = (v19 * Angles2(v21, math.rad(v22), 0)).LookVector;
                local v23 = workspace:Raycast(u6.Position, LookVector * u2:NextNumber(22, 26), u1);

                if v23 then
                    local u24 = AssetHandler.GetAsset("Particles/SurgicalSlash/CoilLightningImpact", {
                        AbilityName = "Ope",
                        SkinName = SkinName
                    }):Clone();
                    ParticleHandler.Unusualify(u24, {
                        Character = u4.Character
                    });
                    u24.Position = v23.Position;
                    u24.Parent = workspace.Effects;
                    AssetHandler.ScaleAsset(u24, {
                        Scale = u2:NextNumber(0.85, 1.2)
                    });
                    local Attachment = u24.Attachment;
                    local v25 = u2:NextNumber(9.25, 10.75);
                    task.delay(1 / v25, function() -- Line: 167
                        -- upvalues: ParticleHandler (ref), u24 (copy)
                        task.delay(ParticleHandler.GetMaxLifetime(u24), u24.Destroy, u24);
                        ParticleHandler.Emit(u24, ParticleHandler.GenerateEmitInfo(u24));
                    end);
                    local Magnitude = (v23.Position - u6.Position).Magnitude;
                    local v26 = u2:NextNumber(1.75, 2);
                    local v27 = math.ceil(Magnitude / 1.5);
                    EffectsHandler.CallEffect("Generate Quasiduck Lightning", nil, {
                        Color = ParticleHandler.TryHSVShift(ColorSequence.new(u3[SkinName] or u3.Default), ParticleHandler.GetUnusualHSVData({
                            Character = u4.Character
                        })),
                        Curves = { u2:NextNumber(-5, 5), u2:NextNumber(-5, 5) },
                        Speed = v25,
                        Length = v26,
                        A1 = v10,
                        A2 = Attachment,
                        Size = u2:NextNumber(0.9, 1.25),
                        PartCount = v27
                    });
                end;
            end;

            task.wait();
        end;

        ParticleHandler.EnableParticles(v9, false);
    end;
end;
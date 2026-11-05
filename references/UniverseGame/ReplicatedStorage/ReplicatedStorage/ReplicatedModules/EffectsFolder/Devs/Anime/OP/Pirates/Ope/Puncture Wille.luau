  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = game:GetService("Players").LocalPlayer;
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = Random.new();
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Include;
u2.FilterDescendantsInstances = { workspace.Map };

return function(u3, p4, p5, u6) -- Line: 19
    -- upvalues: u2 (copy), EffectsHandler (copy), AssetHandler (copy), ParticleHandler (copy), TweenService (copy), u1 (copy)
    local v7 = os.clock();
    local v8 = os.clock();
    local u9 = workspace:Raycast(p4.Position, Vector3.new(0, -45, 0), u2);
    local v10 = {
        AbilityName = "Ope",
        SkinName = u6
    };
    EffectsHandler.CallEffect("Emit Particle V3", {
        AbilityName = "Ope",
        Path = "Particles/PunctureWille/Release",
        MaxRenderDistance = 500,
        Charactter = u3,
        Origin = p4.CFrame * CFrame.new(0, -3, 0) * CFrame.Angles(-1.5707963267948966, 0, 0),
        SkinName = u6
    });
    local v11;

    if u9 then
        EffectsHandler.CallEffect("Bubble Distortion", {
            StartSize = Vector3.new(10, 10, 10),
            Transparency = 15,
            Time = 0.25,
            Origin = CFrame.new(u9.Position),
            EndSize = Vector3.new(1, 1, 1) * p5 * 2.5
        });
        EffectsHandler.CallEffect("Emit Particle V3", {
            AbilityName = "Ope",
            Path = "Particles/PunctureWille/InitialImpact",
            MaxRenderDistance = 500,
            Character = u3,
            Origin = CFrame.new(u9.Position, u9.Position + u9.Normal) * CFrame.new(0, 3, 0) * CFrame.Angles(-1.5707963267948966, 0, 0),
            SkinName = u6
        });
        task.spawn(function() -- Line: 62
            -- upvalues: EffectsHandler (ref), u3 (copy), u9 (copy), u6 (copy)
            for _ = 1, 5 do
                EffectsHandler.CallEffect("Emit Particle V3", {
                    AbilityName = "Ope",
                    Path = "Particles/PunctureWille/Explosion",
                    MaxRenderDistance = 500,
                    Character = u3,
                    Origin = CFrame.new(u9.Position, u9.Position + u9.Normal) * CFrame.new(0, 3, 0) * CFrame.Angles(-1.5707963267948966, 0, 0),
                    SkinName = u6
                });
                task.wait(0.16);
            end;
        end);
        v11 = AssetHandler.GetAsset("Particles/PunctureWille/ActiveGround", v10):Clone();
        v11.CFrame = CFrame.new(u9.Position, u9.Position + u9.Normal) * CFrame.Angles(0, -1.5707963267948966, 0);
        ParticleHandler.Unusualify(v11, {
            Character = u3
        });
        v11.Parent = workspace.Effects;
        task.delay(10, v11.Destroy, v11);
        local Part = Instance.new("Part");
        Part.CanCollide = false;
        Part.CastShadow = false;
        Part.Anchored = true;
        Part.Color = Color3.new(0.803922, 0.972549, 1);
        Part.Size = Vector3.new(1, 1, 1) * p5 * 1.5;
        Part.Material = Enum.Material.Neon;
        Part.Shape = "Ball";
        Part.Transparency = 0.95;
        Part.Position = u9.Position;
        Part.Parent = workspace.Effects;
        local u12 = TweenService:Create(Part, TweenInfo.new(0.05, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 10, true), {
            Size = Part.Size * 1.15
        });
        u12:Play();
        task.delay(0.6000000000000001, function() -- Line: 102
            -- upvalues: u12 (copy), TweenService (ref), Part (copy)
            u12:Pause();
            TweenService:Create(Part, TweenInfo.new(0.2), {
                Transparency = 1,
                Size = Part.Size * 1.4
            }):Play();
            task.delay(0.2, Part.Destroy, Part);
        end);
        EffectsHandler.CallEffect("Randomized Ground Craters", {
            Lifetime = 1.5,
            SizeMultiplier = 1.35,
            Origin = CFrame.new(u9.Position),
            Power = p5 / 1.35
        });
    else
        v11 = nil;
    end;

    local v13 = ParticleHandler.HSVShiftTable({ Color3.fromRGB(88, 110, 238), Color3.fromRGB(9, 137, 207), Color3.fromRGB(0, 0, 0) }, ParticleHandler.GetUnusualHSVData({
        Character = u3
    }));
    local Model = Instance.new("Model");
    Model.Parent = workspace.Effects;
    task.delay(0.8, Model.Destroy, Model);
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillTransparency = 0;
    Highlight.FillColor = Color3.new(0.960784, 0.960784, 0.960784);
    Highlight.OutlineTransparency = 1;
    Highlight.Parent = Model;

    while true do
        if u9 and os.clock() - v8 > 0.035 then
            local v14 = math.random(1, #v13);
            local CallEffect = EffectsHandler.CallEffect;
            local v15 = {
                PartCount = 8,
                Color = ColorSequence.new(v13[v14]),
                Speed = u1:NextNumber(6.66, 9.5),
                CFrames = { CFrame.new(u9.Position) * CFrame.new(u1:NextNumber(-4, 4), 0, u1:NextNumber(-4, 4)), CFrame.new(u9.Position) * CFrame.new(u1:NextNumber(-p5, p5), u1:NextNumber(25, 30), u1:NextNumber(-p5, p5)) },
                Size = u1:NextNumber(0.6, 0.95)
            };
            local v16;

            if v14 == #v13 or not Model then
                v16 = nil;
            else
                v16 = Model;
            end;

            v15.Parent = v16;
            CallEffect("Generate Quasiduck Lightning", nil, v15);
        end;

        local Position = p4.Position;
        local v17 = u1:NextNumber(-p5, p5);
        local v18 = Position + Vector3.new(v17, 0, u1:NextNumber(-p5, p5));
        local v19 = workspace:Raycast(v18, Vector3.new(0, -60, 0), u2);

        if v19 then
            local Instance2 = v19.Instance;
            local v20 = math.random(0, 360);
            local v21 = math.rad(v20);
            local Part = Instance.new("Part");
            Part.Anchored = true;
            Part.CanCollide = false;
            Part.CanTouch = false;
            Part.Material = v19.Material;
            Part.Color = Instance2.Color;
            Part.CFrame = CFrame.new(v19.Position) * CFrame.Angles(v21, v21, v21);
            Part.Size = Vector3.new(1, 1, 1) * u1:NextNumber(4.5, 6);
            Part.BottomSurface = Enum.SurfaceType.Smooth;
            Part.TopSurface = Enum.SurfaceType.Smooth;
            Part.Parent = workspace.Effects;
            task.delay(2, Part.Destroy, Part);

            for _, child in pairs(Instance2:GetChildren()) do
                if child:IsA("Decal") or child:IsA("Texture") then
                    child:Clone().Parent = Part;
                end;
            end;

            local v22 = math.random(0, 360);
            math.rad(v22);
            local v23 = {
                Size = Vector3.new(0, 0, 0)
            };
            local Position2 = Part.Position;
            local v24 = Part.Size.Magnitude * u1:NextNumber(3.5, 7);
            v23.Position = Position2 + Vector3.new(0, v24, 0);
            TweenService:Create(Part, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), v23):Play();
        end;

        local v25 = p4.CFrame * CFrame.new(u1:NextNumber(-10, 10), u1:NextNumber(-10, 10), u1:NextNumber(-10, 10));

        if os.clock() - v8 > 0.04 then
            local v26 = math.random(1, #v13);
            local CallEffect = EffectsHandler.CallEffect;
            local v27 = {
                Color = ColorSequence.new(v13[v26]),
                Speed = u1:NextNumber(6.66, 9.5),
                CFrames = { v25, v25 * CFrame.new(u1:NextNumber(-3, 3), -u1:NextNumber(12.5, 25), u1:NextNumber(-3, 3)) },
                Size = u1:NextNumber(0.45, 0.85)
            };
            local v28;

            if v26 == #v13 or not Model then
                v28 = nil;
            else
                v28 = Model;
            end;

            v27.Parent = v28;
            CallEffect("Generate Quasiduck Lightning", nil, v27);
            v8 = os.clock();
        end;

        task.wait(u1:NextNumber(0.02, 0.035));

        if os.clock() - v7 > 0.8 then
            if v11 then
                task.delay(ParticleHandler.EnableParticles(v11, false), v11.Destroy, v11);
            end;

            return;
        end;
    end;
end;
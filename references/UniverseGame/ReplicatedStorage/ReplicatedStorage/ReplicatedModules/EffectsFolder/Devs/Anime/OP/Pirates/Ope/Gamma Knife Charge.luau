  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = Random.new();

return function(u2, p3, p4) -- Line: 12
    -- upvalues: ParticleHandler (copy), TweenService (copy), AssetHandler (copy), EffectsHandler (copy), u1 (copy)
    local u5 = ParticleHandler.GetUnusualHSVData({
        Character = u2
    });
    local Model = Instance.new("Model");
    Model.Name = "Gamma Knife";
    Model.Parent = workspace.Effects;
    task.delay(p3 * 2, Model.Destroy, Model);
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.OutlineTransparency = 1;
    Highlight.FillTransparency = 0;
    Highlight.FillColor = Color3.new(1, 1, 1);
    Highlight.Parent = Model;
    local Part = Instance.new("Part");
    Part.Shape = "Ball";
    Part.Material = Enum.Material.Neon;
    Part.Color = ParticleHandler.TryHSVShift(Color3.fromRGB(105, 255, 94), u5);
    Part.Size = Vector3.new(0, 0, 0);
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CastShadow = false;
    Part.CFrame = u2["Left Arm"].CFrame * CFrame.new(0, -1, 0);
    Part.Parent = Model;
    task.delay(p3 * 2, Part.Destroy, Part);
    TweenService:Create(Part, TweenInfo.new(p3 * 0.8, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
        Size = Vector3.new(2.25, 2.25, 2.25)
    }):Play();
    local u6 = AssetHandler.GetAsset("Particles/GammaKnife/Charge", {
        AbilityName = "Ope",
        SkinName = p4
    }):Clone();
    ParticleHandler.Unusualify(u6, {
        HSVData = u5
    });
    u6.Parent = u2["Left Arm"];
    ParticleHandler.AttachTo(u6, {
        Part = u2["Left Arm"]
    });
    local v7 = os.clock();

    repeat
        local v8 = u2["Left Arm"].CFrame * CFrame.new(0, -1, 0);
        EffectsHandler.CallEffect("Generate Quasiduck Lightning", u2, {
            Size = 0.38,
            Color = ParticleHandler.TryHSVShift(ColorSequence.new(Color3.fromRGB(105, 255, 94)), u5),
            Speed = u1:NextNumber(6.5, 7.8),
            CFrames = { v8 * CFrame.new(u1:NextNumber(-7.5, 7.5), u1:NextNumber(-7.5, 7.5), u1:NextNumber(-7.5, 7.5)), v8 },
            Parent = Model
        });
        Part.CFrame = u2["Left Arm"].CFrame * CFrame.new(u1:NextNumber(-0.3, 0.3), -1, u1:NextNumber(-0.3, 0.3));
        task.wait(0.015);
    until not u2:IsDescendantOf(game) or os.clock() - v7 > p3 * 0.8;

    ParticleHandler.EnableParticles(u6.Core, false);
    TweenService:Create(Part, TweenInfo.new(p3 * 0.1, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {
        Size = Vector3.new(0, 0, 0)
    }):Play();
    task.delay(0.1, function() -- Line: 90
        -- upvalues: ParticleHandler (ref), u6 (copy), EffectsHandler (ref), u2 (copy), u5 (copy), u1 (ref), Model (copy)
        ParticleHandler.Emit(u6.Release, ParticleHandler.GenerateEmitInfo(u6.Release));
        task.spawn(EffectsHandler.CallEffect, "Active Lightning", {
            Lifetime = 2.5,
            Interval = 0.1,
            Part = u2["Left Arm"],
            Outline = Color3.new(1, 1, 1),
            Ranges = {
                X = NumberRange.new(-1.25, 1.25),
                Y = NumberRange.new(-2.5, 2.5),
                Z = NumberRange.new(-1.25, 1.25)
            },
            Lightning = {
                Color = ParticleHandler.TryHSVShift(ColorSequence.new(Color3.fromRGB(120, 255, 83)), u5)
            }
        });
        local v9 = ParticleHandler.HSVShiftTable({ Color3.fromRGB(105, 255, 94), Color3.fromRGB(0, 0, 0) }, u5);

        for i = 1, 10 do
            local v10 = u2["Left Arm"].CFrame * CFrame.new(0, -1, 0);
            local v11 = i % 2 == 0 and 1 or 2;
            local CallEffect = EffectsHandler.CallEffect;
            local v12 = {
                Size = 0.37,
                Sparks = true,
                Color = ColorSequence.new(v9[v11]),
                Speed = u1:NextNumber(7, 8),
                CFrames = { v10, v10 * CFrame.new(u1:NextNumber(-14, 14), u1:NextNumber(-14, 14), u1:NextNumber(-14, 14)) }
            };
            local v13;

            if v11 == 1 then
                v13 = Model or nil;
            else
                v13 = nil;
            end;

            v12.Parent = v13;
            CallEffect("Generate Quasiduck Lightning", u2, v12);
            task.wait(0.1);
        end;

        task.delay(ParticleHandler.EnableParticles(u6, false), u6.Destroy, u6);
    end);
end;
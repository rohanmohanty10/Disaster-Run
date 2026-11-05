  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = Random.new();
local v2 = RaycastParams.new();
v2.FilterType = Enum.RaycastFilterType.Include;
v2.FilterDescendantsInstances = { workspace.Map };

return function(p3, p4, p5, p6) -- Line: 16
    -- upvalues: ParticleHandler (copy), u1 (copy), EffectsHandler (copy), AssetHandler (copy), TweenService (copy)
    local Model = Instance.new("Model");
    Model.Name = "Gamma Knife";
    Model.Parent = workspace.Effects;
    task.delay(5, Model.Destroy, Model);
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.OutlineTransparency = 1;
    Highlight.FillTransparency = 0;
    Highlight.FillColor = Color3.new(1, 1, 1);
    Highlight.Parent = Model;
    local Attachment = Instance.new("Attachment");
    Attachment.Parent = p4.Torso;
    task.delay(5, Attachment.Destroy, Attachment);
    local v7 = ParticleHandler.GetUnusualHSVData({
        Character = p3
    });
    local v8 = ParticleHandler.HSVShiftTable({ Color3.fromRGB(105, 255, 94), Color3.fromRGB(0, 0, 0) }, v7);

    for _ = 1, 8 do
        local v9 = u1:NextNumber(0, 6.283185307179586);
        local Position = p4.Torso.CFrame.Position;
        local v10 = math.cos(v9);
        local v11 = math.sin(v9);
        local v12 = math.sin(v9);
        local v13 = Position + Vector3.new(v10, v11, v12) * u1:NextNumber(5.5, 8);
        local Attachment2 = Instance.new("Attachment");
        Attachment2.Parent = workspace.Terrain;
        Attachment2.WorldPosition = v13;
        task.delay(2, Attachment2.Destroy, Attachment2);
        local v14 = math.random(1, #v8);
        EffectsHandler.CallEffect("Generate Quasiduck Lightning", nil, {
            PartCount = 8,
            Sparks = true,
            Color = ColorSequence.new(v8[v14]),
            Curves = { u1:NextNumber(-7.5, 7.5), u1:NextNumber(-7.5, 7.5) },
            Speed = u1:NextNumber(7.85, 10.75),
            A1 = Attachment,
            A2 = Attachment2,
            Size = u1:NextNumber(0.65, 0.85),
            Parent = v14 == 1 and Model and Model or nil
        });
    end;

    local Highlight2 = Instance.new("Highlight");
    Highlight2.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight2.OutlineTransparency = 0.25;
    Highlight2.FillTransparency = 0.65;
    Highlight2.FillColor = ParticleHandler.TryHSVShift(Color3.new(0.282353, 0.996078, 0), v7);
    Highlight2.OutlineColor = Color3.new(0, 0, 0);
    Highlight2.Parent = p4;
    local v15 = AssetHandler.GetAsset("Particles/GammaKnife/Debuff", {
        AbilityName = "Ope",
        SkinName = p6
    }):Clone();
    ParticleHandler.Unusualify(v15, {
        HSVData = v7
    });
    v15.Parent = p4;
    ParticleHandler.AttachTo(v15, {
        Part = p4.HumanoidRootPart
    });
    local v16 = os.clock();

    repeat
        local CFrame = p4.Torso.CFrame;
        local v17 = u1:NextNumber(0, 6.283185307179586);
        local Position = CFrame.Position;
        local v18 = math.cos(v17);
        local v19 = math.sin(v17);
        local v20 = math.sin(v17);
        local v21 = Position + Vector3.new(v18, v19, v20) * u1:NextNumber(9, 12);
        local Attachment2 = Instance.new("Attachment");
        Attachment2.Parent = workspace.Terrain;
        Attachment2.WorldPosition = v21;
        task.delay(2, Attachment2.Destroy, Attachment2);
        local v22 = math.random(1, #v8);
        EffectsHandler.CallEffect("Generate Quasiduck Lightning", nil, {
            PartCount = 7,
            Color = ColorSequence.new(v8[v22]),
            Curves = { u1:NextNumber(-7.5, 7.5), u1:NextNumber(-7.5, 7.5) },
            Speed = u1:NextNumber(8, 10.75),
            A1 = Attachment,
            A2 = Attachment2,
            Size = u1:NextNumber(0.25, 0.45),
            Parent = v22 == 1 and Model and Model or nil
        });
        task.wait(0.01);
    until not p4:IsDescendantOf(game) or p5 < os.clock() - v16;

    TweenService:Create(Highlight2, TweenInfo.new(0.5), {
        FillTransparency = 1,
        OutlineTransparency = 1
    }):Play();
    task.delay(0.5, Highlight2.Destroy, Highlight2);
    task.delay(ParticleHandler.EnableParticles(v15, false), v15.Destroy, v15);
end;
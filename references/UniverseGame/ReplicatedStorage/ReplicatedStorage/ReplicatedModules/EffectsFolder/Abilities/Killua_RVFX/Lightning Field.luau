  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Players");
local u1 = _G.Petal("Util");
local _ = ReplicatedStorage["Client Assets"];
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u2 = Random.new();
local u3 = RaycastParams.new();
u3.FilterType = Enum.RaycastFilterType.Include;
u3.FilterDescendantsInstances = { workspace.Map };

return function(u4) -- Line: 21
    -- upvalues: ParticleHandler (copy), u2 (copy), u1 (copy), u3 (copy), EffectsHandler (copy)
    local Character = u4.Character;
    local Part = u4.Part;

    if Part == nil then
        return;
    end;

    local Origin = u4.Origin;
    local u5 = u4.Attribute or "LightningAura";
    local _ = Character.HumanoidRootPart;
    os.clock();
    local _ = os.clock() + 0.3;
    local u6 = u4.Radius or 10;
    local u7 = u4.SpeedRange or {
        Min = 3,
        Max = 6.5
    };
    local u8 = u4.AnimationSpeedRange or {
        Min = 1,
        Max = 2
    };
    local u9 = u4.PartCountRange or {
        Min = 5,
        Max = 10
    };
    local u10 = u4.Color or ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(145, 164, 207)),
        ColorSequenceKeypoint.new(0.2, Color3.fromRGB(204, 229, 255)),
        ColorSequenceKeypoint.new(0.5, Color3.fromRGB(153, 204, 255)),
        ColorSequenceKeypoint.new(0.8, Color3.fromRGB(137, 153, 207)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(113, 122, 207))
    });
    local v11 = ParticleHandler.GetUnusualHSVData({
        Character = Character
    });

    if v11 ~= nil then
        u10 = ParticleHandler.HSVShift(u10, v11);
    end;

    task.spawn(function() -- Line: 56
        -- upvalues: Character (copy), u5 (copy), Origin (ref), Part (copy), u4 (copy), u2 (ref), u1 (ref), u6 (copy), u3 (ref), u7 (copy), u8 (copy), u9 (copy), EffectsHandler (ref), u10 (ref)
        while Character:IsDescendantOf(game) and Character:GetAttribute(u5) do
            if not Origin and Part then
                Origin = Part.Position;
            end;

            local v12 = u4.Size and u2:NextNumber(u4.Size.X, u4.Size.Y) or u2:NextNumber(0.35, 0.65);
            local v13 = u4.Height and u2:NextNumber(u4.Height.X, u4.Height.Y) or u2:NextNumber(5, 20);
            local v14 = u1.randomPlaneCirclePos(Origin, u6);
            local v15 = workspace:Raycast(v14 + Vector3.new(0, 7.5, 0), Vector3.new(0, -15, 0), u3);

            if v15 then
                local _ = v15.Instance;
                local Attachment = Instance.new("Attachment");
                Attachment.Parent = workspace.Terrain;
                Attachment.WorldPosition = v15.Position;
                local Attachment2 = Instance.new("Attachment");
                Attachment2.Parent = workspace.Terrain;
                Attachment2.WorldPosition = v15.Position + Vector3.new(0, v13, 0);
                local v16 = u2:NextNumber(u7.Min, u7.Max);
                local v17 = { u2:NextNumber(-5, 5), u2:NextNumber(-5, 5) };
                local v18 = u2:NextNumber(0.5, 1);
                local v19 = u2:NextNumber(u8.Min, u8.Max);
                local v20 = u2:NextInteger(u9.Min, u9.Max);
                local v21 = { 0.5, 1.5 };
                local v22 = EffectsHandler.CallEffect("Generate Quasiduck Lightning", nil, {
                    Color = u10,
                    Curves = v17,
                    Speed = v16,
                    Length = v18,
                    A1 = Attachment,
                    A2 = Attachment2,
                    Size = v12,
                    PartCount = v20
                });
                v22.MinThicknessMultiplier = 0.35;
                v22.AnimationSpeed = v19;
                v22.MinRadius = v21[1];
                v22.MaxRadius = v21[2];
                task.delay(0.25 / v16, function() -- Line: 103
                    -- upvalues: Attachment (copy), Attachment2 (copy)
                    Attachment:Destroy();
                    Attachment2:Destroy();
                end);
            end;

            EffectsHandler.Wait(0.06);
        end;
    end);
end;
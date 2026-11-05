  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("TweenService");
game:GetService("Players");
local _ = ReplicatedStorage["Client Assets"];
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u1 = Random.new();
local u2 = RaycastParams.new();
u2.FilterType = Enum.RaycastFilterType.Include;
u2.FilterDescendantsInstances = { workspace.Map };

return function(u3) -- Line: 18
    -- upvalues: ParticleHandler (copy), u1 (copy), u2 (copy), EffectsHandler (copy)
    local Character = u3.Character;
    local Part = u3.Part;

    if Part == nil then
        return;
    end;

    local Origin = u3.Origin;
    local u4 = u3.Attribute or "LightningAura";
    local Once = u3.Once;

    if Character:FindFirstChild("HumanoidRootPart") == nil then
        return;
    end;

    os.clock();
    local _ = os.clock() + 0.3;
    local u5 = u3.Radius or 10;
    local u6 = u3.Color or ColorSequence.new(Color3.fromRGB(192, 0, 3));
    local v7 = ParticleHandler.GetUnusualHSVData({
        Character = Character
    });

    if v7 ~= nil then
        u6 = ParticleHandler.HSVShift(u6, v7);
    end;

    local function Cast() -- Line: 43
        -- upvalues: Origin (ref), Part (copy), u3 (copy), u1 (ref), u5 (copy), u2 (ref), EffectsHandler (ref), u6 (ref)
        if not Origin and Part then
            Origin = Part.Position;
        end;

        local v8 = u3.Size and u1:NextNumber(u3.Size.X, u3.Size.Y) or u1:NextNumber(0.35, 0.65);
        local v9 = u3.Height and u1:NextNumber(u3.Height.X, u3.Height.Y) or u1:NextNumber(5, 20);
        local v10 = u1:NextNumber(-u5, u5);
        local v11 = Origin + Vector3.new(v10, 0, u1:NextNumber(-u5, u5));
        local v12 = workspace:Raycast(v11 + Vector3.new(0, 7.5, 0), Vector3.new(0, -15, 0), u2);

        if v12 then
            local _ = v12.Instance;
            local Attachment = Instance.new("Attachment");
            Attachment.Parent = workspace.Terrain;
            Attachment.WorldPosition = v12.Position;
            local Attachment2 = Instance.new("Attachment");
            Attachment2.Parent = workspace.Terrain;
            Attachment2.WorldPosition = v12.Position + Vector3.new(0, v9, 0);
            u1:NextNumber(5, 7.5);
            local v13 = { u1:NextNumber(-5, 5), u1:NextNumber(-5, 5) };
            local v14 = u1:NextNumber(7, 9);
            local v15 = u1:NextNumber(0.5, 1);
            local v16 = u1:NextNumber(0, 1);
            local v17 = u1:NextInteger(10, 14);
            local v18 = { 1.25, 1.5 };
            local v19 = EffectsHandler.CallEffect("Generate Quasiduck Lightning", nil, {
                Color = u6,
                Curves = v13,
                Speed = v14,
                Length = v15,
                A1 = Attachment,
                A2 = Attachment2,
                Size = v8,
                PartCount = v17
            });
            v19.MinThicknessMultiplier = 0.5;
            v19.AnimationSpeed = v16;
            v19.MinRadius = v18[1];
            v19.MaxRadius = v18[2];
            task.delay(0.25 / v14, function() -- Line: 90
                -- upvalues: Attachment (copy), Attachment2 (copy)
                Attachment:Destroy();
                Attachment2:Destroy();
            end);
        end;
    end;

    task.spawn(function() -- Line: 97
        -- upvalues: Once (copy), Character (copy), u4 (copy), Cast (copy), EffectsHandler (ref)
        if Once then
            for _ = 1, math.random(5, 10) do
                Cast();
                task.wait(0.05);
            end;
        else
            while Character:IsDescendantOf(game) and Character:GetAttribute(u4) do
                Cast();
                EffectsHandler.Wait(0.015);
            end;
        end;
    end);
end;
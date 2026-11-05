  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local RunService = game:GetService("RunService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.EffectsHandler);
local u1 = ReplicatedStorage:FindFirstChild("Client Assets").Assets.Abilities["Uber Oni"].Particles["Hand Trail"];
local u2 = Random.new();

local function CubicBezier(p3, p4, p5, p6, p7) -- Line: 15
    return (1 - p3) ^ 3 * p4 + 3 * (1 - p3) ^ 2 * p3 * p5 + 3 * (1 - p3) * p3 ^ 2 * p6 + p3 ^ 3 * p7;
end;

return function(p8) -- Line: 19
    -- upvalues: ParticleHandler (copy), u1 (copy), u2 (copy), RunService (copy)
    local v9 = p8 or {};
    local u10 = ParticleHandler.TranslateToCFrame(v9.Origin) or error("No origin data");
    local v11 = v9.Amount or 3;
    local u12 = v9.Offset or Vector3.new(0, 0, 0);
    local _ = v9.TrailDelay or 0;
    local v13 = v9.Object or u1;
    local v14 = v9.Time or 1;
    os.clock();
    local u15 = {};

    for _ = 1, v11 do
        local v16 = v13:Clone();

        if v9.HSVData then
            ParticleHandler.Unusualify(v16, v9);
        end;

        v16.Anchored = true;
        v16.Parent = workspace.Effects;
        ParticleHandler.EnableAllParticles(v16, true);
        local v17 = {
            Part = v16,
            Degree = u2:NextInteger(-360, 360),
            Radius = u2:NextNumber(2.5, 20),
            Height = u2:NextNumber(0, 3),
            RadiusIncrease = u2:NextNumber(5, 15),
            DegreeIncrease = u2:NextNumber(100, 200),
            HeightIncrease = u2:NextNumber(1, 20)
        };
        local v18 = u2:NextNumber(-10, 10);
        local v19 = u2:NextNumber(0, 10);
        v17.CurveOffset = Vector3.new(v18, v19, u2:NextNumber(-10, 10));
        table.insert(u15, v17);
    end;

    os.clock();
    local u25 = RunService.RenderStepped:Connect(function(p20) -- Line: 64
        -- upvalues: u15 (copy), u10 (copy), u12 (copy)
        for _, v in u15 do
            local Part = v.Part;
            local Degree = v.Degree;
            local Radius = v.Radius;
            local Height = v.Height;
            local v21 = math.rad(Degree);
            local v22 = math.sin(v21) * Radius;
            local v23 = math.rad(Degree);
            local v24 = math.cos(v23) * Radius;
            Part.Position = u10.Position + u12 + Vector3.new(v22, Height, v24);
            v.Degree = v.Degree + v.DegreeIncrease * p20;
            v.Radius = v.Radius + v.RadiusIncrease * p20;
            v.Height = v.Height + v.HeightIncrease * p20;
        end;
    end);
    task.delay(v14, function() -- Line: 84
        -- upvalues: u25 (ref), u15 (copy), ParticleHandler (ref)
        u25:Disconnect();
        u25 = nil;

        for _, v in u15 do
            local Part = v.Part;
            ParticleHandler.EnableAllParticles(Part, false);
            ParticleHandler.DestroyEmit(Part);
        end;
    end);
end;
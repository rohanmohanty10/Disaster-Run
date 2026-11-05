  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Players");
game:GetService("RunService");
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.Types);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);

local function CubicBezier(p1, p2, p3, p4, p5) -- Line: 15
    return (1 - p1) ^ 3 * p2 + 3 * (1 - p1) ^ 2 * p1 * p3 + 3 * (1 - p1) * p1 ^ 2 * p4 + p1 ^ 3 * p5;
end;

local function Quad(p6) -- Line: 19
    return p6 * p6;
end;

local u7 = Random.new();

local function u10(p8, p9) -- Line: 24
    -- upvalues: u7 (copy)
    return u7:NextNumber(p8, p9);
end;

local function RandomPointOnSphere(p11) -- Line: 28
    local v12 = 2 * math.random() - 1;
    local v13 = 6.283185307179586 * math.random();
    local v14 = math.sqrt(1 - v12 * v12);
    local v15 = p11 * v14 * math.cos(v13);
    local v16 = p11 * v14 * math.sin(v13);

    return Vector3.new(v15, v16, p11 * v12);
end;

local function ComputePoints(p17, p18) -- Line: 41
    -- upvalues: ParticleHandler (copy), RandomPointOnSphere (copy)
    local v19 = ParticleHandler.TranslateToPosition(p17) + RandomPointOnSphere(p18);

    return {
        v19,
        v19:Lerp(ParticleHandler.TranslateToPosition(p17), 0.5) + RandomPointOnSphere(p18),
        ParticleHandler.TranslateToPosition(p17) + RandomPointOnSphere(p18),
        p17
    };
end;

local function UseNumber(p20) -- Line: 54
    -- upvalues: u10 (copy)
    if typeof(p20) == "number" then
        return p20;
    end;

    return typeof(p20) ~= "NumberRange" and 0 or u10(p20.Min, p20.Max);
end;

return function(u21, u22) -- Line: 77
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), ComputePoints (copy), UseNumber (copy), u7 (copy)
    local Duration = u22.Duration;
    local Rate = u22.Rate;
    local u23 = u22.Radius or 50;
    local Amount = u22.Amount;
    local Lifetime = u22.Lifetime;
    local Goal = u22.Goal;
    local ForceClear = u22.ForceClear;
    local LifetimeElapsedProportion = u22.LifetimeElapsedProportion;
    local u24 = AssetHandler.GetAsset(u22.Path, AssetHandler.GetAbilityData(u21));

    if not u24 then
        return;
    end;

    if u24:IsA("Folder") or u24:IsA("Model") then
        u24 = u24:GetChildren();
    end;

    local u25 = {};

    local function CreateParticle(p26) -- Line: 98
        -- upvalues: u24 (ref), ParticleHandler (ref), u21 (copy), ComputePoints (ref), Goal (copy), UseNumber (ref), u23 (copy), u25 (ref), Lifetime (copy), u7 (ref)
        local v27 = (typeof(u24) == "table" and u24[math.random(1, #u24)] or u24):Clone();
        ParticleHandler.EnableAllParticles(v27, true);
        ParticleHandler.Unusualify(v27, {
            Character = u21
        });
        local v28 = ComputePoints(Goal, UseNumber(u23));
        local v29 = {
            v27,
            v28,
            0,
            p26.Lifetime or u7:NextNumber(Lifetime.Min, Lifetime.Max)
        };
        table.insert(u25, v29);
        v27.Position = v28[1];
        v27.Parent = workspace.Effects;
    end;

    local function Update(p30) -- Line: 115
        -- upvalues: u25 (ref), ParticleHandler (ref), u22 (copy)
        for i, v in u25 do
            local u31 = v[1];
            local v32 = v[2];
            local v33 = v[3];
            local v34 = v[4];

            if v34 <= v33 or typeof(v32[4]) == "Instance" and not v32[4].Parent then
                table.remove(u25, i);
                ParticleHandler.EnableAllParticles(u31, false);

                if u22.KeepAlive then
                    task.delay(u22.KeepAlive, function() -- Line: 126
                        -- upvalues: u31 (copy)
                        u31:Destroy();
                    end);
                else
                    ParticleHandler.DestroyByMaxLifetime(u31);
                end;
            else
                local v35 = v33 / v34;
                local v36 = v35 * v35;
                local v37 = v32[1];
                local v38 = v32[2];
                local v39 = v32[3];
                local v40 = ParticleHandler.TranslateToPosition(v32[4]);
                u31.Position = (1 - v36) ^ 3 * v37 + 3 * (1 - v36) ^ 2 * v36 * v38 + 3 * (1 - v36) * v36 ^ 2 * v39 + v36 ^ 3 * v40;
                v[3] = v[3] + p30;
            end;
        end;
    end;

    local v41 = os.clock();
    local v42 = 0;

    if Amount then
        Duration = Duration or Lifetime.Max;

        for _ = 1, Amount do
            CreateParticle({});
        end;
    end;

    while typeof(Duration) == "number" and v42 < Duration or typeof(Duration) == "Instance" and Duration:IsDescendantOf(workspace) do
        local v43 = task.wait();

        if Rate and Rate <= os.clock() - v41 then
            v41 = os.clock();
            CreateParticle({
                Lifetime = u7:NextNumber(Lifetime.Min, Lifetime.Max) * (LifetimeElapsedProportion and (math.clamp(LifetimeElapsedProportion.Increment and 1 + v42 / (LifetimeElapsedProportion.Denominator or 1) or 1 - v42 / (LifetimeElapsedProportion.Denominator or 1), LifetimeElapsedProportion.Min or 0, LifetimeElapsedProportion.Max or 1) or 1) or 1)
            });
        end;

        v42 = v42 + v43;
        Update(v43);
    end;

    if not ForceClear then
        while #u25 > 0 do
            Update((task.wait()));
        end;
    end;

    for _, v in u25 do
        if v[1] then
            v[1]:Destroy();
        end;

        table.clear(v);
    end;

    table.clear(u25);
    u25 = nil;
end;
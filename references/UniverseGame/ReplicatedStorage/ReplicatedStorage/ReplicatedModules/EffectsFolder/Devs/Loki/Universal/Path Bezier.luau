  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
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
local u1 = Random.new();

local function u4(p2, p3) -- Line: 58
    -- upvalues: u1 (copy)
    return u1:NextNumber(p2, p3);
end;

local function QuadBezier(p5, p6, p7, p8) -- Line: 62
    return p6:Lerp(p7, p5):Lerp(p7:Lerp(p8, p5), p5);
end;

local function GetAlpha(p9, p10, p11) -- Line: 66
    -- upvalues: TweenService (copy)
    if p10 then
        return TweenService:GetValue(p9, p10, p11 or Enum.EasingDirection.Out);
    end;

    return p9;
end;

local function ComputePoints(p12, p13, p14, p15) -- Line: 74
    -- upvalues: ParticleHandler (copy)
    local v16 = ParticleHandler.TranslateToPosition(p12);
    local v17 = ParticleHandler.TranslateToPosition(p13);
    local v18 = v16:Lerp(v17, 0.5);

    return { p12, (CFrame.lookAt(v18, v17) * CFrame.Angles(0, 0, (math.rad(p15))) * CFrame.new(0, p14, 0)).Position, p13 };
end;

local function UseNumber(p19) -- Line: 88
    -- upvalues: u4 (copy)
    if typeof(p19) == "number" then
        return p19;
    end;

    return typeof(p19) ~= "NumberRange" and 0 or u4(p19.Min, p19.Max);
end;

return function(u20, p21) -- Line: 98
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), ComputePoints (copy), u1 (copy), UseNumber (copy), TweenService (copy)
    local Amount = p21.Amount;
    local Lifetime = p21.Lifetime;
    local Duration = p21.Duration;
    local Rate = p21.Rate;
    local EasingStyle = p21.EasingStyle;
    local EasingDirection = p21.EasingDirection;
    local Origin = p21.Origin;
    local Goal = p21.Goal;
    local SpreadAngle = p21.SpreadAngle;
    local u22 = p21.CurveRadius or 10;
    local u23 = p21.Scale or 1;
    local u24;

    if p21.RawPath == nil then
        u24 = false;
    else
        u24 = p21.RawPath;
    end;

    local ForceClear = p21.ForceClear;
    local LifetimeElapsedProportion = p21.LifetimeElapsedProportion;
    local HSVShift = p21.HSVShift;
    local GetAsset = AssetHandler.GetAsset;
    local EffectPath = p21.EffectPath;
    local v25;

    if u24 then
        v25 = nil;
    else
        v25 = AssetHandler.GetAbilityData(u20);
    end;

    local u26 = GetAsset(EffectPath, v25);

    if not u26 then
        return;
    end;

    local u27 = {};

    local function CreateParticle(p28) -- Line: 125
        -- upvalues: u26 (copy), ParticleHandler (ref), u24 (copy), u20 (copy), HSVShift (copy), u23 (copy), AssetHandler (ref), ComputePoints (ref), Origin (copy), Goal (copy), u22 (copy), u1 (ref), UseNumber (ref), SpreadAngle (copy), u27 (ref), Lifetime (copy)
        local v29 = u26:Clone();
        ParticleHandler.EnableAllParticles(v29, true);

        if not u24 then
            ParticleHandler.Unusualify(v29, {
                Character = u20
            });
        end;

        if HSVShift then
            ParticleHandler.HSVShiftParticles(v29, HSVShift);
        end;

        if u23 ~= 1 then
            AssetHandler.ScaleAsset(v29, {
                Scale = u23
            });
        end;

        local v30 = u22;

        if typeof(v30) ~= "number" then
            v30 = typeof(v30) ~= "NumberRange" and 0 or u1:NextNumber(v30.Min, v30.Max);
        end;

        local v31 = ComputePoints(Origin, Goal, v30, UseNumber(SpreadAngle));
        local v32 = {};
        local v33;

        if p28 and p28.Lifetime then
            v33 = p28.Lifetime;

            if typeof(v33) ~= "number" then
                v33 = typeof(v33) ~= "NumberRange" and 0 or u1:NextNumber(v33.Min, v33.Max);
            end;
        else
            v33 = Lifetime;

            if typeof(v33) ~= "number" then
                v33 = typeof(v33) ~= "NumberRange" and 0 or u1:NextNumber(v33.Min, v33.Max);
            end;
        end;

        v32[1], v32[2], v32[3], v32[4] = v29, v31, 0, v33;
        table.insert(u27, v32);
        v29.Position = ParticleHandler.TranslateToPosition(v31[1]);
        v29.Parent = workspace.Effects;
    end;

    local function Update(p34) -- Line: 150
        -- upvalues: u27 (ref), ParticleHandler (ref), EasingStyle (copy), EasingDirection (copy), TweenService (ref)
        for i, v in u27 do
            local v35 = v[1];
            local v36 = v[2];
            local v37 = v[3];
            local v38 = v[4];

            if v38 <= v37 then
                table.remove(u27, i);
                ParticleHandler.EnableAllParticles(v35, false);
                ParticleHandler.DestroyByMaxLifetime(v35);
            else
                local v39 = v37 / v38;
                local v40 = EasingStyle;
                local v41 = EasingDirection;

                if v40 then
                    v39 = TweenService:GetValue(v39, v40, v41 or Enum.EasingDirection.Out);
                end;

                local v42 = ParticleHandler.TranslateToPosition(v36[1]);
                local v43 = v36[2];
                local v44 = ParticleHandler.TranslateToPosition(v36[3]);
                v35.Position = v42:Lerp(v43, v39):Lerp(v43:Lerp(v44, v39), v39);
                v[3] = v[3] + p34;
            end;
        end;
    end;

    local v45 = os.clock();
    local v46 = 0;

    if Amount then
        if not Duration then
            if typeof(Lifetime) == "NumberRange" then
                Duration = Lifetime.Max;
            else
                Duration = Lifetime;
            end;
        end;

        for _ = 1, Amount do
            CreateParticle({});
        end;
    end;

    while typeof(Duration) == "number" and v46 < Duration or typeof(Duration) == "Instance" and Duration:IsDescendantOf(workspace) do
        local v47 = task.wait();

        if Rate and Rate <= os.clock() - v45 then
            v45 = os.clock();
            local v48 = {};
            local v49;

            if typeof(Lifetime) == "number" then
                v49 = Lifetime;
            else
                v49 = typeof(Lifetime) ~= "NumberRange" and 0 or u1:NextNumber(Lifetime.Min, Lifetime.Max);
            end;

            v48.Lifetime = v49 * (LifetimeElapsedProportion and (math.clamp(LifetimeElapsedProportion.Increment and 1 + v46 / (LifetimeElapsedProportion.Denominator or 1) or 1 - v46 / (LifetimeElapsedProportion.Denominator or 1), LifetimeElapsedProportion.Min or 0, LifetimeElapsedProportion.Max or 1) or 1) or 1);
            CreateParticle(v48);
        end;

        v46 = v46 + v47;
        Update(v47);
    end;

    if not ForceClear then
        while #u27 > 0 do
            Update((task.wait()));
        end;
    end;

    for _, v in u27 do
        if v[1] then
            v[1]:Destroy();
        end;

        table.clear(v);
    end;

    table.clear(u27);
    u27 = nil;
end;
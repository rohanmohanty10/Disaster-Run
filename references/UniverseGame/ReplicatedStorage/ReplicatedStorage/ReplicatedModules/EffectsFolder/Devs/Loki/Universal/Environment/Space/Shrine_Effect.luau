  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Players");
game:GetService("RunService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.Types);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
local u1 = Random.new();

local function u4(p2, p3) -- Line: 25
    -- upvalues: u1 (copy)
    return u1:NextNumber(p2, p3);
end;

local function UseNumber(p5) -- Line: 29
    -- upvalues: u4 (copy)
    if typeof(p5) == "number" then
        return p5;
    end;

    return typeof(p5) ~= "NumberRange" and 0 or u4(p5.Min, p5.Max);
end;

local function TweenCallback(p6, p7, u8, p9, p10, p11, p12, p13, p14) -- Line: 39
    -- upvalues: TweenService (copy)
    local v15 = TweenService:Create(p6, TweenInfo.new(p9 or 0.5, p10 or Enum.EasingStyle.Quad, p11 or Enum.EasingDirection.Out, p12 or 0, p13 or false, p14 or 0), p7);
    v15.Completed:Connect(function() -- Line: 49
        -- upvalues: u8 (copy)
        if u8 then
            u8();
        end;
    end);
    v15:Play();
end;

return function(p16, p17) -- Line: 55
    -- upvalues: EffectsHandler (copy), TweenCallback (copy), u1 (copy), ParticleHandler (copy)
    local ShrineEffects = workspace:FindFirstChild("Map"):FindFirstChild("Fractured Island"):FindFirstChild("Special"):FindFirstChild("ShrineEffects");
    local v18 = ({
        ABILITY_658 = "PlanetShaper",
        ABILITY_8008135 = "Crystallized",
        ABILITY_13579 = "NuclearStar"
    })[p17.Index];
    local v19 = ({
        ABILITY_658 = {
            HueShift = 17
        },
        ABILITY_8008135 = {
            HueShift = 267
        },
        ABILITY_13579 = {
            HueShift = 218
        }
    })[p17.Index];

    if not v18 then
        return;
    end;

    local v20 = p17.SkipInitial or false;
    local v21 = ShrineEffects:FindFirstChild((`{v18}_Effects`));
    local v22 = ShrineEffects:FindFirstChild((`{v18}_Statue`));

    if not (v21 and v22) then
        return;
    end;

    local v23 = p17.State == nil and true or p17.State;

    if v23 and not v20 then
        EffectsHandler.CallEffect("Emit Particle V3", {
            Path = "Universal/Interaction/Space/ShrineActivate",
            RawPath = true,
            Scale = 1.75,
            ScaleLifetime = 0.9,
            BypassRenderCap = true,
            Origin = v22.CFrame,
            HSVShift = v19
        });
    end;

    local v24 = v21:FindFirstChildOfClass("Beam");

    if v24 and v23 then
        local Attachment0 = v24.Attachment0;
        local Attachment1 = v24.Attachment1;

        if Attachment0 and (Attachment1 and not v20) then
            local Magnitude = (Attachment0.WorldPosition - Attachment1.WorldPosition).Magnitude;
            task.spawn(EffectsHandler.CallEffect, "Path Bezier", p16, {
                EffectPath = "Abilities/crystallized/Particles/Common/EnergyTrail",
                RawPath = true,
                Scale = 2.25,
                Duration = 3,
                Rate = 0.15,
                Origin = Attachment0,
                Goal = Attachment1,
                CurveRadius = NumberRange.new(Magnitude / 5, Magnitude / 3.75),
                SpreadAngle = NumberRange.new(-180, 180),
                EasingStyle = Enum.EasingStyle.Sine,
                EasingDirection = Enum.EasingDirection.InOut,
                Lifetime = Magnitude / 60,
                HSVShift = v19
            });
        end;

        for _, child in v21:GetChildren() do
            if child:IsA("Beam") and not (v23 and child.Enabled) then
                local Width0 = child.Width0;
                local Width1 = child.Width1;
                child.Width0 = 0;
                child.Width1 = 0;
                TweenCallback(child, {
                    Width0 = Width0,
                    Width1 = Width1
                }, function() -- Line: 140
                end, 1.75 + u1:NextNumber(0.25, 0.65), Enum.EasingStyle.Quad, Enum.EasingDirection.InOut);
            end;
        end;
    end;

    ParticleHandler.EnableAllParticles(v21, v23);
end;
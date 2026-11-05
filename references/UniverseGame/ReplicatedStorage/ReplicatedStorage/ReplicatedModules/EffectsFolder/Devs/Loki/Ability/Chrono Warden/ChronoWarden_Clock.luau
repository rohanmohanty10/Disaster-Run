  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
local Trove = require(Knit.Util.Trove);
local Petal = _G.Petal;
Petal("New");
local u1 = Petal("Util");
local _ = u1.Tween;
local Heartbeat = game:GetService("RunService").Heartbeat;
local ParticleHandler = require(PathShortcuts.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

local function _(p2, p3, p4) -- Line: 17
    return p2 + (p3 - p2) * p4;
end;

function RescaleModel(p5, p6)
    local _ = p5.PrimaryPart.Position;

    for _, descendant in ipairs(p5:GetDescendants()) do
        if descendant:IsA("BasePart") then
            descendant.Size = descendant.Size * p6;
            local v7 = descendant.Position - p5:GetPrimaryPartCFrame().p;
            local v8 = descendant.CFrame - descendant.Position;
            descendant.CFrame = CFrame.new(p5:GetPrimaryPartCFrame().p + v7 * p6) * v8;
        elseif descendant:IsA("JointInstance") then
            local v9 = descendant.C0.p * p6;
            local v10, v11, v12 = descendant.C0:ToEulerAnglesXYZ();
            local v13 = descendant.C1.p * p6;
            local v14, v15, v16 = descendant.C1:ToEulerAnglesXYZ();
            descendant.C0 = CFrame.new(v9) * CFrame.Angles(v10, v11, v12);
            descendant.C1 = CFrame.new(v13) * CFrame.Angles(v14, v15, v16);
        end;
    end;
end;

return function(p17) -- Line: 44
    -- upvalues: AssetHandler (copy), Trove (copy), ParticleHandler (copy), u1 (copy), EffectsHandler (copy), Heartbeat (copy)
    local Origin = p17.Origin;
    local Duration = p17.Duration;
    local Speed = p17.Speed;
    local u18 = p17.StartCoeff or 1;
    local u19 = p17.EndCoeff or 0;
    local u20 = p17.ExtraTime or 0;
    local u21 = p17.Sway or 0.2;
    local v22 = p17.HueShift or 0;
    local v23 = p17.EmitParticles or false;
    local Character = p17.Character;
    local v24 = AssetHandler.GetAbilityData(Character);
    local v25 = AssetHandler.CloneAsset("Models/Clock", v24);

    if not v25 then
        warn("No clock model found");

        return;
    end;

    local v26 = Trove.new();
    v26:Add(v25);
    local Mid = v25.Mid;
    local MinuteHand = Mid.MinuteHand;
    local HourHand = Mid.HourHand;
    RescaleModel(v25, p17.Scale or 1);
    v25.Parent = workspace.Effects;
    v25:PivotTo(Origin);

    for _, child in v25:GetChildren() do
        child.Color = ParticleHandler.HSVShift(child.Color, {
            HueShift = v22
        });
        u1.Tween(child, 0.2, "Quad", "InOut", {
            Transparency = 0
        });
    end;

    if v23 then
        EffectsHandler.CallEffect("Emit Particle V3", {
            Path = "Particles/ClockCast",
            AutoSerialize = true,
            CFrame = Mid.CFrame,
            Scale = p17.Scale or 1,
            Player = game:GetService("Players"):GetPlayerFromCharacter(Character)
        });
    end;

    local u27 = os.clock();
    local u28 = 1;
    local u29 = 0;
    local u30 = true;
    local u31 = math.random(-100000, 100000);
    task.spawn(function() -- Line: 113
        -- upvalues: u30 (ref), Heartbeat (ref), Mid (copy), Origin (copy), u21 (copy), u31 (copy)
        while u30 do
            local _ = Heartbeat:Wait() * 60;
            local new = CFrame.new;
            local v32 = os.clock() + u31;
            local v33 = u21 * math.cos(v32);
            local v34 = os.clock() + u31 * 2;
            Mid.CFrame = Origin * new(v33, 0, u21 * math.sin(v34));
        end;
    end);
    task.spawn(function() -- Line: 122
        -- upvalues: u27 (copy), Duration (copy), u20 (copy), u28 (ref), u18 (copy), u19 (copy), u29 (ref), MinuteHand (copy), Speed (copy), HourHand (copy), Heartbeat (ref)
        while os.clock() - u27 < Duration + u20 do
            local v35 = u18;
            u28 = v35 + (u19 - v35) * (u29 / Duration + u20);
            local v36 = MinuteHand;
            v36.C0 = v36.C0 * CFrame.Angles(0, math.rad(Speed * u28), 0);
            local v37 = HourHand;
            v37.C0 = v37.C0 * CFrame.Angles(0, math.rad(Speed / 3 * u28), 0);
            u29 = u29 + Heartbeat:Wait();
        end;
    end);
    task.wait(Duration + Duration / 4.5);

    for _, child in v25:GetChildren() do
        u1.Tween(child, 0.35, "Quad", "InOut", {
            Transparency = 1
        });
    end;

    task.wait(0.36);
    u30 = false;
    v26:Destroy();
end;
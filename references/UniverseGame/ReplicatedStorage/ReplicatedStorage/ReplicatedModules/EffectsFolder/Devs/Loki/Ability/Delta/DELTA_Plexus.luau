  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
local Trove = require(Knit.Util.Trove);
local Petal = _G.Petal;
local u1 = Petal("New");
local _ = Petal("Util").Tween;
local _ = game:GetService("RunService").RenderStepped;
local Heartbeat = game:GetService("RunService").Heartbeat;
CFn = CFrame.new;
V3n = Vector3.new;
Ang = CFrame.Angles;
Rad = math.rad;
Noise = math.noise;
Clamp = math.clamp;

function Rng(p2, p3)
    return Random.new():NextNumber(p2, p3);
end;

local function Lerp(p4, p5, p6) -- Line: 30
    return p4:Lerp(p5, p6);
end;

local function UseNumber(p7) -- Line: 34
    if typeof(p7) == "number" then
        return p7;
    end;

    if typeof(p7) == "NumberRange" then
        return Rng(p7.Min, p7.Max);
    end;
end;

return function(u8) -- Line: 42
    -- upvalues: u1 (copy), Trove (copy), ParticleHandler (copy), Heartbeat (copy)
    (function(u9, p10, p11) -- Line: 44, Name: CreatePlexus
        -- upvalues: u1 (ref), Trove (ref), u8 (copy), ParticleHandler (ref), Heartbeat (ref)
        local v12 = u1("Model")({
            Name = "PlexusModel"
        });
        local u13 = Trove.new();
        u13:Add(v12);
        local _ = u8.HueShift or 0;

        for _ = 1, p10 do
            local v14 = u1("Part")({
                Shape = "Ball",
                Anchored = true,
                CanCollide = false,
                Material = "Neon",
                CastShadow = false,
                Size = V3n(1, 1, 1) * Rng(0.8, 1.2),
                Parent = v12,
                Color = u8.Color
            });

            if u8.Character then
                ParticleHandler.Unusualify(v14, {
                    IncludeParts = true,
                    Character = u8.Character
                });
            end;

            u1("Attachment")({
                Parent = v14
            });
        end;

        local v15 = v12:GetChildren();
        local u16 = u8.MaxAngle or 360;
        local u17 = u8.Resolution or 3;
        local u18 = u8.MaxConnectorDistance or 10;
        local u19 = u8.Drag or 1.08;

        for _, v in v15 do
            local u20;

            if typeof(p11) == "number" then
                u20 = p11;
            elseif typeof(p11) == "NumberRange" then
                u20 = Rng(p11.Min, p11.Max);
            else
                u20 = nil;
            end;

            local u21 = Rng(1, 100000000);
            local Size = v.Size;

            for i = 1, p10 do
                local u22 = v15[i];

                if u22 ~= v then
                    local v23 = u1("Attachment")({
                        Parent = u22
                    });
                    local u24 = u1("Beam")({
                        Width0 = 0.08,
                        Width1 = 0.08,
                        FaceCamera = true,
                        LightInfluence = 0,
                        LightEmission = 1,
                        Brightness = 2,
                        Parent = v,
                        Attachment0 = v.Attachment,
                        Attachment1 = v23,
                        Transparency = NumberSequence.new(0),
                        Color = ColorSequence.new(u8.Color)
                    });

                    if u8.Character then
                        ParticleHandler.Unusualify(u24, {
                            Character = u8.Character
                        });
                    end;

                    task.spawn(function() -- Line: 116
                        -- upvalues: v (copy), u20 (copy), Heartbeat (ref), i (copy), u22 (copy), u18 (copy), u24 (copy)
                        local v25 = 0;
                        local CFrame2 = v.Attachment.CFrame;
                        local v26 = u20 * 0.9;
                        local v27;

                        if math.random(1, 2) == 1 then
                            v27 = -2;
                        else
                            v27 = 2;
                        end;

                        while v25 < v26 do
                            local v28 = Heartbeat:Wait();
                            local v29 = (tick() - i) * 35;
                            local v30 = 1 - math.cos(v29) * 1;
                            u24.Transparency = NumberSequence.new(u18 < (v.Position - u22.Position).Magnitude and 1 or v30);
                            u24.CurveSize0 = math.lerp(0, v27, v25 / v26);

                            if v.Parent then
                                v.Attachment.CFrame:Lerp(CFrame2 * CFrame.Angles(Rad(Rng(-360, 360)), Rad(Rng(-360, 360)), Rad(Rng(-360, 360))), v25 / v26);
                            end;

                            v25 = v25 + v28;
                        end;

                        u24.Enabled = false;
                    end);
                end;
            end;

            task.spawn(function() -- Line: 153
                -- upvalues: u8 (ref), u9 (copy), u16 (copy), v (copy), u20 (copy), Heartbeat (ref), u17 (ref), u21 (copy), u19 (copy), Size (copy)
                local v31 = u8.Velocity or Vector3.new(0, 0, 0);
                local v32 = u8.VelocityDrag or 0.9;

                if typeof(v32) ~= "number" then
                    if typeof(v32) == "NumberRange" then
                        v32 = Rng(v32.Min, v32.Max);
                    else
                        v32 = nil;
                    end;
                end;

                local v33 = u8.VelocitySpeed or 1;

                if typeof(v33) ~= "number" then
                    if typeof(v33) == "NumberRange" then
                        v33 = Rng(v33.Min, v33.Max);
                    else
                        v33 = nil;
                    end;
                end;

                local v34 = u9 * Ang(Rad(Rng(-u16, u16)), Rad(Rng(-u16, u16)), Rad(Rng(-u16, u16)));
                v.CFrame = v34;
                local v35 = 0;

                while v35 < u20 do
                    local v36 = Heartbeat:Wait();
                    local v37 = math.clamp(v36 * 60, 0.1, 10);
                    local v38 = Noise(v34.X / u17 + 0.1, u21);
                    local v39 = Noise(v34.Y / u17 + 0.1, u21);
                    local v40 = Noise(v34.Z / u17 + 0.1, u21);
                    local Position = v34.Position;
                    v34 = (v34 + v31 * v33 * v37) * Ang(v38 * 25 * v37, v39 * 25 * v37, v40 * 25 * v37) * CFn(0, 0, -u17 * v37);
                    local _ = (Position - v34.Position).Unit;
                    v.CFrame = v.CFrame:Lerp(CFn(v34.p), 0.1);
                    u17 = math.clamp(u17 * u19, 0.1, 100);
                    v31 = v31 * math.pow(v32, v37);
                    v.Size = Size:Lerp(V3n(0, 0, 0), v35 / u20);
                    v35 = v35 + v36;
                end;

                v:Destroy();
            end);
            v12.Parent = workspace.Effects;
            task.delay(u20 + 1, function() -- Line: 202
                -- upvalues: u13 (copy)
                u13:Destroy();
            end);
        end;

        return v12;
    end)(u8.Origin, u8.NodeAmount, u8.Duration);
end;
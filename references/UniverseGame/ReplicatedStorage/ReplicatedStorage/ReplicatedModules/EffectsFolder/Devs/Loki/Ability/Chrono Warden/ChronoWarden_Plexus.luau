  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
local Trove = require(Knit.Util.Trove);
local Petal = _G.Petal;
local u1 = Petal("New");
local _ = Petal("Util").Tween;
local RenderStepped = game:GetService("RunService").RenderStepped;
CFn = CFrame.new;
V3n = Vector3.new;
Ang = CFrame.Angles;
Rad = math.rad;
Noise = math.noise;
Clamp = math.clamp;

function Rng(p2, p3)
    return Random.new():NextNumber(p2, p3);
end;

local function Lerp(p4, p5, p6) -- Line: 24
    return p4:Lerp(p5, p6);
end;

return function(u7) -- Line: 28
    -- upvalues: u1 (copy), Trove (copy), RenderStepped (copy)
    (function(u8, p9, p10) -- Line: 30, Name: CreatePlexus
        -- upvalues: u1 (ref), Trove (ref), u7 (copy), RenderStepped (ref)
        local v11 = u1("Model")({
            Name = "PlexusModel"
        });
        local u12 = Trove.new();
        u12:Add(v11);
        local _ = u7.HueShift or 0;

        for _ = 1, p9 do
            local v13 = u1("Part")({
                Shape = "Ball",
                Anchored = true,
                CanCollide = false,
                Material = "Neon",
                CastShadow = false,
                Size = V3n(1, 1, 1) * Rng(0.8, 1.2),
                Parent = v11,
                Color = u7.Color
            });
            u1("Attachment")({
                Parent = v13
            });
        end;

        local v14 = v11:GetChildren();

        for _, v in v14 do
            local u15 = Rng(p10 / 2, p10);
            local u16 = Rng(1, 100000000);
            local Size = v.Size;
            local u17 = 3;

            for i = 1, p9 do
                local u18 = v14[i];

                if u18 ~= v then
                    local v19 = u1("Attachment")({
                        Parent = u18
                    });
                    local u20 = u1("Beam")({
                        Width0 = 0.08,
                        Width1 = 0.08,
                        FaceCamera = true,
                        LightInfluence = 0,
                        LightEmission = 1,
                        Brightness = 2,
                        Parent = v,
                        Attachment0 = v.Attachment,
                        Attachment1 = v19,
                        Transparency = NumberSequence.new(0),
                        Color = ColorSequence.new(u7.Color)
                    });
                    task.spawn(function() -- Line: 93
                        -- upvalues: u15 (copy), RenderStepped (ref), i (copy), v (copy), u18 (copy), u20 (copy)
                        for _ = 1, u15 - 10 do
                            RenderStepped:Wait();
                            local v21 = (tick() - i) * 35;
                            local v22 = 1 - math.cos(v21) * 1;
                            u20.Transparency = NumberSequence.new((v.Position - u18.Position).Magnitude > 10 and 1 or v22);
                        end;

                        u20.Enabled = false;
                    end);
                end;
            end;

            task.spawn(function() -- Line: 113
                -- upvalues: u8 (copy), v (copy), u15 (copy), RenderStepped (ref), u17 (ref), u16 (copy), Size (copy)
                local v23 = u8 * Ang(Rad(Rng(-360, 360)), Rad(Rng(-360, 360)), Rad(Rng(-360, 360)));
                v.CFrame = v23;

                for i = 1, u15 do
                    RenderStepped:Wait();
                    local v24 = Noise(v23.X / u17 + 0.1, u16);
                    local v25 = Noise(v23.Y / u17 + 0.1, u16);
                    local v26 = Noise(v23.Z / u17 + 0.1, u16);
                    local Position = v23.Position;
                    v23 = v23 * Ang(v24 * 7, v25 * 7, v26 * 7) * CFn(0, 0, -u17);
                    local _ = (Position - v23.Position).Unit;
                    v.CFrame = v.CFrame:Lerp(CFn(v23.p), 0.1);
                    u17 = math.clamp(u17 - 0.08000000000000007, 0.1, 100);
                    v.Size = Size:Lerp(V3n(0, 0, 0), i / u15);
                end;

                v:Destroy();
            end);
            v11.Parent = workspace.Effects;
            task.delay((u15 + 5) / 30, function() -- Line: 140
                -- upvalues: u12 (copy)
                u12:Destroy();
            end);
        end;

        return v11;
    end)(u7.Origin, u7.NodeAmount, u7.Duration);
end;
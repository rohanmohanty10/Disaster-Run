  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
local PathShortcuts2 = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
game:GetService("RunService");
require(PathShortcuts2.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(PathShortcuts2.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(Knit.Util.Trove);
local Petal = _G.Petal;
local u1 = Petal("New");
local u2 = Petal("Util");
local u3 = Petal("Extensions");
local u4 = script.Ring:Clone();

function Lerp(p5, p6, p7)
    if typeof(p5) == "number" then
        return p5 + (p6 - p5) * p7;
    end;

    return p5:Lerp(p6, p7);
end;

function Quad(p8, p9, p10, p11)
    return Lerp(Lerp(p8, p9, p11), Lerp(p9, p10, p11), p11);
end;

local function CreateRing(u12, u13, p14, u15, p16, p17) -- Line: 32
    -- upvalues: u4 (copy), ParticleHandler (copy)
    local u18 = u4:Clone();
    local v19 = u12.CFrame * CFrame.new(u12.Size.X * u13.X, u12.Size.Y * u13.Y, u12.Size.Z * u13.Z);
    u18.Parent = workspace.Effects;
    u18.CanCollide = false;
    u18.CastShadow = false;
    u18.Anchored = true;
    u18.CFrame = v19;
    u18.Size = Vector3.new(0, 0, 0);
    u18.Transparency = 1;
    u18.Color = ParticleHandler.TryHSVShift(p16 or u18.Color, p17);
    local u20 = p14 + (1 - (u12.Size.X + u12.Size.Z) / 2);
    local CFrame2 = u12.CFrame;
    task.spawn(function() -- Line: 52
        -- upvalues: u15 (copy), u18 (copy), CFrame2 (copy), u12 (copy), u13 (copy), u20 (ref)
        local v21 = 0;

        while v21 < u15 do
            v21 = v21 + task.wait();
            u18.CFrame = Lerp(CFrame2 * CFrame.new(-u12.Size.X * u13.X, u12.Size.Y / 3 * u13.Y, -u12.Size.Z * u13.Z), CFrame2 * CFrame.new(-u12.Size.X * u13.X, -u12.Size.Y * u13.Y * 1.75, 0), v21 / u15);
            u18.Size = Quad(Vector3.new(0, 0, 0), Vector3.new(4, 0.05, 4) * u20, Vector3.new(0, 0, 0), v21 / u15);
            u18.Transparency = Quad(1.25, 0, 1.15, v21 / u15);
        end;

        u18:Destroy();
    end);
end;

return function(p22) -- Line: 68
    -- upvalues: u1 (copy), ParticleHandler (copy), u2 (copy), u3 (copy), CreateRing (copy)
    local AttachPart = p22.AttachPart;
    local Color = p22.Color;
    local v23 = p22.Axis or Vector3.new(0, 0.65, 0);
    local _ = p22.Strength or 3;
    local v24 = p22.RingLifetimeMultiplier or 1;
    local u25 = u1("PointLight")({
        Name = "Glow",
        Brightness = 0,
        Range = 3,
        Color = ParticleHandler.TryHSVShift(Color or Color3.fromRGB(188, 155, 93), p22.HSVData),
        Parent = AttachPart
    });
    u2.Tween(u25, 0.2, "Quad", "InOut", {
        Brightness = 3
    });
    local v26 = u3.Rng(0.9, 1.1);

    for i = 1, 4 do
        local v27 = u3.Rng(-0.1, 0.1);
        CreateRing(AttachPart, v23 + Vector3.new(v27, 0, u3.Rng(-0.1, 0.1)), v26 * 0.5 + i / 3, u3.Rng(0.6, 0.65) * v24 * (i / 4), Color, p22.HSVData);
    end;

    task.wait(0.1);
    u2.Tween(u25, 0.3, "Quad", "Out", {
        Brightness = 0
    });
    task.delay(0.5, function() -- Line: 94
        -- upvalues: u25 (copy)
        u25:Destroy();
    end);
end;
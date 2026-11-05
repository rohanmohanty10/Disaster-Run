  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
local Trove = require(Knit.Util.Trove);
local Petal = _G.Petal;
local u1 = Petal("New");
local u2 = Petal("Util");
local _ = u2.Tween;
local _ = game:GetService("RunService").Heartbeat;
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
local _ = Instance.new;
local new = Vector3.new;
local new2 = CFrame.new;
local _ = CFrame.Angles;
local _ = Color3.fromRGB;
local u3 = Random.new();

local function Rng(p4, p5) -- Line: 19
    -- upvalues: u3 (copy)
    return u3:NextNumber(p4, p5);
end;

local function Lerp(p6, p7, p8) -- Line: 23
    return p6:Lerp(p7, p8);
end;

local function Quad(p9, p10, p11, p12) -- Line: 28
    -- upvalues: Lerp (copy)
    return Lerp(p9:Lerp(p10, p12), p10:Lerp(p11, p12), p12);
end;

local u13 = RaycastParams.new();
u13.FilterType = Enum.RaycastFilterType.Whitelist;

local function RaycastMap(p14, p15, p16) -- Line: 37
    -- upvalues: u13 (copy)
    u13.FilterDescendantsInstances = { workspace.Map };
    local v17 = workspace:Raycast(p14, p15, u13);

    if p16 then
        return v17;
    end;

    if v17 then
        return v17.Position;
    end;
end;

local function Delay(u18, u19, ...) -- Line: 48
    -- upvalues: EffectsHandler (copy)
    local u20 = ... and (typeof(...) == "table" and ... or ({ ... } or {})) or {};

    return task.spawn(function() -- Line: 50
        -- upvalues: EffectsHandler (ref), u18 (copy), u19 (copy), u20 (copy)
        EffectsHandler.Wait(u18);
        u19(unpack(u20));
    end);
end;

local u21 = {};

return function(p22, p23) -- Line: 57
    -- upvalues: Trove (copy), u21 (copy), u2 (copy), Delay (copy), u1 (copy), u3 (copy), new2 (copy), Rng (copy), new (copy), EffectsHandler (copy)
    local u24 = Trove.new();
    p22:FindFirstChild("HumanoidRootPart");
    local Halo = p22:FindFirstChild("Halo");
    local v25;

    if Halo then
        v25 = Halo:FindFirstChild("Inner");
    else
        v25 = Halo;
    end;

    if p23.Cancel then
        local v26 = u21[p22];

        if v26 then
            v26.Cancel = true;
            v26.Tween:Pause();
            u21[p22] = nil;
        end;

        return;
    end;

    if not (p23.NoHalo or Halo and (v25 and (Halo.Parent and v25.Parent))) then
        return;
    end;

    local v27 = p23.Color or v25.Color;
    local Origin = p23.Origin;
    local Destination = p23.Destination;
    local v28 = p23.Duration or 25;
    local v29 = p23.PartAmount or { 5, 9 };
    local v30 = p23.Movement or false;
    local v31 = {};
    local v32 = {};

    for _, descendant in p22:GetDescendants() do
        if (descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture"))) and descendant.Name ~= "HumanoidRootPart" then
            if descendant.Transparency ~= 1 then
                v31[descendant] = descendant.Transparency;
                u2.Tween(descendant, 0.075, "Quad", "InOut", {
                    Transparency = 1
                });
            end;
        elseif descendant:IsA("ParticleEmitter") then
            v32[descendant] = descendant.Enabled;
            descendant.Enabled = false;
            descendant:Clear();
            Delay(v28 / 60 - 0.075, function() -- Line: 101
                -- upvalues: descendant (copy)
                descendant.Enabled = true;
            end);
        end;
    end;

    local v33 = u1("Folder")({
        Name = "Blink"
    });
    u24:Add(v33);
    v33.Parent = workspace.Effects;
    local v34 = {
        Cancel = false,
        Tween = nil
    };

    if v30 then
        v34.Tween = u2.Tween(p22:FindFirstChild("HumanoidRootPart"), v28 / 60, "Quad", "InOut", {
            CFrame = v30
        });
    end;

    u21[p22] = v34;

    for i = 1, v28 do
        if v34.Cancel then
            break;
        end;

        Origin = Origin:Lerp(Destination, i / v28);

        for _ = 1, math.random(v29[1], v29[2]) do
            local v35 = u3:NextNumber(0.5, 1.35);
            local v36 = new2(Origin, Destination) * new2(u3:NextNumber(-3, 3), u3:NextNumber(-3, 3), Rng(-0.5, 2));
            local u37 = u1("Part")({
                Anchored = true,
                CanCollide = false,
                Material = "Neon",
                CastShadow = false,
                CFrame = v36,
                Color = v27,
                Size = new(v35, v35, v35)
            });
            Delay(0.3, function() -- Line: 143
                -- upvalues: u37 (copy)
                u37.Transparency = 1;
            end);
            u2.Tween(u37, 0.2, "Quad", "InOut", {
                Size = Vector3.new(0, 0, Rng(0.1, 0.8)),
                CFrame = v36 * new2(0, 0, Rng(0.45, 2.5))
            });
            u37.Parent = v33;
        end;

        EffectsHandler.Wait();
    end;

    for i, _ in v31 do
        if i and i.Parent then
            u2.Tween(i, 0.075, "Quad", "InOut", {
                Transparency = 0
            });
        end;
    end;

    u21[p22] = nil;
    table.clear(v32);
    table.clear(v31);
    Delay(2, function() -- Line: 168
        -- upvalues: u24 (copy)
        u24:Destroy();
    end);
end;
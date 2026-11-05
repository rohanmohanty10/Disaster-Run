  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
local Trove = require(Knit.Util.Trove);
local Petal = _G.Petal;
local u1 = Petal("New");
local u2 = Petal("Util");
local _ = u2.Tween;
local Heartbeat = game:GetService("RunService").Heartbeat;
local _ = Instance.new;
local new = Vector3.new;
local new2 = CFrame.new;
local _ = CFrame.Angles;
local _ = Color3.fromRGB;
local u3 = Random.new();

local function Rng(p4, p5) -- Line: 20
    -- upvalues: u3 (copy)
    return u3:NextNumber(p4, p5);
end;

local function Lerp(p6, p7, p8) -- Line: 24
    return p6:Lerp(p7, p8);
end;

local function Quad(p9, p10, p11, p12) -- Line: 29
    -- upvalues: Lerp (copy)
    return Lerp(p9:Lerp(p10, p12), p10:Lerp(p11, p12), p12);
end;

local u13 = RaycastParams.new();
u13.FilterType = Enum.RaycastFilterType.Whitelist;

local function RaycastMap(p14, p15, p16) -- Line: 38
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

return function(p18, p19) -- Line: 49
    -- upvalues: Trove (copy), ParticleHandler (copy), u2 (copy), u1 (copy), u3 (copy), new2 (copy), Rng (copy), new (copy), Heartbeat (copy)
    local v20 = Trove.new();
    p18:FindFirstChild("HumanoidRootPart");
    local Origin = p19.Origin;
    local Destination = p19.Destination;
    local v21 = p19.Duration or 25;
    local Colors = p19.Colors;
    local v22 = ParticleHandler.GetUnusualHSVData({
        Player = p19.Player,
        Character = p18
    });

    if v22 ~= nil then
        for i, v in Colors do
            Colors[i] = ParticleHandler.HSVShift(v, v22);
        end;
    end;

    local v23 = p19.PartAmount or { 5, 9 };
    local v24 = p19.Movement or false;
    local v25 = {};
    local v26 = {};

    for _, descendant in p18:GetDescendants() do
        if (descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture"))) and (descendant.Name ~= "HumanoidRootPart" and not descendant:GetAttribute("OriginalTransparency")) then
            descendant:SetAttribute("OriginalTransparency", descendant.Transparency);
            v25[descendant] = true;
            u2.Tween(descendant, 0.075, "Quad", "InOut", {
                Transparency = 1
            });
        elseif descendant:IsA("ParticleEmitter") then
            v26[descendant] = descendant.Enabled;
            descendant.Enabled = false;
            descendant:Clear();
        end;
    end;

    local v27 = u1("Folder")({
        Name = "Blink"
    });
    v20:Add(v27);
    v27.Parent = workspace.Effects;

    if v24 then
        local HumanoidRootPart = p18:FindFirstChild("HumanoidRootPart");
        local LinearVelocity = Instance.new("LinearVelocity");
        LinearVelocity.MaxForce = (1 / 0);
        LinearVelocity.VectorVelocity = Vector3.new(0, 0, 0);
        LinearVelocity.Attachment0 = HumanoidRootPart:FindFirstChildOfClass("Attachment");
        LinearVelocity.Parent = HumanoidRootPart;
        u2.Tween(HumanoidRootPart, v21 / 60, "Quad", "InOut", {
            CFrame = v24
        });
        task.delay(v21 / 60, function() -- Line: 104
            -- upvalues: HumanoidRootPart (copy), LinearVelocity (copy)
            HumanoidRootPart.Velocity = Vector3.new(0, 0, 0);
            LinearVelocity:Destroy();
        end);
    end;

    for i = 1, v21 - 20 do
        Origin = Origin:Lerp(Destination, i / v21);
        local v28 = math.random(v23[1], v23[2]);
        local Unit = (Destination - Origin).Unit;

        for _ = 1, v28 do
            local v29 = u3:NextNumber(0.8, 1.35);
            local v30 = new2(Origin, Destination + Unit * 10 + new(u3:NextNumber(-2, 2), Rng(-2, 2))) * new2(u3:NextNumber(-3, 3), u3:NextNumber(-3, 3), Rng(-0.5, 2));
            local u31 = u1("Part")({
                Anchored = true,
                CanCollide = false,
                Material = "Neon",
                CastShadow = false,
                CFrame = v30 * new2(0, 0, Rng(5, 8)),
                Color = Colors[math.random(1, #Colors)],
                Size = new(v29, v29, v29 * 3),
                Children = {
                    Mesh = u1("SpecialMesh")({
                        MeshType = Enum.MeshType.Sphere
                    })
                }
            });
            task.delay(0.5, function() -- Line: 137
                -- upvalues: u31 (copy)
                u31.Transparency = 1;
            end);
            u2.Tween(u31, 0.305 + u3:NextNumber(0.01, 0.225), "Quad", "InOut", {
                Transparency = 1,
                Size = Vector3.new(0, 0, Rng(0.1, 0.4)),
                Color = Colors[math.random(1, #Colors)],
                CFrame = v30 * new2(0, 0, -u3:NextNumber(6, 9))
            });
            u31.Parent = v27;
        end;

        if v24 then
            p18:FindFirstChild("HumanoidRootPart").Velocity = Vector3.new(0, 0, 0);
        end;

        Heartbeat:Wait();
    end;

    for i, _ in v25 do
        if i and (i.Parent and i:GetAttribute("OriginalTransparency")) then
            u2.Tween(i, 0.075, "Quad", "InOut", {
                Transparency = i:GetAttribute("OriginalTransparency")
            });
            i:SetAttribute("OriginalTransparency", nil);
        end;
    end;

    for i, v in v26 do
        i.Enabled = v;
        v26[i] = nil;
    end;

    table.clear(v26);
    table.clear(v25);
    task.delay(2, v20.Destroy, v20);
end;
  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
local Trove = require(Knit.Util.Trove);
local Petal = _G.Petal;
Petal("New");
local u1 = Petal("Util");
local _ = u1.Tween;
local _ = game:GetService("RunService").Heartbeat;
local _ = Instance.new;
local new = Vector3.new;
local new2 = CFrame.new;
local Angles = CFrame.Angles;
local _ = Color3.fromRGB;
local u2 = Random.new();

local function Rng(p3, p4) -- Line: 17
    -- upvalues: u2 (copy)
    return u2:NextNumber(p3, p4);
end;

local function Lerp(p5, p6, p7) -- Line: 21
    return p5 + (p6 - p5) * p7;
end;

local function Quad(p8, p9, p10, p11) -- Line: 26
    local v12 = p8 + (p9 - p8) * p11;

    return v12 + (p9 + (p10 - p9) * p11 - v12) * p11;
end;

local u13 = RaycastParams.new();
u13.FilterType = Enum.RaycastFilterType.Whitelist;

local function RaycastMap(p14, p15, p16) -- Line: 35
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

local Prism = script.Prism;

return function(p18, p19) -- Line: 48
    -- upvalues: Trove (copy), Prism (copy), u2 (copy), new2 (copy), Angles (copy), u1 (copy), new (copy)
    local v20 = Trove.new();
    p18:FindFirstChild("HumanoidRootPart");
    local Color = p18:FindFirstChild("Halo"):FindFirstChild("Inner").Color;
    local Origin = p19.Origin;
    local v21 = v20:Construct(Instance, "Model");

    for _ = 1, p19.Amount or 10 do
        local u22 = Prism:Clone();
        local u23 = u2:NextNumber(2, 27.5);
        local v24 = Origin * CFrame.new(0, 0, -3.2);
        local v25 = p19.Spread or 4;
        local v26 = v25 + (1 - v25) * (u23 / 27.5);
        local v27 = v24 * new2(u2:NextNumber(-v26, v26), u2:NextNumber(-v26, v26), -15);
        local Magnitude = (v27.Position - v24.Position).Magnitude;
        u22.Parent = v21;
        u22.Color = Color;
        local v28 = new2(v24:Lerp(v27, 0.5).Position, v27.Position) * new2(0, 0, Magnitude / 2) * Angles(-1.5707963267948966, 0, 0);
        u22.Size = Vector3.new(0.5, 0, 0.5);
        u22.CFrame = v28;
        u22.Transparency = 1;
        u1.Tween(u22, u2:NextNumber(0.07, 0.18), "Back", "InOut", {
            Transparency = 0.1,
            CFrame = v28 * new2(0, u23 / 2, 0),
            Size = new(0.5, u23, 0.5)
        });
        task.spawn(function() -- Line: 84
            -- upvalues: u1 (ref), u22 (copy), u2 (ref), u23 (copy), new (ref)
            task.wait(0.3);
            u1.Tween(u22, u2:NextNumber(0.1, 0.5), "Back", "InOut", {
                CFrame = u22.CFrame * CFrame.new(0, -u23 / 2, 0),
                Size = new()
            });
        end);
    end;

    v21.Parent = workspace.Effects;
    task.delay(1.5, v20.Destroy, v20);
end;
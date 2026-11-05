  

 

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
local _ = Instance.new;
local _ = Vector3.new;
local _ = CFrame.new;
local _ = CFrame.Angles;
local _ = Color3.fromRGB;
local u3 = Random.new();

local function Rng(p4, p5) -- Line: 17
    -- upvalues: u3 (copy)
    return u3:NextNumber(p4, p5);
end;

local function Lerp(p6, p7, p8) -- Line: 21
    return p6 + (p7 - p6) * p8;
end;

local function Quad(p9, p10, p11, p12) -- Line: 26
    local v13 = p9 + (p10 - p9) * p12;

    return v13 + (p10 + (p11 - p10) * p12 - v13) * p12;
end;

local u14 = RaycastParams.new();
u14.FilterType = Enum.RaycastFilterType.Whitelist;

local function RaycastMap(p15, p16, p17) -- Line: 35
    -- upvalues: u14 (copy)
    u14.FilterDescendantsInstances = { workspace.Map };
    local v18 = workspace:Raycast(p15, p16, u14);

    if p17 then
        return v18;
    end;

    if v18 then
        return v18.Position;
    end;
end;

local _ = script.Prism;

return function(p19) -- Line: 48
    -- upvalues: Trove (copy), u1 (copy), u2 (copy)
    local u20 = Trove.new();
    p19:FindFirstChild("HumanoidRootPart");
    local _ = p19:FindFirstChild("Halo"):FindFirstChild("Inner").Color;
    local CurrentCamera = workspace.CurrentCamera;
    local FieldOfView = CurrentCamera.FieldOfView;
    local v21 = u1("ColorCorrectionEffect")({
        Name = "Revive"
    });
    v21.Parent = game:GetService("Lighting");
    u20:Add(v21);
    u2.Tween(CurrentCamera, 0.25, "Quart", "InOut", {
        FieldOfView = CurrentCamera.FieldOfView * 2
    });
    u2.Tween(v21, 0.2, "Quad", "InOut", {
        Saturation = -4,
        Contrast = 0
    });
    task.wait(0.225);
    u2.Tween(CurrentCamera, 0.4, "Quad", "InOut", {
        FieldOfView = FieldOfView
    });
    u2.Tween(v21, 0.35, "Quad", "InOut", {
        Saturation = 0,
        Contrast = 0
    });
    task.delay(1, function() -- Line: 81
        -- upvalues: u20 (copy)
        u20:Destroy();
    end);
end;
  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Players");
game:GetService("RunService");
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.Types);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
require(game.ReplicatedStorage.ClientLibrary.BoatTween);
local u1 = RaycastParams.new();
u1.IgnoreWater = true;
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };
u1.CollisionGroup = "Map";

function RaycastMap(p2, p3)
    -- upvalues: u1 (copy)
    return workspace:Raycast(p2, p3, u1);
end;

local _ = Fusion.New;
Random.new();

return function(p4) -- Line: 38
    -- upvalues: Trove (copy), AssetHandler (copy), Fusion (copy)
    local Character = p4.Character;

    if not (Character and Character.Parent) then
        return;
    end;

    if not Character:GetAttribute("RampageMeter") then
        return;
    end;

    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local u5 = Trove.new();
    u5:AttachToInstance(Character);
    local v6 = AssetHandler.CloneAsset("Misc/RampageMeter", AssetHandler.GetAbilityData(Character));

    if not v6 then
        return;
    end;

    u5:Add(v6);
    local Holder = v6:WaitForChild("Holder");
    local Sigil = v6:FindFirstChild("Sigil");
    local Meter = Holder:FindFirstChild("Bar"):FindFirstChild("Meter");
    local u7 = Fusion.Value(false);
    local u8 = Fusion.Value(Character:GetAttribute("RampageMeter"));
    Fusion.Hydrate(Meter)({
        Size = Fusion.Spring(Fusion.Computed(function() -- Line: 65
            -- upvalues: u8 (copy)
            local v9 = u8:get() or 0;

            return UDim2.fromScale(1, (math.clamp(v9 / 100, 0, 1)));
        end), 20, 0.8)
    });
    Fusion.Hydrate(Holder)({
        GroupTransparency = Fusion.Spring(Fusion.Computed(function() -- Line: 72
            -- upvalues: u7 (copy)
            return u7:get() and 0 or 1;
        end), 10, 0.75)
    });
    Fusion.Hydrate(Sigil)({
        ImageTransparency = Fusion.Spring(Fusion.Computed(function() -- Line: 78
            -- upvalues: u7 (copy)
            return u7:get() and 0 or 1;
        end), 10, 0.75)
    });
    Fusion.Hydrate(v6)({
        Enabled = true,
        Parent = HumanoidRootPart,
        Adornee = HumanoidRootPart,
        Size = Fusion.Spring(Fusion.Computed(function() -- Line: 87
            -- upvalues: u7 (copy)
            return u7:get() and UDim2.new(1, 0, 5, 0) or UDim2.new(1, 0, 1, 0);
        end), 10, 0.75)
    });
    u7:set(true);

    while Character and (Character.Parent and Character:GetAttribute("RampageMeter")) do
        u8:set(Character:GetAttribute("RampageMeter"));
        task.wait(0.03333333333333333);
    end;

    u7:set(false);
    task.delay(1.5, function() -- Line: 101
        -- upvalues: u5 (copy)
        u5:Destroy();
    end);
end;
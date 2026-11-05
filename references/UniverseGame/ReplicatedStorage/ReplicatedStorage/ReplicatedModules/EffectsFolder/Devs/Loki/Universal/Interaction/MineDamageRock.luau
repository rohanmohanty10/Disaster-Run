  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Players = game:GetService("Players");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
require(game.ReplicatedStorage.ClientLibrary.BoatTween);
require(ReplicatedStorage.ReplicatedModules.Types);
local v1 = RaycastParams.new();
v1.FilterType = Enum.RaycastFilterType.Include;
v1.FilterDescendantsInstances = { workspace.Map };
local Petal = _G.Petal;
Petal("Util");
local v2 = Petal("Extensions");
local _ = Fusion.Value;
local _ = Fusion.Observer;
local _ = Fusion.New;
local Rng = v2.Rng;
local _ = Players.LocalPlayer;

return function(p3, p4) -- Line: 34
    -- upvalues: Fusion (copy), Rng (copy), EffectsHandler (copy)
    if not (p3 and p3.Parent) then
        return;
    end;

    if not p3:FindFirstChild("OriginalPos") then
        p3:SetAttribute("OriginalPos", p3.Position);
    end;

    local u5 = Fusion.Value(p3:GetAttribute("OriginalPos") or p3.Position);
    local u6 = Fusion.Spring(u5, 35, 0.55);
    Fusion.Hydrate(p3)({
        Position = u6
    });
    local v7;

    if p4.Variant == 1 then
        local v8 = Rng(-3, 3);
        v7 = Vector3.new(v8, 0, Rng(-3, 3));
    elseif p4.Variant == 2 then
        local v9 = Rng(-5, 5);
        v7 = Vector3.new(v9, 0, Rng(-5, 5));
    else
        v7 = Vector3.new(0, 0, 0);
    end;

    EffectsHandler.CallEffects({
        {
            Name = "HighlightObject",
            Data = {
                p3,
                {
                    OutlineTransparency = 0,
                    FillTransparency = 0.2,
                    Lifetime = 0.25,
                    Tween = true,
                    DepthMode = Enum.HighlightDepthMode.Occluded,
                    FillColor = p4.Variant == 2 and Color3.fromRGB(255, 213, 62) or Color3.fromRGB(255, 84, 84),
                    OutlineColor = p4.Variant == 2 and Color3.fromRGB(181, 149, 44) or Color3.fromRGB(167, 52, 52)
                }
            }
        },
        {
            Name = "Emit Particle V3",
            Data = {
                {
                    RawPath = true,
                    Scale = 1.75,
                    ScaleLifetime = 1,
                    BypassRenderCap = true,
                    Origin = p3.CFrame * CFrame.new(0, -1.5, 0),
                    Path = "Universal/Interaction/Camellia/Mining/" .. (p4.Variant == 2 and "MineEmit2" or "MineEmit")
                }
            }
        }
    });
    u6:addVelocity(v7);
    task.defer(function() -- Line: 83
        -- upvalues: u6 (ref), u5 (ref)
        u6 = nil;
        u5 = nil;
    end);
end;
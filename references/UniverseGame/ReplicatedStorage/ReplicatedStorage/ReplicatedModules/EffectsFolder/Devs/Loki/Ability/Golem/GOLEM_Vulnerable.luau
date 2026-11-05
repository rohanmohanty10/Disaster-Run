  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Players");
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
local BoatTween = require(ReplicatedStorage.ClientLibrary.BoatTween);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
require(ReplicatedStorage.ReplicatedModules.Types);
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };

function RaycastMap(p2, p3)
    -- upvalues: u1 (copy)
    return workspace:Raycast(p2, p3, u1);
end;

local Petal = _G.Petal;
Petal("Util");
Petal("New");
local v4 = Petal("Extensions");
local _ = Fusion.Value;
local _ = Fusion.Observer;
local _ = v4.Rng;
local u5 = {};

return function(u6) -- Line: 34
    -- upvalues: u5 (copy), Trove (copy), BoatTween (copy), Fusion (copy)
    if u5[u6] then
        return;
    end;

    local v7 = Trove.new();

    local function Tween(p8, p9) -- Line: 41
        -- upvalues: BoatTween (ref)
        BoatTween:Create(p8, p9):Play();
    end;

    local u10 = Fusion.New("Highlight")({
        FillTransparency = 1,
        OutlineTransparency = 1,
        FillColor = Color3.fromRGB(255, 93, 93),
        OutlineColor = Color3.fromRGB(255, 70, 70)
    });
    u10.Parent = u6;
    u10.Name = "VulnerableHighlight";
    v7:Add(function() -- Line: 55
        -- upvalues: u10 (copy), BoatTween (ref)
        if not (u10 and u10.Parent) then
            return;
        end;

        BoatTween:Create(u10, {
            Time = 0.2,
            EasingStyle = "Smoother",
            EasingDirection = "InOut",
            StepType = "Heartbeat",
            Goal = {
                OutlineTransparency = 1,
                FillTransparency = 1
            }
        }):Play();
        task.delay(0.2, function() -- Line: 68
            -- upvalues: u10 (ref)
            u10:Destroy();
        end);
    end);

    for _, descendant in u6:GetDescendants() do
        if descendant:IsA("BasePart") and descendant.Name == "neon" then
            if not descendant:GetAttribute("OriginalColor") then
                descendant:SetAttribute("OriginalColor", descendant.Color);
            end;

            BoatTween:Create(descendant, {
                Time = 0.2,
                EasingStyle = "Smoother",
                EasingDirection = "InOut",
                StepType = "Heartbeat",
                Goal = {
                    Color = Color3.fromRGB(117, 64, 64)
                }
            }):Play();
        end;
    end;

    v7:Add(function() -- Line: 90
        -- upvalues: u6 (copy), BoatTween (ref)
        for _, descendant in u6:GetDescendants() do
            if descendant:IsA("BasePart") and descendant.Name == "neon" then
                BoatTween:Create(descendant, {
                    Time = 0.2,
                    EasingStyle = "Smoother",
                    EasingDirection = "InOut",
                    StepType = "Heartbeat",
                    Goal = {
                        Color = descendant:GetAttribute("OriginalColor") or Color3.fromRGB(74, 119, 179)
                    }
                }):Play();
            end;
        end;
    end);
    BoatTween:Create(u10, {
        Time = 0.35,
        EasingStyle = "Smoother",
        EasingDirection = "InOut",
        StepType = "Heartbeat",
        Goal = {
            OutlineTransparency = 0.2,
            FillTransparency = 0.95
        }
    }):Play();
    u5[u6] = true;

    repeat
        task.wait(0.016666666666666666);
    until not (u6 and (u6.Parent and u6:GetAttribute("Vulnerable")));

    v7:Destroy();
    u5[u6] = nil;
end;
  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Players");
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
local BoatTween = require(game.ReplicatedStorage.ClientLibrary.BoatTween);
require(ReplicatedStorage.ReplicatedModules.Types);

return function(p1, p2) -- Line: 23
    -- upvalues: Trove (copy), BoatTween (copy), AssetHandler (copy), ParticleHandler (copy)
    if not (p1 and (p2 and p2.Duration)) then
        return;
    end;

    local u3 = Trove.new();

    local function Tween(p4, p5) -- Line: 28
        -- upvalues: u3 (copy), BoatTween (ref)
        u3:Add(BoatTween:Create(p4, p5)):Play();
    end;

    local v6 = AssetHandler.CloneAsset("Models/Triangle", AssetHandler.GetAbilityData(p1));
    ParticleHandler.Unusualify(v6, {
        IncludeParts = true,
        Character = p1
    });
    v6.Size = Vector3.new(0, 0, 0);
    v6.Parent = workspace.Effects;
    u3:Add(v6);
    local Duration = p2.Duration;
    local v7 = os.clock();
    local Origin = p2.Origin;
    local v8 = (typeof(Origin) == "CFrame" and Origin and Origin or Origin.CFrame) * (p2.Offset or CFrame.identity);
    u3:Add(BoatTween:Create(v6, {
        EasingStyle = "Smoother",
        EasingDirection = "InOut",
        Reverses = true,
        StepType = "Heartbeat",
        Time = Duration / 2,
        Goal = {
            Size = Vector3.new(1.732, 0.005, 1.5) * (p2.Scale or 5)
        }
    })):Play();
    local v9 = 0;

    while true do
        if typeof(Origin) == "Instance" then
            v8 = Origin.CFrame * (p2.Offset or CFrame.identity);
        end;

        v6.CFrame = v8 * CFrame.Angles(0, math.rad(v9 * 250), 0) * CFrame.new(0, 0, v6.Size.Z * 0.16666666666666666);

        if os.clock() - v7 >= 0.01 then
            local u10 = v6:Clone();
            u10.Parent = workspace.Effects;
            u3:Add(BoatTween:Create(u10, {
                Time = 0.4,
                EasingStyle = "Smoother",
                EasingDirection = "InOut",
                StepType = "Heartbeat",
                Goal = {
                    Transparency = 1
                }
            })):Play();
            task.delay(0.4, function() -- Line: 83
                -- upvalues: u10 (copy)
                u10:Destroy();
            end);
            v7 = os.clock();
        end;

        v9 = v9 + task.wait();

        if Duration < v9 then
            u3:Destroy();

            return;
        end;
    end;
end;
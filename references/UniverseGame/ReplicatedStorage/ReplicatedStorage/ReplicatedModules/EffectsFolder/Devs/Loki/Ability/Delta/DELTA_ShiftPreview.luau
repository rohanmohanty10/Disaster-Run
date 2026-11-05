  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local Players = game:GetService("Players");
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Fusion = require(ReplicatedStorage.ClientLibrary.Fusion);
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);
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
local _ = v2.Rng;
local _ = Players.LocalPlayer;

return function(p3, p4) -- Line: 40
    -- upvalues: Players (copy), Trove (copy), AssetHandler (copy), Fusion (copy), ParticleHandler (copy)
    if not p3.Parent then
        return;
    end;

    if p4.Stats then
        Players:GetPlayerFromCharacter(p3);
        local v5 = Trove.new();
        v5:AttachToInstance(p3);
        local Stats = p4.Stats;
        p3:FindFirstChild("HumanoidRootPart");
        local v6 = AssetHandler.GetAbilityData(p3);
        local u7 = Fusion.Value(0);
        local u8 = Fusion.Value(Vector3.new(0, 0, 0));
        local MaxCharge = Stats.MaxCharge;

        if p3:FindFirstChild("HumanoidRootPart") then
            u8:set(p3:FindFirstChild("HumanoidRootPart").Position);
        end;

        local u9 = AssetHandler.CloneAsset("Particles/Shift/Preview", v6);
        ParticleHandler.Unusualify(u9, {
            Character = p3
        });
        ParticleHandler.ScaleParticle(u9.Grow, Stats.MinSize / 10);
        ParticleHandler.ScaleLifetime(u9, 1.25);
        Fusion.Hydrate(u9)({
            Position = Fusion.Spring(Fusion.Computed(function() -- Line: 67
                -- upvalues: u8 (ref)
                return u8:get();
            end), 35, 0.8),
            Parent = workspace.Effects
        });
        ParticleHandler.EnableAllParticles(u9.Grow, true);
        local v10 = AssetHandler.ScaleAsset(u9.Grow, {
            ReturnObject = true,
            Scale = Stats.MaxSize - 3,
            TweenInfo = TweenInfo.new(MaxCharge)
        });

        if v10 then
            v5:Add(v10);
        end;

        v5:Add(function() -- Line: 90
            -- upvalues: ParticleHandler (ref), u9 (copy), u7 (ref), u8 (ref)
            ParticleHandler.EnableAllParticles(u9, false);
            task.delay(0.75, function() -- Line: 93
                -- upvalues: u9 (ref)
                u9:Destroy();
            end);
            u7 = nil;
            u8 = nil;
        end);

        return {
            Trove = v5,
            Charge = u7,
            Goal = u8
        };
    end;
end;
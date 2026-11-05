  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);

return function(p1) -- Line: 11
    -- upvalues: Trove (copy), AssetHandler (copy), ParticleHandler (copy), EffectsHandler (copy)
    local Player = p1.Player;
    local HumanoidRootPart = (p1.Character or error("no char")):FindFirstChild("HumanoidRootPart");
    local v2 = p1.Duration or error("no duration");
    local v3 = p1.Distance or error("no distance");
    local v4 = Trove.new();
    local v5 = v4:Clone(AssetHandler.GetAsset("Particles/Beam/Beam", {
        AbilityName = "Sternritter A: Antithesis",
        SkinName = p1.SkinName
    }));
    v5.Parent = workspace.Effects;
    local v6 = 0;

    if Player and Player.Data.Skin:GetAttribute("UnusualHueId") then
        v6 = v6 + Player.Data.Skin:GetAttribute("UnusualHueId") * 5;
    end;

    if v6 > 0 then
        ParticleHandler.HSVShiftParticles(v5, {
            HueShift = v6
        });
    end;

    local v7 = v4:Construct(Instance, "Weld");
    v7.Part0 = HumanoidRootPart;
    v7.Part1 = v5;
    v7.C0 = CFrame.new(0, 0, -4);
    v7.Parent = HumanoidRootPart;
    EffectsHandler.CallEffect("Boat Tween", v5.Welds.Moveable, {
        Time = 0.25,
        EasingStyle = "EntranceExpressive",
        EasingDirection = "In",
        StepType = "RenderStepped",
        Goal = {
            C0 = CFrame.new(0, 0, -v3 + 4)
        }
    });
    ParticleHandler.EnableAllParticles(v5, true);
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Particles/Beam/Shoot",
        AutoSerialize = true,
        AbilityName = "Dragon Knight",
        AttachTo = {
            Part = v5,
            Offset = CFrame.Angles(0, 3.141592653589793, 0)
        },
        SkinName = p1.SkinName,
        Player = Player
    });
    task.wait(v2);
    local v8 = next;
    local v9, v10 = v5:GetChildren();

    for _, v in v8, v9, v10 do
        if v:IsA("BasePart") then
            v.Anchored = true;
        end;
    end;

    v7.Part1 = nil;
    local v11 = ParticleHandler.EnableAllParticles(v5, false);
    task.wait(v11);
    v4:Destroy();
end;
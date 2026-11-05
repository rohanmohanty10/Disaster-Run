  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Petal = _G.Petal;
Petal("New");
local u1 = Petal("Util");
Petal("Extensions");

return function(p2) -- Line: 10
    -- upvalues: AssetHandler (copy), u1 (copy), EffectsHandler (copy)
    local TargetCharacter = p2.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local HumanoidRootPart = TargetCharacter:FindFirstChild("HumanoidRootPart");
    local u3 = AssetHandler.CloneAsset(p2.Name .. "/CandyCane", {
        AbilityName = "KillEffects"
    });
    local new = CFrame.new;
    local Position = HumanoidRootPart.Position;
    local v4 = -TargetCharacter:GetExtentsSize().Y * 2;
    u3.CFrame = new(Position + Vector3.new(0, v4, 0));
    u3.Parent = workspace.Effects;
    local Tween = u1.Tween;
    local v5 = {};
    local v6 = CFrame.new(HumanoidRootPart.Position);
    local Angles = CFrame.Angles;
    local v7 = math.random(-10, 10);
    local v8 = math.rad(v7);
    local v9 = math.random(-80, 80);
    local v10 = math.rad(v9);
    local v11 = math.random(-10, 10);
    v5.CFrame = v6 * Angles(v8, v10, (math.rad(v11)));
    Tween(u3, 0.3, "Quad", "InOut", v5);
    task.delay(1, function() -- Line: 21
        -- upvalues: EffectsHandler (ref), u3 (copy), u1 (ref)
        EffectsHandler.CallEffect("Emit Particle V3", {
            Clone = false,
            Transparency = false,
            AbilityName = "KillEffects",
            Origin = u3,
            Particle = u3
        });
        u1.Tween(u3, 0.3, "Quad", "Out", {
            Transparency = 1
        });
        task.delay(3, function() -- Line: 30
            -- upvalues: u3 (ref)
            u3:Destroy();
        end);
    end);
    EffectsHandler.CallEffect("Play Sound At", {
        Object = AssetHandler.GetAsset(p2.Name .. "/KillEffectSound", {
            AbilityName = "KillEffects"
        }),
        Origin = CFrame.new(HumanoidRootPart.Position)
    });
end;
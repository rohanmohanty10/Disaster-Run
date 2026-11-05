  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local CollectionService = PathShortcuts.CollectionService;
local ClientAssets = PathShortcuts.ClientAssets;
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = Random.new();

return function(p2) -- Line: 12
    -- upvalues: CollectionService (copy), EffectsHandler (copy), u1 (copy), ClientAssets (copy), ParticleHandler (copy)
    local v3 = p2 or {};
    local Character = v3.Character;

    if not Character then
        return;
    end;

    local v4 = v3.Origin or Character:FindFirstChild("HumanoidRootPart");
    local v5 = 1;

    while true do
        if Character.Parent == nil or not CollectionService:HasTag(Character, "CrescentCycle") then
            return;
        end;

        local v6, v7, v8;

        if v5 == 2 then
            local Angles = CFrame.Angles;
            local v9 = math.random(-40, 40);
            v6 = Angles(0, 1.5707963267948966, (math.rad(v9)));

            if not v6 then
                v7 = CFrame.Angles;
                v8 = math.random(-40, 40);
                v6 = v7(math.rad(v8), -1.5707963267948966, 3.141592653589793);
            end;
        else
            v7 = CFrame.Angles;
            v8 = math.random(-40, 40);
            v6 = v7(math.rad(v8), -1.5707963267948966, 3.141592653589793);
        end;

        local v10 = v5 == 2 and CFrame.Angles(0, 0, -1.3089969389957472) or CFrame.Angles(0, 0, 1.3089969389957472);
        task.spawn(EffectsHandler.CallEffect, "Anubis_Slash", {
            Time = 0.25,
            Size = Vector3.new(6.5, 20, 6.5),
            SurfaceDirection = "Bottom",
            Origin = v4,
            Offset = v6,
            EndCFrame = CFrame.Angles(0, -1.5707963267948966, 0),
            Color = Color3.fromRGB(170, 0, 0)
        });
        local v11 = u1:NextNumber(0.11, 0.13) * 60 * 1.3;
        local v12 = v4.CFrame * v10;
        local v13 = ClientAssets.Assets.Abilities.Gryphon.Particles.Slash.SlashFollow:Clone();
        v13.CFrame = v12 * CFrame.new(0, 0, -v11);
        v13.Parent = workspace.Effects;
        ParticleHandler.Emit(v13, ParticleHandler.GenerateEmitInfo(v13));
        v5 = v5 == 1 and 2 or 1;
        task.wait(0.115);
    end;
end;
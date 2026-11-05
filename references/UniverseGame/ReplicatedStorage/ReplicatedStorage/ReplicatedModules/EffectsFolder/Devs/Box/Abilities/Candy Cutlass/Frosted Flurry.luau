  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local CollectionService = PathShortcuts.CollectionService;
local _ = PathShortcuts.ClientAssets;
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = Random.new();

return function(p2) -- Line: 12
    -- upvalues: AssetHandler (copy), CollectionService (copy), EffectsHandler (copy), u1 (copy), ParticleHandler (copy)
    local v3 = p2 or {};
    local Character = v3.Character;

    if not Character then
        return;
    end;

    local _ = v3.Origin;
    AssetHandler.GetAbilityData(v3.Character);
    local v4 = {
        AbilityName = "Candy Cutlass",
        SkinName = v3.SkinName
    };
    local v5 = v3.Origin or Character:FindFirstChild("HumanoidRootPart");

    while true do
        if Character.Parent == nil or not CollectionService:HasTag(Character, "ActiveFFlurry") then
            return;
        end;

        local v6, v7, v8;

        if math.random(1, 2) == 1 then
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

        task.spawn(EffectsHandler.CallEffect, "Anubis_Slash", {
            Time = 0.25,
            Size = Vector3.new(6.5, 20, 6.5),
            SurfaceDirection = "Bottom",
            Origin = v5,
            Offset = v6,
            EndCFrame = CFrame.Angles(0, -2.6179938779914944, 0),
            Color = Color3.fromRGB(255, 0, 0)
        });
        local _ = u1:NextNumber(0.11, 0.13) * 60 * 1.3;
        local CFrame2 = v5.CFrame;
        local Angles = CFrame.Angles;
        local v10 = math.random(-30, 30);
        local v11 = math.random(1, 2) == 1 and 180 or 0;
        local v12 = CFrame2 * Angles(0, 0, (math.rad(v10 + v11)));
        local v13 = AssetHandler.CloneAsset("Particles/Slash", v4);

        if v3.SkinName ~= "D_Estunator" then
            v12 = v12 * CFrame.new(0, 0, -7.5) * CFrame.Angles(0, 1.5707963267948966, 0) or v12;
        end;

        v13.CFrame = v12;
        v13.Parent = workspace.Effects;
        ParticleHandler.Emit(v13, ParticleHandler.GenerateEmitInfo(v13));
        ParticleHandler.DestroyParticle(v13);

        for _, descendant in pairs(v13:GetDescendants()) do
            if descendant:IsA("Beam") then
                task.defer(AssetHandler.ScaleAsset, descendant, {
                    Scale = 0,
                    TweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.In)
                });
            end;
        end;

        task.wait(0.095);
    end;
end;
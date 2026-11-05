  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local CollectionService = PathShortcuts.CollectionService;
local ClientAssets = PathShortcuts.ClientAssets;
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = Random.new();

return function(p2) -- Line: 12
    -- upvalues: CollectionService (copy), EffectsHandler (copy), u1 (copy), ClientAssets (copy), ParticleHandler (copy), AssetHandler (copy)
    local v3 = p2 or {};
    local Character = v3.Character;
    local Color = v3.Color;
    local _ = v3.NoParticle;

    if not Character then
        return;
    end;

    local v4 = v3.Origin or Character:FindFirstChild("HumanoidRootPart");

    while true do
        if Character.Parent == nil or not CollectionService:HasTag(Character, "ActiveFlurry") then
            return;
        end;

        local v5, v6, v7;

        if math.random(1, 2) == 1 then
            local Angles = CFrame.Angles;
            local v8 = math.random(-40, 40);
            v5 = Angles(0, 1.5707963267948966, (math.rad(v8)));

            if not v5 then
                v6 = CFrame.Angles;
                v7 = math.random(-40, 40);
                v5 = v6(math.rad(v7), -1.5707963267948966, 3.141592653589793);
            end;
        else
            v6 = CFrame.Angles;
            v7 = math.random(-40, 40);
            v5 = v6(math.rad(v7), -1.5707963267948966, 3.141592653589793);
        end;

        task.spawn(EffectsHandler.CallEffect, "Anubis_Slash", {
            Time = 0.25,
            Size = Vector3.new(6.5, 20, 6.5),
            SurfaceDirection = "Bottom",
            Origin = v4,
            Offset = v5,
            EndCFrame = CFrame.Angles(0, -2.6179938779914944, 0),
            Color = Color or Color3.fromRGB(51, 83, 154)
        });
        local v9 = u1:NextNumber(0.11, 0.13) * 60 * 1.3;
        local CFrame2 = v4.CFrame;
        local Angles = CFrame.Angles;
        local v10 = math.random(-30, 30);
        local v11 = math.random(1, 2) == 1 and 180 or 0;
        local v12 = CFrame2 * Angles(0, 0, (math.rad(v10 + v11)));
        local v13 = ClientAssets["Sticky Fingers"]["Hypnotic Flurry"].Slash:Clone();
        v13.CFrame = v12 * CFrame.new(0, 0, -v9);
        v13.Parent = workspace.Effects;
        ParticleHandler.Emit(v13, ParticleHandler.GenerateEmitInfo(v13));

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
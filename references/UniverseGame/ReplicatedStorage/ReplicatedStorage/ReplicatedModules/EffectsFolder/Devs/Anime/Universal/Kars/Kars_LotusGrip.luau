  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);

return function(p1, p2) -- Line: 9
    -- upvalues: AssetHandler (copy), TweenService (copy), EffectsHandler (copy)
    if not (p2 and p1) then
        return;
    end;

    local v3 = AssetHandler.GetAbilityData(p1);
    local v4 = AssetHandler.CloneAsset("Particles/LotusGrip/Meshes", v3);
    v4.Parent = workspace.Effects;
    v4:SetPrimaryPartCFrame(p2);
    task.delay(2, v4.Destroy, v4);

    for _, child in v4:GetChildren() do
        if child.Name == "Shockwave" then
            TweenService:Create(child, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Transparency = 1,
                Size = child.Size * Vector3.new(3, 0.15, 3)
            }):Play();
        elseif child.Name == "Coil" then
            local v5 = TweenInfo.new(1.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
            local v6 = {
                Transparency = 1
            };
            local Orientation = child.Orientation;
            local v7 = math.random(220, 360);
            v6.Orientation = Orientation + Vector3.new(0, v7, 0);
            v6.Position = child.Position + Vector3.new(0, child.Size.Y / 2, 0);
            v6.Size = child.Size * Vector3.new(0.5, 2, 0.5);
            TweenService:Create(child, v5, v6):Play();
        end;
    end;

    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Particles/LotusGrip/Launch",
        AbilityName = "Kars",
        AutoSerialize = true,
        Origin = p2 * CFrame.Angles(1.5707963267948966, 0, 0),
        Player = game.Players:GetPlayerFromCharacter(p1)
    });
    EffectsHandler.CallEffect("Rock Debris", {
        Lifetime = 1.5,
        Size = Vector3.new(2.9, 2.9, 2.9),
        Radius = 15,
        Amount = 15,
        Origin = p2
    });
    local CallEffect = EffectsHandler.CallEffect;
    local v8 = {
        Size = Vector3.new(15, 15, 15),
        Amount = 8
    };
    local fromEulerAnglesXYZ = CFrame.fromEulerAnglesXYZ;
    local v9 = math.random(0, 360);
    v8.Origin = p2 * fromEulerAnglesXYZ(0, math.rad(v9), 0);
    CallEffect("Anubis_Laceration", v8);
    local v10 = Random.new();

    for _ = 1, math.random(15, 20) do
        local v11 = AssetHandler.CloneAsset("Particles/LotusGrip/Line", v3);
        local Angles = CFrame.Angles;
        local v12 = math.random(-360, 360);
        local v13 = math.rad(v12);
        local v14 = math.random(-360, 360);
        local v15 = math.rad(v14);
        local v16 = math.random(-360, 360);
        v11.CFrame = p2 * Angles(v13, v15, (math.rad(v16)));
        v11.Color = Color3.fromRGB(255, 255, 255);
        local v17 = v11.Size.X * v10:NextNumber(1, 1.25);
        local v18 = v11.Size.Y * v10:NextNumber(0.9, 1.15);
        local v19 = v11.Size.Z * v10:NextNumber(1, 1.25);
        v11.Size = Vector3.new(v17, v18, v19) * 0.5;
        v11.Parent = workspace.Effects;
        task.delay(0.33, v11.Destroy, v11);
        TweenService:Create(v11, TweenInfo.new(0.33, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Size = Vector3.new(0, v11.Size.Y / 2, 0),
            CFrame = v11.CFrame * CFrame.new(0, v10:NextNumber(49, 69) * 0.5, 0)
        }):Play();
    end;
end;
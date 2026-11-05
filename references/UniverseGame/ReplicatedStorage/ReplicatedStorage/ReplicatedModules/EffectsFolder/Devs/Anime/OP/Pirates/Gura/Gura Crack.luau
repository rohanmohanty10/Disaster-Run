  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local u1 = ReplicatedStorage:FindFirstChild("Client Assets");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local u2 = Random.new();

return function(p3) -- Line: 15
    -- upvalues: EffectsHandler (copy), u1 (copy), u2 (copy), TweenService (copy), LocalPlayer (copy)
    local Origin = p3.Origin;
    local CamSettings = p3.CamSettings;
    local v4 = p3.Scale or 1;
    local v5 = p3.Duration or { 0.035, 0.04 };
    EffectsHandler.CallEffect("ChronoWarden_Crack", {
        LastMultiplier = 35,
        AnimateSpawn = false,
        Origin = Origin,
        Iterations = math.ceil(4 * v4),
        BranchDuration = v5,
        BranchThickness = { 1 * v4, 1.05 * v4 },
        BranchAmount = math.random(12, 14),
        BranchLength = { 5.5 * v4, 6 * v4 },
        Color = Color3.new(0.435294, 0.54902, 1)
    });
    EffectsHandler.CallEffect("Emit Particle V3", {
        AutoSerialize = true,
        Origin = Origin * CFrame.Angles(3.141592653589793, -1.5707963267948966, 0),
        Particle = u1.Gura.QuakeRelease,
        MaxRenderDistance = 300 * v4,
        Scale = v4
    });

    for _ = 1, math.random(19, 26) do
        local v6 = u1.Gura.GlassShard:Clone();
        local v7 = u2:NextNumber(8, 11);
        local v8 = u2:NextNumber(8, 11);
        v6.Size = Vector3.new(v7, v8, u2:NextNumber(8, 11)) * v4;
        local v9 = Origin * CFrame.new(u2:NextNumber(-3, 3), u2:NextNumber(-3, 3), u2:NextNumber(-3, 3));
        local Angles = CFrame.Angles;
        local v10 = math.random(-360, 360);
        local v11 = math.rad(v10);
        local v12 = math.random(-360, 360);
        local v13 = math.rad(v12);
        local v14 = math.random(-360, 360);
        v6.CFrame = v9 * Angles(v11, v13, (math.rad(v14)));
        v6.Parent = workspace.Effects;
        task.delay(1, v6.Destroy, v6);
        local v15 = TweenInfo.new(u2:NextNumber(0.85, 1), Enum.EasingStyle.Cubic, Enum.EasingDirection.Out);
        local v16 = {
            Transparency = 1,
            Size = Vector3.new(0, 0, 0)
        };
        local v17 = v6.CFrame * CFrame.new(math.random(-35, 35), math.random(-35, 35), math.random(-35, 35));
        local Angles2 = CFrame.Angles;
        local v18 = math.random(-360, 360);
        local v19 = math.rad(v18);
        local v20 = math.random(-360, 360);
        local v21 = math.rad(v20);
        local v22 = math.random(-360, 360);
        v16.CFrame = v17 * Angles2(v19, v21, (math.rad(v22)));
        TweenService:Create(v6, v15, v16):Play();
    end;

    if CamSettings then
        local Magnitude = ((LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()).HumanoidRootPart.Position - Origin.Position).Magnitude;

        if Magnitude < 150 then
            local v23 = math.abs((150 - Magnitude) / 150);
            CamSettings[1] = CamSettings[1] * v23;
            CamSettings[2] = CamSettings[2] * v23;
            EffectsHandler.CallEffect("Camera Shake", CamSettings);
        end;
    end;
end;
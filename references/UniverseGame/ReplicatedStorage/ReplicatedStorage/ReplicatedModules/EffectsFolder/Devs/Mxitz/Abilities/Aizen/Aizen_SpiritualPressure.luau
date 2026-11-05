  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
local HttpService = game:GetService("HttpService");
local Players = game:GetService("Players");
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local u1 = { "Head", "Torso", "Left Arm", "Right Arm", "Right Leg", "Left Leg" };

return function(p2) -- Line: 12
    -- upvalues: Players (copy), EffectsHandler (copy), AssetHandler (copy), u1 (copy), ParticleHandler (copy), HttpService (copy)
    local v3 = p2 or {};
    local v4 = v3.character or error("no character");
    local v5 = v3.bubbleSize or 12;
    local HumanoidRootPart = v4:FindFirstChild("HumanoidRootPart");
    local v6 = Players:GetPlayerFromCharacter(v4);
    EffectsHandler.CallEffect("Bubble Distortion", {
        Transparency = 15,
        Time = 1,
        Origin = CFrame.new(HumanoidRootPart.Position),
        StartSize = Vector3.new(1, 1, 1) * v5 * 2.5,
        EndSize = Vector3.new(1, 1, 1) * v5 * 2.5
    });
    EffectsHandler.CallEffect("HighlightObject", v4, {
        OutlineTransparency = 0.99,
        FillTransparency = -10,
        Lifetime = 0.45,
        Style = "Circular",
        Direction = "Out",
        Tween = true,
        DepthMode = Enum.HighlightDepthMode.Occluded,
        FillColor = Color3.fromRGB(105, 198, 255),
        OutlineColor = Color3.fromRGB(255, 255, 255)
    });
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Particles/SpiritualPressure",
        AutoSerialize = true,
        Origin = HumanoidRootPart.CFrame * CFrame.new(0, -3.5, 0),
        Player = v6,
        Character = v4
    });
    EffectsHandler.CallEffect("Mesh Shockwave", HumanoidRootPart.CFrame * CFrame.new(0, -3, 0) * CFrame.Angles(1.5707963267948966, 0, 0));
    local v7 = AssetHandler.GetAsset("Particles/PressureUserEnable", AssetHandler.GetAbilityData(v6 or v4));
    local u8 = {};

    if v7 then
        for _, v in u1 do
            local v9 = v4:FindFirstChild(v);

            if v9 then
                for _, child in v7:GetChildren() do
                    local v10 = child:Clone();
                    v10.Parent = v9;
                    ParticleHandler.EnableParticle(v10, true);
                    table.insert(u8, v10);
                end;
            end;
        end;
    end;

    local v11 = AssetHandler.CloneAsset("Particles/GroundCharge", AssetHandler.GetAbilityData(v6 or v4));
    v11.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, -2.58, 0);
    v11.Parent = workspace.Effects;
    local v12 = ParticleHandler.EnableAllParticles(v11, true);
    task.delay(0.5, ParticleHandler.EnableAllParticles, v11, false);
    task.delay(0.5 + v12, v11.Destroy, v11);
    task.delay(0.5, function() -- Line: 83
        -- upvalues: u8 (copy), ParticleHandler (ref)
        for _, v in u8 do
            task.delay(ParticleHandler.EnableParticle(v, false), v.Destroy, v);
        end;
    end);
    local v13 = `{HttpService:GenerateGUID(false)}{os.clock()}`;
    v4:SetAttribute(v13, true);
    task.delay(0.5, v4.SetAttribute, v4, v13, nil);
    EffectsHandler.CallEffect("Nocturnus_LightningAura", {
        Radius = 10,
        WaitTime = 0.1,
        Size = Vector2.new(0.25, 0.45),
        Height = Vector2.new(5, 10),
        Character = v4,
        Part = HumanoidRootPart,
        Color = ColorSequence.new(Color3.fromRGB(105, 198, 255), Color3.fromRGB(0, 0, 0)),
        Attribute = v13
    });
end;
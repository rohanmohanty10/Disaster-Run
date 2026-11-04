 

 

local CollectionService = game:GetService("CollectionService");
local v1 = {};
local u2 = {
    CopperBite = { 184, 113, 64, "sparkles", 2 },
    Ashsteel = { 164, 181, 192, "sparkles", 2 },
    IronFang = { 189, 218, 237, "sparkles", 2 },
    ForestEdge = { 102, 194, 113, "sparkles", 2 },
    AmberSting = { 255, 179, 51, "sparkles", 4 },
    RoseQuartz = { 255, 134, 200, "sparkles", 4 },
    TidalShard = { 71, 207, 255, "smoke", 4 },
    VenomThorn = { 143, 248, 61, "smoke", 4 },
    MoltenFang = { 255, 96, 25, "fire", 8 },
    SpectralReaper = { 113, 247, 194, "smoke", 7 },
    StormTalon = { 106, 179, 255, "sparkles", 12 },
    Moonfang = { 195, 177, 255, "sparkles", 6 },
    SolarPhoenix = { 255, 195, 53, "fire", 12 },
    VoidSovereign = { 157, 70, 255, "smoke", 10 },
    Voidspine = { 157, 70, 255, "smoke", 10 },
    Bloodthorn = { 157, 70, 255, "smoke", 10 },
    VipersFang = { 157, 70, 255, "smoke", 10 },
    GlacialCrown = { 135, 236, 255, "sparkles", 12 },
    CelestialDragon = { 255, 127, 199, "fire", 10 },
    BaseDagger = { 185, 208, 223, "sparkles", 1 },
    SpoonDagger = { 185, 255, 237, "sparkles", 2 },
    BalloonDagger = { 255, 122, 184, "sparkles", 3 },
    Hotdog = { 255, 196, 64, "sparkles", 10 },
    NumberOneFan = { 240, 60, 66, "sparkles", 10 },
    SelfieStick = { 255, 236, 245, "sparkles", 6 }
};

function v1.apply(p3) -- Line: 31
    -- upvalues: u2 (copy), CollectionService (copy)
    local v4 = u2[p3.Name];

    if p3:GetAttribute("Rarity") ~= "Epic" and p3:GetAttribute("Rarity") ~= "Legendary" then
        for _, child in p3:GetChildren() do
            if child:GetAttribute("KnifeVFXGenerated") then
                child:Destroy();
            end;
        end;

        return false;
    end;

    if not v4 then
        return false;
    end;

    for _, child in p3:GetChildren() do
        if child:GetAttribute("KnifeVFXGenerated") then
            child:Destroy();
        end;
    end;

    local Color3_fromRGB_ret = Color3.fromRGB(v4[1], v4[2], v4[3]);

    for _, v in { "Blade", "StowedBlade" } do
        local v5 = p3:FindFirstChild(v);

        if v5 and v5:IsA("BasePart") then
            local Part = Instance.new("Part");
            Part.Name = v .. "Aura";
            Part.Size = Vector3.new(0.1, 0.1, 0.1);
            Part.Transparency = 1;
            Part.CanCollide = false;
            Part.CanTouch = false;
            Part.CanQuery = false;
            Part.CastShadow = false;
            Part.Massless = true;
            Part.CFrame = v5.CFrame;
            Part:SetAttribute("WeaponVFX", true);
            Part:SetAttribute("KnifeVFXGenerated", true);
            local Weld = Instance.new("Weld");
            Weld.Name = "VFXWeld";
            Weld.Part0 = v5;
            Weld.Part1 = Part;
            Weld.Parent = Part;
            local v6 = p3:GetAttribute("FantasyCrateSkin") == true;
            local v7 = p3:GetAttribute("BladeAxis") == "Y";
            local v8;

            if v7 then
                v8 = v5.Size.Y;
            elseif v6 then
                v8 = v5.Size.X;
            else
                v8 = v5.Size.Z;
            end;

            local v9 = v7 and Vector3.new(0, 1, 0) or (v6 and Vector3.new(1, 0, 0) or Vector3.new(-0, -0, -1));
            local Attachment = Instance.new("Attachment");
            Attachment.Name = "EdgeTip";
            Attachment.Position = v9 * v8 * 0.42;
            Attachment.Parent = Part;
            local Attachment2 = Instance.new("Attachment");
            Attachment2.Name = "EdgeHeel";
            Attachment2.Position = v9 * -v8 * 0.1;
            Attachment2.Parent = Part;
            local Trail = Instance.new("Trail");
            Trail.Name = "BladeStreak";
            Trail.Attachment0 = Attachment2;
            Trail.Attachment1 = Attachment;
            Trail.Color = ColorSequence.new(Color3_fromRGB_ret, Color3.new(1, 1, 1));
            Trail.Lifetime = v4[5] >= 7 and 0.24 or 0.12;
            Trail.MinLength = 0.08;
            Trail.LightEmission = 0.85;
            Trail.FaceCamera = true;
            Trail.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.48), NumberSequenceKeypoint.new(1, 1) });
            Trail.WidthScale = NumberSequence.new(1, 0);
            Trail.Enabled = false;
            Trail:SetAttribute("VFXAuthoredEnabled", true);
            Trail.Parent = Part;
            local ParticleEmitter = Instance.new("ParticleEmitter");
            ParticleEmitter.Name = p3.Name .. "Motes";
            ParticleEmitter.Texture = "rbxasset://textures/particles/" .. v4[4] .. "_main.dds";
            ParticleEmitter.Color = ColorSequence.new(Color3_fromRGB_ret, Color3_fromRGB_ret:Lerp(Color3.new(1, 1, 1), 0.65));
            ParticleEmitter.LightEmission = 0.8;
            ParticleEmitter.LightInfluence = 0;
            ParticleEmitter.Rate = v4[5];
            ParticleEmitter:SetAttribute("VFXBaseRate", v4[5]);
            ParticleEmitter:SetAttribute("VFXAuthoredEnabled", true);
            ParticleEmitter.Lifetime = NumberRange.new(0.25, v4[4] == "smoke" and 0.85 or 0.55);
            ParticleEmitter.Speed = NumberRange.new(0.15, v4[4] == "fire" and 1.6 or 0.7);
            ParticleEmitter.Acceleration = Vector3.new(0, v4[4] == "fire" and 2 or 0.5, 0);
            ParticleEmitter.SpreadAngle = Vector2.new(80, 80);
            ParticleEmitter.Rotation = NumberRange.new(0, 360);
            ParticleEmitter.RotSpeed = NumberRange.new(-90, 90);
            ParticleEmitter.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(0.2, v4[4] == "smoke" and 0.3 or 0.14), NumberSequenceKeypoint.new(1, 0) });
            ParticleEmitter.Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.2, 0.25), NumberSequenceKeypoint.new(1, 1) });
            ParticleEmitter.Enabled = false;
            ParticleEmitter.Parent = Attachment;
            Part.Parent = p3;
            CollectionService:AddTag(Part, "ValleyWeaponVFX");
        end;
    end;

    return true;
end;

return v1;
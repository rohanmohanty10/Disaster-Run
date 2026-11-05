  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local Players = game:GetService("Players");
local Debris = game:GetService("Debris");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local SoundGroups = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("SoundGroups"));
local u1 = { 2567841967 };
local _ = game:GetService("SoundService").StandSounds;

local function SFX(p2, p3, p4) -- Line: 17
    -- upvalues: AssetHandler (copy), SoundGroups (copy)
    local v5 = AssetHandler.CloneAsset("Mayhem/Sounds/" .. p2, {
        AbilityName = "KillEffects"
    });
    SoundGroups:AssignSoundTag(v5);
    v5.Parent = p3;

    if p4 then
        for i, v in p4 do
            v5[i] = v;
        end;

        table.clear(p4);
    end;

    v5:Play();

    return v5;
end;

local function TeleportationVFX(p6) -- Line: 31
    -- upvalues: EffectsHandler (copy)
    if not p6 then
        return;
    end;

    EffectsHandler.CallEffect("Glitcher Sphere", {
        Type = "Add",
        MeshSize = Vector3.new(0.1, 0.1, 0.1),
        Speed = 3,
        Value = 0.25,
        OuterPosition = 0,
        CFrame = p6.CFrame,
        Color = Color3.new(1, 0, 0)
    });

    for _ = 1, 20 do
        local CallEffect = EffectsHandler.CallEffect;
        local v7 = {
            BonusSpeed = 1,
            Type = "Add",
            MeshSize = Vector3.new(3, 3, 3),
            Value = 0.06,
            OuterPosition = 0,
            Speed = math.random(4, 8)
        };
        local CFrame2 = p6.CFrame;
        local Angles = CFrame.Angles;
        local v8 = math.random(-360, 360);
        local v9 = math.rad(v8);
        local v10 = math.random(-360, 360);
        local v11 = math.rad(v10);
        local v12 = math.random(-360, 360);
        v7.CFrame = CFrame2 * Angles(v9, v11, (math.rad(v12)));
        v7.Color = Color3.new(1, 0, 0);
        CallEffect("Glitcher Pixelblock", v7);
    end;

    for _ = 1, 9 do
        local CallEffect = EffectsHandler.CallEffect;
        local v13 = {
            BonusSpeed = 3,
            Type = "Add",
            MeshSize = Vector3.new(1, 1, 10),
            Speed = 0.25,
            Value = -0.01,
            OuterPosition = 0
        };
        local CFrame2 = p6.CFrame;
        local Angles = CFrame.Angles;
        local v14 = math.random(-360, 360);
        local v15 = math.rad(v14);
        local v16 = math.random(-360, 360);
        local v17 = math.rad(v16);
        local v18 = math.random(-360, 360);
        v13.CFrame = CFrame2 * Angles(v15, v17, (math.rad(v18)));
        v13.Color = Color3.new(1, 0, 0);
        CallEffect("Glitcher SphereMK", v13);
    end;
end;

return function(p19) -- Line: 69
    -- upvalues: Players (copy), u1 (copy), AssetHandler (copy), Debris (copy), SoundGroups (copy), TeleportationVFX (copy), EffectsHandler (copy), SFX (copy)
    local TargetCharacter = p19.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local KillerPlayer = p19.KillerPlayer;
    local HumanoidRootPart = KillerPlayer.Character.HumanoidRootPart;
    local HumanoidRootPart2 = TargetCharacter:FindFirstChild("HumanoidRootPart");
    local v20 = Players:GetPlayerFromCharacter(TargetCharacter);

    if not HumanoidRootPart2 then
        return;
    end;

    if v20 and table.find(u1, v20.UserId) or table.find(u1, KillerPlayer.UserId) then
        return;
    end;

    local v21 = AssetHandler.CloneAsset("Mayhem/Models/Apparition", {
        AbilityName = "KillEffects"
    });
    local HumanoidRootPart3 = v21.HumanoidRootPart;
    local Animator = v21.Humanoid.Animator;
    Debris:AddItem(v21, 6.75);

    for _, child in v21:GetChildren() do
        if child:IsA("BasePart") then
            child.CollisionGroup = "Ghosted";
            child.CanCollide = false;
        end;
    end;

    for _, child in TargetCharacter:GetChildren() do
        if child:IsA("BasePart") then
            child.CollisionGroup = "Ghosted";
            child.CanCollide = false;

            if child == HumanoidRootPart2 then
                child.Anchored = true;
            end;
        end;
    end;

    v21.Parent = workspace.Effects;
    Animator:LoadAnimation(AssetHandler.GetAsset("Mayhem/Animation", {
        AbilityName = "KillEffects"
    })):Play(0, 1, 0.75);
    v21.Wings.Anim.Animator:LoadAnimation(AssetHandler.GetAsset("Mayhem/WingAnimation", {
        AbilityName = "KillEffects"
    })):Play(0, 1, 1);
    local v22 = AssetHandler.CloneAsset("Mayhem/Sounds/Shing", {
        AbilityName = "KillEffects"
    });
    SoundGroups:AssignSoundTag(v22);
    v22.Parent = HumanoidRootPart3;
    v22:Play();
    HumanoidRootPart3.CFrame = HumanoidRootPart2.CFrame * CFrame.new(0, 0.9, 3.25);
    local v23 = HumanoidRootPart or HumanoidRootPart3;
    local v24 = AssetHandler.CloneAsset("Mayhem/Sounds/Shing", {
        AbilityName = "KillEffects"
    });
    SoundGroups:AssignSoundTag(v24);
    v24.Parent = v23;
    v24:Play();
    TeleportationVFX(v23);
    local v25 = AssetHandler.CloneAsset("Mayhem/Sounds/Shing", {
        AbilityName = "KillEffects"
    });
    SoundGroups:AssignSoundTag(v25);
    v25.Parent = HumanoidRootPart3;
    v25:Play();
    TeleportationVFX(HumanoidRootPart3);
    EffectsHandler.Wait(0.05);
    local v26 = AssetHandler.CloneAsset("Mayhem/Sounds/Grab", {
        AbilityName = "KillEffects"
    });
    SoundGroups:AssignSoundTag(v26);
    v26.Parent = HumanoidRootPart3;
    v26:Play();
    local v27 = AssetHandler.CloneAsset("Mayhem/Sounds/GrabEcho", {
        AbilityName = "KillEffects"
    });
    SoundGroups:AssignSoundTag(v27);
    v27.Parent = HumanoidRootPart3;
    v27:Play();
    EffectsHandler.CallEffect("Event Shake", {
        Intensity = 8.5,
        Length = 2,
        Distance = 40,
        Origin = HumanoidRootPart2.Position
    });
    EffectsHandler.Wait(0.225);
    local v28 = AssetHandler.CloneAsset("Mayhem/Sounds/HeartbreakEcho", {
        AbilityName = "KillEffects"
    });
    SoundGroups:AssignSoundTag(v28);
    v28.Parent = HumanoidRootPart3;
    v28:Play();
    local v29 = AssetHandler.CloneAsset("Mayhem/Sounds/GrabEcho", {
        AbilityName = "KillEffects"
    });
    SoundGroups:AssignSoundTag(v29);
    v29.Parent = HumanoidRootPart3;
    v29:Play();
    local v30 = AssetHandler.CloneAsset("Mayhem/Sounds/Voiceline", {
        AbilityName = "KillEffects"
    });
    SoundGroups:AssignSoundTag(v30);
    v30.Parent = HumanoidRootPart3;
    v30:Play();
    EffectsHandler.Wait(0.3);
    EffectsHandler.CallEffect("Event Shake", {
        Intensity = 12.5,
        Length = 2,
        Distance = 45,
        Origin = HumanoidRootPart2.Position
    });
    local v50 = task.spawn(function() -- Line: 139
        -- upvalues: HumanoidRootPart2 (copy), EffectsHandler (ref)
        while true do
            task.wait();

            if not (HumanoidRootPart2 and HumanoidRootPart2.Parent) then
                break;
            end;

            local v31 = HumanoidRootPart2.CFrame * CFrame.new(0, 1.5, 0);
            local CallEffect = EffectsHandler.CallEffect;
            local v32 = {
                BonusSpeed = 5,
                RotationSpeed = 5,
                MeshType = "Round",
                Type = "Add",
                Transparency = "Out",
                Size = Vector3.new(0.025, 0.025, 0.025)
            };
            local Angles = CFrame.Angles;
            local v33 = math.random(-360, 360);
            local v34 = math.rad(v33);
            local v35 = math.random(-360, 360);
            local v36 = math.rad(v35);
            local v37 = math.random(-360, 360);
            v32.CFrame = v31 * Angles(v34, v36, (math.rad(v37)));
            v32.Value = math.random(25, 200);
            v32.Color = Color3.new(0.65, 0, 0);
            CallEffect("Glitcher Slash", v32);
            local CallEffect2 = EffectsHandler.CallEffect;
            local v38 = {
                BonusSpeed = 1.35,
                Type = "Add",
                MeshSize = Vector3.new(3, 3, 3),
                Value = 0.03,
                OuterPosition = 0,
                Speed = math.random(7, 12)
            };
            local Angles2 = CFrame.Angles;
            local v39 = math.random(-360, 360);
            local v40 = math.rad(v39);
            local v41 = math.random(-360, 360);
            local v42 = math.rad(v41);
            local v43 = math.random(-360, 360);
            v38.CFrame = v31 * Angles2(v40, v42, (math.rad(v43)));
            v38.Color = Color3.new(1, 0, 0);
            CallEffect2("Glitcher Pixelblock", v38);
            local CallEffect3 = EffectsHandler.CallEffect;
            local v44 = {
                Type = "Add",
                Scale = Vector3.new(3.5, 3.5, 3.5),
                X = -0.1,
                Y = 2,
                Z = -0.1,
                BonusSpeed = math.random(10, 75) / 10
            };
            local Angles3 = CFrame.Angles;
            local v45 = math.random(-360, 360);
            local v46 = math.rad(v45);
            local v47 = math.random(-360, 360);
            local v48 = math.rad(v47);
            local v49 = math.random(-360, 360);
            v44.CFrame = v31 * Angles3(v46, v48, (math.rad(v49)));
            v44.Color = Color3.new(1, 0, 0);
            CallEffect3("Glitcher Sphere2", v44);
            EffectsHandler.CallEffect("Glitcher Blink", {
                Image = 2092248396,
                Size = 0,
                Delay = 0.25,
                Parent = HumanoidRootPart2,
                Color = Color3.new(1, 0, 0),
                BonusSize = math.random(3, 35),
                RotationSpeed = math.random(3, 9)
            });
        end;
    end);
    EffectsHandler.Wait(0.425);
    EffectsHandler.CallEffect("Event Shake", {
        Intensity = 20,
        Length = 4,
        Distance = 50,
        Origin = HumanoidRootPart2.Position
    });
    SFX("Explosion", HumanoidRootPart3, {
        PlaybackSpeed = 0.9
    });
    SFX("Explosion", HumanoidRootPart3, {
        PlaybackSpeed = 0.75
    });
    SFX("Heartbreak", HumanoidRootPart3, {
        PlaybackSpeed = 0.9
    });
    local v51 = AssetHandler.CloneAsset("Mayhem/Sounds/Heartbreak", {
        AbilityName = "KillEffects"
    });
    SoundGroups:AssignSoundTag(v51);
    v51.Parent = HumanoidRootPart3;
    v51:Play();
    local v52 = AssetHandler.CloneAsset("Mayhem/Sounds/Lightning", {
        AbilityName = "KillEffects"
    });
    SoundGroups:AssignSoundTag(v52);
    v52.Parent = HumanoidRootPart3;
    v52:Play();
    local v53 = AssetHandler.CloneAsset("Mayhem/Sounds/Explosion2", {
        AbilityName = "KillEffects"
    });
    SoundGroups:AssignSoundTag(v53);
    v53.Parent = HumanoidRootPart3;
    v53:Play();
    local v54 = AssetHandler.CloneAsset("Mayhem/Sounds/Smack", {
        AbilityName = "KillEffects"
    });
    SoundGroups:AssignSoundTag(v54);
    v54.Parent = HumanoidRootPart3;
    v54:Play();
    local v55 = AssetHandler.CloneAsset("Mayhem/Sounds/Knife", {
        AbilityName = "KillEffects"
    });
    SoundGroups:AssignSoundTag(v55);
    v55.Parent = HumanoidRootPart3;
    v55:Play();
    pcall(task.cancel, v50);
    EffectsHandler.CallEffect("Glitcher Kill", TargetCharacter);
    local v56 = HumanoidRootPart2.CFrame * CFrame.new(0, 1.5, 0);

    for _ = 1, 9 do
        local CallEffect = EffectsHandler.CallEffect;
        local v57 = {
            BonusSpeed = 5,
            RotationSpeed = 1.75,
            MeshType = "Round",
            Type = "Add",
            Transparency = "Out",
            Size = Vector3.new(0.04, 0.04, 0.04)
        };
        local Angles = CFrame.Angles;
        local v58 = math.random(-360, 360);
        local v59 = math.rad(v58);
        local v60 = math.random(-360, 360);
        local v61 = math.rad(v60);
        local v62 = math.random(-360, 360);
        v57.CFrame = v56 * Angles(v59, v61, (math.rad(v62)));
        v57.Value = math.random(50, 300);
        v57.Color = Color3.new(0.65, 0, 0);
        CallEffect("Glitcher Slash", v57);
        local CallEffect2 = EffectsHandler.CallEffect;
        local v63 = {
            BonusSpeed = 2,
            Type = "Add",
            MeshSize = Vector3.new(3.5, 3.5, 3.5),
            Value = 0.04,
            OuterPosition = 0,
            Speed = math.random(3, 10)
        };
        local Angles2 = CFrame.Angles;
        local v64 = math.random(-360, 360);
        local v65 = math.rad(v64);
        local v66 = math.random(-360, 360);
        local v67 = math.rad(v66);
        local v68 = math.random(-360, 360);
        v63.CFrame = v56 * Angles2(v65, v67, (math.rad(v68)));
        v63.Color = Color3.new(1, 0, 0);
        CallEffect2("Glitcher Pixelblock", v63);
        local CallEffect3 = EffectsHandler.CallEffect;
        local v69 = {
            Type = "Add",
            Scale = Vector3.new(3.75, 3.75, 3.75),
            X = -0.15,
            Y = 1.75,
            Z = -0.15,
            BonusSpeed = math.random(20, 100) / 10
        };
        local Angles3 = CFrame.Angles;
        local v70 = math.random(-360, 360);
        local v71 = math.rad(v70);
        local v72 = math.random(-360, 360);
        local v73 = math.rad(v72);
        local v74 = math.random(-360, 360);
        v69.CFrame = v56 * Angles3(v71, v73, (math.rad(v74)));
        v69.Color = Color3.new(1, 0, 0);
        CallEffect3("Glitcher Sphere2", v69);
    end;

    for i = 1, 3 do
        EffectsHandler.CallEffect("Glitcher Blink", {
            Image = 2092248396,
            Size = 0,
            BonusSize = 30,
            Parent = HumanoidRootPart2,
            Color = Color3.new(1, 0, 0),
            Delay = i + (i >= 3 and (i / 3 or 0) or 0)
        });
    end;

    EffectsHandler.Wait(0.4);
    local v75 = HumanoidRootPart or HumanoidRootPart3;
    local v76 = AssetHandler.CloneAsset("Mayhem/Sounds/Shing", {
        AbilityName = "KillEffects"
    });
    SoundGroups:AssignSoundTag(v76);
    v76.Parent = v75;
    v76:Play();
    TeleportationVFX(v75);
    local v77 = AssetHandler.CloneAsset("Mayhem/Sounds/Shing", {
        AbilityName = "KillEffects"
    });
    SoundGroups:AssignSoundTag(v77);
    v77.Parent = HumanoidRootPart3;
    v77:Play();
    TeleportationVFX(HumanoidRootPart3);

    for _, descendant in v21:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.Transparency = 1;
        elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
            descendant:Destroy();
        end;
    end;
end;
  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local SoundGroups = require(game:GetService("ReplicatedStorage"):WaitForChild("ReplicatedModules"):WaitForChild("SoundGroups"));

return function(p1) -- Line: 10
    -- upvalues: AssetHandler (copy), TweenService (copy), ParticleHandler (copy), SoundGroups (copy), EffectsHandler (copy)
    local TargetCharacter = p1.TargetCharacter;

    if not TargetCharacter then
        return;
    end;

    local CFrame2 = TargetCharacter:FindFirstChild("HumanoidRootPart").CFrame;
    local u2 = AssetHandler.GetAsset("Crosshead/Animations", {
        AbilityName = "KillEffects"
    });
    local u3 = AssetHandler.CloneAsset("Crosshead/Model", {
        AbilityName = "KillEffects"
    });
    u3.Parent = workspace.Effects;
    u3:PivotTo(CFrame2 * CFrame.new(0, 0, 6));
    task.delay(7.5, u3.Destroy, u3);

    for _, descendant in u3:GetDescendants() do
        if (descendant:IsA("Decal") or descendant:IsA("BasePart")) and not string.find(descendant.Name, "HumanoidRootPart") then
            TweenService:Create(descendant, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Transparency = 0
            }):Play();
        end;
    end;

    ParticleHandler.EnableAllParticles(u3, true);
    local v4 = u3.Humanoid.Animator:LoadAnimation(u2.Summon);
    v4:Play();
    local summon = u3.Stand.StandHumanoidRootPart.summon;
    SoundGroups:AssignSoundTag(summon);
    summon:Play();
    v4.Stopped:Wait();
    local swing = u3.Stand.StandHumanoidRootPart.swing;
    SoundGroups:AssignSoundTag(swing);
    swing:Play();
    local v5 = u3.Humanoid.Animator:LoadAnimation(u2.Crush);
    v5:Play();
    task.delay(0.31666666666666665, function() -- Line: 51
        -- upvalues: u3 (copy), SoundGroups (ref), EffectsHandler (ref), TargetCharacter (copy), CFrame2 (copy)
        local hit = u3.Stand.StandHumanoidRootPart.hit;
        SoundGroups:AssignSoundTag(hit);
        hit:Play();
        hit:Play();
        EffectsHandler.CallEffect("SK_VANISH", {
            Transparency = 1,
            Character = TargetCharacter
        });
        EffectsHandler.CallEffect("Final Heroic Strike", {
            LookVector = Vector3.new(0, -1, 0),
            Radius = 30,
            Meshes = false,
            Origin = CFrame2
        });
    end);
    v5.Stopped:Connect(function() -- Line: 70
        -- upvalues: u3 (copy), SoundGroups (ref), u2 (copy), TweenService (ref), ParticleHandler (ref)
        local despawn = u3.Stand.StandHumanoidRootPart.despawn;
        SoundGroups:AssignSoundTag(despawn);
        despawn:Play();
        u3.Humanoid.Animator:LoadAnimation(u2.Desummon):Play();

        for _, descendant in u3:GetDescendants() do
            if descendant:IsA("Decal") or descendant:IsA("BasePart") then
                TweenService:Create(descendant, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
                ParticleHandler.EnableAllParticles(u3, false);
            end;
        end;
    end);
end;
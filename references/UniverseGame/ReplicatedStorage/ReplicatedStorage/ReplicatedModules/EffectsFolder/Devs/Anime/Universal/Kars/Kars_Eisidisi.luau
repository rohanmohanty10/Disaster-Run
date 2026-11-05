  

 

game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local _ = Players.LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
require(PathShortcuts.KnitPath.Knit);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local Common = require(PathShortcuts.ReplicatedModules.StatsFolder.Kars.Kars.Common);

return function(p1) -- Line: 20
    -- upvalues: Players (copy), Common (copy), TweenService (copy), AssetHandler (copy), ParticleHandler (copy), EffectsHandler (copy)
    local Character = p1.Character;
    local Animation = p1.Animation;
    local Speed = p1.Speed;
    local Sounds = p1.Sounds;
    local Positions = p1.Positions;
    local v2 = p1.FinishFrame or 37;
    local IsLaunch = p1.IsLaunch;
    local _ = Character.HumanoidRootPart;
    local v3 = Players:GetPlayerFromCharacter(Character);
    local v4;

    if v3 then
        v4 = v3.Data.Skin:GetAttribute("SkinName");
    else
        v4 = v3;
    end;

    local v5 = CFrame.new(Positions[1], Positions[2]);
    local u6 = Common:GetPillarmanModel("Eisidisi", {
        AbilityName = "Kars",
        Player = v3,
        SkinName = v4
    });
    u6.HumanoidRootPart.CFrame = v5;
    u6.Parent = workspace.Effects;
    task.delay(2 / Speed, u6.Destroy, u6);
    local Animation2 = Instance.new("Animation");
    Animation2.AnimationId = Animation;
    Animation2.Parent = u6;
    (u6:FindFirstChild("Humanoid") or u6:FindFirstChild("AnimationController")).Animator:LoadAnimation(Animation2):Play(nil, nil, Speed);

    for i, v in Sounds do
        local v7 = v:Clone();
        v7.Parent = u6.HumanoidRootPart;
        Sounds[i] = v7;
    end;

    Sounds.SFX:Play();
    Sounds.Voiceline:Play();

    for _, descendant in ipairs(u6:GetDescendants()) do
        if descendant:IsA("BasePart") then
            local Transparency = descendant.Transparency;
            descendant.Transparency = 1;
            TweenService:Create(descendant, TweenInfo.new(0.12 / Speed, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Transparency = Transparency
            }):Play();
        end;
    end;

    local HumanoidRootPart = u6.HumanoidRootPart;

    if IsLaunch then
        local v8 = AssetHandler.GetAbilityData(Character);
        local v9 = ParticleHandler.GetUnusualHSVData({
            Character = Character
        });
        local u10 = 0;
        local u11 = {};

        for i = 1, 3 do
            local v12 = u10 + i / 3 * 6.283185307179586;
            local v13 = AssetHandler.CloneAsset("Particles/BloodCascade/Trail", v8);
            v13.CFrame = u6.Torso.CFrame * CFrame.new(math.cos(v12) * 5, 0, -math.sin(v12) * 5);

            if v9 ~= nil then
                ParticleHandler.Unusualify(v13, {
                    HSVData = v9
                });
            end;

            v13.Parent = u6;
            table.insert(u11, v13);
        end;

        local u14 = nil;
        u14 = game["Run Service"].RenderStepped:Connect(function(p15) -- Line: 100
            -- upvalues: u6 (copy), u14 (ref), u10 (ref), u11 (copy), TweenService (ref)
            if u6:IsDescendantOf(game) then
                u10 = u10 + 9.42477796076938 * p15 % 6.283185307179586;

                for i, v in u11 do
                    local v16 = u10 + i / #u11 * 6.283185307179586;
                    TweenService:Create(v, TweenInfo.new(p15, Enum.EasingStyle.Linear), {
                        CFrame = u6.Torso.CFrame * CFrame.new(math.cos(v16) * 5, 0, -math.sin(v16) * 5)
                    }):Play();
                end;

                return;
            end;

            u14:Disconnect();
            u14 = nil;
        end);
        local v17 = (Positions[1] + Positions[2]) / 2 + Vector3.new(0, (Positions[1] - Positions[2]).Magnitude / 1.5, 0);

        for i = 1, 10 do
            local v18 = task.wait(v2 / 60 / Speed / 10);
            local v19 = i / 10;
            local v20 = (1 - v19) ^ 2 * Positions[1] + 2 * (1 - v19) * v19 * v17 + v19 ^ 2 * Positions[2];
            TweenService:Create(HumanoidRootPart, TweenInfo.new(v18, Enum.EasingStyle.Linear), {
                CFrame = CFrame.new(v20, v20 + v5.LookVector)
            }):Play();
        end;

        for _, v in u11 do
            task.delay(ParticleHandler.EnableAllParticles(v, false), v.Destroy, v);
        end;
    else
        local Magnitude = (Positions[1] - Positions[2]).Magnitude;
        task.spawn(EffectsHandler.CallEffect, "Rock Trail", {
            Offset = 3.5,
            Size = 1.5,
            Duration = 1,
            DurationOffset = 0.1,
            Down = true,
            Origin = HumanoidRootPart.CFrame,
            LookVector = HumanoidRootPart.CFrame.LookVector,
            Distance = Magnitude,
            Amount = math.ceil(Magnitude / 2),
            SpawnDelay = 0.017 / Speed
        });
        local v21 = TweenService:Create(HumanoidRootPart, TweenInfo.new(v2 / 60 / Speed, Enum.EasingStyle.Linear), {
            CFrame = CFrame.new(Positions[2], Positions[2] + v5.LookVector)
        });
        v21:Play();
        v21.Completed:Wait();
        task.wait(0.35 / Speed);
    end;

    task.delay(0.12 / Speed, function() -- Line: 165
        -- upvalues: u6 (copy), TweenService (ref), Speed (copy)
        if not u6:IsDescendantOf(game) then
            return;
        end;

        for _, descendant in ipairs(u6:GetDescendants()) do
            if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
                TweenService:Create(descendant, TweenInfo.new(0.25 / Speed, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    Transparency = 1
                }):Play();
            elseif descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or descendant:IsA("Beam")) then
                descendant.Enabled = false;
            end;
        end;
    end);
end;
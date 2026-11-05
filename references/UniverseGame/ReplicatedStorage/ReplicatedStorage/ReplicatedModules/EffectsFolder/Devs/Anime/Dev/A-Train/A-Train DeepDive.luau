  

 

game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local _ = Players.LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.ReplicatedModules.EffectsHandler);
local AssetHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.ReplicatedModules.StatsFolder.Kars.Kars.Common);
local u1 = RaycastParams.new();
u1.FilterType = Enum.RaycastFilterType.Include;
u1.FilterDescendantsInstances = { workspace.Map };

local function Bezier(p2, p3, p4, p5) -- Line: 24
    return (1 - p2) ^ 2 * p3 + 2 * (1 - p2) * p2 * p4 + p2 ^ 2 * p5;
end;

return function(p6) -- Line: 28
    -- upvalues: Players (copy), AssetHandler (copy), ParticleHandler (copy), TweenService (copy), u1 (copy)
    local Character = p6.Character;
    local Animation = p6.Animation;
    local Speed = p6.Speed;
    local Sounds = p6.Sounds;
    local Positions = p6.Positions;
    local FinishFrame = p6.FinishFrame;
    local _ = Character.HumanoidRootPart;
    local v7 = Players:GetPlayerFromCharacter(Character);

    if v7 then
        v7.Data.Skin:GetAttribute("SkinName");
    end;

    local v8 = CFrame.new(Positions[1], Positions[2]);
    local u9 = AssetHandler.CloneAsset("Models/The Deep", {
        AbilityName = "UGrain Dev"
    });
    u9.HumanoidRootPart.CFrame = v8;
    u9.HumanoidRootPart.Anchored = true;
    u9.Parent = workspace.Effects;
    local u10 = AssetHandler.CloneAsset("Particles/DrippingTrail", {
        AbilityName = "UGrain Dev"
    });
    u10.Parent = workspace.Effects;
    ParticleHandler.EnableAllParticles(u10, true);
    task.delay(FinishFrame / 60 / Speed, function() -- Line: 55
        -- upvalues: ParticleHandler (ref), u9 (copy), u10 (copy)
        ParticleHandler.EnableAllParticles(u9, false);
        ParticleHandler.DestroyEmit(u9);
        ParticleHandler.EnableAllParticles(u10, false);
        ParticleHandler.DestroyEmit(u10);
    end);
    local Animation2 = Instance.new("Animation");
    Animation2.AnimationId = Animation;
    Animation2.Parent = u9;
    (u9:FindFirstChild("Humanoid") or u9:FindFirstChild("AnimationController")).Animator:LoadAnimation(Animation2):Play(nil, nil, Speed);

    for i, v in Sounds do
        local v11 = v:Clone();
        v11.Parent = u9.HumanoidRootPart;
        Sounds[i] = v11;
    end;

    if Sounds.SFX then
        Sounds.SFX:Play();
    end;

    if Sounds.Voiceline then
        Sounds.Voiceline:Play();
    end;

    for _, descendant in ipairs(u9:GetDescendants()) do
        if descendant:IsA("BasePart") then
            local Transparency = descendant.Transparency;
            descendant.Transparency = 1;
            TweenService:Create(descendant, TweenInfo.new(0.5 / Speed, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Transparency = Transparency
            }):Play();
        end;
    end;

    local HumanoidRootPart = u9.HumanoidRootPart;
    local u12 = 0;
    local u13 = {};

    for i = 1, 3 do
        local v14 = u12 + i / 3 * 6.283185307179586;
        local v15 = AssetHandler.CloneAsset("Particles/WaterTrail", {
            AbilityName = "UGrain Dev"
        });
        v15.CFrame = u9.Torso.CFrame * CFrame.new(math.cos(v14) * 10, 0, -math.sin(v14) * 10);
        v15.Parent = u9;
        table.insert(u13, v15);
    end;

    local u16 = nil;
    u16 = game["Run Service"].RenderStepped:Connect(function(p17) -- Line: 117
        -- upvalues: u9 (copy), u16 (ref), u12 (ref), u13 (copy), TweenService (ref), u1 (ref), u10 (copy)
        if not u9:IsDescendantOf(game) then
            u16:Disconnect();
            u16 = nil;

            return;
        end;

        u12 = u12 + 9.42477796076938 * p17 % 6.283185307179586;

        for i, v in u13 do
            local v18 = u12 + i / #u13 * 6.283185307179586;
            TweenService:Create(v, TweenInfo.new(p17, Enum.EasingStyle.Linear), {
                CFrame = u9.Torso.CFrame * CFrame.new(math.cos(v18) * 10, 0, -math.sin(v18) * 10)
            }):Play();
        end;

        local v19 = workspace:Raycast(u9.Torso.Position, Vector3.new(0, -150, 0), u1);

        if v19 then
            u10.CFrame = CFrame.new(v19.Position, v19.Position + v19.Normal) * CFrame.new(0, 0, -1) * CFrame.Angles(-4.71238898038469, 0, 0);
        end;
    end);
    local v20 = (Positions[1] + Positions[2]) / 2 + Vector3.new(0, (Positions[1] - Positions[2]).Magnitude / 1.5, 0);

    for i = 1, 15 do
        local v21 = task.wait(FinishFrame / 60 / Speed / 15);
        local v22 = i / 15;
        local v23 = (1 - v22) ^ 2 * Positions[1] + 2 * (1 - v22) * v22 * v20 + v22 ^ 2 * Positions[2];
        local v24 = (i + 1) / 15;
        local v25 = (1 - v24) ^ 2 * Positions[1] + 2 * (1 - v24) * v24 * v20 + v24 ^ 2 * Positions[2];
        TweenService:Create(HumanoidRootPart, TweenInfo.new(v21, Enum.EasingStyle.Linear), {
            CFrame = CFrame.new(v23, v25)
        }):Play();
    end;

    for _, v in u13 do
        task.delay(ParticleHandler.EnableAllParticles(v, false), v.Destroy, v);
    end;

    task.delay(0.12, function() -- Line: 159
        -- upvalues: u9 (copy), TweenService (ref), Speed (copy)
        if not u9:IsDescendantOf(game) then
            return;
        end;

        for _, descendant in ipairs(u9:GetDescendants()) do
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
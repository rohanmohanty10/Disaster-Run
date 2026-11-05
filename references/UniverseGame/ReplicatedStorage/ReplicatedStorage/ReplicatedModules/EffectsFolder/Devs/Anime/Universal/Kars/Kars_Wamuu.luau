  

 

game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.GenericModule);
require(PathShortcuts.KnitPath.Knit);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local Common = require(PathShortcuts.ReplicatedModules.StatsFolder.Kars.Kars.Common);

return function(p1) -- Line: 13
    -- upvalues: Players (copy), Common (copy), RunService (copy), TweenService (copy), EffectsHandler (copy), LocalPlayer (copy)
    local Character = p1.Character;
    local Animation = p1.Animation;
    local Speed = p1.Speed;
    local Sounds = p1.Sounds;
    local Reference = p1.Reference;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local u2 = Players:GetPlayerFromCharacter(Character);
    local v3;

    if u2 then
        v3 = u2.Data.Skin:GetAttribute("SkinName");
    else
        v3 = u2;
    end;

    local u4 = {
        AbilityName = "Kars",
        SkinName = v3
    };
    local u5 = Common:GetPillarmanModel("Wamuu", {
        AbilityName = "Kars",
        Player = u2,
        SkinName = v3
    });
    u5.HumanoidRootPart.CFrame = HumanoidRootPart.CFrame;
    u5.Parent = workspace.Effects;

    local function IsStillValid() -- Line: 30
        -- upvalues: Reference (copy)
        return not Reference or Reference.Parent ~= nil;
    end;

    local u6 = nil;

    if Reference then
        u6 = RunService.Heartbeat:Connect(function() -- Line: 36
            -- upvalues: Reference (copy), u6 (ref), u5 (copy)
            if not Reference or Reference.Parent ~= nil then
                return;
            end;

            u6:Disconnect();

            for _, descendant in pairs(u5:GetDescendants()) do
                if descendant:IsA("Sound") then
                    descendant:Stop();
                end;
            end;

            u5:Destroy();
        end);
    end;

    task.delay(3.5 / Speed, function() -- Line: 52
        -- upvalues: u6 (ref), u5 (copy)
        if u6 then
            u6:Disconnect();
        end;

        if u5.Parent then
            u5:Destroy();
        end;
    end);
    local Animation2 = Instance.new("Animation");
    Animation2.AnimationId = Animation;
    Animation2.Parent = u5;
    (u5:FindFirstChild("Humanoid") or u5:FindFirstChild("AnimationController")).Animator:LoadAnimation(Animation2):Play(nil, nil, Speed);

    for i, v in Sounds do
        local v7 = v:Clone();
        v7.Parent = u5.HumanoidRootPart;
        Sounds[i] = v7;
    end;

    Sounds.SFX:Play();

    for _, descendant in ipairs(u5:GetDescendants()) do
        if descendant:IsA("BasePart") then
            local Transparency = descendant.Transparency;
            descendant.Transparency = 1;
            TweenService:Create(descendant, TweenInfo.new(0.52 / Speed, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                Transparency = Transparency
            }):Play();
        end;
    end;

    local v8 = 0.7833333333333333 / Speed;
    local u9 = u5.HumanoidRootPart.CFrame * CFrame.new(0, 0, -7.5);
    TweenService:Create(u5.HumanoidRootPart, TweenInfo.new(v8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        CFrame = u9
    }):Play();
    task.delay(v8 * 0.9, function() -- Line: 95
        -- upvalues: u5 (copy), Sounds (copy), Reference (copy), EffectsHandler (ref), u9 (copy), u4 (copy), u2 (copy), LocalPlayer (ref), Speed (copy)
        if not u5:IsDescendantOf(game) then
            return;
        end;

        Sounds.Voiceline:Play();

        for i = 1, 3 do
            if Reference and Reference.Parent == nil then
                break;
            end;

            EffectsHandler.CallEffect("Rock Debris", {
                Lifetime = 2.5,
                Origin = u9 * CFrame.new(0, 0, -0.375),
                Size = Vector3.new(1, 1, 1) * i,
                Radius = i / 0.5 + 2.7,
                Amount = i + 9
            });
            EffectsHandler.CallEffect("Emit Particle V3", {
                Path = "Particles/Wamuu/Slam",
                AutoSerialize = true,
                Origin = u9 * CFrame.new(0, -2.5, 0) * CFrame.Angles(0, 0, -1.5707963267948966),
                AbilityName = u4.AbilityName,
                SkinName = u4.SkinName,
                Scale = i / 2
            });

            if u2 == LocalPlayer then
                EffectsHandler.CallEffect("Camera Shake", {
                    i / 1.5 * 5,
                    i / 1.5 * 13,
                    0,
                    0.65,
                    Vector3.new(0.25, 0.25, 0.25),
                    Vector3.new(4, 1, 1)
                });
            end;

            task.wait(0.8333333333333334 / Speed);
        end;
    end);
    task.delay(3.1666666666666665 / Speed, function() -- Line: 131
        -- upvalues: u5 (copy), TweenService (ref), Speed (copy)
        if not u5:IsDescendantOf(game) then
            return;
        end;

        for _, descendant in ipairs(u5:GetDescendants()) do
            if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
                TweenService:Create(descendant, TweenInfo.new(0.3 / Speed, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    Transparency = 1
                }):Play();
            elseif descendant:IsA("ParticleEmitter") or (descendant:IsA("Trail") or descendant:IsA("Beam")) then
                descendant.Enabled = false;
            end;
        end;
    end);
end;
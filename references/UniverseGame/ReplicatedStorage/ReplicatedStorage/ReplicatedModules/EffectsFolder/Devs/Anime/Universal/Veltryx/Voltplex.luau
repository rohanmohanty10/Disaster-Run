  

 

local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
local u1 = Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p2) -- Line: 17
    -- upvalues: EffectsHandler (copy), LocalPlayer (copy), AssetHandler (copy), u1 (copy), ParticleHandler (copy), TweenService (copy)
    local HumanoidRootPart = p2.HumanoidRootPart;
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Particles/Voltplex/Burst",
        AutoSerialize = true,
        Offset = CFrame.Angles(0, 1.5707963267948966, 0) * CFrame.new(3, 0, 0),
        Origin = HumanoidRootPart,
        Player = LocalPlayer
    });
    EffectsHandler.CallEffect("Mesh Emit", {
        Effect = "Forward Lunge",
        Origin = HumanoidRootPart.CFrame * CFrame.new(0, 0, 20)
    });
    local v3 = AssetHandler.GetAsset("Particles/Voltplex/Trails", AssetHandler.GetAbilityData(p2)):GetChildren();
    local CFrame2 = HumanoidRootPart.CFrame;

    for i = 1, 6 do
        local u4 = 12;
        local u5 = u1:NextNumber(0, 3);
        local u6 = i * 60 + 0;
        local u7 = u1:NextNumber(-1, 1);
        local u8 = u1:NextNumber(57, 65);
        local u9 = v3[math.random(1, #v3)]:Clone();
        local new = CFrame.new;
        local v10 = math.rad(u6);
        local v11 = math.cos(v10) * u4;
        local v12 = math.rad(u6);
        u9.CFrame = CFrame2 * new(v11, math.sin(v12) * u4, -u7);
        ParticleHandler.Unusualify(u9, {
            Character = p2
        });
        u9.Parent = workspace.Effects;
        task.delay(3, u9.Destroy, u9);
        local u13 = os.clock();
        local u14 = u1:NextNumber(0.25, 0.4);
        task.spawn(function() -- Line: 62
            -- upvalues: u6 (ref), u7 (ref), u8 (copy), u4 (ref), u5 (copy), u13 (copy), u14 (copy), TweenService (ref), u9 (copy), CFrame2 (copy), ParticleHandler (ref)
            repeat
                local v15 = task.wait();
                math.rad(u6);
                u6 = u6 + v15 * -450;
                u7 = u7 + v15 * u8;
                local v16 = (os.clock() - u13) / u14;
                u4 = math.lerp(12, u5, v16);
                local v17 = TweenInfo.new(v15, Enum.EasingStyle.Linear);
                local v18 = {};
                local new2 = CFrame.new;
                local v19 = math.rad(u6);
                local v20 = math.cos(v19) * u4;
                local v21 = math.rad(u6);
                v18.CFrame = CFrame2 * new2(v20, math.sin(v21) * u4, -u7);
                TweenService:Create(u9, v17, v18):Play();
            until not u9:IsDescendantOf(game) or u14 < os.clock() - u13;

            ParticleHandler.EnableAllParticles(u9, false);
        end);
    end;
end;
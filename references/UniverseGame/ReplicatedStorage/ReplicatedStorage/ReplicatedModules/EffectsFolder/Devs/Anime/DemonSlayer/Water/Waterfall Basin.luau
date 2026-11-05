  

 

local TweenService = game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 17
    -- upvalues: AssetHandler (copy), EffectsHandler (copy), ParticleHandler (copy), TweenService (copy)
    local v2 = p1 or {};
    local Player = v2.Player;
    local Character = v2.Character;
    local _ = Character.HumanoidRootPart;
    local Origin = v2.Origin;
    local v3 = AssetHandler.GetAbilityData(Character);
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Particles/Basin/Slam",
        Player = Player,
        Origin = Origin
    });
    local u4 = AssetHandler.CloneAsset("Particles/Basin/Waterfall", v3);
    u4.CFrame = CFrame.new(Origin.Position) * CFrame.new(0, u4.Size.Y / 2 - 0.5, 0);
    u4.Parent = workspace.Effects;
    u4.Enable.WorldCFrame = Origin;
    task.delay(1, function() -- Line: 41
        -- upvalues: ParticleHandler (ref), u4 (copy)
        ParticleHandler.DestroyEmit(u4);
        ParticleHandler.EnableAllParticles(u4, false);
    end);
    local u5 = AssetHandler.CloneAsset("Particles/Basin/Slamwave", v3);
    u5.CFrame = Origin * CFrame.new(0, 4, 0);
    u5.Parent = workspace.Effects;
    local v6 = TweenService:Create(u5, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {
        Size = Vector3.new(50, 5, 50),
        Transparency = 1
    });
    v6:Play();
    v6.Completed:Connect(function() -- Line: 55
        -- upvalues: u5 (copy)
        u5:Destroy();
    end);

    for _, descendant in u4:GetDescendants() do
        if descendant:IsA("Beam") then
            local Brightness = descendant.Brightness;
            descendant.Brightness = descendant.Brightness * 3;
            local v7 = TweenService:Create(descendant, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Brightness = Brightness
            });
            v7.Completed:Connect(function() -- Line: 67
                -- upvalues: TweenService (ref), descendant (copy)
                TweenService:Create(descendant, TweenInfo.new(1, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Width0 = 0,
                    Width1 = 0,
                    ZOffset = 0
                }):Play();
            end);
            v7:Play();
        end;
    end;

    EffectsHandler.CallEffect("Mesh Emit", {
        Effect = "Waterfall Basin",
        Origin = u4.CFrame * CFrame.new(0, 5, 3)
    });
end;
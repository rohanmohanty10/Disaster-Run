  

 

local TweenService = game:GetService("TweenService");
game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
game:GetService("RunService");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
Random.new();
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 17
    -- upvalues: AssetHandler (copy), EffectsHandler (copy), TweenService (copy)
    local v2 = p1 or {};
    local Player = v2.Player;
    local Offset = v2.Offset;
    local AttachTo = v2.AttachTo;
    local Character = Player.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    AssetHandler.GetAbilityData(Character);
    local v3 = EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Particles/SurfaceSlash/Slash",
        Player = Player,
        Origin = not AttachTo and HumanoidRootPart,
        Offset = Offset,
        AttachTo = AttachTo
    });
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Particles/SurfaceSlash/Ground",
        Player = Player,
        Origin = HumanoidRootPart
    });
    EffectsHandler.CallEffect("Emit Particle V3", {
        Path = "Particles/SurfaceSlash/Linger",
        Player = Player,
        Origin = HumanoidRootPart
    });
    local Particle = v3.Particle;
    local u4 = { 17836548128, 17836547951, 17836547734, 17836547166, 17836547005, 17836546844, 17836546641, 17836546429, 17836546162, 17836545963, 17836545816, 17836545674, 17836545512, 17836545387, 17836545280 };
    task.spawn(function() -- Line: 54
        -- upvalues: u4 (copy), Particle (copy), EffectsHandler (ref)
        for i = 1, #u4 do
            Particle.FlipbookSlash.Decal.Texture = "rbxassetid://" .. u4[i];
            EffectsHandler.Wait(0.35 / #u4);
        end;
    end);

    for _, child in Particle.Slash.Attachment:GetChildren() do
        if child:IsA("Beam") then
            if child.Name == "Keep" then
                EffectsHandler.CallEffect("Boat Tween", child, {
                    Time = 0.75,
                    EasingStyle = "ExitExpressive",
                    EasingDirection = "Out",
                    StepType = "RenderStepped",
                    Goal = {
                        Transparency = NumberSequence.new(1)
                    }
                });
            else
                TweenService:Create(child, TweenInfo.new(0.3, Enum.EasingStyle.Cubic, Enum.EasingDirection.InOut), {
                    Width0 = 0,
                    Width1 = 0
                }):Play();
            end;
        end;
    end;
end;
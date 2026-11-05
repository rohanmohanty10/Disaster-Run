  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("TweenService");
local Players = game:GetService("Players");
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
Random.new();

return function(p1) -- Line: 13
    -- upvalues: Players (copy), AssetHandler (copy), ParticleHandler (copy), EffectsHandler (copy)
    local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local v2 = Players:GetPlayerFromCharacter(p1);
    local v3 = 0;

    if v2 and v2.Data.Skin:GetAttribute("UnusualHueId") then
        v3 = v3 + v2.Data.Skin:GetAttribute("UnusualHueId") * 5;
    end;

    local v4 = AssetHandler.CloneAsset("Particles/Pirouette/Tornado", AssetHandler.GetAbilityData(p1));
    v4.Parent = workspace.Effects;

    if v3 > 0 then
        ParticleHandler.HSVShiftParticles(v4, {
            HueShift = v3
        });
    end;

    ParticleHandler.AttachTo(v4, {
        Part = HumanoidRootPart
    });

    for _, descendant in v4:GetDescendants() do
        if descendant:IsA("Beam") then
            local Transparency = descendant.Transparency;
            descendant.Transparency = NumberSequence.new(1);
            EffectsHandler.CallEffect("Boat Tween", descendant, {
                Time = 0.35,
                EasingStyle = "EntranceExpressive",
                EasingDirection = "In",
                StepType = "RenderStepped",
                Goal = {
                    Transparency = Transparency
                }
            });
        end;
    end;

    repeat
        task.wait();
    until not (p1:IsDescendantOf(game) and p1:GetAttribute("Pirouette"));

    task.delay(ParticleHandler.EnableParticles(v4, false), v4.Destroy, v4);

    for _, descendant in v4:GetDescendants() do
        if descendant:IsA("Beam") then
            EffectsHandler.CallEffect("Boat Tween", descendant, {
                Time = 0.35,
                EasingStyle = "ExitExpressive",
                EasingDirection = "Out",
                StepType = "RenderStepped",
                Goal = {
                    Transparency = NumberSequence.new(1)
                }
            });
        end;
    end;
end;
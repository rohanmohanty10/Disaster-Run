  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local _ = ReplicatedStorage["Client Assets"];
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
Random.new();

return function(p1, p2) -- Line: 14
    -- upvalues: Players (copy), AssetHandler (copy), ParticleHandler (copy), EffectsHandler (copy), TweenService (copy)
    local v3 = Players:GetPlayerFromCharacter(p1);
    local HumanoidRootPart = p1.HumanoidRootPart;
    local v4 = AssetHandler.GetAbilityData(v3 or p1);
    local v5 = AssetHandler.GetAsset("Particles/Mellow/FX", v4):Clone();
    v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(0, 0.75, -3.8);
    v5.Parent = workspace.Effects;
    local v6 = 0;

    if v3 and v3.Data.Skin:GetAttribute("UnusualHueId") then
        v6 = v6 + v3.Data.Skin:GetAttribute("UnusualHueId") * 5;
    end;

    if v6 > 0 then
        ParticleHandler.HSVShiftParticles(v5, {
            HueShift = v6
        });
    end;

    for _, descendant in v5:GetDescendants() do
        if descendant:IsA("Beam") then
            local Transparency = descendant.Transparency;
            descendant.Transparency = NumberSequence.new(1);
            EffectsHandler.CallEffect("Boat Tween", descendant, {
                Time = 0.2,
                EasingStyle = "EntranceExpressive",
                EasingDirection = "In",
                StepType = "RenderStepped",
                Goal = {
                    Transparency = Transparency
                }
            });
        end;
    end;

    while true do
        local v7 = AssetHandler.GetAsset("Particles/Mellow/HeartBeam", v4):Clone();
        v7:SetPrimaryPartCFrame(HumanoidRootPart.CFrame * CFrame.new(0, 0, -1.5) * CFrame.Angles(-1.5707963267948966, 1.5707963267948966, 3.141592653589793));
        v7.Parent = workspace.Effects;
        task.delay(0.5, v7.Destroy, v7);

        for _, child in v7:GetChildren() do
            if v6 > 0 then
                child.Color = ParticleHandler.HSVShift(child.Color, {
                    HueShift = v6
                });
            end;

            TweenService:Create(child, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                Position = child.Position + HumanoidRootPart.CFrame.LookVector * p2,
                Size = child.Size * 25
            }):Play();
            TweenService:Create(child, TweenInfo.new(0.2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out, 0, false, 0.3), {
                Transparency = 1
            }):Play();
        end;

        task.wait(0.1);

        if not (p1:IsDescendantOf(game) and p1:GetAttribute("MeroMellow")) then
            local v8 = ParticleHandler.GetMaxLifetime(v5);
            task.delay(ParticleHandler.EnableParticles(v5, false) + 1, v5.Destroy, v5);

            for _, descendant in v5:GetDescendants() do
                if descendant:IsA("Beam") then
                    EffectsHandler.CallEffect("Boat Tween", descendant, {
                        EasingStyle = "ExitExpressive",
                        EasingDirection = "Out",
                        StepType = "RenderStepped",
                        Time = v8 / 10,
                        Goal = {
                            Transparency = NumberSequence.new(1)
                        }
                    });
                end;
            end;

            return;
        end;
    end;
end;
  

 

local ParticleHandler = require(game.ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local TweenService = game:GetService("TweenService");
require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);

return function(p1, p2, p3) -- Line: 6
    -- upvalues: TweenService (copy), ParticleHandler (copy)
    if not p1:FindFirstChild("Blades") or p1:GetAttribute("BoneBlades") and not p3 then
        return;
    end;

    local v4 = p2 and 0 or 1;
    local Blades = p1:FindFirstChild("Blades");
    local v5 = p1:FindFirstChild("Kars Skin Outfit");

    if v5 and v5:GetAttribute("BoneBladeShift") then
        for _, descendant in p1:GetDescendants() do
            if not (Blades and descendant:IsDescendantOf(Blades)) and ((descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture"))) and descendant.Name ~= "HumanoidRootPart") then
                local v6 = not descendant:IsDescendantOf(v5);
                local v7 = v6 and (p2 and 1 or (descendant:GetAttribute("OriginalTransparency") or 0)) or v4;
                local v8 = not v6 and p2 and (descendant:GetAttribute("OriginalTransparency") or 0) or v7;
                descendant:SetAttribute("VanishBlacklist", v6 and p2 and p2 or not p2);

                if not v6 or descendant:GetAttribute("OriginalTransparency") ~= nil then
                    if descendant:GetAttribute("OverrideTransparency") then
                        v8 = descendant:GetAttribute("OverrideTransparency");
                    end;

                    TweenService:Create(descendant, TweenInfo.new(0.5), {
                        Transparency = v8
                    }):Play();
                end;
            end;
        end;
    end;

    local v9 = Blades:FindFirstChildOfClass("Highlight");

    if v9 then
        TweenService:Create(v9, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            OutlineTransparency = p2 and 0 or 1
        }):Play();
    end;

    for _, child in Blades:GetChildren() do
        local LightDancerFX = child:FindFirstChild("LightDancerFX");

        for _, descendant in child:GetDescendants() do
            if LightDancerFX and (descendant == LightDancerFX and p1:GetAttribute("LightDancer")) then
                ParticleHandler.EnableParticle(LightDancerFX, p2);
            elseif not (LightDancerFX and descendant:IsDescendantOf(LightDancerFX)) then
                if descendant:IsA("BasePart") then
                    TweenService:Create(descendant, TweenInfo.new(0.5, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                        Transparency = p2 and (descendant:GetAttribute("OriginalTransparency") or 0) or 1
                    }):Play();
                elseif descendant:IsA("ParticleEmitter") and not p2 then
                    descendant.Enabled = p2;
                end;
            end;
        end;
    end;
end;
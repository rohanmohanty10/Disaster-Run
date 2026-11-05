  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("Players");
require(ReplicatedStorage.ReplicatedModules.Classes.Sequence_V3);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local TweenService = game:GetService("TweenService");

return function(p1, p2) -- Line: 10
    -- upvalues: TweenService (copy)
    local v3 = p2 or {};
    local v4 = TweenInfo.new(v3.Time or 0.25, v3.EasingStyle or Enum.EasingStyle.Sine, v3.EasingDirection or Enum.EasingDirection.Out);
    local v5 = v3.Ultimate or false;
    local Ultimate = p1:FindFirstChild("Ultimate");

    for _, descendant in pairs(p1:GetDescendants()) do
        if not Ultimate or (not descendant:IsDescendantOf(Ultimate) or v5) then
            if descendant:IsA("BasePart") then
                local v6 = descendant:GetAttribute("OriginalTransparency") or descendant.Transparency;
                descendant.Transparency = 1;
                TweenService:Create(descendant, v4, {
                    Transparency = v6
                }):Play();
            elseif descendant:IsA("Light") then
                local v7 = descendant:GetAttribute("OriginalBrightness") or descendant.Brightness;
                descendant.Brightness = 0;
                TweenService:Create(descendant, v4, {
                    Brightness = v7
                }):Play();
            elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Beam") then
                descendant.Enabled = descendant:GetAttribute("OriginalEnabled") or true;

                if descendant:IsA("Beam") then
                    TweenService:Create(descendant, v4, {
                        Width0 = descendant:GetAttribute("OriginalWidth0") or descendant.Width0,
                        Width1 = descendant:GetAttribute("OriginalWidth1") or descendant.Width1
                    }):Play();
                end;
            end;
        end;
    end;
end;
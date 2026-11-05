  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local GenericModule = require(PathShortcuts.GenericModule);
local _ = PathShortcuts.ClientAssets;
Random.new();
game:GetService("TweenService");

local function Invert(p1) -- Line: 11
    return -(p1 - 1);
end;

return function(p2) -- Line: 15
    -- upvalues: GenericModule (copy)
    local Character = p2.Character;
    local Transparency = p2.Transparency;
    local v3 = p2.TweenInfo and TweenInfo.new(unpack(p2.TweenInfo)) or TweenInfo.new(0.1);
    local v4 = Character:FindFirstChild("Stand") or Character:FindFirstChild("Blades");

    for _, descendant in pairs(p2.Character:GetDescendants()) do
        if descendant.Name ~= "HumanoidRootPart" and (not descendant.Parent or descendant.Parent.Name ~= "_Rika" and (not v4 or (not descendant:IsDescendantOf(v4) or p2.AffectStands))) and ((descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture"))) and not descendant:GetAttribute("VanishBlacklist")) then
            local v5 = descendant:GetAttribute("OverrideTransparency") or Transparency;
            local v6 = descendant:GetAttribute("OriginalTransparency");

            if not v6 then
                v6 = descendant.Transparency;
                descendant:SetAttribute("OriginalTransparency", v6);
            end;

            if v3.Time > 0 then
                game:GetService("TweenService"):Create(descendant, v3, {
                    Transparency = GenericModule.Lerp(v6, 1, v5)
                }):Play();
            else
                descendant.Transparency = GenericModule.Lerp(v6, 1, v5);
            end;
        end;
    end;
end;
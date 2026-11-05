  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local _ = ReplicatedStorage["Client Assets"];
local ReplicatedLibrary = ReplicatedStorage.ReplicatedModules.ReplicatedLibrary;
require(ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(ReplicatedLibrary.ParticleHandler);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local u1 = Random.new();

return function(p2, p3) -- Line: 12
    -- upvalues: ParticleHandler (copy), EffectsHandler (copy), TweenService (copy), u1 (copy)
    if not (p2 and p2:IsDescendantOf(game)) then
        return;
    end;

    local Locations = p3.Locations;
    local Lightning = p3.Lightning;
    local CustomPath = p3.CustomPath;
    local SkinName = p3.SkinName;
    local AbilityName = p3.AbilityName;
    local v4 = ParticleHandler.GetUnusualHSVData({
        Character = p2
    });
    local v5 = CustomPath or "Particles/PunctureWille/Shambles";

    for _, v in Locations do
        EffectsHandler.CallEffect("Emit Particle V3", {
            MaxRenderDistance = 1000000,
            Character = p2,
            Origin = v,
            Path = v5,
            SkinName = SkinName,
            AbilityName = AbilityName or "Ope",
            PlaySounds = p3.PlaySounds ~= false
        });
    end;

    if p3.FadeCharacter ~= false then
        for _, descendant in p2:GetDescendants() do
            if (descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture"))) and (descendant.Transparency < 0.5 and not descendant:GetAttribute("VanishBlacklist")) then
                local v6 = descendant:GetAttribute("OriginalTransparency") or 0;
                descendant.Transparency = 1;
                TweenService:Create(descendant, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    Transparency = v6
                }):Play();
            end;
        end;
    end;

    if Lightning then
        local Model = Instance.new("Model");
        Model.Name = "Lightning";
        Model.Parent = workspace.CurrentCamera;
        local Highlight = Instance.new("Highlight");
        Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
        Highlight.OutlineTransparency = 1;
        Highlight.FillTransparency = 0;
        Highlight.FillColor = Color3.new(1, 1, 1);
        Highlight.Parent = Model;
        task.delay(1.5, Model.Destroy, Model);

        for _ = 1, 3 do
            EffectsHandler.CallEffect("Generate Quasiduck Lightning", p2, {
                Size = 0.17,
                Color = ParticleHandler.TryHSVShift(ColorSequence.new(Color3.fromRGB(9, 137, 207)), v4),
                Speed = u1:NextNumber(6, 8.5),
                CFrames = { Locations[1], Locations[2] * CFrame.new(u1:NextNumber(-10, 10), u1:NextNumber(-10, 10), 0) },
                Parent = Model
            });
        end;
    end;
end;
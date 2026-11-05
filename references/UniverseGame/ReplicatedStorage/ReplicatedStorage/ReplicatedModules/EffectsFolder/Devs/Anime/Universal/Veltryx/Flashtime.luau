  

 

local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local _ = Players.LocalPlayer;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);
Random.new();
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.EffectsHandler);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.FXHandler);
local v1 = RaycastParams.new();
v1.FilterType = Enum.RaycastFilterType.Include;
v1.FilterDescendantsInstances = { workspace.Map };

return function(p2) -- Line: 24
    -- upvalues: Trove (copy), AssetHandler (copy), ParticleHandler (copy), RunService (copy), TweenService (copy)
    local v3 = p2 or {};
    local Character = v3.Character;
    local Attribute = v3.Attribute;
    local u4 = Trove.new();
    u4:AttachToInstance(Character);
    u4:Connect(Character:GetAttributeChangedSignal(Attribute), function() -- Line: 33
        -- upvalues: Character (copy), Attribute (copy), u4 (copy)
        if not Character:GetAttribute(Attribute) then
            u4:Destroy();
        end;
    end);
    local u5 = AssetHandler.GetAbilityData(Character);
    local u6 = AssetHandler.CloneAsset("Particles/Flashtime/Trails", u5);
    ParticleHandler.Unusualify(u6, {
        Character = Character
    });
    u6.Parent = Character;

    for _, child in u6:GetChildren() do
        ParticleHandler.AttachTo(child, {
            Part = Character[child.Name]
        });
    end;

    u4:Add(function() -- Line: 51
        -- upvalues: ParticleHandler (ref), u6 (copy)
        ParticleHandler.DestroyEmit(u6);
        ParticleHandler.EnableAllParticles(u6, false);
    end);
    local Position = Character.Torso.Position;
    u4:Connect(RunService.RenderStepped, function(p7) -- Line: 58
        -- upvalues: ParticleHandler (ref), Character (copy), Position (ref), AssetHandler (ref), u5 (copy), TweenService (ref)
        local v8 = ParticleHandler.GetUnusualHSVData({
            Character = Character
        });

        if (Position - Character.Torso.Position).Magnitude > 2.5 and not Character:GetAttribute("NoAfterimages") then
            Position = Character.Torso.Position;
            local v9 = AssetHandler.CloneAsset("Particles/Flashtime/Afterimage", u5);
            ParticleHandler.Unusualify(v9, {
                HSVData = v8
            });
            v9.Parent = workspace.Effects;
            task.delay(1.15, v9.Destroy, v9);

            for _, child in v9:GetChildren() do
                child.CFrame = Character[child.Name].CFrame;
                TweenService:Create(child, TweenInfo.new(1.15, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
            end;
        end;
    end);
end;
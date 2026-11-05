  

 

local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local EffectsHandler = require(PathShortcuts.ReplicatedModules.EffectsHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local _ = game.ReplicatedStorage:WaitForChild("Client Assets").Assets.Abilities.KillEffects.Mayhem;
local u1 = TweenInfo.new(1.75, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut);

return function(p2) -- Line: 13
    -- upvalues: AssetHandler (copy), Debris (copy), TweenService (copy), u1 (copy), EffectsHandler (copy)
    for _, descendant in p2:GetDescendants() do
        if descendant:IsA("BasePart") or (descendant:IsA("Decal") or descendant:IsA("Texture")) then
            descendant.Transparency = 1;
        elseif descendant:IsA("Beam") or (descendant:IsA("ParticleEmitter") or descendant:IsA("Trail")) then
            descendant:Destroy();
        end;
    end;

    local v3 = AssetHandler.CloneAsset("Mayhem/Sounds/Dust", {
        AbilityName = "KillEffects"
    });
    v3.Parent = p2.PrimaryPart or p2:FindFirstChildWhichIsA("BasePart");
    v3:Play();
    local v4 = AssetHandler.CloneAsset("Mayhem/Models/Victim", {
        AbilityName = "KillEffects"
    });
    Debris:AddItem(v4, 8);
    v4.Parent = workspace.Effects;

    for _, child in v4:GetChildren() do
        if p2:FindFirstChild(child.Name) then
            child.CFrame = p2[child.Name].CFrame;
            child.Anchored = false;
            child.CollisionGroup = "Ghosted";
            local u5 = AssetHandler.CloneAsset("Mayhem/Particles/Kill", {
                AbilityName = "KillEffects"
            });
            u5.Parent = child;
            local v6 = TweenService:Create(child, u1, {
                Transparency = 1
            });
            v6.Completed:Once(function() -- Line: 42
                -- upvalues: child (copy), u5 (copy), EffectsHandler (ref)
                if child and u5 then
                    EffectsHandler.CallEffect("Glitcher Sphere", {
                        Type = "Add",
                        MeshSize = Vector3.new(0.1, 0.1, 0.1),
                        Speed = 1.75,
                        Value = 0.1,
                        CFrame = child.CFrame,
                        Color = Color3.new(1, 0, 0)
                    });
                    u5.Speed = NumberRange.new(10, 25);
                    u5.Drag = 5;
                    u5.Acceleration = Vector3.new(0, 2, 0);
                    EffectsHandler.Wait(0.5);

                    if child and u5 then
                        u5.Enabled = false;
                    end;
                end;
            end);
            v6:Play();
        else
            child:Destroy();
        end;
    end;
end;
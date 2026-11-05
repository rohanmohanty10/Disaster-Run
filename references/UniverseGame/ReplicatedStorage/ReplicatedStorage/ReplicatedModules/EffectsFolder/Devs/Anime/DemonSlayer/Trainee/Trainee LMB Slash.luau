  

 

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
require(PathShortcuts.ReplicatedModules.EffectsHandler);

return function(p1) -- Line: 17
    -- upvalues: AssetHandler (copy), TweenService (copy)
    local v2 = p1 or {};
    local _ = v2.Player;
    local Character = v2.Character;
    local HumanoidRootPart = Character.HumanoidRootPart;
    local Count = v2.CharacterState["Rush Attack"].Count;
    local v3 = AssetHandler.GetAbilityData(Character);
    local v4 = { Vector3.new(-34.854, -93.694, 0), Vector3.new(0, 70, 180), Vector3.new(50, -110, 0), Vector3.new(-12.308, 100.652, 169.919) };
    local v5 = AssetHandler.CloneAsset("Misc/BeamSlash", v3);
    v5.CFrame = HumanoidRootPart.CFrame * CFrame.Angles(0, 3.141592653589793, 0);
    v5.CFrame = v5.CFrame * CFrame.fromOrientation(math.rad(v4[Count].X), math.rad(v4[Count].Y), (math.rad(v4[Count].Z)));
    v5.Parent = workspace.Effects;
    task.delay(0.4, v5.Destroy, v5);
    TweenService:Create(v5, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
        CFrame = v5.CFrame * CFrame.Angles(0, -10, 0)
    }):Play();

    for _, descendant in v5:GetDescendants() do
        if descendant:IsA("Beam") then
            TweenService:Create(descendant, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                Width0 = 0,
                Width1 = 0
            }):Play();
        end;
    end;
end;
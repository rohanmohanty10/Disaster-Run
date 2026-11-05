  

 

game:GetService("TweenService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local _ = Players.LocalPlayer;
local _ = workspace.CurrentCamera;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
require(PathShortcuts.KnitPath.Trove);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local v1 = RaycastParams.new();
v1.FilterType = Enum.RaycastFilterType.Include;
v1.FilterDescendantsInstances = { workspace.Map };

return function(p2) -- Line: 20
    -- upvalues: AssetHandler (copy), ParticleHandler (copy)
    local v3 = workspace.Effects:WaitForChild(p2, 5);

    if not v3 then
        return;
    end;

    local v4 = AssetHandler.CloneAsset("Models/Batrang", {
        AbilityName = "The Dark Knight"
    });
    v4.Anchored = true;
    v4.CFrame = v3.CFrame;
    v4.Parent = workspace.Effects;
    ParticleHandler.EnableAllParticles(v4, true);
    local v5 = 0;

    while v3:IsDescendantOf(workspace.Effects) and not v3:GetAttribute("Destroyed") do
        local v6 = task.wait();
        v5 = v5 + 37.69911184307752 * v6 * (v6 * 60);

        if v5 > 6.283185307179586 then
            v5 = v5 - 6.283185307179586;
        end;

        v4.CFrame = v4.CFrame:Lerp(v3.CFrame * CFrame.Angles(-v5, 0, 0), 0.5);
    end;

    ParticleHandler.DestroyEmit(v4);
    ParticleHandler.EnableAllParticles(v4, false);

    for _, child in v4:GetChildren() do
        if child:IsA("BasePart") then
            child.Transparency = 1;
        end;
    end;
end;
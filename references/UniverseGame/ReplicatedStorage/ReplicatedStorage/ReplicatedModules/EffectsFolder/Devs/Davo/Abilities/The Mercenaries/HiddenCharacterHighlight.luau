  

 

local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
require(PathShortcuts.KnitPath.Knit);
local Trove = require(PathShortcuts.KnitPath.Trove);

return function(p1) -- Line: 11
    -- upvalues: Trove (copy), AssetHandler (copy), TweenService (copy), ParticleHandler (copy)
    local u2 = Trove.new();
    u2:AttachToInstance(p1);
    local v3 = AssetHandler.CloneAsset("Models/MeshChar", {
        AbilityName = "The Mercenaries"
    });
    v3.Parent = workspace.Effects;
    v3.Root:Destroy();
    u2:Add(v3);
    local v4 = TweenInfo.new(0.25);
    local u5 = p1:FindFirstChild("Head") or p1:FindFirstChild("Torso");

    for _, child in v3:GetChildren() do
        local v6 = p1:FindFirstChild(child.Name);

        if v6 then
            child.Transparency = 1;
            TweenService:Create(child, v4, {
                Transparency = 0.85
            }):Play();
            child.Color = Color3.new(1, 1, 1);
            child.CFrame = v6.CFrame;
            ParticleHandler.AttachTo(child, {
                Part = v6
            });
        else
            child:Destroy();
        end;
    end;

    u2:Connect(u5:GetPropertyChangedSignal("Transparency"), function() -- Line: 48
        -- upvalues: u5 (copy), u2 (copy)
        if u5.Transparency < 0.01 and u2 then
            u2:Destroy();
        end;
    end);
end;
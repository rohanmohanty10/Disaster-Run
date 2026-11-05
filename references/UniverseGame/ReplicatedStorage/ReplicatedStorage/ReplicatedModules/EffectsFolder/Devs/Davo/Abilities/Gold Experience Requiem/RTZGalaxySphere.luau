  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
require(PathShortcuts.KnitPath.Knit);
local u1 = TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.Out);
local u2 = TweenInfo.new(1.45, Enum.EasingStyle.Quad, Enum.EasingDirection.In);

return function(p3) -- Line: 12
    -- upvalues: AssetHandler (copy), TweenService (copy), u2 (copy), u1 (copy)
    local u4 = AssetHandler.CloneAsset("Models/GalaxySphere", {
        AbilityName = "Gold Experience Requiem"
    });
    u4.Parent = workspace.Effects;
    u4.Position = p3;
    local u5 = TweenService:Create(u4, u2, {
        Transparency = 1
    });
    local u6 = TweenService:Create(u4, u1, {
        Size = Vector3.new(75, 75, 75)
    });
    u6:Play();
    u6.Completed:Once(function() -- Line: 26
        -- upvalues: u4 (copy), TweenService (ref), u2 (ref), u5 (copy), u6 (copy)
        for _, child in u4:GetChildren() do
            TweenService:Create(child, u2, {
                Transparency = 1
            }):Play();
        end;

        u5:Play();
        u5.Completed:Once(function() -- Line: 33
            -- upvalues: u6 (ref), u5 (ref), u4 (ref)
            task.wait();
            u6:Destroy();
            u5:Destroy();
            u4:Destroy();
        end);
    end);
end;
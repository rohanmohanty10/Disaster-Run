  

 

game:GetService("Debris");
local TweenService = game:GetService("TweenService");
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local PathShortcuts = require(ReplicatedModules.PathShortcuts);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

function WeldTo(p1, p2, p3)
    p3.CFrame = p1;
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = p2;
    WeldConstraint.Part1 = p3;
    WeldConstraint.Parent = p3;

    return WeldConstraint;
end;

return function(p4) -- Line: 20
    -- upvalues: AssetHandler (copy), TweenService (copy)
    local u5 = AssetHandler.CloneAsset("Particles/Spikes", {
        AbilityName = "Candy Cutlass",
        SkinName = "D_Estunator"
    });
    WeldTo(p4.Torso.CFrame, p4.Torso, u5);
    u5.Parent = p4;
    u5.Name = "Spikes";
    local v6 = TweenInfo.new(1.5, Enum.EasingStyle.Quart);

    for _, descendant in u5:GetDescendants() do
        if descendant:IsA("Beam") then
            descendant.Enabled = true;
            local v7 = descendant:GetAttribute("OriginalWidth");

            if not v7 then
                descendant:SetAttribute("OriginalWidth", descendant.Width0);
                v7 = descendant.Width0;
            end;

            descendant.Width0 = v7 * 3;
            descendant.Width1 = v7 * 3;
            descendant.TextureSpeed = -5;
            TweenService:Create(descendant, v6, {
                TextureSpeed = 0,
                Width0 = v7,
                Width1 = v7
            }):Play();
        end;
    end;

    task.delay(2.5833333333333335, function() -- Line: 48
        -- upvalues: u5 (copy)
        u5:Destroy();
    end);
end;
  

 

local TweenService = game:GetService("TweenService");
local ReplicatedModules = game:GetService("ReplicatedStorage").ReplicatedModules;
local ParticleHandler = require(ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedModules.ReplicatedLibrary.AssetHandler);

return function(p1, p2) -- Line: 10
    -- upvalues: AssetHandler (copy), ParticleHandler (copy), TweenService (copy)
    if not p1 then
        return;
    end;

    local v3 = TweenInfo.new(0.8, Enum.EasingStyle.Circular, Enum.EasingDirection.Out);

    if not p2 then
        for _, child in p1:GetChildren() do
            if child:IsA("Highlight") and child:GetAttribute("MarkedHighlight") then
                local v4 = TweenService:Create(child, v3, {
                    FillTransparency = 1,
                    OutlineTransparency = 1
                });
                v4:Play();
                v4.Completed:Once(function() -- Line: 63
                    -- upvalues: child (copy)
                    child:Destroy();
                end);
            elseif child:IsA("BasePart") and child:GetAttribute("ShadowCurse") then
                ParticleHandler.EnableAllParticles(child, false);
                ParticleHandler.Emit(child:FindFirstChild("Consumption"), ParticleHandler.GenerateEmitInfo(child:FindFirstChild("Consumption")));
                ParticleHandler.DestroyEmit(child);
            end;
        end;

        return;
    end;

    for _, child in p1:GetChildren() do
        if child:IsA("Highlight") and child:GetAttribute("MarkedHighlight") then
            child:Destroy();
        end;
    end;

    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillTransparency = 1;
    Highlight.FillColor = Color3.fromRGB(0, 0, 0);
    Highlight.OutlineColor = Color3.fromRGB(164, 255, 139);
    Highlight.OutlineTransparency = 1;
    Highlight.Parent = p1;

    if AssetHandler.GetAsset("Particles/Curse", {
        AbilityName = "Cid Kagenou"
    }) then
        local v5 = AssetHandler.CloneAsset("Particles/Curse", {
            AbilityName = "Cid Kagenou"
        });
        v5.Parent = p1;
        ParticleHandler.AttachTo(v5, {
            Part = p1:FindFirstChild("Head"),
            Offset = CFrame.new(0, -2.5, 0)
        });
        ParticleHandler.EnableParticle(v5.Attach, true);
        v5:SetAttribute("ShadowCurse", true);
    end;

    Highlight:SetAttribute("MarkedHighlight", true);
    TweenService:Create(Highlight, v3, {
        FillTransparency = 0.75,
        OutlineTransparency = 0.45
    }):Play();
end;
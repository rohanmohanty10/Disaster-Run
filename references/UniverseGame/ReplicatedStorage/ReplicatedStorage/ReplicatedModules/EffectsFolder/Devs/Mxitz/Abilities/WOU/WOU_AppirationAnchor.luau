  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);

return function(p1, p2) -- Line: 6
    -- upvalues: TweenService (copy)
    p1.Archivable = true;
    local v3 = p1:Clone();
    v3.HumanoidRootPart.CFrame = p2;

    for _, descendant in v3:GetDescendants() do
        if (descendant:IsA("BasePart") or (descendant:IsA("Accessory") or descendant:IsA("SpecialMesh"))) and descendant.Name ~= "HumanoidRootPart" then
            if descendant:IsA("BasePart") then
                if descendant:IsA("MeshPart") then
                    descendant.TextureID = "";
                end;

                descendant.Color = Color3.new();
                descendant.Transparency = 0.5;
                descendant.Material = Enum.Material.SmoothPlastic;
                descendant.CanCollide = false;
                descendant.Anchored = true;
            end;
        else
            descendant:Destroy();
        end;
    end;

    v3.Parent = workspace.Effects;

    while p1 and (p1:IsDescendantOf(game) and p1:GetAttribute("Apparition")) do
        task.wait(0.1);
    end;

    for _, descendant in v3:GetDescendants() do
        if descendant:IsA("BasePart") then
            TweenService:Create(descendant, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Transparency = 1
            }):Play();
        end;
    end;

    task.delay(0.25, v3.Destroy, v3);
end;
  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local _ = game:GetService("Players").LocalPlayer;
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
Random.new();

return function(p1, p2, p3) -- Line: 15
    -- upvalues: ParticleHandler (copy), AssetHandler (copy), TweenService (copy)
    local HumanoidRootPart = p1:FindFirstChild("HumanoidRootPart");

    if not HumanoidRootPart then
        return;
    end;

    local u4 = TweenInfo.new(0.85 / p2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out);
    local v5 = ParticleHandler.GetUnusualHSVData({
        Character = p1
    });
    local v6 = AssetHandler.GetAsset("Particles/InjectionShot/Scope", {
        AbilityName = "Ope",
        SkinName = p3
    }):Clone();
    ParticleHandler.Unusualify(v6, {
        IncludeParts = true,
        HSVData = v5
    });
    v6:SetPrimaryPartCFrame(HumanoidRootPart.CFrame * CFrame.new(0, 0, -7));
    v6.Parent = workspace.Effects;
    local Highlight = Instance.new("Highlight");
    Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
    Highlight.FillColor = ParticleHandler.TryHSVShift(Color3.fromRGB(50, 67, 109), v5);
    Highlight.FillTransparency = 0;
    Highlight.OutlineTransparency = 1;
    Highlight.Parent = v6;
    task.delay(0.7 / p2, v6.Destroy, v6);

    for _, child in v6:GetChildren() do
        if child.Name == "Branch" then
            TweenService:Create(child, u4, {
                Size = child.Size * 20,
                CFrame = child.CFrame * CFrame.new((child.Size * 20).X / 2 + v6.PrimaryPart.Size.X * 10, 0, 0)
            }):Play();
            local u7 = child.Size * 20;
            task.spawn(function() -- Line: 47
                -- upvalues: u4 (copy), child (copy), u7 (copy), TweenService (ref)
                for i = 1, 3 do
                    task.wait(u4.Time / 6);
                    local v8 = child[tostring(i)];
                    v8.CFrame = v8.CFrame * CFrame.new(u7.X / 3 * i, 0, 0);
                    TweenService:Create(child[tostring(i)], TweenInfo.new(0.15, Enum.EasingStyle.Linear), {
                        Size = child[tostring(i)].Size * 20
                    }):Play();
                end;
            end);
        end;

        if child.Name == "Shock" then
            TweenService:Create(child, u4, {
                Size = child.Size * 20
            }):Play();
        end;

        if child.Name == "Pointer" then
            TweenService:Create(child, u4, {
                Size = child.Size * 20,
                Position = v6.PrimaryPart.Position - (v6.PrimaryPart.Position - child.Position) * 20
            }):Play();
        end;
    end;
end;
  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local TableUtil = require(Knit.Util.TableUtil);
require(PathShortcuts.ReplicatedModules.EffectsHandler);
local TweenService = game:GetService("TweenService");

return function(p1) -- Line: 9
    -- upvalues: TableUtil (copy), TweenService (copy)
    local Character = p1.Character;
    local Target = p1.Target;
    local v2 = p1.Lifetime or 0.5;

    if Target or not Character then
        Character = Target;
    elseif not Character:FindFirstChild("HumanoidRootPart") then
        Character = Character:FindFirstChildWhichIsA("BasePart");
    end;

    if not (Character and Character:IsDescendantOf(workspace)) then
        return;
    end;

    local v3 = TableUtil.Reconcile(p1.Options or {}, {
        Material = p1.Material,
        Color = p1.Color,
        ToExclude = p1.ToExclude or {},
        ToInclude = p1.ToInclude or {},
        IsHighlight = p1.IsHighlight or false,
        FillColor = p1.FillColor or Color3.new(1, 1, 1),
        OutlineColor = p1.OutlineColor or Color3.new(0, 0, 0),
        FillTransparency = p1.FillTransparency or 0,
        OutlineTransparency = p1.OutlineTransparency or 0,
        DepthMode = p1.DepthMode or Enum.HighlightDepthMode.AlwaysOnTop,
        AllowAccessories = p1.AllowAccessories == nil and true or p1.AllowAccessories,
        BaseTransparency = p1.BaseTransparency or 0.5
    });
    local v4 = v3.ToInclude and #v3.ToInclude > 0;
    Character.Archivable = true;
    local v5, v6;

    if Character:IsA("Model") then
        v5 = Character:Clone();
        v6 = v5:GetDescendants();

        if v3.IsHighlight then
            local v7 = v5:FindFirstChildOfClass("Humanoid");

            if v7 then
                v7:Destroy();
            end;

            local HumanoidRootPart = v5:FindFirstChild("HumanoidRootPart");

            if HumanoidRootPart then
                HumanoidRootPart.Size = Vector3.new(0, 0, 0);
            end;
        end;
    else
        if not Character:IsA("BasePart") then
            return;
        end;

        local v8 = false;

        if v4 then
            v8 = true;

            for _, v in ipairs(v3.ToInclude) do
                if v == Character.Name then
                    v8 = false;
                    break;
                end;
            end;
        else
            for _, v in ipairs(v3.ToExclude) do
                if v == Character.Name then
                    v8 = true;
                    break;
                end;
            end;
        end;

        if v8 then
            return;
        end;

        v5 = Character:Clone();
        v6 = { v5 };
    end;

    v5.Name = v3.IsHighlight and "AfterimageHighlight" or "AfterimageGhost";

    if v3.AllowAccessories == false and Character:IsA("Model") then
        for _, descendant in ipairs(v5:GetDescendants()) do
            if descendant:IsA("Accessory") or (descendant:IsA("Shirt") or descendant:IsA("Pants")) then
                descendant:Destroy();
            end;
        end;
    end;

    for _, v in ipairs(v6) do
        local v9 = false;

        if v4 then
            v9 = true;

            for _, v7 in ipairs(v3.ToInclude) do
                if v7 == v.Name then
                    v9 = false;
                    break;
                end;
            end;
        else
            for _, v7 in ipairs(v3.ToExclude) do
                if v7 == v.Name then
                    v9 = true;
                    break;
                end;
            end;
        end;

        if v9 then
            v:Destroy();
        elseif v:IsA("Script") or (v:IsA("LocalScript") or (v:IsA("JointInstance") or (v:IsA("Constraint") or v:IsA("Sound")))) then
            v:Destroy();
        elseif v:IsA("BasePart") then
            v.Anchored = true;
            v.CollisionGroup = "NoCollision";

            if v3.Color and not v3.IsHighlight then
                v.Color = v3.Color;

                if v:IsA("MeshPart") then
                    v.TextureID = "";
                end;

                local v10 = v:FindFirstChildOfClass("SpecialMesh");

                if v10 then
                    v10.TextureId = "";
                end;
            end;

            if v3.IsHighlight then
                v.Transparency = 1;
                v.Material = Enum.Material.Glass;
            else
                v.Transparency = v3.BaseTransparency;

                if v3.Material then
                    v.Material = v3.Material;
                end;
            end;

            if Character:IsA("Model") then
                local v11 = Character:FindFirstChild(v.Name);

                if v11 and v11:IsA("BasePart") then
                    v.CFrame = v11.CFrame;
                end;
            elseif Character:IsA("BasePart") then
                v.CFrame = Character.CFrame;
            end;
        elseif v:IsA("Decal") then
            if v3.IsHighlight then
                v:Destroy();
            else
                v.Transparency = v3.BaseTransparency;
            end;
        end;
    end;

    v5.Parent = workspace.Effects;

    if v5:FindFirstChild("HumanoidRootPart") then
        v5.PrimaryPart = v5:FindFirstChild("HumanoidRootPart");
    end;

    if p1.Origin and v5.PrimaryPart then
        v5:PivotTo(p1.Origin);
    end;

    if v3.IsHighlight then
        local Highlight = Instance.new("Highlight");
        Highlight.Adornee = v5;
        Highlight.FillColor = v3.FillColor;
        Highlight.OutlineColor = v3.OutlineColor;
        Highlight.FillTransparency = v3.FillTransparency;
        Highlight.OutlineTransparency = v3.OutlineTransparency;
        Highlight.DepthMode = v3.DepthMode;
        Highlight.Parent = v5;
        TweenService:Create(Highlight, TweenInfo.new(v2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            FillTransparency = 1,
            OutlineTransparency = 1
        }):Play();
    else
        for _, v in ipairs(v6) do
            if v:IsA("BasePart") or v:IsA("Decal") then
                TweenService:Create(v, TweenInfo.new(v2, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                    Transparency = 1
                }):Play();
            end;
        end;
    end;

    task.delay(v2, v5.Destroy, v5);

    return v5;
end;
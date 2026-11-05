  

 

local LocalPlayer = game:GetService("Players").LocalPlayer;
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local Knit = require(PathShortcuts.KnitPath.Knit);
local u1 = nil;
Knit.OnStart():andThen(function() -- Line: 12
    -- upvalues: u1 (ref), PathShortcuts (copy)
    u1 = require(PathShortcuts.KnitPath.Trove);
end);
local Highlight = Instance.new("Highlight");
Highlight.FillColor = Color3.fromRGB(255, 255, 255);
Highlight.FillTransparency = 0;
Highlight.OutlineColor = Color3.fromRGB(255, 255, 255);
Highlight.OutlineTransparency = 0;
Highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;

return function(u2) -- Line: 23
    -- upvalues: u1 (ref), LocalPlayer (copy), Highlight (copy), TweenService (copy), RunService (copy)
    if u2.Change and u2.Name then
        for _, child in workspace.Effects:GetChildren() do
            if u2.HighlightData and (child:IsA("Highlight") and child.Name == u2.Name) then
                for i, v in u2.HighlightData do
                    child[i] = v;
                end;
            elseif u2.ImageData and (child:IsA("BasePart") and child.Name == u2.Name) then
                for i, v in u2.ImageData do
                    child.BillboardGui.ImageLabel[i] = v;
                end;
            end;
        end;

        return;
    end;

    if not u2.Change and (u2.Name and workspace.Effects:FindFirstChild(u2.Name)) then
        return;
    end;

    local v3 = u2.Tween and (typeof(u2.Tween) == "number" and TweenInfo.new(u2.Tween) or TweenInfo.new(u2.Tween.Time or 1, u2.Tween.EasingStyle or Enum.EasingStyle.Linear, u2.Tween.EasingDirection or Enum.EasingDirection.InOut, u2.Tween.RepeatCount or 0, u2.Tween.Reverse or false, u2.Tween.Delay or 0));
    local u4 = u1.new();
    local u5 = script.ScreenEffect:Clone();
    u5.Parent = workspace.Effects;
    u5.Name = u2.Name;
    u5.BillboardGui.Active = false;
    u4:Add(u5);
    u5.BillboardGui.PlayerToHideFrom = LocalPlayer;
    local u6 = {};

    for _, v in u2.Models do
        local v7 = Instance.fromExisting(Highlight);
        v7.Parent = workspace.Effects;
        v7.Adornee = v;
        v7.Name = u2.Name or "ScreenHighlight";
        table.insert(u6, v7);
        u4:Add(v7);
    end;

    for _, v in u6 do
        if v3 and u2.HighlightData then
            local v8 = TweenService:Create(v, v3, u2.HighlightData);

            if u2.Tween.HighlightData then
                for i, v2 in u2.Tween.HighlightData do
                    v[i] = v2;
                end;
            else
                v.FillTransparency = v.FillTransparency >= 1 and 0 or 1;
                v.OutlineTransparency = v.OutlineTransparency >= 1 and 0 or 1;
            end;

            v8:Play();
        elseif not v3 and (u2.HighlightData and u2.HighlightData) then
            for i, v2 in u2.HighlightData do
                v[i] = v2;
            end;
        end;

        v.Enabled = true;
    end;

    if v3 and u2.ImageData then
        local v9 = TweenService:Create(u5.BillboardGui.ImageLabel, v3, u2.ImageData);

        if u2.Tween.ImageData then
            for i, v in u2.Tween.ImageData do
                u5.BillboardGui.ImageLabel[i] = v;
            end;
        else
            u5.BillboardGui.ImageLabel.ImageTransparency = u5.BillboardGui.ImageLabel.ImageTransparency >= 1 and 0 or 1;
        end;

        v9:Play();
    elseif not v3 and u2.ImageData then
        for i, v in u2.ImageData do
            u5.BillboardGui.ImageLabel[i] = v;
        end;
    end;

    u5.BillboardGui.Enabled = true;
    u5.BillboardGui.Active = true;
    u5.BillboardGui.AlwaysOnTop = false;
    u5.BillboardGui.PlayerToHideFrom = nil;

    local function Clear() -- Line: 124
        -- upvalues: u4 (copy), u2 (copy), u6 (copy)
        u4:Destroy();
        table.clear(u2);
        table.clear(u6);
    end;

    u4:Add(RunService.PreRender:Connect(function(p10) -- Line: 131
        -- upvalues: u5 (copy)
        local v11 = 70 / workspace.CurrentCamera.FieldOfView;
        local ViewportSize = workspace.CurrentCamera.ViewportSize;
        u5.CFrame = workspace.CurrentCamera.CFrame * CFrame.new(0, 0, v11 - 1);
        u5.BillboardGui.StudsOffsetWorldSpace = Vector3.new(0, 0, -(ViewportSize.X - ViewportSize.Y) / 900);
        u5.BillboardGui.Size = UDim2.fromOffset(ViewportSize.X + v11, ViewportSize.Y + v11);
    end));
    u4:Add(u2.Host.AncestryChanged:Connect(function(p12, p13) -- Line: 138
        -- upvalues: u4 (copy), u2 (copy), u6 (copy)
        if not (p13 and p13:IsDescendantOf(game)) then
            u4:Destroy();
            table.clear(u2);
            table.clear(u6);
        end;
    end));

    if u2.Hook then
        u4:Add(u2.Host:GetAttributeChangedSignal(u2.Hook):Once(Clear));
    end;

    u4:Add(LocalPlayer.CharacterAdded:Once(Clear));
end;
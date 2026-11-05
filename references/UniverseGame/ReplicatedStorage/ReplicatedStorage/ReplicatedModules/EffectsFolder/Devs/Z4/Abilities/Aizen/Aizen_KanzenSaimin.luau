  

 

local TweenService = game:GetService("TweenService");
local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Trove = require(PathShortcuts.KnitPath.Trove);
local Outline = script:WaitForChild("NightVisionHud"):WaitForChild("Outline");

if game:GetService("RunService"):IsClient() then
    Outline.Parent = nil;
end;

return function(p1, p2) -- Line: 13
    -- upvalues: LocalPlayer (copy), Trove (copy), TweenService (copy), Outline (copy)
    if game.Lighting:FindFirstChild("Aizen Night Vision") then
        return;
    end;

    local v3 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
    local v4;

    if v3 then
        v4 = v3.HumanoidRootPart;
    else
        v4 = v3;
    end;

    if not (v3 and v4) then
        return;
    end;

    local v5 = Trove.new();
    v5:AttachToInstance(v3);
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect");
    ColorCorrectionEffect.Name = "Aizen Night Vision";
    ColorCorrectionEffect.Parent = game.Lighting;
    TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.3), {
        TintColor = Color3.fromRGB(139, 189, 255)
    }):Play();
    v5:Add(function() -- Line: 37
        -- upvalues: TweenService (ref), ColorCorrectionEffect (copy)
        local v6 = TweenService:Create(ColorCorrectionEffect, TweenInfo.new(0.5), {
            TintColor = Color3.fromRGB(255, 255, 255)
        });
        v6.Completed:Connect(function() -- Line: 42
            -- upvalues: ColorCorrectionEffect (ref)
            ColorCorrectionEffect:Destroy();
        end);
        v6:Play();
    end);

    while v3:IsDescendantOf(game) and v3:GetAttribute(p2 or "CloneSpawned") do
        for _, child in workspace.Living:GetChildren() do
            if child == p1 then
                local NightVisionHud = child:FindFirstChild("NightVisionHud");

                if not NightVisionHud then
                    NightVisionHud = v5:Clone(script.NightVisionHud);
                    Outline:Clone().Parent = NightVisionHud;
                    NightVisionHud.MaxDistance = (1 / 0);
                    NightVisionHud.Outline.Adornee = child;
                    NightVisionHud.Parent = child;
                end;

                NightVisionHud.Meter.GroupTransparency = 0;
                NightVisionHud.Outline.FillTransparency = 0;

                if child:GetAttribute("Meter") and child:GetAttribute("MaxMeter") then
                    NightVisionHud.Meter.Percent.Size = UDim2.new(child:GetAttribute("Meter") / child:GetAttribute("MaxMeter"), 0, 1, 0);
                end;
            end;
        end;

        task.wait();
    end;

    if v3:IsDescendantOf(game) then
        v5:Destroy();
    end;
end;
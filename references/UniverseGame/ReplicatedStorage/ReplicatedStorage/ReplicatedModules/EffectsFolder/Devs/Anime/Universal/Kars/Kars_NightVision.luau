  

 

game:GetService("TweenService");
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
    -- upvalues: LocalPlayer (copy), Trove (copy), Outline (copy)
    if game.Lighting:FindFirstChild("Kars Night Vision") then
        return;
    end;

    local v3 = p1 or 50;
    local v4 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
    local v5;

    if v4 then
        v5 = v4.HumanoidRootPart;
    else
        v5 = v4;
    end;

    if not (v4 and v5) then
        return;
    end;

    local v6 = Trove.new();
    v6:AttachToInstance(v4);

    while v4:IsDescendantOf(game) and v4:GetAttribute(p2 or "LightDancer") do
        for _, child in workspace.Living:GetChildren() do
            if child ~= v4 and child.PrimaryPart then
                local Magnitude = (v5.Position - child.PrimaryPart.Position).Magnitude;
                local NightVisionHud = child:FindFirstChild("NightVisionHud");

                if v3 < Magnitude then
                    if NightVisionHud then
                        NightVisionHud:Destroy();
                    end;
                else
                    if not NightVisionHud then
                        NightVisionHud = v6:Clone(script.NightVisionHud);
                        Outline:Clone().Parent = NightVisionHud;
                        NightVisionHud.MaxDistance = v3;
                        NightVisionHud.Outline.Adornee = child;
                        NightVisionHud.Parent = child;
                    end;

                    local v7 = math.max(0, (Magnitude + 10) / v3);
                    NightVisionHud.Meter.GroupTransparency = v7;
                    NightVisionHud.Outline.FillTransparency = v7;

                    if child:GetAttribute("Meter") and child:GetAttribute("MaxMeter") then
                        NightVisionHud.Meter.Percent.Size = UDim2.new(child:GetAttribute("Meter") / child:GetAttribute("MaxMeter"), 0, 1, 0);
                    end;
                end;
            end;
        end;

        task.wait();
    end;

    if v4:IsDescendantOf(game) then
        v6:Destroy();
    end;
end;
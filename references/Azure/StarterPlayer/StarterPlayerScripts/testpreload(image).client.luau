 

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local ContentProvider = game:GetService("ContentProvider");
local Players = game:GetService("Players");

for _, descendant in ipairs(ReplicatedStorage.Resources:GetDescendants()) do
    if descendant:IsA("ScreenGui") and string.find(descendant.Name, "ImpactFrame") then
        local v1 = descendant:Clone();

        for _, descendant2 in ipairs(v1:GetDescendants()) do
            if descendant2:IsA("Frame") or (descendant2:IsA("CanvasGroup") or descendant2:IsA("ImageLabel")) then
                if descendant2:IsA("ImageLabel") then
                    descendant2.BackgroundTransparency = 1;
                    descendant2.ImageTransparency = 0.999;
                    descendant2.Size = UDim2.fromScale(0.01, 0.01);
                    descendant2.Visible = true;
                else
                    descendant2.Visible = false;
                end;
            end;
        end;

        v1.Enabled = true;
        v1.ResetOnSpawn = false;
        v1.Name = `impactFrame | {workspace:GetServerTimeNow()} (Preload)`;
        v1.Parent = Players.LocalPlayer.PlayerGui;
        ContentProvider:PreloadAsync({ descendant });
    end;
end;
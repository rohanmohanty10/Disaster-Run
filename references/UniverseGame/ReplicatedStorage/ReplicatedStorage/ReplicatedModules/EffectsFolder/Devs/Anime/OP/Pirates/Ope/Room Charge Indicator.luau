  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local LocalPlayer = game:GetService("Players").LocalPlayer;
local _ = ReplicatedStorage["Client Assets"];
local PathShortcuts = require(ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);

return function(p1) -- Line: 15
    -- upvalues: LocalPlayer (copy), AssetHandler (copy), TweenService (copy)
    local Speed = p1.Speed;
    local MaxSize = p1.MaxSize;
    local v2 = p1.Lifetime / Speed;
    local GrowthRate = p1.GrowthRate;
    task.wait(p1.StartFrame / 60);
    local v3 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait();
    local HumanoidRootPart = v3.HumanoidRootPart;
    local v4 = os.clock();
    local v5 = AssetHandler.GetAsset("Particles/Room/Indicator", {
        AbilityName = "Ope",
        SkinName = p1.SkinName
    }):Clone();
    v5.Parent = workspace.Effects;
    task.delay(v2 + 0.5, v5.Destroy, v5);
    TweenService:Create(v5, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        Transparency = 0.9
    }):Play();

    while true do
        local v6 = task.wait(0.016666666666666666);

        if v5:IsDescendantOf(game) and HumanoidRootPart:IsDescendantOf(game) then
            v5.CFrame = HumanoidRootPart.CFrame * CFrame.new(0.1, -0.6, -2.82);
            local v7 = TweenInfo.new(v6, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut);
            local v8 = {};
            local v9 = (os.clock() - v4) * GrowthRate * Speed;
            v8.Size = Vector3.new(1, 1, 1) * math.min(v9, MaxSize);
            TweenService:Create(v5, v7, v8):Play();
        end;

        if v2 < os.clock() - v4 or (not v3:IsDescendantOf(game) or v3:GetAttribute("Room")) then
            if v5:IsDescendantOf(game) then
                task.delay(0.35, v5.Destroy, v5);
                TweenService:Create(v5, TweenInfo.new(0.35, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
                    Transparency = 1
                }):Play();
            end;

            return;
        end;
    end;
end;
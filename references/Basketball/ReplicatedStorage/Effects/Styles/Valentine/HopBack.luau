 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Essentials = require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local _ = Players.LocalPlayer;
workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 11
    -- upvalues: Essentials (copy), TweenService (copy), VfxManager (copy)
    local Character = p2.Character;

    for i = 1, 5 do
        local v3 = Essentials:CreateClone(Character);
        local v4 = Essentials:Highlight(v3);
        v4.FillColor = Color3.fromRGB(255, 253, 155);
        v4.OutlineColor = Color3.fromRGB(255, 120, 47);
        v4.FillTransparency = 0;
        v4.OutlineTransparency = 0;
        TweenService:Create(v4, TweenInfo.new(0.5), {
            FillTransparency = 1,
            OutlineTransparency = 1
        }):Play();
        VfxManager.DestroyEffect(v3, 0.5);
        task.wait(0.05);
        local _ = i;
    end;
end;
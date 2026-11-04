  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);

return function(p1) -- Line: 9
    -- upvalues: Essentials (copy), TweenService (copy), Debris (copy)
    local v2 = Essentials:Highlight(p1.Char);
    v2.FillColor = Color3.new(1, 0.207843, 0.207843);
    local v3 = TweenService:Create(v2, TweenInfo.new(0.45, Enum.EasingStyle.Back, Enum.EasingDirection.Out, 0, true), {
        FillTransparency = 0.65,
        OutlineTransparency = 0.8
    });
    v3:Play();
    Debris:AddItem(v3, 0.45);
    Debris:AddItem(v2, 0.45);
end;
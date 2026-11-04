 
 

local Debris = game:GetService("Debris");
local TweenService = game:GetService("TweenService");
local Lighting = game:GetService("Lighting");

return function(p1: number, p2: number) -- Line: 5
    -- upvalues: Lighting (copy), TweenService (copy), Debris (copy)
    local v3 = p2 or 0.2;
    local BlurEffect = Instance.new("BlurEffect");
    BlurEffect.Size = p1 or 24;
    BlurEffect.Parent = Lighting;
    TweenService:Create(BlurEffect, TweenInfo.new(v3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
        Size = 0
    }):Play();
    Debris:AddItem(BlurEffect, v3);
end;
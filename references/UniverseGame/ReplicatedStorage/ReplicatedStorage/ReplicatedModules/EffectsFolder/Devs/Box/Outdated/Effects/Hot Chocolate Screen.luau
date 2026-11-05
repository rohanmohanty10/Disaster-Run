  

 

local TweenService = game:GetService("TweenService");
local u1 = game:GetService("ReplicatedStorage")["Client Assets"];

return function() -- Line: 4
    -- upvalues: u1 (copy), TweenService (copy)
    local v2 = u1["Candy Cutlass"].HotChocolate.CoffeeColor:Clone();
    v2.Parent = game.Lighting;
    local v3 = u1["Candy Cutlass"].HotChocolate.CoffeeBlur:Clone();
    v3.Parent = game.Lighting;
    task.wait(2.5);
    TweenService:Create(v2, TweenInfo.new(0.5), {
        TintColor = Color3.fromRGB(255, 255, 255)
    }):Play();
    TweenService:Create(v2, TweenInfo.new(0.5), {
        Contrast = 0
    }):Play();
    TweenService:Create(v3, TweenInfo.new(0.5), {
        Size = 0
    }):Play();
    task.wait(0.5);
    v2:Destroy();
    v3:Destroy();
end;
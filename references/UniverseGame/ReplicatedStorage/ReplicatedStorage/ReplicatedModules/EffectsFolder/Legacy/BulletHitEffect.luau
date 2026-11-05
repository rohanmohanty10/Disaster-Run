  

 

game:GetService("TweenService");
local EffectsHandler = require(game.ReplicatedStorage.ReplicatedModules.EffectsHandler);
local _ = math.random;
local u1 = EffectsHandler.GetEffect("generatehit");

return function(p2, p3) -- Line: 5
    -- upvalues: u1 (copy)
    u1(p2.HumanoidRootPart.CFrame * CFrame.new(math.random(-0.5, 0.5), math.random(-0.5, 0.5), math.random(-0.5, 0.5)), {
        Color = Color3.fromRGB(191, 0, 3),
        Color2 = Color3.fromRGB(129, 0, 2),
        Count = 4,
        Size = 1.2,
        nil
    });
end;
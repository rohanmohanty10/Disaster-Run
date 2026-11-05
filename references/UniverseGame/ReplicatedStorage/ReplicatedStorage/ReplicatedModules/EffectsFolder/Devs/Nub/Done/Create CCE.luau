  

 

local StoreHandler = require(game.ReplicatedStorage.ReplicatedModules.Independent.StoreHandler);

local function tweendeb(p1, p2) -- Line: 2
    p1:Play();
    p1.Completed:Wait();

    if p2 then
        p2:Destroy();
    end;

    return true;
end;

return function(p3, p4, p5) -- Line: 9
    -- upvalues: StoreHandler (copy)
    local ColorCorrectionEffect = Instance.new("ColorCorrectionEffect", game.Lighting);
    StoreHandler.GetStore("Effects_CCE")[p3] = ColorCorrectionEffect;
    local v6, v7 = game:GetService("TweenService"):Create(ColorCorrectionEffect, TweenInfo.new(unpack(p4)), p5);
    v6:Play();
    v6.Completed:Wait();

    if v7 then
        v7:Destroy();
    end;
end;
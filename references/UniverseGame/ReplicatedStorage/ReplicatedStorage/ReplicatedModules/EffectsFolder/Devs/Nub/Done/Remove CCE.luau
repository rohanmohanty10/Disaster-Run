  

 

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
    local v6 = StoreHandler.GetStore("Effects_CCE");
    local v7 = v6[p3];

    if type(p4) == "table" and type(p5) == "table" then
        local v8, v9 = game:GetService("TweenService"):Create(v7, TweenInfo.new(unpack(p4)), p5);
        v8:Play();
        v8.Completed:Wait();

        if v9 then
            v9:Destroy();
        end;
    end;

    v7:Destroy();
    v6[p3] = nil;
end;
  

local u1 = require(game.ReplicatedStorage.Packages.Signal).new();
local u2 = {};
local v3 = require(game.ReplicatedStorage.Packages.Knit).CreateController({
    Name = "DiscountController"
});

function v3.ObserveDiscount(p4, u5, u6) -- Line: 10
    -- upvalues: u2 (ref), u1 (copy)
    u6(not u2[u5]);

    return u1:Connect(function(p7) -- Line: 12
        -- upvalues: u6 (copy), u5 (copy)
        u6(not p7[u5]);
    end);
end;

function v3.KnitInit(p8) -- Line: 17
    -- upvalues: u2 (ref), u1 (copy)
    game.ReplicatedStorage.UpdateDiscounts.OnClientEvent:Connect(function(p9) -- Line: 18
        -- upvalues: u2 (ref), u1 (ref)
        u2 = p9;
        u1:Fire(u2);
    end);
end;

return v3;
 

 

local Players = game:GetService("Players");
local MarketplaceService = game:GetService("MarketplaceService");
local ShopConfig = require(script.Parent.ShopConfig);
local u1 = {};
local u2 = ShopConfig.binding(game.GameId);
local u3 = (-1 / 0);

local function currencyOf(p4) -- Line: 11
    local string_lower_ret = string.lower((tostring(p4)));

    return (string_lower_ret == "coins" or string_lower_ret == "coin") and "coins" or ((string_lower_ret == "gems" or string_lower_ret == "gem") and "gems" or nil);
end;

function u1.shortfall(p5, p6) -- Line: 16
    local v7 = (tonumber(p5) or 0) - (tonumber(p6) or 0);
    local math_ceil_ret = math.ceil(v7);

    return math.max(0, math_ceil_ret);
end;

function u1.pick(p8, p9, p10) -- Line: 21
    -- upvalues: u1 (copy), u2 (copy), ShopConfig (copy)
    local string_lower_ret = string.lower((tostring(p8)));
    local v11 = (string_lower_ret == "coins" or string_lower_ret == "coin") and "coins" or ((string_lower_ret == "gems" or string_lower_ret == "gem") and "gems" or nil);
    local v12 = u1.shortfall(p9, p10);

    if not (v11 and (v12 > 0 and u2.PurchasesEnabled ~= false)) then
        return nil;
    end;

    local v13 = nil;
    local v14 = nil;

    for _, v in ShopConfig.Packs do
        local v15 = u2.ProductIds[v.Key];

        if v.Currency == v11 and (type(v15) == "number" and v15 > 0) then
            if v12 <= v.Amount and (not v13 or v.Amount < v13.Amount) then
                v13 = v;
            end;

            if not v14 or v.Amount > v14.Amount then
                v14 = v;
            end;
        end;
    end;

    return v13 or v14;
end;

function u1.prompt(p16, p17, p18) -- Line: 43
    -- upvalues: u1 (copy), u3 (ref), Players (copy), MarketplaceService (copy), u2 (copy)
    local v19 = u1.pick(p16, p17, p18);

    if not (v19 and (os.clock() - u3 >= 1 and Players.LocalPlayer:GetAttribute("GiftOpen") == nil)) then
        return nil;
    end;

    u3 = os.clock();
    local success, result = pcall(MarketplaceService.PromptProductPurchase, MarketplaceService, Players.LocalPlayer, u2.ProductIds[v19.Key]);

    if success then
        return v19;
    end;

    warn("CurrencyTopUp: the purchase prompt did not open:", result);

    return nil;
end;

return u1;
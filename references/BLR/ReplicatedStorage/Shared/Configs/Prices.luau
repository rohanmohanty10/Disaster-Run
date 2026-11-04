  

local RunService = game:GetService("RunService");
local MarketplaceService = game:GetService("MarketplaceService");
local v1 = {};
local u2 = { 2651999228, 2651999330, 2680382383, 2680388957, 2701485013, 2806418548, 3232087483, 3232662440, 3232663985, 2671676819, 2352505264, 2671681840, 2671681719, 1936508687, 2147779964, 1936508844, 2147780238, 2147780454, 1936509000, 2667359437, 2669959770, 2680407395, 2680444375, 3234147648, 3234246228, 3273900003, 2319963711, 2319963764, 2319963839, 2362904741, 2362917830, 2319967641, 2461470812, 2461470975, 2461471100, 2673669038, 2660228654, 2660228791, 2660228867, 2660228990, 2660229193 };
local u3 = {};

local function exponentialBackoff(p4) -- Line: 60
    return 1 * 2 ^ (p4 - 1);
end;

local function SetupPrices() -- Line: 65
    -- upvalues: u2 (copy), MarketplaceService (copy), u3 (copy)
    for _, v in u2 do
        local u5 = v;

        for i = 1, 5 do
            local v6 = tostring(u5);
            local success, result = pcall(function() -- Line: 70
                -- upvalues: MarketplaceService (ref), u5 (copy)
                return MarketplaceService:GetProductInfo(u5, Enum.InfoType.Product);
            end);

            if success then
                u3[v6] = result.PriceInRobux;
                print((`Product ID: {u5} | Price: {result.PriceInRobux} robux`));
                break;
            end;

            local v7 = 1 * 2 ^ (i - 1);
            print((`Retry {i} after {v7} seconds due to error: {error}`));
            task.wait(v7);
            local _ = i;
        end;
    end;
end;

print("Getting Prices");

if RunService:IsServer() then
    print("This shouldnt run on the server");

    return nil;
end;

task.spawn(SetupPrices);

function v1.HandlePriceText(p8: table, u9: userdata, u10: string, u11: number, u12: string?, u13: string?) -- Line: 96
    -- upvalues: u3 (copy)
    task.spawn(function() -- Line: 98
        -- upvalues: u3 (ref), u11 (copy), u9 (copy), u10 (copy), u12 (copy), u13 (copy)
        while not u3[tostring(u11)] do
            u9[u10] = "[PRICE LOADING]";
            task.wait(0.1);
        end;

        local v14 = u3[tostring(u11)];
        u9[u10] = (u12 or "") .. tostring(v14) .. (u13 or "");
    end);
end;

function v1.GetPrice(p15: table, p16: number) -- Line: 107
    -- upvalues: u2 (copy), u3 (copy)
    return table.find(u2, p16) and (u3[tostring(p16)] or "LOADING") or warn("ID Not Reported By QA: ", p16);
end;

return v1;
  

local MarketplaceService = game:GetService("MarketplaceService");
local u1 = {};
local u2 = {};

return function(u3: number, u4: any) -- Line: 6, Name: getProductInfo
    -- upvalues: u1 (copy), u2 (copy), MarketplaceService (copy)
    assert(u3, "assetId for getProductInfo was nil");
    assert(u4, "infoType is forced for getProductInfo in case ur dumb. sorry!!!");

    if u1[u3] then
        return u1[u3];
    end;

    if u2[u3] then
        table.insert(u2[u3], coroutine.running());

        return coroutine.yield();
    end;

    u2[u3] = { coroutine.running() };
    task.spawn(function() -- Line: 18
        -- upvalues: MarketplaceService (ref), u3 (copy), u4 (copy), u1 (ref), u2 (ref)
        local success, result = pcall(function() -- Line: 19
            -- upvalues: MarketplaceService (ref), u3 (ref), u4 (ref)
            return MarketplaceService:GetProductInfo(u3, u4);
        end);

        if success then
            u1[u3] = result;
        else
            warn((`failed to get product info {u3} {u4}. error: {result}`));
        end;

        for _, v in u2[u3] do
            task.spawn(v, u1[u3]);
        end;

        u2[u3] = nil;
    end);

    return coroutine.yield();
end;
 
 

local Shared = script.Parent.Parent.Parent.Shared;
local React = require(Shared.React);
local Promise = require(Shared.Promise);
local MarketplaceService = game:GetService("MarketplaceService");
local u1 = {};
local u4 = Promise.promisify(function(p2: number, p3: any) -- Line: 15
    -- upvalues: MarketplaceService (copy)
    if p2 > 0 then
        return MarketplaceService:GetProductInfo(p2, p3);
    end;

    return nil;
end);

return function(p5: number?, p6: any) -- Line: 44, Name: useProductInfo
    -- upvalues: React (copy), u1 (copy), Promise (copy), u4 (copy)
    local u7 = p5 or 0;
    local u8 = p6 or Enum.InfoType.Asset;
    local u9 = `{u8.Name}_{u7}`;
    local u11, u12 = React.useState(function() -- Line: 49
        -- upvalues: u1 (ref), u9 (copy), Promise (ref), u4 (ref), u7 (copy), u8 (copy)
        local v10 = u1[u9];

        if not v10 then
            v10 = Promise.retry(u4, 5, u7, u8);
            u1[u9] = v10;
        end;

        if v10:getStatus() == "Completed" then
            return v10:expect();
        end;

        return nil;
    end);
    React.useEffect(function() -- Line: 66
        -- upvalues: u1 (ref), u9 (copy), Promise (ref), u4 (ref), u7 (copy), u8 (copy), u11 (copy), u12 (copy)
        local v13 = u1[u9];

        if not v13 then
            v13 = Promise.retry(u4, 5, u7, u8);
            u1[u9] = v13;
        end;

        local u15 = v13:andThen(function(p14: table) -- Line: 74
            -- upvalues: u11 (ref), u12 (ref)
            if p14 and u11 ~= p14 then
                u12(p14);

                return;
            end;

            u12(nil);
        end):catch(function() -- Line: 80
            -- upvalues: u12 (ref)
            u12(nil);
        end);

        return function() -- Line: 84
            -- upvalues: u15 (copy)
            u15:cancel();
        end;
    end, { u7, u8 });

    return u11;
end;
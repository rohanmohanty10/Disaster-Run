  

local u1 = {};
local MarketplaceService = game:GetService("MarketplaceService");
local Players = game:GetService("Players");
local Utilities = require(script.Parent.Parent.Utilities);
local EngagementMarkers = require(script.Parent.Parent.EngagementMarkers);
local ServerClientInfoHandler = require(script.Parent.Parent.ServerClientInfoHandler);
local u2 = {
    [Enum.InfoType.GamePass] = "gamepass",
    [Enum.InfoType.Product] = "devproduct",
    [Enum.InfoType.Asset] = "asset",
    [Enum.InfoType.Subscription] = "subscription"
};
local u3 = {};
local u4 = false;
local u5 = {};

local function IsString(p6: any, p7: number) -- Line: 51
    local v8;

    if type(p6) == "string" then
        v8 = #p6 <= p7;
    else
        v8 = false;
    end;

    return v8;
end;

local function SanitizeClientProductInfo(p9) -- Line: 59
    if type(p9) ~= "table" then
        return nil;
    end;

    local PriceInRobux = p9.PriceInRobux;

    if PriceInRobux ~= nil and (type(PriceInRobux) ~= "number" or (PriceInRobux ~= PriceInRobux or (PriceInRobux < 0 or PriceInRobux == (1 / 0)))) then
        return nil;
    end;

    local v10 = {
        PriceInRobux = PriceInRobux
    };
    local DisplayPrice = p9.DisplayPrice;
    local v11;

    if type(DisplayPrice) == "string" then
        v11 = #DisplayPrice <= 32;
    else
        v11 = false;
    end;

    local v12;

    if v11 then
        v12 = p9.DisplayPrice;
    else
        v12 = nil;
    end;

    v10.DisplayPrice = v12;
    local Name = p9.Name;
    local v13;

    if type(Name) == "string" then
        v13 = #Name <= 200;
    else
        v13 = false;
    end;

    local v14;

    if v13 then
        v14 = p9.Name;
    else
        v14 = nil;
    end;

    v10.Name = v14;
    local Description = p9.Description;
    local v15;

    if type(Description) == "string" then
        v15 = #Description <= 1000;
    else
        v15 = false;
    end;

    local v16;

    if v15 then
        v16 = p9.Description;
    else
        v16 = nil;
    end;

    v10.Description = v16;

    return v10;
end;

local function GetClientProductInfo(p17: any, p18: number, p19: any) -- Line: 78
    -- upvalues: SanitizeClientProductInfo (copy), ServerClientInfoHandler (copy)
    return SanitizeClientProductInfo(ServerClientInfoHandler:GetProductInfoForPlayer(p17, p18, p19));
end;

local function GetProductInfo(p20: any, p21: number, p22: any) -- Line: 82
    -- upvalues: u3 (copy), Utilities (copy), SanitizeClientProductInfo (copy), ServerClientInfoHandler (copy)
    if not u3[p22] then
        u3[p22] = {};
    end;

    local v23 = false;
    local v24 = u3[p22][p21];

    if not v24 then
        if p22 ~= Enum.InfoType.Subscription then
            v24 = Utilities.getProductInfo(p21, p22);
        end;

        if not v24 and Utilities.resolvePlayerObject(p20) then
            v24 = SanitizeClientProductInfo(ServerClientInfoHandler:GetProductInfoForPlayer(p20, p21, p22));
            v23 = true;
        end;

        if not v24 then
            return;
        end;

        if not v23 then
            u3[p22][p21] = v24;
        end;
    end;

    return {
        FromClient = v23,
        Data = v24
    };
end;

local function FlushProductPurchaseCache(u25: userdata) -- Line: 111
    -- upvalues: u5 (copy), u1 (copy)
    local v26 = u5[u25];

    if not v26 then
        return;
    end;

    for _, v in ipairs(v26) do
        task.spawn(function() -- Line: 118
            -- upvalues: u1 (ref), u25 (copy), v (copy)
            u1:UpdatePlayerSpend(u25, false, v.itemId, Enum.InfoType.Product, {
                position = v.position,
                timestampOverride = v.timestamp
            });
        end);
    end;

    u5[u25] = nil;
end;

function u1.UpdatePlayerSpend(p27: table, p28: any, p29: boolean, p30: number, p31: any, p32: table?) -- Line: 128
    -- upvalues: Utilities (copy), GetProductInfo (copy), SanitizeClientProductInfo (copy), ServerClientInfoHandler (copy), u2 (copy), EngagementMarkers (copy)
    local v33 = Utilities.resolvePlayerObject(p28);
    local v34 = GetProductInfo(v33, p30, p31);

    if not v34 then
        return;
    end;

    local v35;

    if v34.FromClient then
        v35 = v34.Data;
    elseif v33 then
        v35 = SanitizeClientProductInfo(ServerClientInfoHandler:GetProductInfoForPlayer(v33, p30, p31));
    else
        v35 = nil;
    end;

    local PriceInRobux = v34.Data.PriceInRobux;

    if v35 and (v35.PriceInRobux and (PriceInRobux and (PriceInRobux > 0 and PriceInRobux < v35.PriceInRobux))) then
        v35 = nil;
    end;

    local v36 = {
        fromReceipt = p29,
        type = u2[p31] or "unknown",
        id = p30,
        price = v35 and v35.PriceInRobux or v34.Data.PriceInRobux,
        basePrice = v34.Data.PriceInRobux
    };
    local v37;

    if v35 then
        v37 = v35.DisplayPrice;
    else
        v37 = nil;
    end;

    v36.localPrice = v37;
    v36.name = v34.Data.Name;
    v36.description = v34.Data.Description;
    v36.imageId = "https://assetdelivery.roblox.com/v1/asset?id=" .. p30;
    local v38 = p32 or {};
    v38.player = v33;

    if v33 then
        v33 = v33.Character;
    end;

    if v38.position == nil and (v33 and v33.PrimaryPart) then
        v38.position = v33.PrimaryPart.Position;
    end;

    EngagementMarkers:SDKMarker("Purchase", v36, v38);
end;

function u1.DevProductPurchased(p39: table, p40: boolean, p41: number, p42: number, p43: vector?) -- Line: 176
    -- upvalues: u4 (ref), Players (copy), GetProductInfo (copy), u5 (copy), FlushProductPurchaseCache (copy)
    if u4 and p40 == false then
        return;
    end;

    local PlayerByUserId = Players:GetPlayerByUserId(p41);

    if not PlayerByUserId then
        return;
    end;

    if not GetProductInfo(PlayerByUserId, p42, Enum.InfoType.Product) then
        return;
    end;

    if p40 then
        u4 = true;
        u5[PlayerByUserId] = nil;
        p39:UpdatePlayerSpend(p41, true, p42, Enum.InfoType.Product, {
            position = p43
        });

        return;
    end;

    u5[PlayerByUserId] = u5[PlayerByUserId] or {};
    local v44 = u5[PlayerByUserId];
    local v45 = {
        itemId = p42,
        position = p43,
        timestamp = DateTime.now().UnixTimestampMillis
    };
    table.insert(v44, v45);

    if #v44 >= 3 then
        FlushProductPurchaseCache(PlayerByUserId);
    end;
end;

function u1.Init(u46) -- Line: 215
    -- upvalues: MarketplaceService (copy), Players (copy), FlushProductPurchaseCache (copy)
    MarketplaceService.PromptGamePassPurchaseFinished:Connect(function(u47, u48, p49) -- Line: 220
        -- upvalues: MarketplaceService (ref), u46 (copy)
        if not p49 then
            return;
        end;

        local success, result = pcall(function() -- Line: 225
            -- upvalues: MarketplaceService (ref), u47 (copy), u48 (copy)
            return MarketplaceService:UserOwnsGamePassAsync(u47.UserId, u48);
        end);

        if success and result then
            u46:UpdatePlayerSpend(u47, false, u48, Enum.InfoType.GamePass);
        end;
    end);
    MarketplaceService.PromptPurchaseFinished:Connect(function(u50, u51, p52) -- Line: 234
        -- upvalues: MarketplaceService (ref), u46 (copy)
        if not p52 then
            return;
        end;

        local success, result = pcall(function() -- Line: 239
            -- upvalues: MarketplaceService (ref), u50 (copy), u51 (copy)
            return MarketplaceService:PlayerOwnsAsset(u50, u51);
        end);

        if success and result then
            u46:UpdatePlayerSpend(u50, false, u51, Enum.InfoType.Asset);
        end;
    end);
    Players.UserSubscriptionStatusChanged:Connect(function(u53, u54) -- Line: 248
        -- upvalues: MarketplaceService (ref), u46 (copy)
        local success, result = pcall(function() -- Line: 249
            -- upvalues: MarketplaceService (ref), u53 (copy), u54 (copy)
            return MarketplaceService:GetUserSubscriptionStatusAsync(u53, u54);
        end);

        if success and result.IsSubscribed then
            u46:UpdatePlayerSpend(u53, false, u54, Enum.InfoType.Subscription);
        end;
    end);
    Players.PlayerRemoving:Connect(FlushProductPurchaseCache);
end;

return u1;
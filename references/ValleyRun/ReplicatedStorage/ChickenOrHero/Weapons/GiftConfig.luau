 

 

local RunService = game:GetService("RunService");
local script_Parent = script.Parent;
local Parent = script_Parent.Parent;
local ShopConfig = require(script_Parent.ShopConfig);
local OfferRules = require(script_Parent.OfferRules);
local Bundles = require(script_Parent.Bundles);
local SkinCatalog = require(script_Parent.SkinCatalog);
local EmoteCatalog = require(Parent.Emotes.EmoteCatalog);
local DailyEmotes = require(Parent.Emotes.DailyEmotes);
local u1 = {
    LiveUniverseId = ShopConfig.LiveUniverseId,
    TestUniverseId = ShopConfig.TestUniverseId,
    GiftProducts = {
        [10764627709] = {
            Football = 3717527002,
            Futbol = 3717527022,
            Spoon = 3717527035,
            VIP = 3717527055,
            DoubleXP = 3717527063,
            Selfie = 3717719448,
            Ghost = 3717721749
        },
        [10768621983] = {
            Football = 3717527080,
            Futbol = 3717527098,
            Spoon = 3717527107,
            VIP = 3717527124,
            DoubleXP = 3717527135,
            Selfie = 3717720312,
            Ghost = 3717722004,
            BonkerBundle = 3717723974
        }
    },
    PassGifts = {
        Football = {
            Kind = "Knife",
            Skin = "Football"
        },
        Futbol = {
            Kind = "Knife",
            Skin = "Futbol"
        },
        Spoon = {
            Kind = "Knife",
            Skin = "SpoonDagger"
        },
        Ghost = {
            Kind = "Knife",
            Skin = "GhostScythe"
        },
        Selfie = {
            Kind = "Knife",
            Skin = "SelfieStick"
        },
        VIP = {
            Kind = "Perk",
            Perk = "VIP",
            Bonus = "VIPDagger"
        },
        DoubleXP = {
            Kind = "Perk",
            Perk = "DoubleXP"
        }
    },
    QueueLimit = 3
};
local game_GameId = game.GameId;
local u2 = ShopConfig.binding(u1.LiveUniverseId);

local function comma(p3) -- Line: 68
    local math_floor_ret = math.floor(p3);

    return tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "");
end;

local function sharedProducts() -- Line: 74
    -- upvalues: game_GameId (copy), u1 (copy), RunService (copy)
    local v4;

    if game_GameId == u1.LiveUniverseId then
        v4 = true;
    elseif game_GameId == u1.TestUniverseId then
        v4 = RunService:IsStudio();
    else
        v4 = false;
    end;

    return v4;
end;

local function packOf(p5) -- Line: 78
    -- upvalues: ShopConfig (copy)
    for _, v in ShopConfig.Packs do
        if v.Key == p5 then
            return v;
        end;
    end;

    return nil;
end;

local u6 = {};

function u1.offer(p7) -- Line: 90
    -- upvalues: u6 (copy), ShopConfig (copy), game_GameId (copy), u1 (copy), Bundles (copy), RunService (copy), EmoteCatalog (copy), u2 (copy)
    if type(p7) ~= "string" or #p7 > 64 then
        return nil;
    end;

    local v8 = u6[p7];

    if v8 then
        return v8;
    end;

    local v9 = nil;

    if ShopConfig.binding(game_GameId).PurchasesEnabled ~= false then
        local v10 = u1.PassGifts[p7];
        local v11 = u1.GiftProducts[game_GameId];
        local v12 = Bundles.get(p7);

        if v12 and (v11 and type(v11[p7]) == "number") then
            v9 = {
                kind = "Bundle",
                giftOnly = true,
                key = p7,
                productId = v11[p7],
                name = v12.Name,
                skin = v12.SkinId,
                details = v12.Details
            };
        elseif v10 and (v11 and type(v11[p7]) == "number") then
            local v13 = ShopConfig.Passes[p7];
            v9 = {
                giftOnly = true,
                key = p7,
                kind = v10.Kind,
                productId = v11[p7]
            };
            local v14;

            if v13 then
                v14 = v13.Name or p7;
            else
                v14 = p7;
            end;

            v9.name = v14;
            v9.skin = v10.Skin;
            v9.perk = v10.Perk;
            v9.bonus = v10.Bonus;
            v9.pass = p7;
        elseif v12 and (v12.TestProductId and game_GameId == Bundles.TestUniverseId) then
            v9 = {
                kind = "Bundle",
                key = p7,
                productId = v12.TestProductId,
                name = v12.Name,
                skin = v12.SkinId,
                details = v12.Details
            };
        else
            local v15;

            if game_GameId == u1.LiveUniverseId then
                v15 = true;
            elseif game_GameId == u1.TestUniverseId then
                v15 = RunService:IsStudio();
            else
                v15 = false;
            end;

            if v15 then
                if v12 then
                    v9 = {
                        kind = "Bundle",
                        key = p7,
                        productId = v12.ProductId,
                        name = v12.Name,
                        skin = v12.SkinId,
                        details = v12.Details
                    };
                elseif string.sub(p7, 1, 6) == "Emote:" then
                    local v16 = EmoteCatalog.get((string.sub(p7, 7)));

                    if v16 and not (v16.Ultimate or (type(v16.ProductId) ~= "number" or v16.ProductId <= 0)) and (v16.ProductUniverse or u1.LiveUniverseId) == u1.LiveUniverseId then
                        v9 = {
                            kind = "Emote",
                            key = p7,
                            productId = v16.ProductId,
                            name = v16.Name .. " emote",
                            emote = v16.Id
                        };
                    end;
                else
                    local v17 = nil;

                    for _, v in ShopConfig.Packs do
                        if v.Key == p7 then
                            v17 = v;
                            break;
                        end;
                    end;

                    local v18;

                    if v17 then
                        v18 = u2.ProductIds[p7];
                    else
                        v18 = v17;
                    end;

                    local v19;

                    if v18 then
                        v19 = ShopConfig.ProductGrants[v18];
                    else
                        v19 = v18;
                    end;

                    if v19 and (v19.UniverseId == u1.LiveUniverseId and (v19.Currency == v17.Currency and v19.Amount == v17.Amount)) then
                        v9 = {
                            kind = "Pack",
                            key = p7,
                            productId = v18
                        };
                        local math_floor_ret = math.floor(v17.Amount);
                        v9.name = tostring(math_floor_ret):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "") .. (v17.Currency == "coins" and " Coins" or " Gems");
                        v9.currency = v17.Currency;
                        v9.amount = v17.Amount;
                    end;
                end;
            end;
        end;
    end;

    if v9 then
        u6[p7] = v9;
    end;

    return v9;
end;

local u20 = nil;

function u1.giftOnlyOffer(p21) -- Line: 196
    -- upvalues: u20 (ref), u1 (copy), game_GameId (copy)
    if not u20 then
        u20 = {};

        for i, v in u1.GiftProducts[game_GameId] or {} do
            local v22 = u1.offer(i);

            if v22 and v22.productId == v then
                u20[v] = v22;
            end;
        end;
    end;

    return u20[p21];
end;

function u1.onSale(p23, p24) -- Line: 211
    -- upvalues: SkinCatalog (copy), ShopConfig (copy), OfferRules (copy), Bundles (copy), EmoteCatalog (copy), DailyEmotes (copy)
    if not p23 then
        return false;
    end;

    if p23.kind == "Knife" then
        local v25 = SkinCatalog.get(p23.skin);

        if not v25 or v25.EquipReady == false then
            return false;
        end;

        local v26 = ShopConfig.flagship(p23.pass);

        if v26 then
            return OfferRules.active(v26, p24);
        end;

        for _, v in ShopConfig.AdditionalKnives or {} do
            if v.OfferKey == p23.pass then
                return true;
            end;
        end;

        return false;
    end;

    if p23.kind == "Perk" then
        return true;
    end;

    if p23.kind == "Bundle" then
        local v27 = Bundles.get(p23.key);
        local v28;

        if v27 == nil then
            v28 = false;
        else
            v28 = Bundles.isOnSale(v27, p24) and OfferRules.active(v27, p24);
        end;

        return v28;
    end;

    if p23.kind ~= "Emote" then
        return p23.kind == "Pack";
    end;

    local v29 = not EmoteCatalog.ComingSoon and DailyEmotes.card(p23.emote, p24) ~= nil;

    return v29;
end;

return u1;
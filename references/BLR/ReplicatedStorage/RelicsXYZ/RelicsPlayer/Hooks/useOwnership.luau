  

local script_Parent = script.Parent;
local Shared = script_Parent.Parent.Parent.Shared;
local React = require(Shared.React);
local Promise = require(Shared.Promise);
local RunContext = require(Shared.RunContext);
local Players = game:GetService("Players");
local MarketplaceService = game:GetService("MarketplaceService");
local useFeatures = require(script_Parent.useFeatures);
local useSignal = require(script_Parent.useSignal);
local LocalPlayer = Players.LocalPlayer;
local u1 = {};

local function promiseOwnership(u2: number, u3: any) -- Line: 30
    -- upvalues: Promise (copy), LocalPlayer (copy), RunContext (copy), MarketplaceService (copy)
    return Promise.new(function(p4, p5) -- Line: 31
        -- upvalues: LocalPlayer (ref), u2 (copy), RunContext (ref), u3 (copy), MarketplaceService (ref)
        if not LocalPlayer then
            p5("No player");

            return;
        end;

        if u2 < 1 then
            p4(false);

            return;
        end;

        if RunContext.IsStudio then
            p4(true);

            return;
        end;

        if u3 == Enum.InfoType.Asset then
            p4(MarketplaceService:PlayerOwnsAsset(LocalPlayer, u2));

            return;
        end;

        if u3 == Enum.InfoType.GamePass then
            p4(MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, u2));

            return;
        end;

        if u3 == Enum.InfoType.Bundle then
            p4(MarketplaceService:PlayerOwnsBundle(LocalPlayer.UserId, u2));

            return;
        end;

        p5("Unsupported info type");
    end);
end;

local function getOwnership(p6: table) -- Line: 59
    -- upvalues: u1 (copy), Promise (copy), LocalPlayer (copy), RunContext (copy), MarketplaceService (copy)
    local u7 = p6.Id or 0;
    local u8 = p6.InfoType or Enum.InfoType.Asset;
    local v9 = `{u8.Name}_{p6.Id}`;

    if u1[v9] then
        return u1[v9];
    end;

    local v12 = Promise.new(function(p10, p11) -- Line: 31
        -- upvalues: LocalPlayer (ref), u7 (copy), RunContext (ref), u8 (copy), MarketplaceService (ref)
        if not LocalPlayer then
            p11("No player");

            return;
        end;

        if u7 < 1 then
            p10(false);

            return;
        end;

        if RunContext.IsStudio then
            p10(true);

            return;
        end;

        if u8 == Enum.InfoType.Asset then
            p10(MarketplaceService:PlayerOwnsAsset(LocalPlayer, u7));

            return;
        end;

        if u8 == Enum.InfoType.GamePass then
            p10(MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, u7));

            return;
        end;

        if u8 == Enum.InfoType.Bundle then
            p10(MarketplaceService:PlayerOwnsBundle(LocalPlayer.UserId, u7));

            return;
        end;

        p11("Unsupported info type");
    end);
    u1[v9] = v12;

    return v12;
end;

return function(u13: table) -- Line: 74, Name: useOwnership
    -- upvalues: useFeatures (copy), React (copy), u1 (copy), Promise (copy), LocalPlayer (copy), RunContext (copy), MarketplaceService (copy), useSignal (copy)
    local u14 = useFeatures();
    local u25, u26 = React.useState(function() -- Line: 77
        -- upvalues: u14 (copy), u13 (copy), u1 (ref), Promise (ref), LocalPlayer (ref), RunContext (ref), MarketplaceService (ref)
        if u14.Demo then
            return true;
        end;

        for _, v in u13 do
            local v15 = v.Id or 0;
            local v16 = v.InfoType or Enum.InfoType.Asset;

            if v15 ~= 0 then
                local v17 = `{v16.Name}_{v15}`;
                local v18 = u1[v17];

                if v18 then
                    if v18:getStatus() == "Resolved" and v18:expect() then
                        return true;
                    end;
                else
                    local u19 = v.Id or 0;
                    local u20 = v.InfoType or Enum.InfoType.Asset;
                    local v21 = `{u20.Name}_{v.Id}`;
                    local v22;

                    if u1[v21] then
                        v22 = u1[v21];
                    else
                        v22 = Promise.new(function(p23, p24) -- Line: 31
                            -- upvalues: LocalPlayer (ref), u19 (copy), RunContext (ref), u20 (copy), MarketplaceService (ref)
                            if not LocalPlayer then
                                p24("No player");

                                return;
                            end;

                            if u19 < 1 then
                                p23(false);

                                return;
                            end;

                            if RunContext.IsStudio then
                                p23(true);

                                return;
                            end;

                            if u20 == Enum.InfoType.Asset then
                                p23(MarketplaceService:PlayerOwnsAsset(LocalPlayer, u19));

                                return;
                            end;

                            if u20 == Enum.InfoType.GamePass then
                                p23(MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, u19));

                                return;
                            end;

                            if u20 == Enum.InfoType.Bundle then
                                p23(MarketplaceService:PlayerOwnsBundle(LocalPlayer.UserId, u19));

                                return;
                            end;

                            p24("Unsupported info type");
                        end);
                        u1[v21] = v22;
                    end;

                    u1[v17] = v22;
                end;
            end;
        end;

        return false;
    end);

    local function checkOwnership(p27: userdata, p28: number, p29: boolean, p30: any) -- Line: 110
        -- upvalues: LocalPlayer (ref), u13 (copy), u1 (ref), Promise (ref), u26 (copy)
        if p27 ~= LocalPlayer then
            return;
        end;

        for _, v in u13 do
            if v.InfoType == p30 and (p28 == v.Id and p29) then
                u1[`{p30.Name}_{p28}`] = Promise.resolve(true);
                u26(true);
            end;
        end;
    end;

    useSignal(MarketplaceService.PromptPurchaseFinished, function(p31, p32, p33) -- Line: 126
        -- upvalues: checkOwnership (copy)
        checkOwnership(p31, p32, p33, Enum.InfoType.Asset);
    end, u13);
    useSignal(MarketplaceService.PromptGamePassPurchaseFinished, function(p34, p35, p36) -- Line: 130
        -- upvalues: checkOwnership (copy)
        checkOwnership(p34, p35, p36, Enum.InfoType.GamePass);
    end, u13);
    useSignal(MarketplaceService.PromptBundlePurchaseFinished, function(p37, p38, p39) -- Line: 134
        -- upvalues: checkOwnership (copy)
        checkOwnership(p37, p38, p39, Enum.InfoType.Bundle);
    end, u13);
    React.useEffect(function() -- Line: 138
        -- upvalues: u25 (copy), u14 (copy), u13 (copy), u1 (ref), Promise (ref), LocalPlayer (ref), RunContext (ref), MarketplaceService (ref), u26 (copy)
        if u25 then
            return;
        end;

        if u14.Demo then
            return;
        end;

        local u40 = {};

        for i, v in u13 do
            local u41 = v.Id or 0;
            local u42 = v.InfoType or Enum.InfoType.Asset;
            local v43 = `{u42.Name}_{v.Id}`;
            local v44;

            if u1[v43] then
                v44 = u1[v43];
            else
                v44 = Promise.new(function(p45, p46) -- Line: 31
                    -- upvalues: LocalPlayer (ref), u41 (copy), RunContext (ref), u42 (copy), MarketplaceService (ref)
                    if not LocalPlayer then
                        p46("No player");

                        return;
                    end;

                    if u41 < 1 then
                        p45(false);

                        return;
                    end;

                    if RunContext.IsStudio then
                        p45(true);

                        return;
                    end;

                    if u42 == Enum.InfoType.Asset then
                        p45(MarketplaceService:PlayerOwnsAsset(LocalPlayer, u41));

                        return;
                    end;

                    if u42 == Enum.InfoType.GamePass then
                        p45(MarketplaceService:UserOwnsGamePassAsync(LocalPlayer.UserId, u41));

                        return;
                    end;

                    if u42 == Enum.InfoType.Bundle then
                        p45(MarketplaceService:PlayerOwnsBundle(LocalPlayer.UserId, u41));

                        return;
                    end;

                    p46("Unsupported info type");
                end);
                u1[v43] = v44;
            end;

            u40[i] = v44;
        end;

        Promise.allSettled(u40):andThen(function() -- Line: 157
            -- upvalues: u40 (copy), u26 (ref)
            for _, v in u40 do
                local v47, v48 = v:await();

                if v47 and v48 then
                    u26(true);

                    return;
                end;
            end;

            u26(false);
        end);
    end, { u13 });

    return u25;
end;
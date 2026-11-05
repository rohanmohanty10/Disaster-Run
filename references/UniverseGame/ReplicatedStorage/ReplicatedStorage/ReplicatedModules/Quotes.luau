  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Promise = require(PathShortcuts.KnitPath.Promise);
local TableUtil = require(PathShortcuts.KnitPath.TableUtil);
local StatsHandler = require(PathShortcuts.ReplicatedModules.StatsHandler);
local AbilityService = require(game.ReplicatedStorage.ReplicatedRoot.Services.Gameplay.AbilityService);
local u1 = {};

for _, descendant in ipairs(script:GetDescendants()) do
    if descendant:IsA("ModuleScript") then
        Promise.try(require, descendant):andThen(function(p2) -- Line: 10
            -- upvalues: u1 (copy)
            for i, v in pairs(p2) do
                if u1[i] then
                    warn("CONFLICTING NAMES", i, v);
                else
                    u1[i] = v;
                end;
            end;
        end):catch(warn):await();
    end;
end;

function u1.GetQuoteInfo(p3, p4) -- Line: 22
    -- upvalues: AbilityService (copy), StatsHandler (copy)
    if AbilityService.IsLegacyAbility(p3) then
        return StatsHandler.GetStats(p3, p4).QuoteInfo;
    end;

    local v5 = AbilityService.GetAbilityData({
        Ability = p3,
        Skin = p4
    });

    if v5 and v5.QuoteInfo then
        return v5.QuoteInfo;
    end;
end;

function u1.GetQuotes(p6) -- Line: 37
    -- upvalues: u1 (copy)
    return u1.GetQuoteInfo(p6).Quotes;
end;

function u1.GetDisplayQuotes(p7, p8, p9) -- Line: 42
    -- upvalues: u1 (copy), Promise (copy), TableUtil (copy)
    local v10 = u1.GetQuoteInfo(p7, p8).Quotes or {};
    local v11 = {};

    for _, v in pairs(v10) do
        for _, v2 in ipairs(v) do
            local v12 = "";

            for _, v3 in ipairs(v2.FullQuote) do
                local Quote = v3.Quote;

                if type(v3.Transformer) == "function" then
                    Promise.try(v3.Transformer, TableUtil.Copy(v3, true), p9):andThen(function(p13) -- Line: 53
                        -- upvalues: Quote (ref)
                        Quote = p13;
                    end):await();
                end;

                v12 = v12 .. Quote;
            end;

            table.insert(v11, v12);
        end;
    end;

    return v11;
end;

return u1;
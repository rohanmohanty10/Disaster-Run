  

local v1 = {};
local LocalizationService = game:GetService("LocalizationService");
game:GetService("Players");
local Signal = require(script.Parent.Parent.Parent.Shared.Modules.Signal);
local Utilities = require(script.Parent.Utilities);
local u2 = Signal.new();

local function ConvertLocaleToISO(p3: string) -- Line: 44
    local string_split_ret = string.split(p3, "-");

    return string.lower(string_split_ret[1]);
end;

local u6 = {
    localeId = function(p4) -- Line: 51, Name: localeId
        -- upvalues: ConvertLocaleToISO (copy), LocalizationService (copy)
        return ConvertLocaleToISO(LocalizationService:GetTranslatorForPlayerAsync(p4).LocaleId);
    end,

    regionId = function(p5) -- Line: 54, Name: regionId
        -- upvalues: LocalizationService (copy)
        return LocalizationService:GetCountryRegionForPlayerAsync(p5);
    end
};
local Cache = require(script.Parent.ServerGate):GetCache();
local u7 = {};

local function GetCachedField(p8: userdata, p9: string) -- Line: 72
    -- upvalues: Cache (copy)
    local v10 = Cache[p8];

    if v10 then
        v10 = v10[p9];
    end;

    return v10;
end;

local function ResolveField(u11: userdata, u12: string) -- Line: 80
    -- upvalues: Cache (copy), u7 (copy), Utilities (copy), u6 (copy), u2 (copy)
    local v13 = Cache[u11];

    if v13 and v13[u12] then
        return;
    end;

    local u14 = u7[u11];

    if u14 and u14[u12] then
        return;
    end;

    if not u14 then
        u14 = {};
        u7[u11] = u14;
    end;

    u14[u12] = true;
    task.spawn(function() -- Line: 96
        -- upvalues: Utilities (ref), u6 (ref), u12 (copy), u11 (copy), u14 (ref), u7 (ref), Cache (ref), u2 (ref)
        local v15 = Utilities.promiseReturn(1, function() -- Line: 97
            -- upvalues: u6 (ref), u12 (ref), u11 (ref)
            return u6[u12](u11);
        end);
        u14[u12] = nil;

        if next(u14) == nil and u7[u11] == u14 then
            u7[u11] = nil;
        end;

        if v15 ~= nil then
            if not Cache[u11] then
                Cache[u11] = {};
            end;

            local v16 = Cache[u11];

            if v16 then
                v16[u12] = v15;
            end;
        end;

        u2:Fire(u11, u12, v15);
    end);
end;

local function WaitForField(u17: userdata, u18: string) -- Line: 128
    -- upvalues: Cache (copy), u2 (copy), ResolveField (copy)
    local v19 = Cache[u17];
    local v20 = v19 and v19[u18];

    if v20 then
        return v20;
    end;

    local coroutine_running_ret = coroutine.running();
    local u21 = false;
    local u22 = nil;
    local u23 = nil;
    u23 = u2:Connect(function(p24: userdata, p25: string, p26: string?) -- Line: 138
        -- upvalues: u17 (copy), u18 (copy), u23 (ref), u21 (ref), u22 (ref), coroutine_running_ret (copy)
        if p24 ~= u17 or p25 ~= u18 then
            return;
        end;

        u23:Disconnect();
        u21 = true;
        u22 = p26;

        if coroutine.status(coroutine_running_ret) == "suspended" then
            coroutine.resume(coroutine_running_ret);
        end;
    end);
    ResolveField(u17, u18);

    if not u21 then
        coroutine.yield();
    end;

    return u22 or "unknown";
end;

function v1.OnResolved(p27: table, p28: any, u29: function) -- Line: 167
    -- upvalues: Utilities (copy), u6 (copy), Cache (copy), u2 (copy), ResolveField (copy)
    local u30 = Utilities.resolvePlayerObject(p28);

    if not u30 then
        u29({
            localeId = "unknown",
            regionId = "unknown"
        });

        return nil;
    end;

    local u31 = {};
    local u32 = {};
    local u33 = 0;

    for i in u6 do
        local v34 = Cache[u30];

        if v34 then
            v34 = v34[i];
        end;

        if v34 then
            u31[i] = v34;
        else
            u32[i] = true;
            u33 = u33 + 1;
        end;
    end;

    if u33 == 0 then
        u29({
            localeId = u31.localeId,
            regionId = u31.regionId
        });

        return nil;
    end;

    local u35 = nil;
    u35 = u2:Connect(function(p36: userdata, p37: string, p38: string?) -- Line: 194
        -- upvalues: u30 (ref), u32 (copy), u33 (ref), u31 (copy), u35 (ref), u29 (copy)
        if p36 ~= u30 or not u32[p37] then
            return;
        end;

        u32[p37] = nil;
        u33 = u33 - 1;
        u31[p37] = p38 or "unknown";

        if u33 == 0 then
            u35:Disconnect();
            u29({
                localeId = u31.localeId,
                regionId = u31.regionId
            });
        end;
    end);
    local v39 = {};

    for i in u32 do
        table.insert(v39, i);
    end;

    for _, v in v39 do
        ResolveField(u30, v);
    end;

    return u35;
end;

function v1.Get(p40, p41) -- Line: 227
    local coroutine_running_ret = coroutine.running();
    local u42 = nil;
    p40:OnResolved(p41, function(p43: table) -- Line: 231
        -- upvalues: u42 (ref), coroutine_running_ret (copy)
        u42 = p43;

        if coroutine.status(coroutine_running_ret) == "suspended" then
            coroutine.resume(coroutine_running_ret);
        end;
    end);

    if not u42 then
        coroutine.yield();
    end;

    return u42;
end;

function v1.GetRegionId(p44, p45) -- Line: 249
    -- upvalues: Utilities (copy), WaitForField (copy)
    local v46 = Utilities.resolvePlayerObject(p45);

    return not v46 and "unknown" or WaitForField(v46, "regionId");
end;

function v1.GetLocaleId(p47, p48) -- Line: 261
    -- upvalues: Utilities (copy), WaitForField (copy)
    local v49 = Utilities.resolvePlayerObject(p48);

    return not v49 and "unknown" or WaitForField(v49, "localeId");
end;

return v1;
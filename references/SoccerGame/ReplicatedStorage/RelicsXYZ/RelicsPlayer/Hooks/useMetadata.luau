  

local Shared = script.Parent.Parent.Parent.Shared;
local React = require(Shared.React);
local Promise = require(Shared.Promise);
local AssetService = game:GetService("AssetService");
local script_Parent = script.Parent;
local useTagged = require(script_Parent.useTagged);
local useProductInfo = require(script_Parent.useProductInfo);
local u1 = {};
local u3 = Promise.promisify(function(p2: table) -- Line: 27
    -- upvalues: AssetService (copy)
    return AssetService:GetAudioMetadataAsync(p2)[1];
end);

local function useSong(p4: number?) -- Line: 31
    -- upvalues: useTagged (copy)
    local v5 = useTagged("RelicsSong");

    if not p4 then
        return nil;
    end;

    for _, v in ipairs(v5) do
        local Attribute = v:GetAttribute("Id");
        local Attribute2 = v:GetAttribute("Artist");

        if p4 and (type(Attribute) == "string" and (type(Attribute2) == "string" and tonumber(Attribute:match("%d+$")) == p4)) then
            return v;
        end;
    end;

    return nil;
end;

return function(p6) -- Line: 54, Name: useMetadata
    -- upvalues: useSong (copy), useProductInfo (copy), React (copy), u1 (copy), Promise (copy), u3 (copy)
    local u7;

    if type(p6) == "string" then
        u7 = tonumber(p6:match("%d+$"));
    else
        u7 = p6 and p6 // 1 or nil;
    end;

    local v8 = useSong(u7);
    local v9 = useProductInfo(u7);
    local u11, u12 = React.useState(function() -- Line: 62
        -- upvalues: u7 (copy), u1 (ref), Promise (ref), u3 (ref)
        local v10 = u7 and u1[u7];

        if v10 then
            if v10:getStatus() == "Resolved" then
                return v10:expect();
            end;
        elseif u7 then
            u1[u7] = Promise.retry(u3, 5, { u7 });
        end;

        return nil;
    end);

    if u7 and (u11 and u11.AssetId ~= tostring(u7)) then
        u12(nil);
    end;

    if u7 and not u1[u7] then
        u1[u7] = Promise.retry(u3, 5, { u7 });
    end;

    React.useEffect(function() -- Line: 86
        -- upvalues: u7 (copy), u11 (copy), u1 (ref), Promise (ref), u3 (ref), u12 (copy)
        local u13;

        if u7 and not u11 then
            local v14 = u1[u7];

            if not v14 then
                v14 = Promise.retry(u3, 5, { u7 });
                u1[u7] = v14;
            end;

            u13 = v14:andThen(u12);
        else
            u13 = nil;
        end;

        return function() -- Line: 100
            -- upvalues: u13 (ref)
            if u13 then
                u13:cancel();
            end;
        end;
    end, { u7, u11 });
    local v15;

    if u11 then
        v15 = u11.Title;
    else
        v15 = u11;
    end;

    if u11 then
        u11 = u11.Artist;
    end;

    local v16;

    if v9 then
        v16 = v9.Name;
    else
        v16 = v9;
    end;

    if v9 then
        v9 = v9.Creator.Name;
    end;

    local v17;

    if v8 then
        v17 = v8.Name;
    else
        v17 = v8;
    end;

    if v8 then
        v8 = v8:GetAttribute("Artist");
    end;

    return v17 and type(v8) == "string" and {
        Title = v17,
        Artist = v8
    } or (v15 and u11 and (v15 == "00000000" and u11 == "Roblox" and {
        Title = "[ Content Encrypted ]",
        Artist = "Unknown Artist"
    } or (v16 == v15 and v9 == u11 and {
        Title = v15,
        Artist = `Uploaded by: @{u11}`
    } or {
        Title = v15,
        Artist = u11
    })) or (not (v16 and v9) and {
        Title = "Unknown Song",
        Artist = "Unknown Artist"
    } or (v16 == "00000000" and v9 == "Roblox" and {
        Title = "[ Content Encrypted ]",
        Artist = "Unknown Artist"
    } or {
        Title = v16,
        Artist = `Uploaded by: @{v9}`
    })));
end;
  

 

local RunService = game:GetService("RunService");
local CollectionService = game:GetService("CollectionService");
local u7 = {
    serialize = function(p1) -- Line: 6, Name: serialize
        local v2 = buffer.create(#p1 * 8);

        for i, v in p1 do
            buffer.writef64(v2, (i - 1) * 8, v);
        end;

        return v2;
    end,

    deserialize = function(p3) -- Line: 16, Name: deserialize
        if typeof(p3) == "string" then
            p3 = buffer.fromstring(p3) or p3;
        end;

        local v4 = {};

        for i = 0, buffer.len(p3) / 8 - 1 do
            local v5 = buffer.readf64(p3, i * 8);
            table.insert(v4, v5);
        end;

        return v4;
    end,

    isLocalFlipbook = function(p6) -- Line: 29, Name: isLocalFlipbook
        -- upvalues: RunService (copy), CollectionService (copy)
        if not RunService:IsStudio() then
            return false;
        end;

        for _, v in CollectionService:GetTags(p6) do
            if v:match("^_local_flipbook_") then
                return true;
            end;
        end;

        return false;
    end
};

function u7.getTexturePrefix(p8) -- Line: 43
    -- upvalues: u7 (copy)
    return u7.isLocalFlipbook(p8) and "rbxtemp://" or "rbxassetid://";
end;

function u7.getFlipbookData(p9) -- Line: 47
    -- upvalues: u7 (copy)
    if not p9:GetAttribute("FlipbookEnabled") then
        return nil;
    end;

    local v10 = p9:GetAttribute("FlipbookTextures");

    if not v10 then
        return nil;
    end;

    local v11 = u7.deserialize(v10);

    if #v11 == 0 then
        return nil;
    end;

    return v11;
end;

function u7.getChangeDuration(p12) -- Line: 81
    local duration = p12.duration;

    if p12.ref:GetAttribute("SyncDuration") then
        duration = p12.effectDuration;
    end;

    return duration;
end;

function u7.createUpdateCallback(u13) -- Line: 91
    -- upvalues: u7 (copy)
    local u14 = u7.getTexturePrefix(u13.ref);

    return function(p15, p16) -- Line: 94
        -- upvalues: u13 (copy), u14 (copy)
        local v17 = math.round(#u13.frames * p15);
        local v18 = math.max(v17, 1);
        u13.setTexture((`{u14}{u13.frames[v18]}`));

        return p16 * u13.getSpeed();
    end;
end;

return u7;
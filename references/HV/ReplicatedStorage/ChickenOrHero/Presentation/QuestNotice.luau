 

 

local u5 = {
    key = function(p1) -- Line: 8, Name: key
        if type(p1) ~= "table" then
            return nil;
        end;

        if p1.mode ~= "Daily" or type(p1.daily) ~= "table" then
            if type(p1.event) == "table" then
                return ("e%s:%s"):format(tostring(p1.event.id), (tostring(p1.event.activeWeapon))):sub(1, 200);
            end;

            return nil;
        end;

        local v2 = {};

        for _, v in p1.daily.quests or {} do
            local v3 = tostring(v.id);
            table.insert(v2, v3);
        end;

        return ("d%s:%s:%s"):format(tostring(p1.daily.day), tostring(p1.daily.slot), table.concat(v2, ",")):sub(1, 200);
    end,

    claimable = function(p4) -- Line: 25, Name: claimable
        if type(p4) ~= "table" or p4.loaded ~= true then
            return false;
        end;

        if p4.mode == "Daily" and type(p4.daily) == "table" then
            for _, v in p4.daily.quests or {} do
                if v.complete and not v.claimed then
                    return true;
                end;
            end;
        elseif type(p4.event) == "table" and p4.event.claimsEnabled then
            for _, v in p4.event.weapons or {} do
                if v.claimable then
                    return true;
                end;
            end;
        end;

        return false;
    end
};

function u5.show(p6, p7) -- Line: 45
    -- upvalues: u5 (copy)
    if p6:GetAttribute("SettingsLoaded") ~= true then
        return false;
    end;

    if p6:GetAttribute("QuestsSeen") ~= true or u5.claimable(p7) then
        return true;
    end;

    local v8;

    if type(p7) == "table" and p7.loaded == true then
        v8 = u5.key(p7);
    else
        v8 = false;
    end;

    local v9;

    if v8 == nil or v8 == false then
        v9 = false;
    else
        v9 = v8 ~= p6:GetAttribute("QuestsSeenKey");
    end;

    return v9;
end;

function u5.seen(p10, p11) -- Line: 57
    -- upvalues: u5 (copy)
    if p10:GetAttribute("QuestsSeen") ~= true then
        p10:SetAttribute("QuestsSeen", true);
    end;

    local v12;

    if type(p11) == "table" and p11.loaded == true then
        v12 = u5.key(p11);
    else
        v12 = false;
    end;

    if v12 and p10:GetAttribute("QuestsSeenKey") ~= v12 then
        p10:SetAttribute("QuestsSeenKey", v12);
    end;
end;

return u5;
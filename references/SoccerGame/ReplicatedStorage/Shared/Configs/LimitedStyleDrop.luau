  

local u1 = {
    Rarity = "Limited",
    LuckyOdds = 0.5,
    EndAttribute = "updateTimer",
    Styles = table.freeze({ "Reaper Sae", "Demon Shidou", "Blood Moon Rin", "Phantom Isagi", "Skeleton Nagi" })
};

function u1.GetStyles() -- Line: 10
    -- upvalues: u1 (copy)
    return table.clone(u1.Styles);
end;

function u1.GetEndTime() -- Line: 14
    -- upvalues: u1 (copy)
    local Attribute = workspace:GetAttribute(u1.EndAttribute);

    return (workspace:GetAttribute("liveDataAvailable") ~= true or typeof(Attribute) ~= "number") and 0 or ((Attribute ~= Attribute or (Attribute <= 0 or Attribute >= (1 / 0))) and 0 or Attribute);
end;

function u1.IsActive(p2: number?) -- Line: 25
    -- upvalues: u1 (copy)
    local EndTime = u1.GetEndTime();
    local v3;

    if EndTime > 0 then
        v3 = (p2 or os.time()) < EndTime;
    else
        v3 = false;
    end;

    return v3;
end;

function u1.IsRollable(p4: string, p5: number?) -- Line: 30
    -- upvalues: u1 (copy)
    local v6;

    if table.find(u1.Styles, p4) == nil then
        v6 = false;
    else
        v6 = u1.IsActive(p5);
    end;

    return v6;
end;

return u1;
  

local u13 = {
    Duration = 30,
    CutsceneLength = 5.333333333333333,
    RoleOrder = { "Lorenzo", "Aiku", "Niko", "Barou" },

    role = function(p1, p2) -- Line: 6, Name: role
        return p1 == "Don Lorenzo" and "Lorenzo" or (p1 == "Aiku" and "Aiku" or (p1 == "Niko" and "Niko" or ((p1 == "NEL King" or p1 == "King" and p2) and "Barou" or nil)));
    end,

    onEnemyHalf = function(p3, p4, p5, p6, p7) -- Line: 14, Name: onEnemyHalf
        local v8 = p6:PointToObjectSpace(p3);
        local v9 = p7 * 0.5;

        if math.abs(v8.X) > v9.X or (math.abs(v8.Z) > v9.Z or (v8.Y < v9.Y - 10 or v8.Y > v9.Y + 50)) then
            return false;
        end;

        local v10 = (p4 + p5) * 0.5;
        local v11 = p4 - p5;
        local Vector3_new_ret = Vector3.new(v11.X, 0, v11.Z);
        local v12;

        if Vector3_new_ret.Magnitude > 0 then
            v12 = (p3 - v10):Dot(Vector3_new_ret) > 0;
        else
            v12 = false;
        end;

        return v12;
    end
};

function u13.selectParty(p14, p15) -- Line: 26
    -- upvalues: u13 (copy)
    local table_clone_ret = table.clone(p15);
    table.sort(table_clone_ret, function(p16, p17) -- Line: 29
        return p16.userId < p17.userId;
    end);
    local v18 = {
        Lorenzo = p14
    };

    for _, v in table_clone_ret do
        if v.role and (v.role ~= "Lorenzo" and not v18[v.role]) then
            v18[v.role] = v;
        end;
    end;

    local v19 = {};

    for _, v in u13.RoleOrder do
        if v18[v] then
            table.insert(v19, v18[v]);
        end;
    end;

    return #v19 >= 3 and v19 and v19 or nil;
end;

function u13.bonuses(p20, p21) -- Line: 42
    return {
        Speed = (p20 == "Aiku" or p20 == "Niko") and 0.05 or 0,
        Cooldown = p20 == "Lorenzo" and 0.05 or 0,
        Shot = p20 == "Barou" and (p21 == 4 and 0.1 or 0.05) or 0
    };
end;

function u13.multiplier(p22, p23, p24) -- Line: 50
    if not p22 then
        return 1;
    end;

    local Attribute = p22:GetAttribute("AdvanceUbersExpires");

    if type(Attribute) ~= "number" or Attribute <= (p24 or workspace:GetServerTimeNow()) then
        return 1;
    end;

    local Attribute2 = p22:GetAttribute("AdvanceUbers" .. p23);

    if type(Attribute2) ~= "number" then
        return 1;
    end;

    local math_clamp_ret = math.clamp(Attribute2, 0, p23 == "Shot" and 0.1 or 0.05);

    return p23 == "Cooldown" and 1 - math_clamp_ret or 1 + math_clamp_ret;
end;

return u13;
 

 

local MovementConfig = require(script.Parent.MovementConfig);
local CrossingBalance = require(script.Parent.CrossingBalance);
local KnifePerks = require(script.Parent.Parent.Weapons.KnifePerks);
local table_clone_ret = table.clone(MovementConfig);
table_clone_ret.MaxSpeed = MovementConfig.MaxSpeed * MovementConfig.RunnerSpeedMultiplier;
table_clone_ret.Acceleration = MovementConfig.Acceleration * MovementConfig.RunnerAccelerationMultiplier;
table_clone_ret.TurnRetention90 = MovementConfig.RunnerTurnRetention90;
table.freeze(table_clone_ret);
local table_clone_ret2 = table.clone(MovementConfig);
table_clone_ret2.MaxSpeed = MovementConfig.MaxSpeed * MovementConfig.CatcherSpeedMultiplier;
table_clone_ret2.TurnRate = MovementConfig.CatcherTurnRate;
table_clone_ret2.SlowTurnRate = MovementConfig.CatcherSlowTurnRate;
local table_clone_ret3 = table.clone(MovementConfig.Dash);
table_clone_ret3.Enabled = false;
table_clone_ret2.Dash = table.freeze(table_clone_ret3);
table.freeze(table_clone_ret2);
local v1 = {};
local u2 = {
    Runner = {},
    Catcher = {}
};

local function baseProfile(p3, p4) -- Line: 21
    -- upvalues: table_clone_ret2 (copy), table_clone_ret (copy), MovementConfig (copy), CrossingBalance (copy), u2 (copy)
    local v5 = p3 == "Catcher" and table_clone_ret2 or (p3 == "Runner" and table_clone_ret or MovementConfig);

    if v5 == MovementConfig or not (p4 and MovementConfig.CrossingBalance.Enabled) then
        return v5;
    end;

    local Attribute = p4:GetAttribute(p3 == "Catcher" and "CrossingCatcherSpeedScale" or "CrossingRunnerSpeedScale");

    if type(Attribute) ~= "number" or Attribute ~= Attribute then
        return v5;
    end;

    local Attribute2 = p4:GetAttribute("CrossingBalanceTuning");
    local v6 = CrossingBalance.tuning(Attribute2);

    if v6 == MovementConfig.CrossingBalance then
        Attribute2 = nil;
    end;

    local v7 = math.clamp(Attribute, p3 == "Catcher" and (1 - v6.CatcherMaxReduction or 1) or 1, p3 == "Runner" and (1 + v6.RunnerMaxBonus or 1) or 1) * 10000 + 0.5;
    local math_floor_ret = math.floor(v7);
    local v8 = math_floor_ret / 10000;
    local v9 = 0;

    if p3 == "Runner" then
        local Attribute3 = p4:GetAttribute("CrossingCatcherCount");
        local Attribute4 = p4:GetAttribute("CrossingRunnerCount");

        if type(Attribute3) == "number" and type(Attribute4) == "number" then
            v9 = CrossingBalance.calculate(Attribute3, Attribute4, Attribute2).pressure;
        elseif v6.RunnerMaxBonus > 0 then
            v9 = (v8 - 1) / v6.RunnerMaxBonus;
        end;

        local v10 = math.clamp(v9, 0, 1) * 10000 + 0.5;
        v9 = math.floor(v10) / 10000;
    end;

    if math_floor_ret == 10000 and v9 == 0 then
        return v5;
    end;

    local v11 = tostring(math_floor_ret) .. ":" .. tostring(v9) .. (not Attribute2 and "" or ":" .. Attribute2);
    local v12 = u2[p3][v11];

    if v12 then
        return v12;
    end;

    local table_clone_ret4 = table.clone(v5);

    for _, v in { "MaxSpeed", "Acceleration", "Deceleration", "StopThreshold", "StallSpeed", "StallSpeedCap" } do
        table_clone_ret4[v] = v5[v] * v8;
    end;

    if p3 == "Runner" then
        table_clone_ret4.Acceleration = table_clone_ret4.Acceleration * (1 + v6.RunnerMaxAccelerationBonus * v9);
        table_clone_ret4.Deceleration = table_clone_ret4.Deceleration * (1 + v6.RunnerMaxBrakingBonus * v9);
        table_clone_ret4.TurnRetention90 = v5.TurnRetention90 + (v6.RunnerMaxTurnRetention - v5.TurnRetention90) * v9;
    end;

    local table_clone_ret5 = table.clone(v5.Dash);
    table_clone_ret5.Distance = v5.Dash.Distance * v8;
    table_clone_ret4.Dash = table.freeze(table_clone_ret5);
    local table_freeze_ret = table.freeze(table_clone_ret4);
    u2[p3][v11] = table_freeze_ret;

    return table_freeze_ret;
end;

local u13 = setmetatable({}, {
    __mode = "k"
});

local function variant(p14, p15) -- Line: 80
    -- upvalues: baseProfile (copy), KnifePerks (copy), u13 (copy)
    local v16 = baseProfile(p14, p15);
    local v17;

    if p15 then
        v17 = p15:GetAttribute("GearSlow") == true;
    else
        v17 = p15;
    end;

    local v18;

    if p15 then
        v18 = p15:GetAttribute("GearBoost") == true;
    else
        v18 = p15;
    end;

    local v19;

    if p15 then
        v19 = p15:GetAttribute("FartBoost") == true;
    else
        v19 = p15;
    end;

    local v20 = (p14 == "Runner" or p14 == "Catcher") and KnifePerks.get(p15) or KnifePerks.forSkin(nil);

    if not (v17 or (v18 or (v19 or v20.Key ~= "None"))) then
        return v16;
    end;

    local v21 = (v17 and "s" or "") .. (v18 and "b" or "") .. (v19 and "f" or "") .. v20.Key;
    local v22 = u13[v16];

    if not v22 then
        v22 = {};
        u13[v16] = v22;
    end;

    if v22[v21] then
        return v22[v21];
    end;

    local table_clone_ret4 = table.clone(v16);
    table_clone_ret4.MaxSpeed = table_clone_ret4.MaxSpeed + v20.SpeedBonus;

    if v20.DashCooldownReduction > 0 then
        local table_clone_ret5 = table.clone(v16.Dash);
        table_clone_ret5.Cooldown = math.max(0, table_clone_ret5.Cooldown - v20.DashCooldownReduction);
        table_clone_ret4.Dash = table.freeze(table_clone_ret5);
    end;

    if v17 then
        table_clone_ret4.MaxSpeed = table_clone_ret4.MaxSpeed * 0.55;
        table_clone_ret4.Acceleration = table_clone_ret4.Acceleration * 0.7;
    end;

    if v18 then
        table_clone_ret4.Acceleration = table_clone_ret4.Acceleration * 1.75;
        table_clone_ret4.TurnRetention90 = math.min(0.95, table_clone_ret4.TurnRetention90 + 0.1875);
    end;

    if v19 then
        local FartCloud = require(script.Parent.Parent.Gear.GearCatalog).Items.FartCloud;
        table_clone_ret4.MaxSpeed = table_clone_ret4.MaxSpeed + (FartCloud and FartCloud.SpeedBonus or 0);
    end;

    v22[v21] = table.freeze(table_clone_ret4);

    return v22[v21];
end;

local u23 = setmetatable({}, {
    __mode = "k"
});
local u24 = setmetatable({}, {
    __mode = "k"
});

local function bladeDash(p25, p26) -- Line: 128
    -- upvalues: u24 (copy), table_clone_ret (copy)
    if p26 then
        p26 = p26:GetAttribute("BladeHearts");
    end;

    if type(p26) ~= "number" or (p26 <= 0 or p25.Dash.Enabled) then
        return p25;
    end;

    local v27 = u24[p25];

    if not v27 then
        local table_clone_ret4 = table.clone(p25);
        table_clone_ret4.Dash = table_clone_ret.Dash;
        v27 = table.freeze(table_clone_ret4);
        u24[p25] = v27;
    end;

    return v27;
end;

function v1.get(p28, p29) -- Line: 142
    -- upvalues: bladeDash (copy), variant (copy), u23 (copy)
    local v30 = bladeDash(variant(p28, p29), p29);

    if p29 then
        p29 = p29:GetAttribute("TrollSpeed");
    end;

    if type(p29) ~= "number" or (p29 ~= p29 or p29 == 1) then
        return v30;
    end;

    local v31 = math.clamp(p29, 0.5, 3) * 100 + 0.5;
    local math_floor_ret = math.floor(v31);
    local v32 = u23[v30] and u23[v30][math_floor_ret];

    if v32 then
        return v32;
    end;

    local table_clone_ret4 = table.clone(v30);
    table_clone_ret4.MaxSpeed = table_clone_ret4.MaxSpeed * (math_floor_ret / 100);
    table_clone_ret4.Acceleration = table_clone_ret4.Acceleration * (math_floor_ret / 100);
    table_clone_ret4.Deceleration = table_clone_ret4.Deceleration * (math_floor_ret / 100);
    u23[v30] = u23[v30] or {};
    u23[v30][math_floor_ret] = table.freeze(table_clone_ret4);

    return u23[v30][math_floor_ret];
end;

return table.freeze(v1);
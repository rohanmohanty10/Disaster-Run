 

 

local u1 = {};
game:GetService("CollectionService");
local l__ReplicatedStorage__1 = game:GetService("ReplicatedStorage");
game:GetService("RunService");
game:GetService("PhysicsService");
local l__Modules__2 = l__ReplicatedStorage__1:WaitForChild("Modules");
local v2 = coroutine;
local _ = v2.resume;
local _ = v2.create;
local _ = task.spawn;
local l__delay__3 = task.delay;
local _ = task.wait;
local l__FunctionLibrary__4 = require(l__Modules__2:WaitForChild("FunctionLibrary"));
l__ReplicatedStorage__1:WaitForChild("Anims");
u1["Blighted Quiver"] = {};
u1["Blighted Quiver"].Variables = {
    Heal_Percent = 15
};
u1["Blighted Quiver"].Desc = `Your projectiles now heal you for {u1["Blighted Quiver"].Variables.Heal_Percent}% of the damage you deal to opponents.`;
u1["Blighted Quiver"].Name = "Blighted Quiver";
u1["Blighted Quiver"].Icon = "http://www.roblox.com/asset/?id=13893453406";
u1["Blighted Quiver"].Requirement = function(...) --[[ Line: 33 ]]
    local _ = (...).self;
    return true;
end;
u1["Blighted Quiver"].Activation = function(...) --[[ Line: 45 ]]
    -- upvalues: u1 (copy)
    local v3 = ...;
    local l__self__5 = v3.self;
    local _ = l__self__5.Player;
    local l__Char__6 = l__self__5.Char;
    local _ = l__self__5.Root;
    local _ = l__self__5.Victim;
    if v3.Func ~= "Setup" then
        return true;
    end;
    l__Char__6:SetAttribute("Blighted_Quiver", u1["Blighted Quiver"].Variables.Heal_Percent / 100);
    return true;
end;
u1["Jeweled Soul"] = {};
u1["Jeweled Soul"].Variables = {
    Crit_Chance = 15
};
u1["Jeweled Soul"].Desc = `Stand abilities can now critical strike when damaging opponents. Increases critical chance by {u1["Jeweled Soul"].Variables.Crit_Chance}%`;
u1["Jeweled Soul"].Name = "Jeweled Soul";
u1["Jeweled Soul"].Icon = "http://www.roblox.com/asset/?id=13518130183";
u1["Jeweled Soul"].Requirement = function(...) --[[ Line: 85 ]]
    local _ = (...).self;
    return true;
end;
u1["Jeweled Soul"].Activation = function(...) --[[ Line: 97 ]]
    -- upvalues: u1 (copy)
    local v4 = ...;
    local l__self__7 = v4.self;
    local _ = l__self__7.Player;
    local l__Char__8 = l__self__7.Char;
    local _ = l__self__7.Root;
    local _ = l__self__7.Victim;
    if v4.Func ~= "Setup" then
        return true;
    end;
    l__Char__8:SetAttribute("Jeweled_Soul", true);
    l__self__7:AddCritChance({
        Name = "Jeweled Soul",
        Value = u1["Jeweled Soul"].Variables.Crit_Chance
    });
    return true;
end;
u1["Piercing Arrow"] = {};
u1["Piercing Arrow"].Variables = {
    Damage_Percent = 120
};
u1["Piercing Arrow"].Desc = "Increase all projectile damage by " .. math.abs(100 - u1["Piercing Arrow"].Variables.Damage_Percent) .. "%";
u1["Piercing Arrow"].Name = "Piercing Arrow";
u1["Piercing Arrow"].Icon = "http://www.roblox.com/asset/?id=129698158";
u1["Piercing Arrow"].Requirement = function(...) --[[ Line: 141 ]]
    local _ = (...).self;
    return true;
end;
u1["Piercing Arrow"].Activation = function(...) --[[ Line: 153 ]]
    -- upvalues: u1 (copy)
    local v5 = ...;
    local l__self__9 = v5.self;
    local _ = l__self__9.Player;
    local l__Char__10 = l__self__9.Char;
    local _ = l__self__9.Root;
    local _ = l__self__9.Victim;
    if v5.Func ~= "Setup" then
        return true;
    end;
    l__Char__10:SetAttribute("Piercing_Arrow", u1["Piercing Arrow"].Variables.Damage_Percent / 100);
    return true;
end;
u1["Spirit Visage"] = {};
u1["Spirit Visage"].Variables = {
    Heal_Percent = 120
};
u1["Spirit Visage"].Desc = "Increase all healing received and given by " .. math.abs(100 - u1["Spirit Visage"].Variables.Heal_Percent) .. "%";
u1["Spirit Visage"].Name = "Spirit Visage";
u1["Spirit Visage"].Icon = "http://www.roblox.com/asset/?id=14436167187";
u1["Spirit Visage"].Requirement = function(...) --[[ Line: 192 ]]
    local _ = (...).self;
    return true;
end;
u1["Spirit Visage"].Activation = function(...) --[[ Line: 204 ]]
    -- upvalues: u1 (copy)
    local v6 = ...;
    local l__self__11 = v6.self;
    local _ = l__self__11.Player;
    local l__Char__12 = l__self__11.Char;
    local _ = l__self__11.Root;
    local _ = l__self__11.Victim;
    if v6.Func ~= "Setup" then
        return true;
    end;
    l__Char__12:SetAttribute("Spirit_Visage", u1["Spirit Visage"].Variables.Heal_Percent / 100);
    return true;
end;
u1["Avatar of Hermes"] = {};
u1["Avatar of Hermes"].Variables = {
    Cooldown_Percent = 70
};
u1["Avatar of Hermes"].Desc = `Reduce the cooldown of dash and blink stand abilities by {100 - u1["Avatar of Hermes"].Variables.Cooldown_Percent}%. Character dashes are only reduced by 15%.`;
u1["Avatar of Hermes"].Name = "Avatar of Hermes";
u1["Avatar of Hermes"].Icon = "http://www.roblox.com/asset/?id=5951934169";
u1["Avatar of Hermes"].Requirement = function(...) --[[ Line: 244 ]]
    local _ = (...).self;
    return true;
end;
u1["Avatar of Hermes"].Activation = function(...) --[[ Line: 256 ]]
    -- upvalues: u1 (copy)
    local v7 = ...;
    local l__self__13 = v7.self;
    local _ = l__self__13.Player;
    local l__Char__14 = l__self__13.Char;
    local _ = l__self__13.Root;
    local _ = l__self__13.Victim;
    if v7.Func ~= "Setup" then
        return true;
    end;
    l__Char__14:SetAttribute("Avatar_of_Hermes", u1["Avatar of Hermes"].Variables.Cooldown_Percent / 100);
    return true;
end;
u1.Goliath = {};
u1.Goliath.Variables = {
    MaxHP_Percent = 120
};
u1.Goliath.Desc = "Increase maximum health points by " .. math.abs(100 - u1.Goliath.Variables.MaxHP_Percent) .. "%";
u1.Goliath.Name = "Goliath";
u1.Goliath.Icon = "http://www.roblox.com/asset/?id=401613236";
function u1.Goliath.Requirement(...) --[[ Line: 295 ]]
    local _ = (...).self;
    return true;
end;
function u1.Goliath.Activation(...) --[[ Line: 307 ]]
    -- upvalues: u1 (copy), l__FunctionLibrary__4 (copy)
    local v8 = ...;
    local l__self__15 = v8.self;
    local _ = l__self__15.Player;
    local l__Char__16 = l__self__15.Char;
    local _ = l__self__15.Root;
    local _ = l__self__15.Victim;
    if v8.Func ~= "Setup" then
        return true;
    end;
    local l__MaxValue__17 = l__self__15.Health.MaxValue;
    l__Char__16:SetAttribute("Goliath", u1.Goliath.Variables.MaxHP_Percent / 100);
    local l__Amount__18 = l__FunctionLibrary__4.ReturnStat({
        Stat = "Max_Health",
        Player = l__self__15.Player
    }).Amount;
    l__self__15.Health.MaxValue = l__Amount__18;
    if l__Amount__18 - l__MaxValue__17 > 0 then
        local l__Health__19 = l__self__15.Health;
        l__Health__19.Value = l__Health__19.Value + (l__Amount__18 - l__MaxValue__17);
    end;
    return true;
end;
u1["North God"] = {};
u1["North God"].Variables = {
    PhysicalDefense = 2,
    MaxStacks = 5,
    Duration = 30
};
u1["North God"].Desc = "After using a dash or blink you gain " .. u1["North God"].Variables.PhysicalDefense .. " Physical-Defense for " .. u1["North God"].Variables.Duration .. "s. This stacks up to " .. u1["North God"].Variables.MaxStacks .. " times";
u1["North God"].Name = "North God";
u1["North God"].Icon = "http://www.roblox.com/asset/?id=13288142767";
u1["North God"].Requirement = function(...) --[[ Line: 363 ]]
    local _ = (...).self;
    return true;
end;
u1["North God"].Activation = function(...) --[[ Line: 375 ]]
    -- upvalues: u1 (copy), l__delay__3 (copy)
    local v9 = ...;
    local l__self__20 = v9.self;
    local _ = l__self__20.Player;
    local l__Char__21 = l__self__20.Char;
    local _ = l__self__20.Root;
    local _ = l__self__20.Victim;
    if v9.Func ~= "Setup" then
        return true;
    end;
    l__Char__21:SetAttribute("North_God_Amount", u1["North God"].Variables.PhysicalDefense / 100);
    l__Char__21:SetAttribute("North_God_Duration", u1["North God"].Variables.Duration);
    l__Char__21:SetAttribute("North_God_MaxStacks", u1["North God"].Variables.MaxStacks);
    function l__self__20.North_God_Activation() --[[ Line: 404 ]]
        -- upvalues: l__self__20 (copy), l__Char__21 (copy), u1 (ref), l__delay__3 (ref)
        local u10 = tick();
        l__self__20.North_God_Tick = u10;
        local v11 = l__Char__21;
        local v12 = l__Char__21:GetAttribute("North_God") and l__Char__21:GetAttribute("North_God") + 1 or 1;
        v11:SetAttribute("North_God", (math.clamp(v12, 1, u1["North God"].Variables.MaxStacks)));
        l__self__20:UpdatePhysicalDefense();
        l__delay__3(u1["North God"].Variables.Duration, function() --[[ Line: 420 ]]
            -- upvalues: l__self__20 (ref), u10 (copy), l__Char__21 (ref)
            if l__self__20.North_God_Tick == u10 then
                l__Char__21:SetAttribute("North_God", nil);
                l__self__20:UpdatePhysicalDefense();
            end;
        end);
    end;
    return true;
end;
u1["Left Right Goodnight"] = {};
u1["Left Right Goodnight"].Variables = {
    BasicAttack_Percent = 120
};
u1["Left Right Goodnight"].Desc = "Increase Basic-Attack (M1/M2) damage by " .. u1["Left Right Goodnight"].Variables.BasicAttack_Percent - 100 .. "%";
u1["Left Right Goodnight"].Name = "Left Right Goodnight";
u1["Left Right Goodnight"].Icon = "http://www.roblox.com/asset/?id=9833736613";
u1["Left Right Goodnight"].Requirement = function(...) --[[ Line: 452 ]]
    local _ = (...).self;
    return true;
end;
u1["Left Right Goodnight"].Activation = function(...) --[[ Line: 464 ]]
    -- upvalues: u1 (copy)
    local v13 = ...;
    local l__self__22 = v13.self;
    local _ = l__self__22.Player;
    local l__Char__23 = l__self__22.Char;
    local _ = l__self__22.Root;
    local _ = l__self__22.Victim;
    if v13.Func ~= "Setup" then
        return true;
    end;
    l__Char__23:SetAttribute("Left_Right_Goodnight", u1["Left Right Goodnight"].Variables.BasicAttack_Percent / 100);
    return true;
end;
u1.Deft = {};
u1.Deft.Variables = {
    BasicAttack_Percent = 120
};
u1.Deft.Desc = "Increase Basic-Attack (M1/M2) speeds by " .. u1.Deft.Variables.BasicAttack_Percent - 100 .. "%";
u1.Deft.Name = "Deft";
u1.Deft.Icon = "http://www.roblox.com/asset/?id=16606914930";
function u1.Deft.Requirement(...) --[[ Line: 503 ]]
    local _ = (...).self;
    return true;
end;
function u1.Deft.Activation(...) --[[ Line: 515 ]]
    -- upvalues: u1 (copy)
    local v14 = ...;
    local l__self__24 = v14.self;
    local _ = l__self__24.Player;
    local l__Char__25 = l__self__24.Char;
    local _ = l__self__24.Root;
    local _ = l__self__24.Victim;
    if v14.Func ~= "Setup" then
        return true;
    end;
    l__Char__25:SetAttribute("Deft", u1.Deft.Variables.BasicAttack_Percent / 100);
    return true;
end;
u1["Last Stand"] = {};
u1["Last Stand"].Variables = {
    Damage_Percent = 115,
    MaxHp_Percent = 50
};
u1["Last Stand"].Desc = "Deal " .. u1["Last Stand"].Variables.Damage_Percent - 100 .. "% increased damage when below " .. u1["Last Stand"].Variables.MaxHp_Percent .. "% of your maximum HP";
u1["Last Stand"].Name = "Last Stand";
u1["Last Stand"].Icon = "http://www.roblox.com/asset/?id=11379131842";
u1["Last Stand"].Requirement = function(...) --[[ Line: 555 ]]
    local _ = (...).self;
    return true;
end;
u1["Last Stand"].Activation = function(...) --[[ Line: 567 ]]
    -- upvalues: u1 (copy)
    local v15 = ...;
    local l__self__26 = v15.self;
    local _ = l__self__26.Player;
    local l__Char__27 = l__self__26.Char;
    local _ = l__self__26.Root;
    local _ = l__self__26.Victim;
    if v15.Func ~= "Setup" then
        return true;
    end;
    l__Char__27:SetAttribute("Last_Stand", u1["Last Stand"].Variables.Damage_Percent / 100);
    l__Char__27:SetAttribute("Last_Stand_MaxHp", u1["Last Stand"].Variables.MaxHp_Percent / 100);
    return true;
end;
u1.Executioner = {};
u1.Executioner.Variables = {
    Damage_Percent = 115,
    MaxHp_Percent = 50
};
u1.Executioner.Desc = "Deal " .. u1.Executioner.Variables.Damage_Percent - 100 .. "% increased damage to enemies below " .. u1.Executioner.Variables.MaxHp_Percent .. "% of their maximum HP";
u1.Executioner.Name = "Executioner";
u1.Executioner.Icon = "http://www.roblox.com/asset/?id=129697807";
function u1.Executioner.Requirement(...) --[[ Line: 612 ]]
    local _ = (...).self;
    return true;
end;
function u1.Executioner.Activation(...) --[[ Line: 624 ]]
    -- upvalues: u1 (copy)
    local v16 = ...;
    local l__self__28 = v16.self;
    local _ = l__self__28.Player;
    local l__Char__29 = l__self__28.Char;
    local _ = l__self__28.Root;
    local _ = l__self__28.Victim;
    if v16.Func ~= "Setup" then
        return true;
    end;
    l__Char__29:SetAttribute("Executioner", u1.Executioner.Variables.Damage_Percent / 100);
    l__Char__29:SetAttribute("Executioner_MaxHp", u1.Executioner.Variables.MaxHp_Percent / 100);
    return true;
end;
u1["Blessing of Sparks"] = {};
u1["Blessing of Sparks"].Variables = {
    Duration = 2.5,
    Damage = 40,
    Cooldown = 15
};
u1["Blessing of Sparks"].Desc = "Upon successfully parrying, your next damaging ability or attack within " .. u1["Blessing of Sparks"].Variables.Duration .. "s will create Sparks, dealing " .. u1["Blessing of Sparks"].Variables.Damage .. " true damage [" .. u1["Blessing of Sparks"].Variables.Cooldown .. "s CD]";
u1["Blessing of Sparks"].Name = "Blessing of Sparks";
u1["Blessing of Sparks"].Icon = "http://www.roblox.com/asset/?id=13321880274";
u1["Blessing of Sparks"].Requirement = function(...) --[[ Line: 670 ]]
    local _ = (...).self;
    return true;
end;
u1["Blessing of Sparks"].Activation = function(...) --[[ Line: 682 ]]
    -- upvalues: u1 (copy)
    local v17 = ...;
    local l__self__30 = v17.self;
    local _ = l__self__30.Player;
    local l__Char__31 = l__self__30.Char;
    local _ = l__self__30.Root;
    local _ = l__self__30.Victim;
    if v17.Func ~= "Setup" then
        return true;
    end;
    l__Char__31:SetAttribute("Blessing_of_Sparks_Damage", u1["Blessing of Sparks"].Variables.Damage);
    l__Char__31:SetAttribute("Blessing_of_Sparks_Duration", u1["Blessing of Sparks"].Variables.Duration);
    l__Char__31:SetAttribute("Blessing_of_Sparks_Cooldown", u1["Blessing of Sparks"].Variables.Cooldown);
    return true;
end;
u1["Serpent\'s Fang"] = {};
u1["Serpent\'s Fang"].Variables = {
    ChipDamage_Percent = 20,
    Physical_Defense_Percent = 50
};
u1["Serpent\'s Fang"].Desc = "Gain chip-damage; deal " .. u1["Serpent\'s Fang"].Variables.ChipDamage_Percent .. "% bypassed damage when Block-Breaking or hitting an enemy\'s Block. And ignore " .. u1["Serpent\'s Fang"].Variables.Physical_Defense_Percent .. "% of enemies\' Physical-Defense";
u1["Serpent\'s Fang"].Name = "Serpent\'s Fang";
u1["Serpent\'s Fang"].Icon = "http://www.roblox.com/asset/?id=15889860574";
u1["Serpent\'s Fang"].Requirement = function(...) --[[ Line: 733 ]]
    local _ = (...).self;
    return true;
end;
u1["Serpent\'s Fang"].Activation = function(...) --[[ Line: 745 ]]
    -- upvalues: u1 (copy)
    local v18 = ...;
    local l__self__32 = v18.self;
    local _ = l__self__32.Player;
    local l__Char__33 = l__self__32.Char;
    local _ = l__self__32.Root;
    local _ = l__self__32.Victim;
    if v18.Func ~= "Setup" then
        return true;
    end;
    l__Char__33:SetAttribute("Serpents_Fang", u1["Serpent\'s Fang"].Variables.ChipDamage_Percent / 100);
    l__Char__33:SetAttribute("Serpents_Fang_PD", u1["Serpent\'s Fang"].Variables.Physical_Defense_Percent / 100);
    return true;
end;
u1["Death God"] = {};
u1["Death God"].Variables = {
    Poison_Damage_Percent = 130,
    Poison_Resist_Percent = 130
};
u1["Death God"].Desc = "Gain " .. u1["Death God"].Variables.Poison_Damage_Percent - 100 .. "% increased Poison damage and take " .. u1["Death God"].Variables.Poison_Resist_Percent - 100 .. "% less Poison damage";
u1["Death God"].Name = "Death God";
u1["Death God"].Icon = "http://www.roblox.com/asset/?id=484395923";
u1["Death God"].Requirement = function(...) --[[ Line: 790 ]]
    local _ = (...).self;
    return true;
end;
u1["Death God"].Activation = function(...) --[[ Line: 802 ]]
    -- upvalues: u1 (copy)
    local v19 = ...;
    local l__self__34 = v19.self;
    local _ = l__self__34.Player;
    local l__Char__35 = l__self__34.Char;
    local _ = l__self__34.Root;
    local _ = l__self__34.Victim;
    if v19.Func ~= "Setup" then
        return true;
    end;
    l__Char__35:SetAttribute("Death_God", u1["Death God"].Variables.Poison_Damage_Percent / 100);
    l__Char__35:SetAttribute("Death_God_Resist", u1["Death God"].Variables.Poison_Resist_Percent / 100);
    return true;
end;
u1.Firebrand = {};
u1.Firebrand.Variables = {
    Fire_Damage_Percent = 125
};
u1.Firebrand.Desc = "Increase all fire related damage that you deal by " .. u1.Firebrand.Variables.Fire_Damage_Percent - 100 .. "%";
u1.Firebrand.Name = "Firebrand";
u1.Firebrand.Icon = "http://www.roblox.com/asset/?id=14502433595";
function u1.Firebrand.Requirement(...) --[[ Line: 846 ]]
    local l__self__36 = (...).self;
    return (({
        ["Hamon (Jonathan Joestar)"] = true,
        ["Dragon Sage"] = true,
        Shinobi = true,
        ["The Incinerator"] = true
    })[l__self__36.PlayerStats.Spec.Value] or ({
        Mera = true,
        ["Hermit Purple"] = true,
        ["Magician\'s Red"] = true
    })[l__self__36.PlayerStats.Stand.Value]) and true or false;
end;
function u1.Firebrand.Activation(...) --[[ Line: 871 ]]
    -- upvalues: u1 (copy)
    local v20 = ...;
    local l__self__37 = v20.self;
    local _ = l__self__37.Player;
    local l__Char__38 = l__self__37.Char;
    local _ = l__self__37.Root;
    local _ = l__self__37.Victim;
    if v20.Func ~= "Setup" then
        return true;
    end;
    l__Char__38:SetAttribute("Firebrand", u1.Firebrand.Variables.Fire_Damage_Percent / 100);
    return true;
end;
u1["Jeweled Vessel"] = {};
u1["Jeweled Vessel"].Variables = {
    Crit_Chance = 25
};
u1["Jeweled Vessel"].Desc = "Gain " .. u1["Jeweled Vessel"].Variables.Crit_Chance .. "% Crit-Chance. Damaging abilities from Fighting-Styles can now Critically-Strike";
u1["Jeweled Vessel"].Name = "Jeweled Vessel";
u1["Jeweled Vessel"].Icon = "rbxassetid://9563726020";
u1["Jeweled Vessel"].Requirement = function(...) --[[ Line: 910 ]]
    local _ = (...).self;
    return true;
end;
u1["Jeweled Vessel"].Activation = function(...) --[[ Line: 922 ]]
    -- upvalues: u1 (copy)
    local v21 = ...;
    local l__self__39 = v21.self;
    local _ = l__self__39.Player;
    local l__Char__40 = l__self__39.Char;
    local _ = l__self__39.Root;
    local _ = l__self__39.Victim;
    if v21.Func ~= "Setup" then
        return true;
    end;
    l__Char__40:SetAttribute("Jeweled_Vessel", true);
    l__self__39:AddCritChance({
        Name = "Jeweled Vessel",
        Value = u1["Jeweled Vessel"].Variables.Crit_Chance
    });
    return true;
end;
u1.Bloodthirster = {};
u1.Bloodthirster.Variables = {
    Heal_Percent = 10
};
u1.Bloodthirster.Desc = "Dealing damage with a blade heals you for " .. u1.Bloodthirster.Variables.Heal_Percent .. "% dealt";
u1.Bloodthirster.Name = "Bloodthirster";
u1.Bloodthirster.Icon = "http://www.roblox.com/asset/?id=129698054";
function u1.Bloodthirster.Requirement(...) --[[ Line: 966 ]]
    local l__self__41 = (...).self;
    if ({
        SwordStyle = true,
        ["Shift Sword Style"] = true,
        ["Emiya Shirou"] = true,
        ["Gate of Babylon"] = true,
        Shinobi = true
    })[l__self__41.PlayerStats.Spec.Value] or ({
        Anubis = true,
        ["Silver Chariot"] = true,
        ["Chariot Requiem"] = true,
        ["The World"] = true,
        ["The World Alternate Universe"] = true,
        ["The World Over Heaven"] = true,
        ["Made in Heaven"] = true,
        ["Crazy Diamond"] = true,
        ["King Crimson Requiem"] = true,
        Aerosmith = true,
        ["White Album"] = true,
        ["Beach Boy"] = true
    })[l__self__41.PlayerStats.Stand.Value] then
        return true;
    end;
    for _, v22 in pairs(l__self__41.Char:GetChildren()) do
        if v22:IsA("Tool") and v22:GetAttribute("Blade") then
            return true;
        end;
    end;
    return false;
end;
function u1.Bloodthirster.Activation(...) --[[ Line: 1007 ]]
    -- upvalues: u1 (copy)
    local v23 = ...;
    local l__self__42 = v23.self;
    local _ = l__self__42.Player;
    local l__Char__43 = l__self__42.Char;
    local _ = l__self__42.Root;
    local _ = l__self__42.Victim;
    if v23.Func ~= "Setup" then
        return true;
    end;
    l__Char__43:SetAttribute("Bloodthirster", u1.Bloodthirster.Variables.Heal_Percent / 100);
    return true;
end;
u1.Immortalized = {};
u1.Immortalized.Variables = {
    MaxHealth_Percent = 30,
    Shield_Health_Percent = 25,
    Duration = 5,
    Heal_Percent = 10,
    Cooldown = 90
};
u1.Immortalized.Desc = "Taking damage that would reduce you below " .. u1.Immortalized.Variables.MaxHealth_Percent .. "% max health will first grant you a " .. u1.Immortalized.Variables.Shield_Health_Percent .. "% max health Shield lasting " .. u1.Immortalized.Variables.Duration .. "s. Dealing Basic-Attack (M1/M2) damage heals you for " .. u1.Immortalized.Variables.Heal_Percent .. "% dealt [" .. u1.Immortalized.Variables.Cooldown .. "s CD]";
u1.Immortalized.Name = "Immortalized";
u1.Immortalized.Icon = "http://www.roblox.com/asset/?id=11322093465";
function u1.Immortalized.Requirement(...) --[[ Line: 1050 ]]
    local _ = (...).self;
    return true;
end;
function u1.Immortalized.Activation(...) --[[ Line: 1062 ]]
    -- upvalues: u1 (copy)
    local v24 = ...;
    local l__self__44 = v24.self;
    local _ = l__self__44.Player;
    local l__Char__45 = l__self__44.Char;
    local _ = l__self__44.Root;
    local _ = l__self__44.Victim;
    if v24.Func ~= "Setup" then
        return true;
    end;
    l__Char__45:SetAttribute("Immortalized_Cooldown", u1.Immortalized.Variables.Cooldown);
    l__Char__45:SetAttribute("Immortalized_Health_Percent", u1.Immortalized.Variables.MaxHealth_Percent / 100);
    l__Char__45:SetAttribute("Immortalized_Shield_Percent", u1.Immortalized.Variables.Shield_Health_Percent / 100);
    l__Char__45:SetAttribute("Immortalized_Duration", u1.Immortalized.Variables.Duration);
    l__Char__45:SetAttribute("Immortalized_Heal", u1.Immortalized.Variables.Heal_Percent / 100);
    return true;
end;
u1["Infinity Edge"] = {};
u1["Infinity Edge"].Variables = {
    Damage_Percent = 120
};
u1["Infinity Edge"].Desc = "Increase all blade related damage by " .. math.abs(100 - u1["Infinity Edge"].Variables.Damage_Percent) .. "%";
u1["Infinity Edge"].Name = "Infinity Edge";
u1["Infinity Edge"].Icon = "http://www.roblox.com/asset/?id=7485051715";
u1["Infinity Edge"].Requirement = u1.Bloodthirster.Requirement;
u1["Infinity Edge"].Activation = function(...) --[[ Line: 1123 ]]
    -- upvalues: u1 (copy)
    local v25 = ...;
    local l__self__46 = v25.self;
    local _ = l__self__46.Player;
    local l__Char__47 = l__self__46.Char;
    local _ = l__self__46.Root;
    local _ = l__self__46.Victim;
    if v25.Func ~= "Setup" then
        return true;
    end;
    l__Char__47:SetAttribute("Infinity_Edge", u1["Infinity Edge"].Variables.Damage_Percent / 100);
    return true;
end;
u1["Enchant: Thorns"] = {};
u1["Enchant: Thorns"].Variables = {
    PhysicalDefense = 5,
    Damage_Percent = 25
};
u1["Enchant: Thorns"].Desc = "Gain " .. u1["Enchant: Thorns"].Variables.PhysicalDefense .. " Physical-Defense. When struck by a Basic-Attack (M1/M2), deal " .. u1["Enchant: Thorns"].Variables.Damage_Percent .. "% of the damage back to the attacker";
u1["Enchant: Thorns"].Name = "Enchant: Thorns";
u1["Enchant: Thorns"].Icon = "http://www.roblox.com/asset/?id=6961006805";
u1["Enchant: Thorns"].Requirement = function(...) --[[ Line: 1163 ]]
    local _ = (...).self;
    return true;
end;
u1["Enchant: Thorns"].Activation = function(...) --[[ Line: 1175 ]]
    -- upvalues: u1 (copy)
    local v26 = ...;
    local l__self__48 = v26.self;
    local _ = l__self__48.Player;
    local l__Char__49 = l__self__48.Char;
    local _ = l__self__48.Root;
    local _ = l__self__48.Victim;
    if v26.Func ~= "Setup" then
        return true;
    end;
    l__Char__49:SetAttribute("Enchant_Thorns", u1["Enchant: Thorns"].Variables.PhysicalDefense / 100);
    l__Char__49:SetAttribute("Enchant_Thorns_Damage", u1["Enchant: Thorns"].Variables.Damage_Percent / 100);
    l__self__48:UpdatePhysicalDefense();
    return true;
end;
u1["Blessed Odds"] = {};
u1["Blessed Odds"].Variables = {
    Crit_Chance = 40
};
u1["Blessed Odds"].Desc = "Gain " .. u1["Blessed Odds"].Variables.Crit_Chance .. "% Crit-Chance";
u1["Blessed Odds"].Name = "Blessed Odds";
u1["Blessed Odds"].Icon = "http://www.roblox.com/asset/?id=554784715";
u1["Blessed Odds"].Requirement = function(...) --[[ Line: 1221 ]]
    local _ = (...).self;
    return true;
end;
u1["Blessed Odds"].Activation = function(...) --[[ Line: 1233 ]]
    -- upvalues: u1 (copy)
    local v27 = ...;
    local l__self__50 = v27.self;
    local _ = l__self__50.Player;
    local _ = l__self__50.Char;
    local _ = l__self__50.Root;
    local _ = l__self__50.Victim;
    if v27.Func ~= "Setup" then
        return true;
    end;
    l__self__50:AddCritChance({
        Name = "Blessed Odds",
        Value = u1["Blessed Odds"].Variables.Crit_Chance
    });
    return true;
end;
return u1;
 

 

local AnimationConfig = require(script.Parent.Parent.Animation.AnimationConfig);
local DaggerConfig = require(script.Parent.DaggerConfig);
local Enum_AnimationPriority = Enum.AnimationPriority;
local u1 = {
    Actions = table.freeze({
        Equip = table.freeze({
            clip = "DaggerEquip",
            looped = false,
            grip = true,
            equip = true,
            priority = Enum_AnimationPriority.Action2
        }),
        Hold = table.freeze({
            clip = "DaggerHold",
            looped = true,
            priority = Enum_AnimationPriority.Action
        }),
        Windup = table.freeze({
            clip = "DaggerWindup",
            looped = false,
            grip = true,
            priority = Enum_AnimationPriority.Action2
        }),
        Stab = table.freeze({
            clip = "DaggerStab",
            looped = false,
            grip = true,
            priority = Enum_AnimationPriority.Action2
        }),
        Dive = table.freeze({
            clip = "DaggerDive",
            looped = false,
            grip = true,
            dive = true,
            priority = Enum_AnimationPriority.Action3
        })
    })
};
local v2 = {};

for i, v in u1.Actions do
    v2[v.clip] = i;
end;

u1.ByClip = table.freeze(v2);
u1.Stow = table.freeze({
    looped = true,
    priority = Enum_AnimationPriority.Idle
});
local u3 = {};

function u1.normalize(p4) -- Line: 31
    if type(p4) == "number" then
        return p4 > 0 and (p4 % 1 == 0 and "rbxassetid://" .. string.format("%.0f", p4)) or nil;
    end;

    if type(p4) ~= "string" then
        return nil;
    end;

    if p4:find("^rbxassetid://%d+$") then
        return p4;
    end;

    local v5 = p4:match("^%s*(%d+)%s*$") or (p4:match("rbxassetid://(%d+)") or p4:match("[?&]id=(%d+)"));

    return v5 and "rbxassetid://" .. v5 or nil;
end;

function u1.custom(p6, p7) -- Line: 45
    -- upvalues: u1 (copy), u3 (copy)
    if p6 then
        p6 = u1.normalize(p6:GetAttribute(p7 .. "Anim"));
    end;

    if p6 and not u3[p6] then
        return p6;
    end;

    return nil;
end;

function u1.stow(p8) -- Line: 53
    -- upvalues: u1 (copy)
    return u1.custom(p8, "Stow");
end;

function u1.default(p9) -- Line: 56
    -- upvalues: AnimationConfig (copy), u1 (copy)
    return AnimationConfig.PublishedIds[u1.Actions[p9].clip];
end;

function u1.id(p10, p11) -- Line: 59
    -- upvalues: u1 (copy)
    return u1.custom(p10, p11) or u1.default(p11);
end;

function u1.fail(p12) -- Line: 62
    -- upvalues: u3 (copy)
    if p12 and not u3[p12] then
        u3[p12] = true;
        warn("Knife clip " .. p12 .. " failed to load; playing the default clip instead.");
    end;
end;

function u1.animated(p13) -- Line: 68
    local v14;

    if p13 == nil then
        v14 = false;
    else
        v14 = p13:GetAttribute("HandleAnimated") == true;
    end;

    return v14;
end;

function u1.fit(p15, p16) -- Line: 72
    return (p16 <= 0 or p16 + 0.01 >= p15) and 1 or p15 / p16;
end;

function u1.timing(p17, p18) -- Line: 80
    -- upvalues: DaggerConfig (copy)
    if not (p17 and (type(p18) == "number" and p18 > 0)) then
        return DaggerConfig;
    end;

    local Attribute = p17:GetAttribute("StabContactStart");
    local Attribute2 = p17:GetAttribute("StabContactEnd");
    local v19 = type(Attribute) == "number" and Attribute and Attribute or DaggerConfig.StabContactStart;
    local math_clamp_ret = math.clamp(v19, 0, p18);
    local v20 = type(Attribute2) == "number" and Attribute2 and Attribute2 or DaggerConfig.StabContactEnd;
    local v21 = {
        StabContactStart = math_clamp_ret,
        StabContactEnd = math.clamp(v20, math_clamp_ret, p18),
        StabDuration = p18
    };

    return setmetatable(v21, {
        __index = DaggerConfig
    });
end;

return table.freeze(u1);
 

 

local Players = game:GetService("Players");
local u1 = {};
local utf8_char_ret = utf8.char(57344);
local u2 = nil;

function u1.infected(p3) -- Line: 10
    -- upvalues: Players (copy), u2 (ref)
    if type(p3) == "number" then
        p3 = Players:GetPlayerByUserId(p3);
    end;

    u2 = u2 or require(script.Parent.Parent.Game.OutbreakConfig);
    local v4 = nil;

    if typeof(p3) == "Instance" and p3:IsA("Player") then
        v4 = p3:GetAttribute("OutbreakInfected") == true;
    elseif type(p3) == "table" and (p3.IsBot and type(p3.GetAttribute) == "function") then
        v4 = p3:GetAttribute("EquippedKnife") == u2.Knife;
    end;

    local v5;

    if v4 == true then
        v5 = u2.active(workspace:GetServerTimeNow());
    else
        v5 = false;
    end;

    return v5;
end;

local function escape(p6) -- Line: 24
    return tostring(p6 or ""):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub("\"", "&quot;");
end;

function u1.format(p7, p8, p9) -- Line: 28
    -- upvalues: utf8_char_ret (copy), u1 (copy)
    local v10 = tostring(p7 or ""):gsub("&", "&amp;"):gsub("<", "&lt;"):gsub(">", "&gt;"):gsub("\"", "&quot;");

    if p8 == true then
        v10 = v10 .. " <font color=\"#3AA8FF\">" .. utf8_char_ret .. "</font>" or v10;
    end;

    if p9 == nil or not u1.infected(p9) then
        return v10;
    end;

    return "<stroke color=\"#2E8B3A\" thickness=\"2\" joins=\"round\">" .. v10 .. "</stroke>";
end;

function u1.player(p11) -- Line: 40
    -- upvalues: u1 (copy)
    local v12;

    if typeof(p11) == "Instance" then
        v12 = p11:IsA("Player");
    else
        v12 = false;
    end;

    local v13;

    if v12 then
        v13 = p11:GetAttribute("LookDisplayName");
    else
        v13 = v12;
    end;

    if type(v13) == "string" then
        return u1.format(v13, p11:GetAttribute("LookVerified") == true, p11);
    end;

    if v12 then
        v12 = p11.HasVerifiedBadge;
    end;

    return u1.format(p11.DisplayName, v12, p11);
end;

return u1;
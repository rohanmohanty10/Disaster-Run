 

 

local Players = game:GetService("Players");
local u1 = {};
local u2 = nil;
local u3 = setmetatable({}, {
    __mode = "k"
});

local function gui() -- Line: 9
    -- upvalues: u2 (ref), Players (copy)
    u2 = u2 or Players.LocalPlayer:WaitForChild("PlayerGui");

    return u2;
end;

function u1.screen(p4) -- Line: 15
    -- upvalues: u2 (ref), Players (copy)
    u2 = u2 or Players.LocalPlayer:WaitForChild("PlayerGui");
    local v5 = u2:WaitForChild(p4, 30);

    if not v5 then
        warn("Interface: PlayerGui." .. p4 .. " has not arrived after 30 seconds");
        u2 = u2 or Players.LocalPlayer:WaitForChild("PlayerGui");
        v5 = u2:WaitForChild(p4);
    end;

    return v5;
end;

function u1.find(p6, p7) -- Line: 24
    for i in string.gmatch(p7, "[^%.]+") do
        if p6 then
            p6 = p6:FindFirstChild(i);
        end;
    end;

    return p6;
end;

function u1.get(p8, p9) -- Line: 32
    -- upvalues: u1 (copy)
    local v10 = u1.find(p8, p9);

    if not v10 then
        error(("Interface: missing %s.%s"):format(p8:GetFullName(), p9), 2);
    end;

    return v10;
end;

function u1.missing(p11, p12) -- Line: 41
    -- upvalues: u1 (copy)
    local v13 = {};

    for _, v in p12 do
        if not u1.find(p11, v) then
            table.insert(v13, v);
        end;
    end;

    return v13;
end;

function u1.template(p14, p15) -- Line: 54
    -- upvalues: u3 (copy)
    local v16 = u3[p14];

    if not v16 then
        v16 = {};
        u3[p14] = v16;
    end;

    local v17 = v16[p15];

    if not v17 then
        v17 = p14:FindFirstChild(p15);

        if not v17 then
            error(("Interface: missing template %s.%s"):format(p14:GetFullName(), p15), 2);
        end;

        v17.Parent = nil;
        v16[p15] = v17;
    end;

    return v17;
end;

function u1.clone(p18, p19, p20, p21) -- Line: 72
    -- upvalues: u1 (copy)
    local v22 = u1.template(p18, p19):Clone();
    v22.Name = p20;

    if p21 and v22:IsA("GuiObject") then
        v22.LayoutOrder = p21;
    end;

    v22.Parent = p18;

    return v22;
end;

return u1;
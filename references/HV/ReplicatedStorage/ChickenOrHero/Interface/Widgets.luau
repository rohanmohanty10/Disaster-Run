 

 

local v1 = {};
local u2 = setmetatable({}, {
    __mode = "k"
});
local Color3_new_ret = Color3.new(0, 0, 0);
local ColorSequence_new_ret = ColorSequence.new(Color3.fromRGB(125, 125, 125), Color3.fromRGB(80, 80, 80));
local Color3_fromRGB_ret = Color3.fromRGB(110, 110, 110);
local Color3_fromRGB_ret2 = Color3.fromRGB(165, 165, 165);
local Color3_fromRGB_ret3 = Color3.fromRGB(105, 105, 105);
local u3 = setmetatable({}, {
    __mode = "k"
});

function v1.number(p4) -- Line: 13
    local string_reverse = string.reverse;
    local math_floor_ret = math.floor(p4 or 0);
    local math_max_ret = math.max(0, math_floor_ret);
    local v5 = string_reverse((tostring(math_max_ret)));
    local string_reverse_ret = string.reverse((string.gsub(v5, "(%d%d%d)", "%1,")));

    return string.gsub(string_reverse_ret, "^,", "");
end;

function v1.clock(p6) -- Line: 19
    local math_ceil_ret = math.ceil(p6 or 0);
    local math_max_ret = math.max(0, math_ceil_ret);

    return ("%d:%02d"):format(math.floor(math_max_ret / 60), math_max_ret % 60);
end;

function v1.titleCase(p7) -- Line: 25
    return string.gsub(string.lower(p7), "%S+", function(p8) -- Line: 26
        return string.gsub(p8, "^%a", string.upper);
    end);
end;

local function originals(p9) -- Line: 31
    -- upvalues: u2 (copy)
    local v10 = u2[p9];

    if not v10 then
        v10 = {};

        for _, descendant in p9:GetDescendants() do
            if descendant:IsA("TextLabel") or descendant:IsA("TextButton") then
                v10[descendant] = { "TextTransparency", descendant.TextTransparency };
            elseif descendant:IsA("ImageLabel") or descendant:IsA("ImageButton") then
                v10[descendant] = { "ImageTransparency", descendant.ImageTransparency };
            end;
        end;

        u2[p9] = v10;
    end;

    return v10;
end;

function v1.dim(p11, p12) -- Line: 49
    -- upvalues: originals (copy)
    local v13 = p11:IsA("GuiButton");

    for i, v in originals(p11) do
        if not v13 or v[1] ~= "TextTransparency" then
            i[v[1]] = p12 and 1 - (1 - v[2]) * 0.45 or v[2];
        end;
    end;
end;

local function greyOut(u14) -- Line: 60
    -- upvalues: ColorSequence_new_ret (copy), Color3_new_ret (copy), Color3_fromRGB_ret (copy), Color3_fromRGB_ret2 (copy), Color3_fromRGB_ret3 (copy)
    local u15 = {};

    local function set(p16, p17, p18) -- Line: 62
        -- upvalues: u15 (copy)
        table.insert(u15, p16);
        table.insert(u15, p17);
        table.insert(u15, p16[p17]);
        p16[p17] = p18;
    end;

    local function one(p19) -- Line: 68
        -- upvalues: ColorSequence_new_ret (ref), u15 (copy), Color3_new_ret (ref), Color3_fromRGB_ret (ref), Color3_fromRGB_ret2 (ref), u14 (copy), Color3_fromRGB_ret3 (ref)
        if p19:IsA("UIGradient") then
            table.insert(u15, p19);
            table.insert(u15, "Color");
            table.insert(u15, p19.Color);
            p19.Color = ColorSequence_new_ret;
        elseif p19:IsA("UIStroke") then
            if p19.Color ~= Color3_new_ret then
                table.insert(u15, p19);
                table.insert(u15, "Color");
                table.insert(u15, p19.Color);
                p19.Color = Color3_fromRGB_ret;
            end;
        elseif p19:IsA("TextLabel") or (p19:IsA("TextButton") or p19:IsA("TextBox")) then
            table.insert(u15, p19);
            table.insert(u15, "TextColor3");
            table.insert(u15, p19.TextColor3);
            p19.TextColor3 = Color3_fromRGB_ret2;
        end;

        if (p19:IsA("ImageLabel") or p19:IsA("ImageButton")) and not p19:FindFirstChildOfClass("UIGradient") then
            if p19 == u14 then
                table.insert(u15, p19);
                table.insert(u15, "ImageColor3");
                table.insert(u15, p19.ImageColor3);
                p19.ImageColor3 = Color3_fromRGB_ret3;

                return;
            end;

            local v20 = 1 - (1 - p19.ImageTransparency) * 0.45;
            table.insert(u15, p19);
            table.insert(u15, "ImageTransparency");
            table.insert(u15, p19.ImageTransparency);
            p19.ImageTransparency = v20;
        end;
    end;

    one(u14);

    for _, descendant in u14:GetDescendants() do
        one(descendant);
    end;

    if u14.BackgroundTransparency < 1 and not u14:IsA("ImageButton") then
        table.insert(u15, u14);
        table.insert(u15, "BackgroundColor3");
        table.insert(u15, u14.BackgroundColor3);
        u14.BackgroundColor3 = Color3_fromRGB_ret3;
    end;

    return u15;
end;

function v1.setEnabled(p21, p22) -- Line: 96
    -- upvalues: u3 (copy), greyOut (copy)
    p21.Interactable = p22;
    local v23 = u3[p21];

    if p22 then
        if v23 then
            u3[p21] = nil;

            for i = #v23 - 2, 1, -3 do
                v23[i][v23[i + 1]] = v23[i + 2];
                local _ = i;
            end;
        end;
    elseif not v23 then
        u3[p21] = greyOut(p21);
    end;
end;

local function lookOf(p24) -- Line: 112
    -- upvalues: Color3_new_ret (copy)
    local v25 = p24:FindFirstChildOfClass("UIGradient");
    local v26 = nil;

    for _, child in p24:GetChildren() do
        if child:IsA("UIStroke") and child.Color ~= Color3_new_ret then
            v26 = child.Color;
        end;
    end;

    local v27 = {};

    if v25 then
        v25 = v25.Color;
    end;

    v27.gradient = v25;
    v27.stroke = v26;

    return v27;
end;

function v1.looks(p28, p29) -- Line: 125
    -- upvalues: lookOf (copy), Color3_new_ret (copy)
    local u30 = {
        [true] = lookOf(p28),
        [false] = lookOf(p29)
    };

    return function(p31, p32) -- Line: 127
        -- upvalues: u30 (copy), Color3_new_ret (ref)
        local v33 = u30[p32 == true];

        for _, child in p31:GetChildren() do
            if child:IsA("UIGradient") and v33.gradient then
                child.Color = v33.gradient;
            elseif child:IsA("UIStroke") and (v33.stroke and child.Color ~= Color3_new_ret) then
                child.Color = v33.stroke;
            end;
        end;
    end;
end;

function v1.setText(p34, p35) -- Line: 140
    if p34.Text ~= p35 then
        p34.Text = p35;
    end;
end;

return v1;
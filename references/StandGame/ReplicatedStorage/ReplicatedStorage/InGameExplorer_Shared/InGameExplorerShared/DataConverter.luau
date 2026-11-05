 

 

local function u5(p1) --[[ Line: 1 ]]
    local v2, v3, v4 = p1:ToOrientation();
    return string.format("CFrame(%s,%s,%s,%s,%s,%s)", p1.X, p1.Y, p1.Z, v2, v3, v4);
end;
local function u7(p6) --[[ Line: 5 ]]
    return string.format("Vector3(%s,%s,%s)", p6.x, p6.y, p6.z);
end;
local function u9(p8) --[[ Line: 9 ]]
    return string.format("Vector2(%s,%s)", p8.x, p8.y);
end;
local function u11(p10) --[[ Line: 13 ]]
    return string.format("Color(%s,%s,%s)", p10.r * 255, p10.g * 255, p10.b * 255);
end;
local function u15(p12) --[[ Line: 26 ]]
    local v13, v14 = p12:match("Vector2%((.-),(.-)%)");
    return Vector2.new(v13, v14);
end;
local function u20(p16) --[[ Line: 30 ]]
    local v17, v18, v19 = p16:match("Color%((.-),(.-),(.-)%)");
    return Color3.fromRGB(v17, v18, v19);
end;
return { function(p21) --[[ Name: ValueToString, Line 58 ]]
        -- upvalues: u5 (copy), u7 (copy), u9 (copy), u11 (copy)
        local v22 = typeof(p21);
        if v22 == "Instance" then
        else
            if v22 == "CFrame" then
                return u5(p21);
            end;
            if v22 == "Vector3" then
                return u7(p21);
            end;
            if v22 == "Vector2" then
                return u9(p21);
            end;
            if v22 == "Color3" then
                return u11(p21);
            end;
            if v22 == "EnumItem" then
                return p21.Name;
            end;
            if v22 == "boolean" then
                return string.format("Bool(%s)", (tostring(p21)));
            end;
            if tostring(p21) then
                return tostring(p21);
            end;
        end;
    end, function(p23) --[[ Name: StringToValue, Line 43 ]]
        -- upvalues: u15 (copy), u20 (copy)
        if p23:match("CFrame") then
            local v24, v25, v26, v27, v28, v29 = p23:match("CFrame%((.-),(.-),(.-),(.-),(.-),(.-)%)");
            return CFrame.new(v24, v25, v26) * CFrame.Angles(v27, v28, v29);
        elseif p23:match("Vector3") then
            local v30, v31, v32 = p23:match("Vector3%((.-),(.-),(.-)%)");
            return Vector3.new(v30, v31, v32);
        elseif p23:match("Vector2") then
            return u15(p23);
        elseif p23:match("Color") then
            return u20(p23);
        elseif p23:match("Bool") then
            return p23:match("Bool%((.+)%)") == "true";
        else
            return p23;
        end;
    end };
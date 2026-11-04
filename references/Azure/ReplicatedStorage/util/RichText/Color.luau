 

 

local function round(p1) -- Line: 5
    return math.round(p1);
end;

return function(p2: any, p3: table) -- Line: 9
    local v4 = not p2 and `{math.round(p3.Value.R * 255)},{math.round(p3.Value.G * 255)},{math.round(p3.Value.B * 255)}`;

    return not p2 and `<font color="rgb({v4})">` or "</font>";
end;
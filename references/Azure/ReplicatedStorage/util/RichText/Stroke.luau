 

 

local function round(p1) -- Line: 5
    return math.round(p1);
end;

return function(p2: any, p3: table) -- Line: 9
    local v4 = not p2 and `thickness="{p3.Thickness}"`;
    local v5 = not p2 and `color="rgb({math.round(p3.Value.R * 255)},{math.round(p3.Value.G * 255)},{math.round(p3.Value.B * 255)})"`;

    return not p2 and `<stroke {v5} {v4}>` or "</stroke>";
end;
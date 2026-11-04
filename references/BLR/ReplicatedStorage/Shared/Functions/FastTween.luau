  

local TweenService = game:GetService("TweenService");

return function(p1, p2, p3) -- Line: 3
    -- upvalues: TweenService (copy)
    local v4 = type(p1) ~= "table" and { p1 } or p1;
    local v5 = {};
    local v6 = p3 or { 1, "Linear", "Out" };

    if v6[2] then
        if type(v6[2]) == "string" then
            v6[2] = Enum.EasingStyle[v6[2]];
        end;
    else
        v6[2] = Enum.EasingStyle.Sine;
    end;

    if v6[3] then
        if type(v6[3]) == "string" then
            v6[3] = Enum.EasingDirection[v6[3]];
        end;
    else
        v6[3] = Enum.EasingDirection.InOut;
    end;

    for _, v in ipairs(v4) do
        local v7 = TweenService:Create(v, TweenInfo.new(unpack(v6)), p2);
        v7:Destroy();
        v7:Play();
        table.insert(v5, v7);
    end;

    return unpack(v5);
end;